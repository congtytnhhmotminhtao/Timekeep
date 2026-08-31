local paper = require("engine.paper")
local thongke = require("backend.thongke")
local tinhtoan = require("backend.tinhtoan")
local chamcong = require("backend.chamcong")

local M = {}
--private

local khung = {
  background = " ",
  title = {
    text = "History",
    toado = {x = 1, y = 12}
  },
  mode = {
    trove = {
      text = "[q]~quit",
      toado = {x = 14, y = 2}
    },
    dieuhuong = {
      text = "[j]~trangtruoc/[k]~trangsau",
      toado = {x = 13, y = 2}
    },
    chitiet = {
      text = "/todate <#maphien>",
      toado = {x = 11, y = 2}
    },
    tinhtong = {
      text = "/tong <vnd>",
      toado = {x = 12, y = 2}
    }
  },
  vien = {
    dinh1 = {x = 1, y = 1},
    dinh2 = {x = 1, y = 29},
    dinh3 = {x = 15, y = 29},
    dinh4 = {x = 15, y = 1},
    duongthang = {
      tren = {format = "-", dau = {x = 1, y = 2}, cuoi = {x = 1, y = 28}},
      duoi = {format = "-", dau = {x = 15, y = 28}, cuoi = {x = 15, y = 2}},
      trai = {format = "|", dau = {x = 14, y = 1}, cuoi = {x = 2, y = 1}},
      phai = {format = "|", dau = {x = 2, y = 29}, cuoi = {x = 14, y = 29}}
    }
  }
}


local history = paper.taopaper(15, 29, khung.background)

--public
function M.ui(trang)
  trang = trang or 1
  local dslichsu, tongsotrang = thongke.history()
  paper.datlaipaper(history)
  --khung
  local dinh = khung.vien
  local dt = khung.vien.duongthang
  paper.ve(history, "+", dinh.dinh1.x, dinh.dinh1.y)
  paper.ve(history, "+", dinh.dinh2.x, dinh.dinh2.y)
  paper.ve(history, "+", dinh.dinh3.x, dinh.dinh3.y)
  paper.ve(history, "+", dinh.dinh4.x, dinh.dinh4.y)

  paper.veduongthang(history, dt.tren.format, dt.tren.dau.x, dt.tren.dau.y, dt.tren.cuoi.x, dt.tren.cuoi.y)
  paper.veduongthang(history, dt.duoi.format, dt.duoi.dau.x, dt.duoi.dau.y, dt.duoi.cuoi.x, dt.duoi.cuoi.y)
  paper.veduongthang(history, dt.trai.format, dt.trai.dau.x, dt.trai.dau.y, dt.trai.cuoi.x, dt.trai.cuoi.y)
  paper.veduongthang(history, dt.phai.format, dt.phai.dau.x, dt.phai.dau.y, dt.phai.cuoi.x, dt.phai.cuoi.y)
  --title
  local title = khung.title
  paper.viet(history, title.text, title.toado.x, title.toado.y)
  --dieuhuong
  local dh = khung.mode.dieuhuong
  paper.viet(history, dh.text, dh.toado.x, dh.toado.y)
  --trove
  local tv = khung.mode.trove
  paper.viet(history, tv.text, tv.toado.x, tv.toado.y)
  --chitiet
  local ct = khung.mode.chitiet
  paper.viet(history, ct.text, ct.toado.x, ct.toado.y)
  --tinh luong
  local tl = khung.mode.tinhtong
  paper.viet(history, tl.text, tl.toado.x, tl.toado.y)
  --xu ly trang
  local tranghientaiui = string.format("sotrang %d %d", trang, tongsotrang)
  paper.viet(history, tranghientaiui, 3, 3)

  local x, y = 5, 3
  for j = 1, 5 do
    if not dslichsu[trang] or not dslichsu[trang][j] then
      break
    end
    local p = dslichsu[trang][j]
    local gioratext = p.chuoira or "..."
    local dongtext = string.format("#%d %s %s-%s", p.maphien, p.ngay, p.chuoivao, gioratext)
    paper.viet(history, dongtext, x, y)
    x = x + 1
  end

  paper.inpaper(history)
end

function M.chitiet(phien)
  paper.datlaipaper(history)
  -- ve khung giong M.ui() ...
  paper.viet(history, "Chi tiet", 1, 10)

  if not phien then
    paper.viet(history, "Khong tim thay phien nay!", 5, 2)
  else
    paper.viet(history, "Ma phien: " .. phien.maphien, 4, 2)
    paper.viet(history, "Ngay: " .. phien.ngay, 5, 2)
    paper.viet(history, "Gio vao: " .. phien.chuoivao, 6, 2)
    paper.viet(history, "Gio ra: " .. (phien.chuoira or "..."), 7, 2)
    paper.viet(history, "Tong gio: " .. (phien.tonggio or "..."), 8, 2)
    if phien.ghichu and phien.ghichu ~= "" then
      paper.viet(history, "Ghi chu: " .. phien.ghichu, 9, 2)
    end
  end

  paper.viet(history, "[q]~quit", 12, 2)
  paper.inpaper(history)
end

function M.tongluongui(tien)
  paper.datlaipaper(history)
  local luong = tinhtoan.tongluong(chamcong.dsphien(), tien)
  
  paper.viet(history, "Tong luong", 1, 10)

  paper.viet(history, string.format("hien tai: %.0f vnđ", luong), 2, 3)

  paper.viet(history, khung.mode.trove.text, khung.mode.trove.toado.x, khung.mode.trove.toado.y)
  paper.inpaper(history)
end







return M

