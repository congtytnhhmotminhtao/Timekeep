local paper = require("engine.paper") 

local M = {}
--private
local khung = {
  background = " ",
  title = {
    text = "Setting",
    toado = {x = 1, y = 4}
  },
  thongbao = {
    text = "COMMING SOON!",
    toado = {x = 6, y = 1}
  },
  mode = {
    trove = {
      text = "[q]~quit",
      toado = {x = 13, y = 2}
    }
  }
}

local setting = paper.taopaper(15, 15, khung.background)

--public
function M.ui()
  paper.datlaipaper(setting)
  --title
  local title = khung.title
  paper.viet(setting, title.text, title.toado.x, title.toado.y)
  --thongbao
  local tb = khung.thongbao
  paper.viet(setting, tb.text, tb.toado.x, tb.toado.y)
  --trove
  local tv = khung.mode.trove
  paper.viet(setting, tv.text, tv.toado.x, tv.toado.y)

  paper.inpaper(setting)
end

return M

