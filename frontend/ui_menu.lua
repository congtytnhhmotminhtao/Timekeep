local paper = require("engine.paper") 

local M = {}

--private
local Conf = {
  background = " ",
  title = "TimeKeep",
  modeUI = {
    "timekeep in",
    "timekeep out",
    "history",
    "setting",
    "leave"
  }
}--private table

local menu = paper.taopaper(7, 18, Conf.background) --private table

--public
function M.ui() --public function
  paper.datlaipaper(menu)
  local x, y = 2, 2 --toa do cua mode
  local x2, y2 = 2, 6 --toa do cua modeUI
  
  paper.ve(menu, "+", 1, 1) --goc trai/tren
  paper.ve(menu, "+", 7, 1) --goc trai/duoi
  paper.ve(menu, "+", 7, 18) --goc phai/duoi
  paper.ve(menu, "+", 1, 18) --goc phai/tren
  
  paper.veduongthang(menu, "|", 2, 1, 6, 1) --canh trai
  paper.veduongthang(menu, "-", 7, 2, 7, 17) --canh duoi
  paper.veduongthang(menu, "|", 6, 18, 2, 18) --canh phai
  paper.veduongthang(menu, "-", 1, 17, 1, 2) --canh tren
  
  paper.viet(menu, Conf.title, 1, 4) --title
    
  for i = 1, #Conf.modeUI do
    paper.viet(menu, string.format("[%d]~", i), x, y)
    paper.viet(menu, Conf.modeUI[i], x2, y2)
    x, x2 = x + 1, x2 + 1
  end
  
  paper.inpaper(menu)
end

return M

