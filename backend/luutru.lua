local ltn = require("engine.ltn_claude")
local qlf = require("engine.quanlyfile")
local chamcong = require("backend.chamcong")

local M = {}
--private


--public
function M.luuphien()
  local data = chamcong.Phien()
  qlf.ghidefile("dulieuphien.ltn", ltn.mahoa(data, true))
end

return M

