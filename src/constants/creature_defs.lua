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
        grabSound = 'hey-sheep',
        color = 'none',
        width = 25,
        height = 20,
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
        grabSound = 'oi',
        width = 50,
        height = 48,
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
        grabSound = 'deephey',
        width = 22,
        height = 46,
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
    ['goat'] = {
        species = 'goat',
        grabSound = 'hey-sheep',
        color = 'none',
        width = 20,
        height = 19,
        walkSpeed = 5,
        texture = 'goat',
        animations = {
            ['idle-down'] = {
                frames = { 1, 2, 3 },
                interval = 0.2,
                texture = 'goat',
            },
            ['grabbed-down'] = {
                frames = { 1, 2 },
                interval = 0.02,
                texture = 'goat',
            },
            ['fall-down'] = {
                frames = { 1, 2, 3 },
                interval = 0.2,
                texture = 'goat',
            },
        },
    },
    ['bird'] = {
        species = 'bird',
        grabSound = 'oi',
        color = 'none',
        width = 30,
        height = 28,
        walkSpeed = 25,
        texture = 'bird',
        animations = {
            ['idle-down'] = {
                frames = { 1, 2, 3 },
                interval = 0.2,
                texture = 'bird',
            },
            ['grabbed-down'] = {
                frames = { 1, 3 },
                interval = 0.02,
                texture = 'bird',
            },
            ['fall-down'] = {
                frames = { 1, 3 },
                interval = 0.2,
                texture = 'bird',
            },
        },
    },
    --[[ ['greekCitizen'] = {
        species = 'greekCitizen',
        grabSound = 'oi',
        color = 'none',
        height = 25,
        width = 25,
        walkSpeed = 15,
        texture = 'greekCitizen',
        animations = {
            ['idle-down'] = {
                frames = { 1 },
                interval = 0.2,
                texture = 'greekCitizen',
            },
            ['grabbed-down'] = {
                frames = { 1 },
                interval = 0.02,
                texture = 'greekCitizen',
            },
            ['fall-down'] = {
                frames = { 1 },
                interval = 0.2,
                texture = 'greekCitizen',
            },
        },
    }, ]]
}
--'goat', 'lamb', 'dog', 'bird', 'wheat', 'wine', 'purple toga human', 'pants barbarian', 'white toga human', 'blue tunic human', 'egyptian hat human'

