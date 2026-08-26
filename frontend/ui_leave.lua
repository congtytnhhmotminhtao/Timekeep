local paper = require("engine.paper")

local M = {}

--private
local khung = {
  background = " ",
  title = {
    text = "TimeKeep",
    toado = {x = 1, y = 5}
  },
  loiChao = {
    text = "Hen gap lai!",
    toado = {x = 8, y = 5}
  },
  devBy = {
    text = "dev by caothu9ok",
    toado = {x = 11, y = 2}
  },
  vien = {
    dinh1 = {x = 1, y = 1},
    dinh2 = {x = 13, y = 1},
    dinh3 = {x = 13, y = 18},
    dinh4 = {x = 1, y = 18},
    duongthang = {
      trai = {format = "|", dau = {x = 2, y = 1}, cuoi = {x = 12, y = 1}},
      phai = {format = "|", dau = {x = 12, y = 18}, cuoi = {x = 2, y = 18}},
      tren = {format = "-", dau = {x = 1, y = 17}, cuoi = {x = 1, y = 2}},
      duoi = {format = "-", dau = {x = 13, y = 2}, cuoi = {x = 13, y = 17}}
    },
  },
  saochoi = {
    hinhtron = {format = "o", tam = {x = 3, y = 4, bankinh = 1}},
    duongthang = {format = ".", dau = {x = 4, y = 5}, cuoi = {x = 6, y = 8}}
  },
  saotrangtri = {
    format = "*",
    toado = {
      sao1 = {x = 3, y = 15},
      sao2 = {x = 5, y = 13},
      sao3 = {x = 8, y = 3}
    }
  }
}--private table

local leave = paper.taopaper(15, 20, khung.background) --private table

--public
function M.ui() --public function
  paper.datlaipaper(leave)

  paper.ve(leave, "+", khung.vien.dinh1.x, khung.vien.dinh1.y)
  paper.ve(leave, "+", khung.vien.dinh2.x, khung.vien.dinh2.y)
  paper.ve(leave, "+", khung.vien.dinh3.x, khung.vien.dinh3.y)
  paper.ve(leave, "+", khung.vien.dinh4.x, khung.vien.dinh4.y)

  local dt = khung.vien.duongthang
  paper.veduongthang(leave, dt.trai.format, dt.trai.dau.x, dt.trai.dau.y, dt.trai.cuoi.x, dt.trai.cuoi.y)
  paper.veduongthang(leave, dt.duoi.format, dt.duoi.dau.x, dt.duoi.dau.y, dt.duoi.cuoi.x, dt.duoi.cuoi.y)
  paper.veduongthang(leave, dt.phai.format, dt.phai.dau.x, dt.phai.dau.y, dt.phai.cuoi.x, dt.phai.cuoi.y)
  paper.veduongthang(leave, dt.tren.format, dt.tren.dau.x, dt.tren.dau.y, dt.tren.cuoi.x, dt.tren.cuoi.y)

  paper.viet(leave, khung.title.text, khung.title.toado.x, khung.title.toado.y)

  local sc = khung.saochoi
  paper.vehinhtron(leave, sc.hinhtron.format, sc.hinhtron.tam.x, sc.hinhtron.tam.y, sc.hinhtron.tam.bankinh)
  paper.veduongthang(leave, sc.duongthang.format, sc.duongthang.dau.x, sc.duongthang.dau.y, sc.duongthang.cuoi.x, sc.duongthang.cuoi.y)

  local st = khung.saotrangtri
  paper.ve(leave, st.format, st.toado.sao1.x, st.toado.sao1.y)
  paper.ve(leave, st.format, st.toado.sao2.x, st.toado.sao2.y)
  paper.ve(leave, st.format, st.toado.sao3.x, st.toado.sao3.y)

  paper.viet(leave, khung.loiChao.text, khung.loiChao.toado.x, khung.loiChao.toado.y)
  paper.viet(leave, khung.devBy.text, khung.devBy.toado.x, khung.devBy.toado.y)

  paper.inpaper(leave)
end

return M

