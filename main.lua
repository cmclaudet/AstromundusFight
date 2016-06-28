require "forthesprites" --Include sprite handling
require "control"       --Include control functions
require "gamestates"    --Include gamestate functions
local luissprite = require("luissprite")  --Include sprite data
local laurencesprite = require("laurencesprite")
local gamestate = "title"    --Game state
local startp1 = 50      --x-coord for p1ayer1
local startp2 = 220     --x-coord for player2
local starty = 180      --y-coord
local char_speed = 75   --walking speed
local scale = 3         --image size scale factor

--import custom font ARCADE CALSSIC, credit to Jakob Fischer, www.pizzadude.dk
font1 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",10)
font2 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",20)
love.graphics.setFont(font1)

--Get window dimensions
windowwidth = love.graphics.getWidth()
windowheight = love.graphics.getHeight()

--load all images and define player1 and player2
function love.load()
    luis = GetInstance (luissprite.info())
    laurence = GetInstance (laurencesprite.info())
    luis_height = luis.sprite.height
    laurence_height = laurence.sprite.height
    player1 = {x = startp1, y = starty - luis_height, speed = char_speed, state = "control", char = luis}
    player2 = {x = startp2, y = starty - laurence_height, speed = char_speed, state = "control", char = laurence}
    player2.char.flip_h = -1

    background = love.graphics.newImage("assets/innsbruck.png")
    titleimg = love.graphics.newImage("assets/title.png")
end

--check if walking key is released
function love.keyreleased(key)
  if key == "d" or key == "a" then
    if gamestate ~= "title" and player1.state == "control" then
    walkrelease(player1) end
  end
  if key == "right" or key == "left" then
    if gamestate ~= "title" and player2.state == "control" then
    walkrelease(player2) end
  end
end

--check if player attacks or changes game state
function love.keypressed(key)
  if key == "return" and gamestate == "title" then
    gamestate = "play"
  end

  if key == "return" and gamestate == "fightend" then
    gamestate = "title"
  end

  if key == "e" and player1.state == "control" then
    basic(player1)  end
  if key == "pageup" and player2.state == "control" then
    basic(player2)  end
end

--update game instances
function love.update(dt)
  --allows user to quit game with escape
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  if gamestate ~= "title" then
    allupdates(player1, player2, dt)    --updates player status
    allupdates(player2, player1, dt)
    UpdateInstance(player1.char, dt)    --updates sprite frame and animations
    UpdateInstance(player2.char, dt)
  end
end

--draws characters, health bars and background
function drawcharacters(player1,player2)
  love.graphics.draw(background)

  --calls function to draw player
  DrawInstance (player1.char, player1.x, player1.y)
  DrawInstance (player2.char, player2.x, player2.y)

  local healthbar_x1 = 15
  local healthbar_x2 = windowwidth/3-(healthbar_x1+player2.char.sprite.max_health)
  local healthbar_y = 25
  local healthbar_l = 5
  local healthbar_w1 = player1.char.sprite.max_health
  local healthbar_w2 = player2.char.sprite.max_health
  local rect_corner = 2
  local p1_health = player1.char.sprite.health
  local p2_health = player2.char.sprite.health

  --draws health bar outline
  love.graphics.rectangle("line",healthbar_x1,healthbar_y,healthbar_w1,healthbar_l,rect_corner,rect_corner)
  love.graphics.rectangle("line",healthbar_x2,healthbar_y,healthbar_w2,healthbar_l,rect_corner,rect_corner)

  --draws health bar background
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",healthbar_x1,healthbar_y,healthbar_w1,healthbar_l,rect_corner,rect_corner)
  love.graphics.rectangle("fill",healthbar_x2,healthbar_y,healthbar_w2,healthbar_l,rect_corner,rect_corner)

  --draws green health bar based on player's current health
  love.graphics.setColor(0,255,0)
  if player1.char.sprite.health > 0 then    --no bar is drawn if player is dead
    love.graphics.rectangle("fill",healthbar_x1,healthbar_y,p1_health,healthbar_l,rect_corner,rect_corner)
  else
    winner = player2
    loser = player1
    if loser.char.curr_frame == #loser.char.sprite["animations"][loser.char.curr_anim] then   --check hurt animation is complete before player dies
      gamestate = "fightend" end    --change game state
  end

  if player2.char.sprite.health > 0 then
    love.graphics.rectangle("fill",healthbar_x2,healthbar_y,p2_health,healthbar_l,rect_corner,rect_corner)
  else
    winner = player1
    loser = player2
    if loser.char.curr_frame ==  #loser.char.sprite["animations"][loser.char.curr_anim] then
      gamestate = "fightend" end
  end

  love.graphics.setColor(255,255,0)
  love.graphics.print("PLAYER 1",10,15)
  love.graphics.print("PLAYER 2",(windowwidth/3-50),15)
  love.graphics.print("Luis",15,32)
  love.graphics.print("Laurence",(windowwidth/3-63),32)
end


function love.draw()
  love.graphics.scale(scale,scale)    --zoom in by scale factor
  if gamestate == "title" then
    title(player1,player2)
  end

  if gamestate == "play" then
    drawcharacters(player1,player2)
  end

  if gamestate == "fightend" then
    drawcharacters(player1,player2)
    fightend(winner,loser)
  end

  love.graphics.setColor(255,255,255)
end
