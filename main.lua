local ui = require("frontend.ui")
--local chamcong = require("backend.chamcong")

local run = true
local UItrangthai = "menu"

for i = 1, 1 do --load
  ui.load("menu")
end

while run do
  for i = 1, 1 do --update
    io.read()
  end

  for i = 1, 1 do --draw
    os.execute("clear")
    ui.load(UItrangthai)
  end
  --run = false --testing
end

