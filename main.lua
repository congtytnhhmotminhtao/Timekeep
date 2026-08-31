local ui = require("frontend.ui")
local trangthai = require("backend.trangthai")
local chamcong = require("backend.chamcong")
local tai = require("backend.tai")
local nap = require("backend.nap")
local luutru = require("backend.luutru")
local thongke = require("backend.thongke")
local qlf = require("engine.quanlyfile")
local ltn = require("engine.ltn_claude")

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
    elseif phim == "3" and state.ui == "menu" then
      local _, tongsotrangMoi = thongke.history()
      state.tongsotrang = tongsotrangMoi
      state.trang = 1
      state.ui = "history"
    elseif phim == "4" and state.ui == "menu" then
      state.ui = "setting"
    elseif phim == "5" and state.ui == "menu" then
      state.ui = "leave"
      state.run = false
    elseif phim == "q" and (state.ui == "timekeepin" or state.ui == "timekeepout" or state.ui == "history") then
      state.ui = "menu"
    elseif phim == "j" and state.ui == "history" then
      state.trang = state.trang - 1
      if state.trang < 1 then
        state.trang = state.trang + 1
      end
    elseif phim == "k" and state.ui == "history" then
      state.trang = state.trang + 1
      if state.trang > state.tongsotrang then
        state.trang = state.trang - 1
      end
    elseif phim == "q" and (state.ui == "history_chitiet" or state.ui == "history_luong") then
      state.ui = "history"
    elseif phim:match("^/todate%s+(%d+)$") and state.ui == "history" then
      local ma = tonumber(phim:match("^/todate%s+(%d+)$"))
      state.phienChiTiet = chamcong.timPhienTheoMa(ma)
      state.ui = "history_chitiet"
    elseif phim:match("^/tong%s+(%d+)$") and state.ui == "history" then
      state.luong = tonumber(phim:match("^/tong%s+(%d+)$"))
      state.ui = "history_luong"
    elseif phim:match("^/reset") and state.ui == "history" then
      chamcong.xoadsphien()
      chamcong.xoaphienhientai()
      qlf.ghidefile("dulieuphien.ltn", ltn.mahoa(chamcong.Phien(), true))
      state.ui = "history"
    elseif phim == "q" and state.ui == "setting" then
      state.ui = "menu"
    end
  end

  for i = 1, 1 do --draw
    os.execute("clear")
    ui.load(state.ui, state.coPhien, state.trang, state.phienChiTiet, state.luong)
  end
end

