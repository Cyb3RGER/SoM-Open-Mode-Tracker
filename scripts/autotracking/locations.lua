EVENT_FLAGS_ADDR = 0x7ECF00
    EVENT_CMDS = {
        [0x00] = 0x00,
        [0x02] = 0x00,
        [0x03] = 0x00,
        [0x04] = 0x00,
        [0x05] = 0x00,
        [0x08] = 0x00,
        [0x0A] = 0x00,
        [0x0E] = 0x00,
        [0x0F] = 0x00,
        [0x10] = 0x01,
        [0x11] = 0x01,
        [0x12] = 0x01,
        [0x13] = 0x01,
        [0x14] = 0x01,
        [0x15] = 0x01,
        [0x16] = 0x01,
        [0x17] = 0x01,
        [0x18] = 0x01,
        [0x19] = 0x01,
        [0x1A] = 0x01,
        [0x1B] = 0x01,
        [0x1C] = 0x00, --unknown params
        [0x1D] = 0x01,
        [0x1E] = 0x01,
        [0x1F] = 0x01,
        [0x20] = 0x01,
        [0x21] = 0x01,
        [0x22] = 0x01,
        [0x23] = 0x01,
        [0x24] = 0x01,
        [0x25] = 0x01,
        [0x26] = 0x01,
        [0x27] = 0x01,
        [0x28] = 0x01,
        [0x29] = 0x01,
        [0x2A] = 0x01,
        [0x2B] = 0x01,
        [0x2C] = 0x01,
        [0x2D] = 0x03,
        [0x2E] = 0x01,
        [0x2F] = 0x01,
        [0x30] = 0x02,
        [0x31] = 0x02,
        [0x32] = 0x02,
        [0x33] = 0x00, --unknown params/ unused?
        [0x34] = 0x02,
        [0x36] = 0x02,
        [0x37] = 0x02,
        [0x38] = 0x01,
        [0x39] = 0x03,
        [0x40] = 0x04,
        [0x42] = 0x04,
        [0x49] = 0x05,
        [0x4A] = 0x05,
        [0x4B] = 0x05,
        [0x4E] = 0x05,
        [0x50] = 0x00,
        [0x51] = 0x00,
        [0x52] = 0x00,
        [0x57] = 0x01,
        [0x58] = 0x00,
        [0x59] = 0x00,
        [0x5A] = 0x01, --run to 5B?
        [0x5B] = 0x00,
        [0x5D] = 0x00,
        [0x5E] = 0x00,
        [0x5F] = 0x00,
    }
    EVENT_FLAG_MAPPING = {}
    EVENT_MAPPING = {
        --[eventNr] = {code,clearAll}
        [0x4a4] = {"@Lost Continent/Tree Palace/Grand Palace Boss",true},
        [0x422] = {"@Mana Fortress/Mana Fortress Boss 1",true},
        [0x425] = {"@Mana Fortress/Mana Fortress Boss 2",true},
        [0x22e] = {"@Gaia's Navel/Earth Palace Mana Seed",true},
        [0x589] = {"@Kakkara Desert/Fire Palace/Fire Palace Reward",true},
        [0x584] = {"@Kakkara Desert/Moon Palace/Moon Palace Seed",true},
        [0x2b2] = {"@Kakkara Desert/Kakkara/Kakkara NPC",true},
        [0x587] = {"@Vandole Empire/Gold City/Gold Tower/Gold Tower Reward",true},
        [0x688] = {"@Elinee's Castle/Elinee's Castle Reward (Chests)",false},
        [0x672] = {"@Lofty Mountains/Palace of Darkness/Palace of Darkness Chest behind bars",true},
        [0x675] = {"@Lost Continent/Tree Palace/Grand Palace Chest",true},
        [0x677] = {"@Vandole Empire/Gold City/Gold Tower/Gold Tower Chest 2",true},
        [0x678] = {"@Kakkara Desert/Fire Palace/Fire Palace After Little Maze",true},
        [0x67b] = {"@Vandole Empire/Gold City/Gold Tower/Gold Tower Chest 1",true},
        [0x691] = {"@Lost Continent/Undersea Palace/Undersea Palace Chest",true},
        [0x68a] = {"@Kakkara Desert/Fire Palace/Fire Palace Near Entrance Chest",true},
        [0x68b] = {"@Kakkara Desert/Fire Palace/Fire Palace Near Orb 2",true},
        [0x66d] = {"@Ice Country/Ice Castle/Ice Castle Boss 2",true},
        [0x586] = {"@Lofty Mountains/Palace of Darkness/Palace of Darkness Reward",true},
        [0x5f5] = {"@Pure Land/Pure Land Boss 5",true},
        [0x5f3] = {"@Pure Land/Pure Land Boss 4",true},
        [0x5f7] = {"@Pure Land/Pure Land Boss 6",true},
        [0x5f8] = {"@Pure Land/Pure Land Mana Tree",true},
        [0x4e4] = {"@Upper Land/Matango/Flammie",true},
        [0x4e5] = {"@Lofty Mountains/Joch's Cave/Doppelgangers",true},
        [0x59b] = {"@Lost Continent/Undersea Palace/Undersea Palace Boss",true},
        [0x4ca] = {"@Lost Continent/Undersea Palace/Undergound City Boss",true},
        [0x68e] = {"@Lofty Mountains/Palace of Darkness/Palace of Darkness Walkway Chest",true},
        [0x132] = {"@Water Palace/Water Palace Mana Seed",true},
        [0x4e2] = {"@Upper Land/Sprite Village/Wind Palace Reward",true},
        [0x689] = {"@Elinee's Castle/Elinee's Castle Reward (Chests)",false},
        [0x670] = {"@Upper Land/Moogle Village/Moogle Village Double Chest",false},
        [0x671] = {"@Ice Country/Ice Castle/Ice Castle Chest",true},
        [0x673] = {"@Pandora/Pandora Castle Chests",false},
        [0x674] = {"@Vandole Empire/North Town/North Town Ruins/North Town Ruins Inner Chest",true},
        [0x676] = {"@Upper Land/Moogle Village/Moogle Village Double Chest",false},
        [0x679] = {"@Vandole Empire/North Town/North Town Castle/Castle Double Chest",false},
        [0x67a] = {"@Vandole Empire/North Town/North Town Ruins/North Town Ruins Left Chest",true},
        [0x67c] = {"@Pandora/Pandora Castle Chests",false},
        [0x67d] = {"@Ice Country/Santas House/Santas House Chest",true},
        [0x68c] = {"@Gaia's Navel/Underground Ship Chest",true},
        [0x68f] = {"@Vandole Empire/North Town/North Town Castle/Castle Double Chest",false},
        [0x690] = {"@Vandole Empire/North Town/North Town Ruins/North Town Ruins Right Chest",true},
        [0x680] = {"@Potos/Potos Chest",true},
        [0x683] = {"@Pandora/Pandora Castle Chests",false},
        [0x684] = {"@Pandora/Pandora Castle Chests",false},
        [0x685] = {"@Pandora/Pandora Castle Chests",false},
        [0x686] = {"@Pandora/Pandora Castle Chests",false},
        [0x687] = {"@Gaia's Navel/Gaia's Navel Cave Chest",true},
        [0x68d] = {"@Vandole Empire/North Town/North Town Castle/Castle Chest",true},
        [0x692] = {"@Upper Land/Matango/Matango Palace Chest",true},
        [0x1b0] = {"@Gaia's Navel/Watts",true},
        [0x581] = {"@Water Palace/Undine",true},
        [0x38c] = {"@Ice Country/Tropical Town/Tropical Town Boss/Salamando",true},
        [0x4b6] = {"@Lost Continent/Tree Palace/Tree Palace Reward (Mana Seed)",true},
        [0x399] = {"@Vandole Empire/South Town/South Town Mara",true},
        [0x2f9] = {"@Turtle Island/Turtle Island NPC",true},
        [0x366] = {"@Gaia's Navel/Dwarf Elder",true},
        [0x1b9] = {"@Gaia's Navel/Dwarf Village Boss",true},
        [0x188] = {"@Pandora/Pandora Castle Girl",true},
        [0x0aa] = {"@Lighthouse/Lighthouse NPC",true},
        [0x36a] = {"@Gaia's Navel/Underground Ship Boss",true},
        [0x112] = {"@Potos/Potos Boss",true},
        [0x5f1] = {"@Pure Land/Pure Land Boss 3",true},
        [0x5ef] = {"@Pure Land/Pure Land Boss 2",true},
        [0x5ed] = {"@Pure Land/Pure Land Boss 1",true},
        [0x553] = {"@Vandole Empire/North Town/North Town Ruins/North Town Ruins Boss 1",true},
        [0x559] = {"@Vandole Empire/North Town/North Town Ruins/North Town Ruins Boss 2",true},
        [0x52f] = {"@Vandole Empire/North Town/North Town Castle/Outside Boss",true},
        [0x4b4] = {"@Lost Continent/Tree Palace/Tree Palace Aegagropilon",true},
        [0x4a2] = {"@Lost Continent/Tree Palace/Tree Palace Boss after seed",true},
        [0x16e] = {"@Pandora/Pandora Ruins Boss",true},
        [0x527] = {"@Vandole Empire/North Town/North Town Castle/Inside Boss",true},
        [0x2d1] = {"@Tasnica/Tasnica Miniboss",true},
        [0x66a] = {"@Ice Country/Ice Castle/Ice Castle Boss 1",true},
    }
    EVENT_FLAGS = {
        0xC8, --gloves
        0xC9, --sword
        0xCA, --axe
        0xCB, --spear
        0xCC, --spear
        0xCD, --bow
        0xCE, --boomerang
        0xCF, --javelin
        0x90, --water seed
        0x91, --earth seed
        0x92, --wind seed
        0x93, --fire seed
        0x94, --light seed
        0x95, --dark seed
        0x96, --moon seed
        0x97, --dryad seed
        0xA8, --gnome
        0xA9, --undine
        0xAA, --salamando
        0xAB, --sylphid
        0xAC, --lumina
        0xAD, --shade
        0xAE, --luna
        0xAF, --dryad
        0x37, --gold key
        0x29, --sht
        0x74, --moogle belt
        0x5C, --midge mallet
        0x0C, --boy
        0x0D, --girl
        0x0E, --sprite
        0x76, --gold
        0x77,
        0x78,
        0x79,
        0x7A,
        0x7B,
        0x7C,
        0x7D,
        0x7E,
        0x04, --weapon orbs
        0x05,
        0x06,
        0x07,
        0x08,
        0x1F,
        0x23,
        0x3d,
        0x3e,
        0x51,
        0x52,
        0x62,
        0x63,
        0x64,
        0x65,
        0x66,
        0x67,
        0x69,
        0x6a,
        0x6b,
        0x6c,
        0x6d,
        0x6e,
        0xA1,
        0xA2,
        0xA3,
        0xD3,
        0xD4,
        0xD5,
        0xD6,
        0xD0,
        0xD7,
        0xDA,
        0xDB,
        0xDD,
        0xDE,
        0xdc,
        0xdf,
        0xe0,
        0xe1,
        0xe2,
    }
    NOTHING_EVENTS = {
    }         
    CURRENT_EVENT_POINTER_ADDR = 0x7E00D1
    EVENT_POINTER_TABLE_ADDR_ADDR = 0x1E7A3
    EVENT_POINTER_TABLE_ADDR = nil
    ADDED_EVENT_DATA_MEMORY_WATCHES = false
    EVENT_DATA_WATCH_SIZE = 0xFF
    ADDED_EVENT_POINTER_TABLE_MEMORY_WATCH = false