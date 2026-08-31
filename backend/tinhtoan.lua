local M = {}
--private



--public
function M.tonggio(giora, giovao)
  if type(giora) ~= "number" or type(giovao) ~= "number" then
    return
  end
  return (giora - giovao)/3600
end

function M.tongluong(dsphien, VNDinHour)
  local tong = 0
  for i = 1, #dsphien do
    tong = tong + dsphien[i].tonggio
  end
  return tong * VNDinHour
end




return M

