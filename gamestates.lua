windowwidth = love.graphics.getWidth()
windowheight = love.graphics.getHeight()
font1 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",10)
font3 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",21)
font4 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",18)
font5 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",14)
font1:setFilter( 'nearest', 'nearest' )
font3:setFilter( 'nearest', 'nearest' )
font4:setFilter( 'nearest', 'nearest' )
font5:setFilter( 'nearest', 'nearest' )

selectsound = love.audio.newSource("assets/sound/Select.wav","static")
movesound = love.audio.newSource("assets/sound/Menu_Move.wav","static")

local player = require("player")

local startp1 = 50      --x-coord for p1ayer1
local startp2 = 220     --x-coord for player2
local starty = 180      --y-coord

--draw title and reset player status for new battle
function title(player1,player2)
  love.graphics.draw(titleimg,windowwidth/6-titleimg:getWidth()/2, 25)
  love.graphics.setFont(font1)
  love.graphics.printf("Press ENTER to play", windowwidth/6-125, windowheight/6+30, 250, "center")
end

--fight is over, allow player to start a new game
function gameover(winner,loser)
  --change loser to dead animation
  loser.char.curr_anim = loser.char.sprite["animation_names"][5]
  love.graphics.setColor(255,255,0)
  love.graphics.setFont(font2)

  if winner == player2 then
    love.graphics.printf("PLAYER 2 WINS!",windowwidth/6-120,windowheight/6-50,250,"center")
  else
    love.graphics.printf("PLAYER 1 WINS!",windowwidth/6-120,windowheight/6-50,250,"center") end

  love.graphics.setFont(font1)
  love.graphics.printf("Press ENTER to play again",windowwidth/6-125,windowheight/6-20,250,"center")

end

--defines when player can move cursor up or down and what happens when player selects character
function choose(key,player)
  if key == player.down and player.cursor["movedown"] then
    player.cursor["y"] = player.cursor["y"] + 31  --add icon height plus icon separation to cursor y value when moving down once
    movesound:play()
    --can only move cursor down if cursor is above the lowest icon
    if player.cursor["y"] > 127 then
      player.cursor["movedown"] = false end
    player.cursor["moveup"] = true  --if movedown is successfully triggered moveup must always become true

  elseif key == player.up and player.cursor["moveup"] then
    movesound:play()
    player.cursor["y"] = player.cursor["y"] - 31
    if player.cursor["y"] < 65 then
      player.cursor["moveup"] = false end
    player.cursor["movedown"] = true

  elseif key == player.attack and player.cursor["confirmed"] == "no" then
    selectsound:play()
    player.cursor["alpha"] = 255 --make cursor opaque if choice is confirmed
    player.cursor["confirmed"] = "yes"
    player.cursor["movedown"] = false
    player.cursor["moveup"] = false
    player.state = "ready"  --when both players ready state may be changed

  elseif key == player.cancel and player.cursor["confirmed"] == "yes" then
    player.cursor["alpha"] = 150
    player.cursor["confirmed"] = "no"
    if player.cursor["y"] < 128 then
      player.cursor["movedown"] = true end
    if player.cursor["y"] > 65 then
      player.cursor["moveup"] = true end
    player.state = "notready"
  end
end

