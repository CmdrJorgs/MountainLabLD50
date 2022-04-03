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
        height = 25,
        width = 25,
        walkSpeed = 15,
        texture = 'blueTogaHuman',
        animations = {
            ['idle-down'] = {
                frames = { 1 },
                interval = 0.2,
                texture = 'blueTogaHuman',
            },
            ['grabbed-down'] = {
                frames = { 1 },
                interval = 0.02,
                texture = 'blueTogaHuman',
            },
            ['fall-down'] = {
                frames = { 1 },
                interval = 0.2,
                texture = 'blueTogaHuman',
            },
        },
    },
}
--'goat', 'lamb', 'dog', 'bird', 'wheat', 'wine', 'purple toga human', 'pants barbarian', 'white toga human', 'blue tunic human', 'egyptian hat human'

