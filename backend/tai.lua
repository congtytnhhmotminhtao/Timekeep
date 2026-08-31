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

--public
function M.filecoban()
  for i = 1, #tainguyen.path do
    if not qlf.getpath(tainguyen.file[i]) then
      os.execute("mkdir -p " .. tainguyen.folder[i])
      qlf.taofile(tainguyen.file[i])
      if i == 1 then
        qlf.ghidefile(tainguyen.file[i], ltn.mahoa(chamcong.Phien(), true))
      elseif i == 2 then
        qlf.ghidefile(tainguyen.file[i], "COMMING SOON!")
      end
      qlf.dichuyenfile(tainguyen.file[i], tainguyen.folder[i])
    end
  end
end

return M