--drawing out all UI for character select screen and asigning correct character for player's choice
function charselect(luis1,laurence1,tadeja1,cat1,luis2,laurence2,tadeja2,cat2,player1,player2)
  love.graphics.setFont(font3)
  love.graphics.setColor(255,255,255,150)
  love.graphics.setLineWidth(1.5)
  love.graphics.line(windowwidth/6,1,windowwidth/6,windowheight/3)

  love.graphics.setColor(255,255,0)
  love.graphics.printf("CHOOSE YOUR CHARACTER", windowwidth/6-150, 5, 300, "center")

  --drawing boxes for icons and player characters
  love.graphics.setColor(255,0,0,150)
  love.graphics.rectangle("fill",15,35,70,120,10,10)
  love.graphics.rectangle("fill",93,35,27,27,3,3)
  love.graphics.rectangle("fill",93,66,27,27,3,3)
  love.graphics.rectangle("fill",93,97,27,27,3,3)
  love.graphics.rectangle("fill",93,128,27,27,3,3)

  love.graphics.setColor(0,0,255,150)
  love.graphics.rectangle("fill",171,35,70,120,10,10)
  love.graphics.rectangle("fill",135,35,27,27,3,3)
  love.graphics.rectangle("fill",135,66,27,27,3,3)
  love.graphics.rectangle("fill",135,97,27,27,3,3)
  love.graphics.rectangle("fill",135,128,27,27,3,3)

  love.graphics.setColor(255,255,0)
  love.graphics.setFont(font1)
  love.graphics.print("PLAYER 1", 12, 32)
  love.graphics.print("PLAYER 2", 208, 32)

  --drawing icons
  love.graphics.setColor(255,255,255)
  love.graphics.draw(luis1.sprite["sprite_sheet"],luis1.sprite["icon"],97,37,0,1.6,1.6)
  love.graphics.draw(luis1.sprite["sprite_sheet"],luis1.sprite["icon"],158,37,0,-1.6,1.6)
  love.graphics.draw(laurence1.sprite["sprite_sheet"],laurence1.sprite["icon"],95,70,0,1.6,1.6)
  love.graphics.draw(laurence1.sprite["sprite_sheet"],laurence1.sprite["icon"],160,70,0,-1.6,1.6)
  love.graphics.draw(tadeja1.sprite["sprite_sheet"],tadeja1.sprite["icon"],95,99,0,1.6,1.6)
  love.graphics.draw(tadeja1.sprite["sprite_sheet"],tadeja1.sprite["icon"],160,99,0,-1.6,1.6)
  love.graphics.draw(cat1.sprite["sprite_sheet"],cat1.sprite["icon"],95,128,0,1.6,1.6)
  love.graphics.draw(cat1.sprite["sprite_sheet"],cat1.sprite["icon"],160,128,0,-1.6,1.6)

  love.graphics.setFont(font5)
  love.graphics.setColor(255,255,255,player1.cursor["alpha"])
  love.graphics.rectangle("line",93,player1.cursor["y"],27,27,3,3)

  --assigning right character to player 1 based on where cursor is
  if player1.cursor["y"] == 35 then
    love.graphics.draw(luis1.sprite["sprite_sheet"],luis1.sprite["animations"]["idle"][1],18,63,0,2,2)
    love.graphics.print("Luis", 57, 148)
    player1.char = luis1
  elseif player1.cursor["y"] == 66 then
    love.graphics.draw(laurence1.sprite["sprite_sheet"],laurence1.sprite["animations"]["idle"][1],18,50,0,2,2)
    love.graphics.print("Laurence", 26, 148)
    player1.char = laurence1
  elseif player1.cursor["y"] == 97 then
    love.graphics.draw(tadeja1.sprite["sprite_sheet"],tadeja1.sprite["animations"]["idle"][1],18,63,0,2,2)
    love.graphics.print("Tadeja", 40, 148)
    player1.char = tadeja1
  elseif player1.cursor["y"] == 128 then
    love.graphics.draw(cat1.sprite["sprite_sheet"],cat1.sprite["animations"]["idle"][1],18,63,0,2,2)
    love.graphics.print("Cat", 65, 148)
    player1.char = cat1
  end

  love.graphics.setColor(255,255,255,player2.cursor["alpha"])
  love.graphics.rectangle("line",135,player2.cursor["y"],27,27,3,3)

  --assigning right character to player 2 also based on cursor position
  if player2.cursor["y"] == 35 then
    love.graphics.draw(luis1.sprite["sprite_sheet"],luis1.sprite["animations"]["idle"][1],235,63,0,-2,2)
    love.graphics.print("Luis", 169, 148)
    player2.char = luis2
  elseif player2.cursor["y"] == 66 then
    love.graphics.draw(laurence1.sprite["sprite_sheet"],laurence1.sprite["animations"]["idle"][1],235,50,0,-2,2)
    love.graphics.print("Laurence", 169, 148)
    player2.char = laurence2
  elseif player2.cursor["y"] == 97 then
    love.graphics.draw(tadeja1.sprite["sprite_sheet"],tadeja1.sprite["animations"]["idle"][1],235,63,0,-2,2)
    love.graphics.print("Tadeja", 169, 148)
    player2.char = tadeja2
  elseif player2.cursor["y"] == 128 then
    love.graphics.draw(cat1.sprite["sprite_sheet"],cat1.sprite["animations"]["idle"][1],235,63,0,-2,2)
    love.graphics.print("Cat", 169, 148)
    player2.char = cat2
  end

  --when both players have confirmed players are informed how to start the fight
  if player1.cursor["confirmed"] == "yes" and player2.cursor["confirmed"] == "yes" then
    love.graphics.setColor(255,255,0)
    love.graphics.setFont(font4)
    love.graphics.printf("PRESS ENTER TO FIGHT", windowwidth/6-150, 170, 300, "center")
  end
end

--resets player stats for play state
function play(player1,player2)
  player1.y = starty - player1.char.sprite.height
  player2.y = starty - player2.char.sprite.height
  player1.x = startp1
  player2.x = startp2
  player1.char.sprite.health = 100
  player2.char.sprite.health = 100
  player1.char.curr_anim = player1.char.sprite["animation_names"][1]
  player1.char.curr_frame = 1
  player2.char.curr_anim = player2.char.sprite["animation_names"][1]
  player2.char.curr_frame = 1
  player1.char.flip_h = 1
  player2.char.flip_h = -1
  player1.state = "control"
  player2.state = "control"
end

--resets stats for character choosing state
function restart(player1,player2)
  player1.cursor["movedown"] = true
  player1.cursor["moveup"] = false
  player1.cursor["confirmed"] = "no"
  player1.cursor["y"] = 35
  player1.cursor["alpha"] = 150
  player1.state = "notready"

  player2.cursor["movedown"] = true
  player2.cursor["moveup"] = false
  player2.cursor["confirmed"] = "no"
  player2.cursor["y"] = 35
  player2.cursor["alpha"] = 150
  player2.state = "notready"
end
