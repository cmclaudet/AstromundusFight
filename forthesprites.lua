
--function to define sprite status at a given moment
function GetInstance (sprite_def)
  if sprite_def == nil then return nil end

  return {
    sprite = sprite_def,
    curr_anim = sprite_def["animation_names"][1],
    curr_frame = 1,
    elapsed_time = 0,
    size_scale = 1,
    time_scale = 1,
    rotation = 0,
    offset_x = 16,
    offset_y = 0,
    flip_h = 1,
    flip_v = 1
  }
end

--update sprite and loop through animation frames
function UpdateInstance (spr, dt)
  if spr.elapsed_time > spr.sprite["frame_duration"]*spr.time_scale then

    if spr.curr_frame < #spr.sprite["animations"][spr.curr_anim] then
      spr.curr_frame = spr.curr_frame + 1
    else
      spr.curr_frame = 1
    end

    spr.elapsed_time = 0

  end
  spr.elapsed_time = spr.elapsed_time + dt
end

--draw sprite
function DrawInstance (spr, x, y)
  love.graphics.draw(
  spr.sprite["sprite_sheet"],
  spr.sprite["animations"][spr.curr_anim][spr.curr_frame],
  x,
  y,
  spr.rotation,
  spr.flip_h,
  spr.flip_v,
  spr.offset_x
  )
end
