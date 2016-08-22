counter = {}

--x, y are the top left co-ords and w, h are the width and height of the collision box
function checkcollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

--return to idle
function toidle(player)
  player.char.curr_anim = player.char.sprite["animation_names"][1]
  player.char.curr_frame = 1
  player.state = "control"
end

--changes to basic attack animation
function basic(key, player)
  if key == player.attack and player.state == "control" then
    player.char.curr_anim = player.char.sprite["animation_names"][3]
    player.char.curr_frame = 1
    player.state = "nocontrol"
  end
end

--change to hurt animation and no control if a player is hit
function collisions(player,scdplayer)

  --hit box changes depending on which way player is facing
  if player.char.flip_h == 1 then
    x1 = player.x+player.char.sprite["hit_box_basic"]["dxR"]
  elseif player.char.flip_h == -1 then
    x1 = player.x+player.char.sprite["hit_box_basic"]["dxL"]
  end

  --defining hit box of attacking player and hurt box of other player
  y1 = player.y+player.char.sprite["hit_box_basic"]["dy"]
  w1 = player.char.sprite["hit_box_basic"]["w"]
  h1 = player.char.sprite["hit_box_basic"]["h"]

  x2 = scdplayer.x+scdplayer.char.sprite["hurt_box"]["dx"]
  y2 = scdplayer.y+scdplayer.char.sprite["hurt_box"]["dy"]
  w2 = scdplayer.char.sprite["hurt_box"]["w"]
  h2 = scdplayer.char.sprite["hurt_box"]["h"]

  if player.char.curr_anim == player.char.sprite["animation_names"][3] then
    if checkcollision(x1, y1, w1, h1, x2, y2, w2, h2) and player.char.curr_frame == 1 and player.state ~= "dead" then
      table.insert(counter,1)
      scdplayer.char.curr_anim = scdplayer.char.sprite["animation_names"][4]
      scdplayer.char.curr_frame = 1
      scdplayer.state = "nocontrol"

      if #counter == 1 then   --only removes specified damage once per attack as counter is cleared at end of animation
        player.char.sprite.dmg_sound:play()
        scdplayer.char.sprite.health = scdplayer.char.sprite.health - (100/scdplayer.char.sprite.max_health)*player.char.sprite.basic_dmg
      end

      if scdplayer.char.sprite.health <= 0 then
        scdplayer.state = "dead"
        for k in pairs(counter) do
          counter[k] = nil end
      end
    end
  end
end

--walking and checking for collisions and returning to idle
function allupdates(player, scdplayer, dt)
  if player.state == "control" then
    if love.keyboard.isDown(player.right) then
      player.char.curr_anim = player.char.sprite["animation_names"][2]
      player.char.flip_h = 1
      if player.x < (windowwidth/3 - 16) then
        player.x = player.x + player.speed*dt
      end
    end

    if love.keyboard.isDown(player.left) then
      player.char.curr_anim = player.char.sprite["animation_names"][2]
      player.char.flip_h = -1
      if player.x > 16 then
        player.x = player.x - player.speed*dt
      end
    end
  end

  collisions(player,scdplayer)

  --return to idle after basic attack animation and hurt animation
  if player.char.curr_anim == player.char.sprite["animation_names"][3] and player.char.curr_frame == #player.char.sprite["animations"][player.char.curr_anim] then
    toidle(player) end

  if scdplayer.char.curr_anim == scdplayer.char.sprite["animation_names"][4] and scdplayer.char.curr_frame == 4 then --#scdplayer.char.sprite["animations"][scdplayer.char.curr_anim]
    for k in pairs(counter) do
      counter[k] = nil end
    toidle(scdplayer)
  end

  --ensure player can always control if in idle state
  if player.char.curr_anim == player.char.sprite["animation_names"][1] then
    player.state = "control" end

end
