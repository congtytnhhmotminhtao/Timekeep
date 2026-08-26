local ltn = require("engine.ltn_claude")
local qlf = require("engine.quanlyfile")
local chamcong = require("backend.chamcong")

local M = {}
--private
local tainguyen = {
  path = {"database/dulieuphien.ltn", "./setting.ltn"},
  folder = {"database", "."},
  file = {"dulieuphien.ltn", "setting.ltn"}
}

local function coFile(path)
  local f = io.open(path, "r")
  if not f then
    return false
  end
  f:close()
  return true
end

--public
function M.filecoban()
  for i = 1, #tainguyen.path do
    if not coFile(tainguyen.path[i]) then
      qlf.taofile(tainguyen.file[i])
      if tainguyen.file[1] then
        qlf.ghidefile(tainguyen.file[1], ltn.mahoa(chamcong.Phien(), true))
      end
      qlf.dichuyenfile(tainguyen.file[i], tainguyen.folder[i])
    end
  end
end

function M.phien()
  
end

return M

