local startp1 = 50      --x-coord for p1ayer1
local startp2 = 220     --x-coord for player2
local starty = 180      --y-coord
local char_speed = 75   --walking speed

player = {}

function player.first(character)
return {
  x = startp1,
  y = starty - character.sprite.height,
  speed = char_speed,
  state = "notready",
  char = character,
  right = 'd',
  left = 'a',
  attack = 'e',
  up = 'w',
  down = 's',
  cancel = 'q',
  cursor = {movedown = true, moveup = false, confirmed = "no", y = 35, alpha = 150}
}
end

function player.second(character)
  character.flip_h = -1
return {
  x = startp2,
  y = starty - character.sprite.height,
  speed = char_speed,
  state = "notready",
  char = character,
  right = 'right',
  left = 'left',
  attack = 'pageup',
  up = 'up',
  down = 'down',
  cancel = 'pagedown',
  cursor = {movedown = true, moveup = false, confirmed = "no", y = 35, alpha = 150}
}
end

return player
