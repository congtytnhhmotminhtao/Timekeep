local chamcong = require("backend.chamcong")

local M = {}
--private



--public
M.state = {
  run = true,
  ui = "menu",
  coPhien = false,
  Phien = chamcong.Phien(),
  trang = 1,
  tongsotrang = 0,
  luong = 0
}

return M

