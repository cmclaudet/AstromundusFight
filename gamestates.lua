local startp1 = 50
local startp2 = 220

--draw title and reset player status for new battle
function title(player1,player2)
  love.graphics.draw(titleimg,windowwidth/6-titleimg:getWidth()/2, 25)
  love.graphics.setFont(font1)
  love.graphics.printf("Press ENTER to play", windowwidth/6-125, windowheight/6+30, 250, "center")
  player1.x = startp1
  player2.x = startp2
  player1.char.curr_anim = player1.char.sprite["animation_names"][1]
  player2.char.curr_anim = player2.char.sprite["animation_names"][1]
  player1.char.curr_frame = 1
  player2.char.curr_frame = 1
  player1.char.sprite.health = player1.char.sprite.max_health
  player2.char.sprite.health = player2.char.sprite.max_health
  player1.char.flip_h = 1
  player2.char.flip_h = -1
end

--fight is over, allow player to start a new game
function fightend(winner,loser)
  loser.state = "dead"
  loser.char.curr_anim = loser.char.sprite["animation_names"][5]
  love.graphics.setColor(255,255,0)
  love.graphics.setFont(font2)

  if winner == player2 then
    love.graphics.printf("PLAYER 2 WINS!",windowwidth/6-120,windowheight/6-50,250,"center")
  else
    love.graphics.printf("PLAYER 1 WINS!",windowwidth/6-120,windowheight/6-65,250,"center") end

  love.graphics.setFont(font1)
  love.graphics.printf("Press ENTER to play again",windowwidth/6-125,windowheight/6-20,250,"center")

end
