require 'src/constants/creature_defs'
require 'src/constants/game_objects'
require 'src/constants/text'
require 'src/constants/graphics'
require 'src/constants/sounds'

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

---
--- creature generation constants
---

INIT_CREATURE_COUNT = 30
RESPAWN_TIME = 5 -- how many seconds must elapse before respawn happens (25% chance)
CREATURE_SICKLY_CHANCE = 0.1

---
--- creature state constants
---

ENTITY_FALL_ACCEL = 100

CURSOR_GRAB_RANGE = 8

---
--- speech bubble constants
---

TEXT_SPEECH_BUBBLE_PADDING = 4

---
--- game event timing constants
---

EXPLOSION_ANIMATION_TOTAL_DURATION = 6
EXPLOSION_ANIMATION_WIPE_START = 1
EXPLOSION_ANIMATION_WIPE_END = 5
