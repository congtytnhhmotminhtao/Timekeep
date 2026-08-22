local paper = require("engine.paper")

local M = {}

--private
local Conf = {
  background = " ",
  title = "TimeKeep",
  loiChao = "Hen gap lai!",
  devBy = "dev by caothu9ok",
}--private table

local leave = paper.taopaper(13, 18, Conf.background) --private table

--public
function M.ui() --private function
  paper.datlaipaper(leave)
  
  --khung vien
  paper.ve(leave, "+", 1, 1)
  paper.ve(leave, "+", 13, 1)
  paper.ve(leave, "+", 13, 18)
  paper.ve(leave, "+", 1, 18)
  paper.veduongthang(leave, "|", 2, 1, 12, 1)
  paper.veduongthang(leave, "-", 13, 2, 13, 17)
  paper.veduongthang(leave, "|", 12, 18, 2, 18)
  paper.veduongthang(leave, "-", 1, 17, 1, 2)
  
  paper.viet(leave, Conf.title, 1, 5)
  
  --sao choi bay di, y nghia "roi di"
  paper.vehinhtron(leave, "o", 3, 4, 1)
  paper.veduongthang(leave, ".", 4, 5, 6, 8)
  
  --sao trang tri
  paper.ve(leave, "*", 3, 15)
  paper.ve(leave, "*", 5, 13)
  paper.ve(leave, "*", 8, 3)
  
  paper.viet(leave, Conf.loiChao, 8, 5)
  paper.viet(leave, Conf.devBy, 11, 2)

  paper.inpaper(leave)
end

return M
