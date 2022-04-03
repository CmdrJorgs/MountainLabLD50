require 'src/constants/creature_defs'
require 'src/constants/game_objects'
require 'src/constants/text'
require 'src/constants/graphics'

VIRTUAL_WIDTH = 768
VIRTUAL_HEIGHT = 432

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--
-- map constants
--
MAP_WIDTH = VIRTUAL_WIDTH -- / TILE_SIZE - 2
MAP_HEIGHT = VIRTUAL_HEIGHT -- math.floor(VIRTUAL_HEIGHT / TILE_SIZE) - 2
GROUND_HEIGHT = 150 -- from the top of the screen
--MAP_RENDER_OFFSET_X = (VIRTUAL_WIDTH - (MAP_WIDTH * TILE_SIZE)) / 2
--MAP_RENDER_OFFSET_Y = (VIRTUAL_HEIGHT - (MAP_HEIGHT * TILE_SIZE)) / 2
INIT_CREATURE_COUNT = 20
CURSOR_GRAB_RANGE = 8

ENTITY_FALL_ACCEL = 100

CREATURE_SICKLY_CHANCE = 0.1