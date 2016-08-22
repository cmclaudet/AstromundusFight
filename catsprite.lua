--holds data for cat sprite

catsprite = {}

local SourceImage = love.graphics.newImage("assets/catspritesheet.png")  --get sprite sheet
SourceImage:setFilter( 'nearest', 'nearest' )    --Scales image so that pixels are sharp

local swipesound = love.audio.newSource("assets/sound/Swipe.wav","static")

local image_w = SourceImage:getWidth()
local image_h = SourceImage:getHeight()

function catsprite.info()
return {
  sprite_sheet = SourceImage,
  sprite_name = "cat",

  frame_duration = 0.17,

  animation_names = {
    "idle",
    "walk",
    "swipe",
    "hurt",
    "dead"
    },

  --specify quads of sprite sheet image for each animation
  animations = {
    idle = {
      love.graphics.newQuad(1,33,32,31,image_w,image_h)
    },
    walk = {
      love.graphics.newQuad(1,1,32,32,image_w,image_h),
      love.graphics.newQuad(32,1,32,32,image_w,image_h),
      love.graphics.newQuad(64,1,32,32,image_w,image_h),
      love.graphics.newQuad(96,1,32,32,image_w,image_h),
      love.graphics.newQuad(128,1,32,32,image_w,image_h),
      love.graphics.newQuad(160,1,32,32,image_w,image_h)
    },
    swipe = {
      love.graphics.newQuad(64,33,64,31,image_w,image_h),
      love.graphics.newQuad(64,33,64,31,image_w,image_h),
      love.graphics.newQuad(32,33,32,31,image_w,image_h),
      love.graphics.newQuad(1,33,32,31,image_w,image_h)
    },
    hurt = {
      love.graphics.newQuad(128,33,32,31,image_w,image_h),
      love.graphics.newQuad(128,33,32,31,image_w,image_h),
      love.graphics.newQuad(128,33,32,31,image_w,image_h),
      love.graphics.newQuad(128,33,32,31,image_w,image_h)
    },
    dead = {
      love.graphics.newQuad(160,32,32,32,image_w,image_h),
      love.graphics.newQuad(160,32,32,32,image_w,image_h),
      love.graphics.newQuad(160,32,32,32,image_w,image_h),
      love.graphics.newQuad(160,32,32,32,image_w,image_h)
    }
  },

  icon = love.graphics.newQuad(9,33,13,16,image_w,image_h),

  --character hurt box, defines top left corner with width and height
  hurt_box = {
    dx = -5,    --x offset from player x coord
    dy = 2,     --y offset from player y coord
    w = 10,     --box width
    h = 30      --box height
  },

  --character hit box for basic attack, defines top left corner with width and height
  hit_box_basic = {
    dxR = 18,     --x offset from player x coord when facing right
    dxL = -23,    --x offset from player x coord when facing left
    dy = 14,
    w = 5,
    h = 4
  },

  health = 100,
  max_health = 75,

  basic_dmg = 7,
  height = 32,

  dmg_sound = swipesound
}
end
return catsprite
