local ui = require("frontend.ui")
local trangthai = require("backend.trangthai")
local chamcong = require("backend.chamcong")
local tai = require("backend.tai")
local nap = require("backend.nap")
local luutru = require("backend.luutru")

local state = trangthai.state

for i = 1, 1 do --load
  os.execute("clear")
  ui.load("logo")
  io.read()
  tai.filecoban()
  nap.chuongtrinh()
  os.execute("clear")
  ui.load("menu")
end

while state.run do
  for i = 1, 1 do --update
    io.write("/"..state.ui.." > ")
    local phim = io.read()
    if phim == "1" and state.ui == "menu" then
      state.coPhien = chamcong.vaoca()
      luutru.luuphien()
      state.ui = "timekeepin"
    elseif phim == "2" and state.ui == "menu" then
      state.coPhien = chamcong.raca()
      luutru.luuphien()
      state.ui = "timekeepout"
    elseif phim == "5" and state.ui == "menu" then
      state.ui = "leave"
      state.run = false
    elseif phim == "q" and (state.ui == "timekeepin" or state.ui == "timekeepout") then
      state.ui = "menu"
    end
  end

  for i = 1, 1 do --draw
    os.execute("clear")
    ui.load(state.ui, state.coPhien)
  end
end

