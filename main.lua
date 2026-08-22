local ui = require("frontend.ui")
--local chamcong = require("backend.chamcong")

local run = true
local UItrangthai = "menu"

for i = 1, 1 do --load
  os.execute("clear")
  ui.load("logo")
  io.read()
  os.execute("clear")
  ui.load("menu")
end

while run do
  for i = 1, 1 do --update
    io.write("/"..UItrangthai.." > ")
    local phim = io.read()
    if phim == "5" then
      UItrangthai = "leave"
      run = false
    end
  end

  for i = 1, 1 do --draw
    os.execute("clear")
    ui.load(UItrangthai)
  end
end

