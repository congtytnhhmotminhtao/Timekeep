local tinhtoan = require("backend.tinhtoan")

local M = {}
--private
local Phien = {
  phienhientai = nil,
  dsphien = {}
} --private table



--public
function M.vaoca(s)
  if Phien.phienhientai then
    return false
  end
  Phien.phienhientai = {}
  Phien.phienhientai.maphien = #Phien.dsphien + 1
  Phien.phienhientai.ngay = os.date("%d/%m/%Y")
  Phien.phienhientai.giovao = os.time()
  Phien.phienhientai.chuoivao = os.date("%H:%M")
  Phien.phienhientai.ghichu = s
  return true
end

function M.raca()
  if not Phien.phienhientai then
    return false
  end
  Phien.phienhientai.giora = os.time()
  Phien.phienhientai.chuoira = os.date("%H:%M")
  Phien.phienhientai.tonggio = tinhtoan.tonggio(Phien.phienhientai.giora, Phien.phienhientai.giovao)
  Phien.dsphien[#Phien.dsphien + 1] = Phien.phienhientai
  Phien.phienhientai = nil
  return true
end

function M.napphien(t)
  Phien = t
end

function M.Phien()
  return Phien
end

function M.phienhientai()
  return Phien.phienhientai
end

function M.dsphien()
  return Phien.dsphien
end

return M

