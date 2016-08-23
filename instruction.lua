--instructions for player

function controls()
  font1 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",10)
  font2 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",15)
  font3 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",20)
  font1:setFilter( 'nearest', 'nearest' )
  font2:setFilter( 'nearest', 'nearest' )
  font3:setFilter( 'nearest', 'nearest' )

  love.graphics.setFont(font3)
  love.graphics.setColor(255,255,0)
  love.graphics.printf("CONTROLS", windowwidth/6-150, 5, 300, "center")

  love.graphics.setFont(font2)
  player2_w = font2:getWidth("PLAYER 2")
  love.graphics.setColor(255,255,255)
  love.graphics.print("PLAYER 1", windowwidth/6-50, 35)
  love.graphics.print("PLAYER 2", windowwidth/3-(10+player2_w), 35)

  love.graphics.setFont(font1)
  love.graphics.print("LEFT", 15, 55)
  love.graphics.print("RIGHT", 15, 70)
  love.graphics.print("UP", 15, 85)
  love.graphics.print("DOWN", 15, 100)
  love.graphics.print("ATTACK", 15, 115)
  love.graphics.print("SELECT", 15, 130)
  love.graphics.print("CANCEL", 15, 145)

  player1_w = font2:getWidth("PLAYER 1")
  p1cx = windowwidth/6-50+player1_w/2
  love.graphics.setColor(255,255,0)
  love.graphics.print("d", p1cx, 55)
  love.graphics.print("a", p1cx, 70)
  love.graphics.print("w", p1cx, 85)
  love.graphics.print("s", p1cx, 100)
  love.graphics.print("e", p1cx, 115)
  love.graphics.print("e", p1cx, 130)
  love.graphics.print("q", p1cx, 145)

  p2cx = windowwidth/3-(10+player2_w)+player2_w/2
  love.graphics.print("l", p2cx, 55)
  love.graphics.print("j", p2cx, 70)
  love.graphics.print("i", p2cx, 85)
  love.graphics.print("k", p2cx, 100)
  love.graphics.print("u", p2cx, 115)
  love.graphics.print("u", p2cx, 130)
  love.graphics.print("o", p2cx, 145)

  love.graphics.setFont(font2)
  love.graphics.printf("PRESS BACK TO RETURN", windowwidth/6-150, windowheight/3-30, 300, "center")
end
