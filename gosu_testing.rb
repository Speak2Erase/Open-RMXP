require "minigl"
include MiniGL
require "json"

require_relative "open_rmxp/requires"

class TestWindow < Gosu::Window
  def initialize(map = 14)
    @tilesets = JSON.load(File.open("Data_JSON/Tilesets.json"))
    @mapdata = JSON.load(File.open("Data_JSON/Map#{map.to_s.rjust(3, "0")}.json"))
    @tilemap = Tilemap.new(@tilesets["tilesets"][@mapdata["tileset_id"] - 1])
    @eventmap = Eventmap.new(@mapdata["events"], @tilesets["tilesets"][@mapdata["tileset_id"] - 1])
    @panomap = Panomap.new(@tilesets["tilesets"][@mapdata["tileset_id"] - 1])
    super 640, 480, { resizable: true }
    self.caption = "Test window"
  end

  def update
  end

  def draw
    fx = width.to_f / (@mapdata["width"] * 32)
    fy = fx
    @tilemap.draw(@mapdata["data"]["elements"], fx, fy)
    @eventmap.draw(fx, fy)
    @panomap.draw(fx, fy, width, height)
    draw_rect(0, 0, width.clone, height.clone, $global_settings.background_color, -500)
  end
end

$global_settings = GlobalSettings.new
$window = TestWindow.new
$window.show
