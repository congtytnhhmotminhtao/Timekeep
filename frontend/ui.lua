local paper = require("engine.paper")

local M = {}

--private
local Conf = {
  background = "X",
  title = "TimeKeep",
  modeUI = {
    "timekeep in",
    "timekeep out",
    "history",
    "setting",
    "leave"
  }
}--private table



--public
function M.load(s) --public function
  local giay = paper.taopaper(15, 20, Conf.background)
  paper.datlaipaper(giay)
  if s == "menu" then
    local x, y = 2, 2 --toa do cua mode
    local x2, y2 = 2, 6 --toa do cua modeUI
    
    paper.ve(giay, "+", 1, 1) --goc trai/tren
    paper.ve(giay, "+", 7, 1) --goc trai/duoi
    paper.ve(giay, "+", 7, 18) --goc phai/duoi
    paper.ve(giay, "+", 1, 18) --goc phai/tren
    
    paper.veduongthang(giay, "|", 2, 1, 6, 1) --canh trai
    paper.veduongthang(giay, "-", 7, 2, 7, 17) --canh duoi
    paper.veduongthang(giay, "|", 6, 18, 2, 18) --canh phai
    paper.veduongthang(giay, "-", 1, 17, 1, 2) --canh tren
    
    paper.viet(giay, Conf.title, 1, 4) --title
    
    for i = 1, #Conf.modeUI do
      paper.viet(giay, string.format("[%d]~", i), x, y)
      paper.viet(giay, Conf.modeUI[i], x2, y2)
      x, x2 = x + 1, x2 + 1
    end
    
  elseif s == "1" then
    
  end
  paper.inpaper(giay)
end

return M

