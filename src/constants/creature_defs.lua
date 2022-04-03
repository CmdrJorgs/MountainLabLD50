CREATURE_DEFS = {
    --['bull'] = {
    --    species = 'bull',
    --    color = 'none',
    --    height = 126,
    --    width = 180,
    --    walkSpeed = 1,
    --    texture = 'bull',
    --    animations = {
    --        ['idle-down'] = {
    --            frames = { 1, 2, 3, 4, 5 },
    --            interval = 0.2,
    --            texture = 'bull',
    --        },
    --    },
    --},
    ['sheep'] = {
        species = 'sheep',
        color = 'none',
        height = 20,
        width = 25,
        walkSpeed = 5,
        texture = 'sheep',
        animations = {
            ['idle-down'] = {
                frames = { 1, 2 },
                interval = 0.2,
                texture = 'sheep',
            },
            ['grabbed-down'] = {
                frames = { 1, 2 },
                interval = 0.02,
                texture = 'sheep',
            },
            ['fall-down'] = {
                frames = { 1, 2 },
                interval = 0.2,
                texture = 'sheep',
            },
        },
    },
    ['blueTogaHuman'] = {
        species = 'blueTogaHuman',
        color = 'blue',
        height = 48,
        width = 50,
        walkSpeed = 15,
        texture = 'blueTogaHuman',
        animations = {
            ['idle-down'] = {
                frames = { 1, 2, 3, 4 },
                interval = 0.1,
                texture = 'blueTogaHuman',
            },
            ['grabbed-down'] = {
                frames = { 5, 6 },
                interval = 0.1,
                texture = 'blueTogaHuman',
            },
            ['fall-down'] = {
                frames = { 1 },
                interval = 0.2,
                texture = 'blueTogaHuman',
            },
        },
    },
    ['whiteTogaHuman'] = {
        species = 'whiteTogaHuman',
        color = 'white',
        height = 46,
        width = 22,
        walkSpeed = 15,
        texture = 'whiteTogaHuman',
        animations = {
            ['idle-down'] = {
                frames = { 1, 2, 3, 4 },
                interval = 0.2,
                texture = 'whiteTogaHuman',
            },
            ['grabbed-down'] = {
                frames = { 1, 2, 3, 4 },
                interval = 0.05,
                texture = 'whiteTogaHuman',
            },
            ['fall-down'] = {
                frames = { 1 },
                interval = 0.2,
                texture = 'whiteTogaHuman',
            },
        },
    },
}
--'goat', 'lamb', 'dog', 'bird', 'wheat', 'wine', 'purple toga human', 'pants barbarian', 'white toga human', 'blue tunic human', 'egyptian hat human'

