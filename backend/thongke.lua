local chamcong = require("backend.chamcong")
local trangthai = require("backend.trangthai")
local ltn = require("engine.ltn_claude")
local qlf = require("engine.quanlyfile")

local M = {}
--private


--public
function M.history()
  local noiDung = qlf.docfile("dulieuphien.ltn")
  if noiDung and noiDung:match("%S") then --chi giai ma neu co noi dung thuc su
    chamcong.napphien(ltn.giaima(noiDung))
  end
  local dsphien = chamcong.dsphien()
  --[[if #dsphien == 0 then
    return nil
  end]]
  local phienmoitrang = 5
  local sophien = 1
  local tongsotrang = math.ceil(#dsphien/phienmoitrang)
  local dslichsu = {}
  for i = 1, tongsotrang do
    dslichsu[i] = {}
    for j = 1, phienmoitrang do
      if not dsphien[sophien] then
        break
      end
      dslichsu[i][j] = {
        maphien = dsphien[sophien].maphien,
        ngay = dsphien[sophien].ngay,
        chuoivao = dsphien[sophien].chuoivao,
        chuoira = dsphien[sophien].chuoira
      }
      sophien = sophien + 1
    end
  end
  return dslichsu, tongsotrang
end


return M

