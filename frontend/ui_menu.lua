local paper = require("engine.paper")

local M = {}

--private
local khung = {
  background = " ",
  title = {
    text = "TimeKeep",
    toado = {x = 1, y = 4}
  },
  vien = {
    dinh1 = {x = 1, y = 1},
    dinh2 = {x = 7, y = 1},
    dinh3 = {x = 7, y = 18},
    dinh4 = {x = 1, y = 18},
    duongthang = {
      trai = {format = "|", dau = {x = 2, y = 1}, cuoi = {x = 6, y = 1}},
      phai = {format = "|", dau = {x = 6, y = 18}, cuoi = {x = 2, y = 18}},
      tren = {format = "-", dau = {x = 1, y = 17}, cuoi = {x = 1, y = 2}},
      duoi = {format = "-", dau = {x = 7, y = 2}, cuoi = {x = 7, y = 17}}
    },
  },
  modeUI = {
    toadoSo = {x = 2, y = 2},     --toa do bat dau cua so thu tu [1]~
    toadoText = {x = 2, y = 6},   --toa do bat dau cua chu mode
    dsMode = {
      {text = "timekeep in"},
      {text = "timekeep out"},
      {text = "history"},
      {text = "setting"},
      {text = "leave"}
    }
  }
}--private table

local menu = paper.taopaper(7, 18, khung.background) --private table

--public
function M.ui() --public function
  paper.datlaipaper(menu)

  paper.ve(menu, "+", khung.vien.dinh1.x, khung.vien.dinh1.y)
  paper.ve(menu, "+", khung.vien.dinh2.x, khung.vien.dinh2.y)
  paper.ve(menu, "+", khung.vien.dinh3.x, khung.vien.dinh3.y)
  paper.ve(menu, "+", khung.vien.dinh4.x, khung.vien.dinh4.y)

  local dt = khung.vien.duongthang
  paper.veduongthang(menu, dt.trai.format, dt.trai.dau.x, dt.trai.dau.y, dt.trai.cuoi.x, dt.trai.cuoi.y)
  paper.veduongthang(menu, dt.duoi.format, dt.duoi.dau.x, dt.duoi.dau.y, dt.duoi.cuoi.x, dt.duoi.cuoi.y)
  paper.veduongthang(menu, dt.phai.format, dt.phai.dau.x, dt.phai.dau.y, dt.phai.cuoi.x, dt.phai.cuoi.y)
  paper.veduongthang(menu, dt.tren.format, dt.tren.dau.x, dt.tren.dau.y, dt.tren.cuoi.x, dt.tren.cuoi.y)

  paper.viet(menu, khung.title.text, khung.title.toado.x, khung.title.toado.y)

  local x, y = khung.modeUI.toadoSo.x, khung.modeUI.toadoSo.y
  local x2, y2 = khung.modeUI.toadoText.x, khung.modeUI.toadoText.y
  for i, mode in ipairs(khung.modeUI.dsMode) do
    paper.viet(menu, string.format("[%d]~", i), x, y)
    paper.viet(menu, mode.text, x2, y2)
    x, x2 = x + 1, x2 + 1
  end

  paper.inpaper(menu)
end

return M

