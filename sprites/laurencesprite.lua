--holds sprite data for character laurence

laurencesprite = {}

local SourceImage = love.graphics.newImage("assets/laurencespritesheet.png")
SourceImage:setFilter( 'nearest', 'nearest' )    --Scales image so that pixels are sharp

local headbuttsound = love.audio.newSource("assets/sound/HeadButt.wav","static")

local image_w = SourceImage:getWidth()
local image_h = SourceImage:getHeight()

function laurencesprite.info()
return {
  sprite_sheet = SourceImage,
  sprite_name = "laurence",

  frame_duration = 0.17,

  animation_names = {
    "idle",
    "walk",
    "headbutt",
    "hurt",
    "dead"
    },

  animations = {
    idle = {
      love.graphics.newQuad(1,41,32,39,image_w,image_h)
    },
    walk = {
      love.graphics.newQuad(1,1,32,40,image_w,image_h),
      love.graphics.newQuad(32,1,32,40,image_w,image_h),
      love.graphics.newQuad(64,1,32,40,image_w,image_h),
      love.graphics.newQuad(96,1,32,40,image_w,image_h),
      love.graphics.newQuad(128,1,32,40,image_w,image_h),
      love.graphics.newQuad(160,1,32,40,image_w,image_h)
    },
    headbutt = {
      love.graphics.newQuad(64,41,32,39,image_w,image_h),
      love.graphics.newQuad(64,41,32,39,image_w,image_h),
      love.graphics.newQuad(32,41,32,39,image_w,image_h),
      love.graphics.newQuad(32,41,32,39,image_w,image_h),
      love.graphics.newQuad(1,41,32,39,image_w,image_h)
    },
    hurt = {
      love.graphics.newQuad(96,41,32,39,image_w,image_h),
      love.graphics.newQuad(96,41,32,39,image_w,image_h),
      love.graphics.newQuad(96,41,32,39,image_w,image_h),
      love.graphics.newQuad(96,41,32,39,image_w,image_h)
    },
    dead = {
      love.graphics.newQuad(128,41,40,39,image_w,image_h),
      love.graphics.newQuad(128,41,40,39,image_w,image_h),
      love.graphics.newQuad(128,41,40,39,image_w,image_h),
      love.graphics.newQuad(128,41,40,39,image_w,image_h)
    }
  },

  icon = love.graphics.newQuad(9,44,13,14,image_w,image_h),

  hurt_box = {
    dx = -6,
    dy = 5,
    w = 12,
    h = 35
  },

  hit_box_basic = {
    dxR = 6,
    dxL = -16,
    dy = 5,
    w = 10,
    h = 10
  },

  health = 100,
  max_health = 100,

  basic_dmg = 5,
  height = 40,

  dmg_sound = headbuttsound
}
end
return laurencesprite
