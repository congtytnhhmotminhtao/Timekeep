local chamcong = require("backend.chamcong")

local M = {}
--private



--public
M.state = {
  run = true,
  ui = "menu",
  coPhien = false,
  Phien = chamcong.Phien()
}

return M

