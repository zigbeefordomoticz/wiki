    # Magic Cube Xiaomi
    # Thanks to: https://github.com/dresden-elektronik/deconz-rest-plugin/issues/138#issuecomment-325101635
    #         +---+
    #         | 2 |
    #     +---+---+---+
    #     | 4 | 0 | 1 |
    #     +---+---+---+
    #         | 5 |
    #         +---+
    #         | 3 |
    #         +---+
    #     Op Blok 5 staat het MI logo; blok 3 bevat de batterij klep.
    #
    #     Schudden: 0x0000 (de bovenkant bovenop maakt niet uit)
    #     90º Draai naar kant x over naar kant y op de bovenkant: 0x0040 + (x << 3) + y
    #     180º Draai naar kant x op top: 0x0080 + x
    #     Druk als kant x is boven op ligt: 0x0100 + x
    #     Dubbel drukken als kant x boven op ligt: 0x0200 + x
    #     Het drukken werkt in elke richting
    #     Voor het dubbel drukken moet je de cube op tillen en twee keer op de tafel tikken.
