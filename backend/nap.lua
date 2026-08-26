local ltn = require("engine.ltn_claude")
local qlf = require("engine.quanlyfile")
local chamcong = require("backend.chamcong")


local M = {}
--private



--public
function M.chuongtrinh()
  local data = qlf.docfile("dulieuphien.ltn")
  chamcong.napphien(ltn.giaima(data))
end



return M

