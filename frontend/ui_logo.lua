local paper = require("engine.paper")

local M = {}

--private
local Conf = {
  background = " ",
  title = "TIMEKEEP",
  devBy = "dev by caothu9ok",
  nam = "2026 - 2026",
  enterMsg = "[Enter de bat dau]",
  saoBang = {
    dau = {x = 3, y = 4, banKinh = 1}, --dau sao bang
    duoi = {x1 = 4, y1 = 5, x2 = 6, y2 = 9}, --duoi sao bang
  }
}--private table

local giay = paper.taopaper(15, 20, Conf.background) --private table

--public
function M.ui() --public function
  paper.datlaipaper(giay)
  
  paper.vehinhtron(giay, "*", Conf.saoBang.dau.x, Conf.saoBang.dau.y, Conf.saoBang.dau.banKinh)
  paper.veduongthang(giay, ".", Conf.saoBang.duoi.x1, Conf.saoBang.duoi.y1, Conf.saoBang.duoi.x2, Conf.saoBang.duoi.y2)
  
  paper.viet(giay, Conf.title, 6, 6)
  paper.viet(giay, Conf.devBy, 9, 2)
  paper.viet(giay, Conf.nam, 10, 4)
  paper.viet(giay, Conf.enterMsg, 13, 1)
  
  paper.inpaper(giay)
end

return M

