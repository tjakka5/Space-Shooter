local Class  = require("lib.middleclass")
local Vector = require("lib.vector")

local Entity = require("src.classes.entity")

local Player = Class("Player", Entity)
Player.texture = love.graphics.newImage("assets/player.png")

function Player:initialize(t)
  Entity.initialize(self, {
    position   = Vector(512 * 0.5, 768 * 0.925),
    dimensions = Vector(90, 50),
    friction   = 12,
    texture    = Player.texture
  })

  self.speed = t and t.speed or 10000

  self.isPlayer = true
end

function Player:input(dt)
  if love.keyboard.isDown("a") then
    self.velocity.x = self.velocity.x - self.speed * dt
  end

  if love.keyboard.isDown("d") then
    self.velocity.x = self.velocity.x + self.speed * dt
  end

  if love.keyboard.isDown("w", "space") then
    self:shoot(dt)
  end
end

function Player:shoot(dt)
  print("pew")
end

function Player:update(dt)
  self:input(dt)

  Entity.update(self, dt)
end

return Player
