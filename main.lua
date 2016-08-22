require "forthesprites" --Include sprite handling
require "control"       --Include control functions
require "gamestates"    --Include gamestate functions
local luissprite = require("luissprite")  --Include sprite data
local laurencesprite = require("laurencesprite")
local tadejasprite = require("tadejasprite")
local catsprite = require("catsprite")
local player = require("player")
local gamestate = "title"    --Game state
local scale = 3         --image size scale factor

--import custom font ARCADE CALSSIC, credit to Jakob Fischer, www.pizzadude.dk
font1 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",10)
font2 = love.graphics.newFont("assets/ARCADECLASSIC.TTF",20)
font1:setFilter( 'nearest', 'nearest' )
font2:setFilter( 'nearest', 'nearest' )
love.graphics.setFont(font1)

--Get window dimensions
windowwidth = love.graphics.getWidth()
windowheight = love.graphics.getHeight()

--load all images and define player1 and player2
function love.load()
    --defining characters for both player 1 and 2. Need separate characters in case both players pick the same character
    luis1 = GetInstance (luissprite.info())
    luis2 = GetInstance (luissprite.info())
    laurence1 = GetInstance (laurencesprite.info())
    laurence2 = GetInstance (laurencesprite.info())
    tadeja1 = GetInstance (tadejasprite.info())
    tadeja2 = GetInstance (tadejasprite.info())
    cat1 = GetInstance (catsprite.info())
    cat2 = GetInstance (catsprite.info())

    --initialise players. Will be changed at character select
    player1 = player.first(luis1)
    player2 = player.second(laurence2)

    background = love.graphics.newImage("assets/innsbruck.png")
    titleimg = love.graphics.newImage("assets/title.png")
    background:setFilter( 'nearest', 'nearest' )    --Scales image so that pixels are sharp
    titleimg:setFilter( 'nearest', 'nearest' )

    playmusic = love.audio.newSource("assets/sound/ChibiNinja.mp3")
    overmusic = love.audio.newSource("assets/sound/HerosDayOff.mp3")
    startsound = love.audio.newSource("assets/sound/Start.wav","static")

    --healthbar positions and dimensions
    healthbar_x1 = 15
    healthbar_x2 = windowwidth/3-(healthbar_x1+100)
    healthbar_y = 25
    healthbar_l = 5
    healthbar_w1 = 100
    healthbar_w2 = 100
    rect_corner = 2
end

--check if player attacks or changes game state
function love.keypressed(key)
  if key == "return" and gamestate == "title" then
    startsound:play()
    gamestate = "charselect"
  end
  if gamestate == "charselect" then
    --function handles choosing character mechanic
    choose(key,player1)
    choose(key,player2)
    --only when both players have selected a character can game begin
    if key == "return" and player1.state == "ready" and player2.state == "ready" then
      startsound:play()
      play(player1,player2)
      gamestate = "play"
    end
  end
  --can restart game
  if key == "return" and gamestate == "gameover" then
    startsound:play()
    restart(player1,player2)
    gamestate = "title"
  end

  --player may attack when gamestate is play
  if gamestate == "play" then
    basic(key, player1)
    basic(key, player2)
  end
end

--changes to idle animation after release of walk control
function walkrelease(key, player)
  if gamestate == "play" or gamestate == "gameover" then
    if player.state == "control" then
      if key == player.left then
        toidle(player)
        player.char.flip_h = -1
      elseif key == player.right then
        toidle(player)
        player.char.flip_h = 1 end
    end
  end
end

--triggers walk release which puts player to idle in correct direction
function love.keyreleased(key)
  walkrelease(key, player1)
  walkrelease(key, player2)
end

--update game instances
function love.update(dt)
  --allows user to quit game with escape
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  if gamestate == "play" or gamestate == "gameover" then
    allupdates(player1, player2, dt)    --updates player status
    allupdates(player2, player1, dt)
    UpdateInstance(player1.char, dt)    --updates sprite frame and animations
    UpdateInstance(player2.char, dt)
  end
end

function drawUI(player1,player2)
  love.graphics.draw(background)

  --draws health bar outline
  love.graphics.rectangle("line",healthbar_x1,healthbar_y,healthbar_w1,healthbar_l,rect_corner,rect_corner)
  love.graphics.rectangle("line",healthbar_x2,healthbar_y,healthbar_w2,healthbar_l,rect_corner,rect_corner)

  --draws health bar background
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",healthbar_x1,healthbar_y,healthbar_w1,healthbar_l,rect_corner,rect_corner)
  love.graphics.rectangle("fill",healthbar_x2,healthbar_y,healthbar_w2,healthbar_l,rect_corner,rect_corner)

  love.graphics.setFont(font1)
  love.graphics.setColor(255,255,0)
  love.graphics.print("PLAYER 1",10,15)
  love.graphics.print("PLAYER 2",(windowwidth/3-50),15)
end

--draws characters, health bars and background
function drawcharacters(player1,player2)
  drawUI(player1,player2)
  --calls function to draw player
  love.graphics.setColor(255,255,255)
  DrawInstance (player1.char, player1.x, player1.y)
  DrawInstance (player2.char, player2.x, player2.y)

  --draws green health bar based on player's current health
  love.graphics.setColor(0,255,0)
  if player1.state ~= "dead" then    --no bar is drawn if player is dead
    love.graphics.rectangle("fill",healthbar_x1,healthbar_y,player1.char.sprite.health,healthbar_l,rect_corner,rect_corner)
  else
    winner = player2
    loser = player1
    if loser.char.curr_frame == #loser.char.sprite["animations"][loser.char.curr_anim] then   --check hurt animation is complete before player dies
      gamestate = "gameover" end    --change game state when player dies
  end

  if player2.state ~= "dead" then
    love.graphics.rectangle("fill",healthbar_x2,healthbar_y,player2.char.sprite.health,healthbar_l,rect_corner,rect_corner)
  else
    winner = player1
    loser = player2
    if loser.char.curr_frame ==  #loser.char.sprite["animations"][loser.char.curr_anim] then
      gamestate = "gameover" end
  end
end


function love.draw()
  love.graphics.scale(scale)    --zoom in by scale factor
  if gamestate == "title" then
    overmusic:stop()
    playmusic:play()
    title(player1,player2)
  end

  if gamestate == "charselect" then
    charselect(luis1,laurence1,tadeja1,cat1,luis2,laurence2,tadeja2,cat2,player1,player2)
  end

  if gamestate == "play" then
    drawcharacters(player1,player2)
  end

  if gamestate == "gameover" then
    playmusic:stop()
    overmusic:play()
    drawcharacters(player1,player2)
    gameover(winner,loser)
  end

  love.graphics.setColor(255,255,255)
end
