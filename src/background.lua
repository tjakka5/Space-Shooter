local Background = {}
Background.position = 0
Background.speed    = 350
Background.texture  = love.graphics.newImage("assets/background.png")

function Background.reset()
  Background.position = 0
end

function Background.update(dt)
  Background.position = Background.position + Background.speed * dt
end

function Background.draw()
  love.graphics.setColor(255, 255, 255, 255)

  for x = 0, 1 do
    for y = -1, 2 do
      local x = x * 256
      local y = Background.position % 256 + y * 256

      love.graphics.draw(Background.texture, x, y)
    end
  end
end

return Background
