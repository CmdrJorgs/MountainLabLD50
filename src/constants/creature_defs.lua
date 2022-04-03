CREATURE_DEFS = {
    ['bull'] = {
        species = 'bull',
        color = 'none',
        height = 126,
        width = 180,
        walkSpeed = 1,
        texture = 'bull',
        animations = {
            ['idle-down'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.2,
                texture = 'bull',
            },
            ['grabbed-down'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.1,
                texture = 'bull',
            },
            ['fall-down'] = {
                frames = { 1, 2, 3, 4, 5 },
                interval = 0.2,
                texture = 'bull',
            },
        },
    },
    ['goat'] = {
        species = 'goat',
        color = 'none',
        texture = 'goat',
        height = 192,
        width = 192,
        animations = {
            ['idle-down'] = {
                frames = { 70, 71, 72, 71 },
                interval = 0.2
            },
            ['grabbed-down'] = {
                frames = { 70, 71, 72, 71 },
                interval = 0.1
            },
            ['fall-down'] = {
                frames = { 70, 71, 72, 71 },
                interval = 0.2
            },
        },
    },
}
--'goat', 'lamb', 'dog', 'bird', 'wheat', 'wine', 'purple toga human', 'pants barbarian', 'white toga human', 'blue tunic human', 'egyptian hat human'

