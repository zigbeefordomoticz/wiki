# Device-side auto-off: On With Timed Off

> Requires a plugin version later than 9.1.008. Up to 9.1.008, `OnOffOnTimeDelay`
> and `OnOffOffWaitTime` only wrote an attribute once (see 2.1).

A relay that Domoticz switches On is normally switched Off by Domoticz too. If
Domoticz, the plugin or the Zigbee network goes down in between, the relay stays
On. For an irrigation valve, a pump or a heater that is a real risk.

The On/Off cluster lets the device run that timer itself: **On With Timed Off**
(cluster `0x0006`, command `0x42`). The plugin sends it with every On when the
device Param `OnOffOnTimeDelay` is set.

Tuya relays implement the same command differently, and the plugin handles them
through a flag in the device configuration (`TuyaOnOffCountdown`).

| | ZCL compliant device | Tuya countdown device |
|---|---|---|
| Does `0x42` switch the relay On? | Yes | **No** |
| Unit of OnTime | 1/10 s | seconds |
| When the time is up | switches Off | **toggles** the relay |
| Plugin sends | `0x42` alone | On, then `0x42` |
| Enabled by | Param `OnOffOnTimeDelay` | same Param + device conf `TuyaOnOffCountdown` |

---

## 1. What the Zigbee specification says

Zigbee Cluster Library (ZCL, document 07-5123), section 3.8, On/Off cluster.
The timed-off feature comes from the lighting profile (ZLL) and is **optional**:
many relays do not implement it.

### 1.1 Attributes

| Id | Name | Type | Meaning |
|---|---|---|---|
| `0x0000` | OnOff | bool | current state |
| `0x4001` | OnTime | uint16, 1/10 s | time left before the device switches itself Off |
| `0x4002` | OffWaitTime | uint16, 1/10 s | time left during which On With Timed Off cannot switch the device On |

`0xFFFF` in OnTime or OffWaitTime means "do not count down", so the longest real
value is `0xFFFE` (6553.4 s, about 1 h 49 min).

### 1.2 Command `0x42` On With Timed Off

| Field | Type | Meaning |
|---|---|---|
| OnOffControl | map8 | bit 0 *Accept Only When On*: when set, the command is ignored if the device is Off |
| OnTime | uint16, 1/10 s | how long to stay On |
| OffWaitTime | uint16, 1/10 s | guard time, see below |

Example, 10 minutes On, no guard, the payload after the ZCL header:

```
42 00 70 17 00 00
│  │  └───┴─ OnTime 6000 = 0x1770, little endian
│  └─ OnOffControl 0x00
└─ command 0x42          OffWaitTime 0 ─┘
```

### 1.3 Behaviour

OnTime and OffWaitTime are not settings: they are the **countdown itself**.

| Event | Effect |
|---|---|
| Every 1/10 s, device On, OnTime > 0 | OnTime − 1. At 0: OffWaitTime = 0 and the device switches **Off** |
| Every 1/10 s, device Off, OffWaitTime > 0 | OffWaitTime − 1 |
| On | switches On. If OnTime = 0, OffWaitTime = 0. A running countdown continues |
| Off | switches Off and **OnTime = 0**. OffWaitTime is kept: the guard starts |
| Toggle | acts as Off or On |
| `0x42`, device On | OnTime = the longer of the current and the new value; OffWaitTime = new value |
| `0x42`, device Off, OffWaitTime = 0 | switches **On**, OnTime and OffWaitTime = new values |
| `0x42`, device Off, OffWaitTime > 0 | stays Off (guard); OffWaitTime = the shorter of the two |
| Write OnTime (`0x4001`) | starts the countdown if the device is On, or at the next On |

Consequences:

- **A countdown can be extended, not shortened**, by another `0x42`. To stop
  earlier, send Off.
- **The guard is not a cool-down after the auto-off.** When OnTime reaches 0,
  OffWaitTime is cleared. The guard only applies after an Off command cut a
  timed On short, and it blocks `0x42`, not a plain On.
- **A value written once is used once.** The countdown consumes OnTime and an
  Off resets it, so writing `0x4001` gives at most one timed cycle. A timer on
  every On means sending the values with every On, which is what `0x42` does.

The table follows the CSA reference implementation of the same cluster
(`OnOffLightingCluster.cpp` in the Matter SDK, whose comments quote the ZCL
text); see the references.

---

## 2. How the plugin implements it

### 2.1 Configuration

Two device Params, set in Device Management (see
[Device parameters](../HowTo_Device-parameters.md)):

| Param | Unit | Meaning |
|---|---|---|
| `OnOffOnTimeDelay` | seconds | auto-off delay sent with every On. 0 or unset = plain On |
| `OnOffOffWaitTime` | seconds | guard time sent with it (ZCL devices only). Usually 0 |

Each takes one value for every endpoint, or one value per endpoint:

```
'OnOffOnTimeDelay': 900
'OnOffOnTimeDelay': {'01': 1500, '02': 900, '03': 1200, '04': 600}
```

The plugin converts to each device's unit: × 10 for the ZCL fields, capped at
`0xFFFE` (6553 s, about 1 h 49 min); whole seconds for a Tuya countdown,
capped at 43200 (12 h). Changing a Param writes nothing to the device: the
values are only used when an On is sent.

