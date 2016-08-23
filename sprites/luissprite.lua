--holds sprite data for character luis

luissprite = {}

local SourceImage = love.graphics.newImage("assets/luisspritesheet.png")  --get sprite sheet
SourceImage:setFilter( 'nearest', 'nearest' )    --Scales image so that pixels are sharp

local kicksound = love.audio.newSource("assets/sound/Kick.wav","static")

local image_w = SourceImage:getWidth()
local image_h = SourceImage:getHeight()

function luissprite.info()
return {
  sprite_sheet = SourceImage,
  sprite_name = "luis",

  frame_duration = 0.17,

  animation_names = {
    "idle",
    "walk",
    "kick",
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
    kick = {
      love.graphics.newQuad(64,33,40,31,image_w,image_h),
      love.graphics.newQuad(64,33,40,31,image_w,image_h),
      love.graphics.newQuad(32,33,32,31,image_w,image_h),
      love.graphics.newQuad(1,33,32,31,image_w,image_h)
    },
    hurt = {
      love.graphics.newQuad(160,33,32,31,image_w,image_h),
      love.graphics.newQuad(160,33,32,31,image_w,image_h),
      love.graphics.newQuad(160,33,32,31,image_w,image_h),
      love.graphics.newQuad(160,33,32,31,image_w,image_h)
    },
    dead = {
      love.graphics.newQuad(128,32,32,32,image_w,image_h),
      love.graphics.newQuad(128,32,32,32,image_w,image_h),
      love.graphics.newQuad(128,32,32,32,image_w,image_h),
      love.graphics.newQuad(128,32,32,32,image_w,image_h)
    }
  },

  icon = love.graphics.newQuad(10,33,12,15,image_w,image_h),

  --character hurt box, defines top left corner with width and height
  hurt_box = {
    dx = -5,    --x offset from player x coord
    dy = 2,     --y offset from player y coord
    w = 10,     --box width
    h = 30      --box height
  },

  --character hit box for basic attack, defines top left corner with width and height
  hit_box_basic = {
    dxR = 15,     --x offset from player x coord when facing right
    dxL = -20,    --x offset from player x coord when facing left
    dy = 10,
    w = 5,
    h = 5
  },

  health = 100,
  max_health = 80,

  basic_dmg = 6,
  height = 32,

  dmg_sound = kicksound
}
end
return luissprite
