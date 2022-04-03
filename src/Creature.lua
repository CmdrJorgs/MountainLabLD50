Creature = Class{}

function Creature:init(def)

    -- in top-down games, there are four directions instead of two
    self.direction = 'down'

    self.animations = self:createAnimations(def.animations)

    -- dimensions
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    -- drawing offsets for padded sprites
    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0

    self.walkSpeed = def.walkSpeed

    self.health = def.health

    --self.dead = false
end

function Creature:createAnimations(animations)
    local animationsReturned = {}
    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture,
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

--[[
    AABB with some slight shrinkage of the box on the top side for perspective.
]]
function Creature:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Creature:changeState(name)
    self.stateMachine:change(name)
end

function Creature:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Creature:enter_grab()
    self.stateMachine:change('grabbed')
end

function Creature:exit_grab(params)
    self.stateMachine:change('falling', {
        dx = params.dx,
        dy = params.dy
    })
end

function Creature:update(dt)
    self.stateMachine:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

-- if we want the entity to walk around on its own us this --
function Creature:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Creature:render(adjacentOffsetX, adjacentOffsetY)
    self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0)
    self.stateMachine:render()
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.x - (adjacentOffsetX or 0), self.y - (adjacentOffsetY or 0)
end
