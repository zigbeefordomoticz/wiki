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
    #     Side 5 is with the MI logo; side 3 contains the battery door.
    #
    #     Shake: 0x0000 (side on top doesn't matter)
    #     90º Flip from side x on top to side y on top: 0x0040 + (x << 3) + y
    #     180º Flip to side x on top: 0x0080 + x
    #     Push while side x is on top: 0x0100 + x
    #     Double Tap while side x is on top: 0x0200 + x
    #     Push works in any direction.
    #     For Double Tap you really need to lift the cube and tap it on the table twice.