local Background = require("src.background")
local World      = require("src.world")

local Entity = require("src.classes.entity")
local Player = require("src.classes.player")

Player()

local Game = {}

function Game:enter()
end

function Game:leave()
end

function Game:update(dt)
  Background.update(dt)

  for _, entity in ipairs(Entity.list.objects) do
    entity:update(dt)
  end
end

function Game:draw()
  Background.draw()

  for _, entity in ipairs(Entity.list.objects) do
    entity:draw()
  end

  love.graphics.setColor(225, 30, 30)
  local items, len = World:getItems()
  for i = 1, len do
    local x, y, w, h = World:getRect(items[i])
    love.graphics.rectangle("line", x, y, w, h)
  end
end

return Game
