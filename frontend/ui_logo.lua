local paper = require("engine.paper")

local M = {}

--private
local khung = {
  background = " ",
  title = {
    text = "TIMEKEEP",
    toado = {x = 6, y = 6}
  },
  devBy = {
    text = "dev by caothu9ok",
    toado = {x = 9, y = 2}
  },
  nam = {
    text = "2026 - 2026",
    toado = {x = 10, y = 4}
  },
  enterMsg = {
    text = "[Enter de bat dau]",
    toado = {x = 13, y = 1}
  },
  saoBang = {
    dau = {format = "*", x = 3, y = 4, banKinh = 1}, --dau sao bang
    duoi = {format = ".", x1 = 4, y1 = 5, x2 = 6, y2 = 9} --duoi sao bang
  }
}--private table

local logo = paper.taopaper(15, 20, khung.background) --private table

--public
function M.ui() --public function
  paper.datlaipaper(logo)

  local sb = khung.saoBang
  paper.vehinhtron(logo, sb.dau.format, sb.dau.x, sb.dau.y, sb.dau.banKinh)
  paper.veduongthang(logo, sb.duoi.format, sb.duoi.x1, sb.duoi.y1, sb.duoi.x2, sb.duoi.y2)

  paper.viet(logo, khung.title.text, khung.title.toado.x, khung.title.toado.y)
  paper.viet(logo, khung.devBy.text, khung.devBy.toado.x, khung.devBy.toado.y)
  paper.viet(logo, khung.nam.text, khung.nam.toado.x, khung.nam.toado.y)
  paper.viet(logo, khung.enterMsg.text, khung.enterMsg.toado.x, khung.enterMsg.toado.y)

  paper.inpaper(logo)
end

return M

