local paper = require("engine.paper")

local M = {}

--private
local khung = {
  background = " ",
  title = {
    text = "timekeep in",
    toado = {x = 1, y = 4}
  },
  thongbao = {
    thanhcong = {
      text = "Da tao phien!",
      toado = {x = 3, y = 2}
    },
    thatbai = {
      text = "Da co phien roi!",
      toado = {x = 3, y = 2}
    }
  },
  mode = {
    text = "[q]~quit",
    toado = {x = 7, y = 2}
  },
  vien = {
    dinh1 = {x = 1, y = 1},
    dinh2 = {x = 9, y = 1},
    dinh3 = {x = 9, y = 18},
    dinh4 = {x = 1, y = 18},
    duongthang = {
      tren = {format = "-", dau = {x = 1, y = 17}, cuoi = {x = 1, y = 2}},
      duoi = {format = "-", dau = {x = 9, y = 2}, cuoi = {x = 9, y = 17}},
      trai = {format = "|", dau = {x = 2, y = 1}, cuoi = {x = 8, y = 1}},
      phai = {format = "|", dau = {x = 8, y = 18}, cuoi = {x = 2, y = 18}}
    }
  }
}--private table

local timekeep = paper.taopaper(9, 18, khung.background) --private table

--public
function M.ui(thanhCong) --public function, thanhCong = true/false
  paper.datlaipaper(timekeep)

  local v = khung.vien
  paper.ve(timekeep, "+", v.dinh1.x, v.dinh1.y)
  paper.ve(timekeep, "+", v.dinh2.x, v.dinh2.y)
  paper.ve(timekeep, "+", v.dinh3.x, v.dinh3.y)
  paper.ve(timekeep, "+", v.dinh4.x, v.dinh4.y)

  local dt = v.duongthang
  paper.veduongthang(timekeep, dt.tren.format, dt.tren.dau.x, dt.tren.dau.y, dt.tren.cuoi.x, dt.tren.cuoi.y)
  paper.veduongthang(timekeep, dt.duoi.format, dt.duoi.dau.x, dt.duoi.dau.y, dt.duoi.cuoi.x, dt.duoi.cuoi.y)
  paper.veduongthang(timekeep, dt.trai.format, dt.trai.dau.x, dt.trai.dau.y, dt.trai.cuoi.x, dt.trai.cuoi.y)
  paper.veduongthang(timekeep, dt.phai.format, dt.phai.dau.x, dt.phai.dau.y, dt.phai.cuoi.x, dt.phai.cuoi.y)

  paper.viet(timekeep, khung.title.text, khung.title.toado.x, khung.title.toado.y)

  if thanhCong then
    local tb = khung.thongbao.thanhcong
    paper.viet(timekeep, tb.text, tb.toado.x, tb.toado.y)
  else
    local tb = khung.thongbao.thatbai
    paper.viet(timekeep, tb.text, tb.toado.x, tb.toado.y)
  end

  paper.viet(timekeep, khung.mode.text, khung.mode.toado.x, khung.mode.toado.y)

  paper.inpaper(timekeep)
end

return M
