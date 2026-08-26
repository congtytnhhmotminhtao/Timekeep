local M = {}
--private



--public
function M.tonggio(giora, giovao)
  if type(giora) ~= "number" or type(giovao) ~= "number" then
    return
  end
  return (giora - giovao)/3600
end

return M

