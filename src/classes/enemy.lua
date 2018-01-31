local Class  = require("lib.middleclass")
local Vector = require("lib.vector")

local Entity = require("src.entity")

local Enemy = Entity("Enemy", Entity)

function Enemy:initialize(t)
  Entity.initialize(self, t)

  self.isEnemy = true
end



return Enemy
