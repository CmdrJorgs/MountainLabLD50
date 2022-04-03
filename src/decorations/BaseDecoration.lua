-- Base class for game objects that display on top of
-- everything else and do not interact with the game.
-- This is used for speech bubbles and for the screen
-- wipe at the end of the game.

BaseDecoration = Class{}

function BaseDecoration:init() end
function BaseDecoration:update(dt) end
function BaseDecoration:render() end