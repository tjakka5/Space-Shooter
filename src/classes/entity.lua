local Class  = require("lib.middleclass")
local Vector = require("lib.vector")
local List   = require("lib.list")

local World = require("src.world")

local Entity = Class("Entity")
Entity.list  = List()

function Entity:initialize(t)
  self.position = t and t.position or Vector(0, 0)
  self.velocity = t and t.velocity or Vector(0, 0)
  self.friction = t and t.friction or 0

  self.dimensions = t and t.dimensions or Vector(0, 0)
  self.filter     = t and t.filter     or function() end

  self.color   = t and t.color or {255, 255, 255, 255}
  self.texture = t and t.texture

  if self.dimensions.x > 0 and self.dimensions.y > 0 then
    World:add(self, self.position.x - self.dimensions.x/2, self.position.y - self.dimensions.y/2, self.dimensions.x, self.dimensions.y)
    self.hasCollider = true
  end

  self.isEntity = true

  Entity.list:add(self)
end

function Entity:destroy()
  if self.hasCollider then
    World:remove(self)
  end

  Entity.list:remove(self)
end

function Entity:move(dt)
  self.position = self.position + self.velocity * dt

  if self.hasCollider then
    local newX, newY, cols, len = World:move(self, self.position.x - self.dimensions.x/2, self.position.y - self.dimensions.y/2, self.filter)

    self.position.x = newX + self.dimensions.x/2
    self.position.y = newY + self.dimensions.y/2

    for i = 1, len do
      self:resolveCollision(cols[i])
    end
  end
end

function Entity:applyFriction(dt)
  local friction = -self.velocity:clone() * self.friction
  self.velocity = self.velocity + friction * dt
end

function Entity:resolveCollision(col)
end

function Entity:update(dt)
  self:applyFriction(dt)
  self:move(dt)
end

function Entity:draw()
  if self.texture then
    local w, h = self.texture:getDimensions()

    love.graphics.setColor(self.color)
    love.graphics.draw(self.texture, self.position.x, self.position.y, 0, nil, nil, w/2, h/2)
  end
end

return Entity