> Until this change, `OnOffOnTimeDelay` and `OnOffOffWaitTime` wrote their value
> as is into the attributes `0x4001` / `0x4002`, once, when the Param changed.
> The unit was not documented and depended on the device (1/10 s on a ZCL
> device, seconds on a Tuya countdown), and as shown in 1.3 the write only
> covered the next On. `OnOffOnTimeDelay` reached `0x4001` only from release
> 9.1.007 (#2064), and no certified device configuration declares these
> Params, so only users who set them by hand see the new behaviour.

### 2.2 Flow

```
Domoticz On
 └─ Modules/actuators.py      actuator_on()
     └─ Modules/onoff_settings.py  onoff_on_with_timed_off()
         ├─ OnOffOnTimeDelay unset for this endpoint  → returns False → plain On
         ├─ native ZiGate (no raw mode)               → error logged, returns False → plain On
         ├─ device conf TuyaOnOffCountdown            → On, then 0x42 in seconds
         └─ otherwise                                 → 0x42 (OnTime, OffWaitTime) × 10, in 1/10 s
             └─ Zigbee/zclCommands.py     zcl_onoff_on_with_timed_off()
                 └─ Zigbee/zclRawCommands.py raw_zcl_zcl_onoff(…, "OnWithTimedOff")
```

- `raw_zcl_zcl_onoff()` builds the `0x42` payload: OnOffControl `0x00`, then
  OnTime and OffWaitTime as little endian uint16.
- Off from Domoticz is unchanged: a plain Off, which cancels the countdown
  (ZCL: OnTime = 0; Tuya: any On/Off/Toggle cancels it).
- Only zigpy coordinators (raw mode) send `0x42`. On a native ZiGate the
  plugin logs an error and sends a plain On, so the device still switches On.

### 2.3 Not covered

- Commands that do not go through `actuator_on()`: group commands, Toggle,
  set-level with on/off on dimmers, and devices driven through Tuya datapoints
  (`TS0601`).
- Reading back the remaining time (OnTime) into Domoticz.

---

## 3. What is specific to Tuya

Many Tuya relays and plugs (`TS0001` to `TS0004`, `TS011F`…) use command `0x42`
for their **countdown** feature, in a way that departs from the ZCL:

- `0x42` **does not switch the relay On**. It only starts a countdown.
- OnTime is in **seconds**, up to 43200 (12 h) per Tuya's documentation.
- When the countdown ends, the relay **toggles**: Off if it was On, **On if it
  was Off**.
- On, Off or Toggle cancel a running countdown.
- Tuya documents OffWaitTime = OnTime.
- While a countdown runs, the device reports the time left in the OnTime
  attribute (`0x4001`), in seconds, every 60 s.

zigbee-herdsman-converters (Zigbee2MQTT) implements exactly this in
`tuya.on_off_countdown`: send the state first, then `onWithTimedOff` with
`ontime = offwaittime = countdown`. Many Tuya device definitions there enable
it with `onOffCountdown: true`.

**What goes wrong with the standard sequence:** sending `0x42` alone (the ZCL
way) to a Tuya relay that is Off does not switch it On, and when the countdown
ends the relay switches **On** by itself. Observed on a TS0004
`_TZ3000_u3oupgdy` (MHCOZY TYWB 4ch-RF): the relay did not switch On, and the
Domoticz widget fell back to Off. With the Tuya sequence below, the same relay
switches On and then Off by itself after the delay.

**How the plugin handles it:** with `"TuyaOnOffCountdown": true` in the device
configuration (see [Device configuration attributes](device-configuration-attributes.md)),
`onoff_on_with_timed_off()` sends:

1. a plain On;
2. `0x42` with OnTime = OffWaitTime = `OnOffOnTimeDelay` in seconds, rounded
   up to a whole second and capped at 43200 (12 h).

`OnOffOffWaitTime` is ignored for these devices.

The flag belongs in the device configuration, not in a user Param: the
behaviour depends on the model and firmware, a wrong choice is unsafe, and
Tuya devices driven through datapoints (`TS0601`) work differently again.

---

## 4. Checking a device on the bench

With a lamp on the relay, not a valve:

1. Set `'OnOffOnTimeDelay': 60` (60 s).
2. Make sure no Off Delay or script in Domoticz switches it Off.
3. Switch it On from Domoticz and touch nothing. With the `zclCommand` debug log
   on, check that the only frames sent are the expected ones.

| What happens | Meaning | Next |
|---|---|---|
| On at once, Off after 60 s | ZCL behaviour works | keep it |
| Stays Off | Tuya countdown, or `0x42` not supported | add `TuyaOnOffCountdown` to its device configuration (a copy in `Conf/Local-Devices`, see [Model name resolution](Model-name-resolution.md)) and test again |
| On, stays On after 60 s | device ignores `0x42` | remove the Param; this device has no device-side auto-off |

In the "stays Off" case with a Tuya device, the countdown has started: the lamp
switches On at the end of it. Send an Off to cancel.

---

## 5. References

- ZCL specification, document 07-5123 (CSA), section 3.8 On/Off cluster.
- CSA reference implementation of the cluster, Matter SDK
  [`OnOffLightingCluster.cpp`](https://github.com/project-chip/connectedhomeip/blob/master/src/app/clusters/on-off-server/OnOffLightingCluster.cpp):
  `HandleOn`, `HandleOff`, `HandleOnWithTimedOff`, `TimerFired`.
- zigpy cluster definition `zigpy.zcl.clusters.general.OnOff`: attributes
  `on_time` `0x4001`, `off_wait_time` `0x4002`; command `on_with_timed_off`
  `0x42` with `on_off_control` (bit `Accept_Only_When_On` = 1), `on_time`,
  `off_wait_time` (uint16).
- zigbee-herdsman-converters
  [`src/lib/tuya.ts`](https://github.com/Koenkk/zigbee-herdsman-converters/blob/master/src/lib/tuya.ts),
  `on_off_countdown` (toZigbee and fromZigbee).
- Zigbee2MQTT device page
  [MHCOZY TYWB 4ch-RF](https://www.zigbee2mqtt.io/devices/TYWB_4ch-RF.html).
