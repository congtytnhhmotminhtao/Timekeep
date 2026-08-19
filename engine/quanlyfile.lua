local M = {}

-- private function
local function timduongdan(file)
  local p = io.popen("find -name \"" .. file .. "\"")
  local path = p:read("*l")
  p:close()
  if not path or path == "" then
    return nil
  end
  return path
end

function M.getpath(file) --public function
  local path = timduongdan(file)
  if not path then
    return nil, "file khong ton tai"
  end
  return path
end

function M.taofile(tenfile) --public function
  local f = io.open(tenfile, "w")
  if not f then
    return nil, tenfile.." tao file that bai!" -- ! fix: bo f:close() vi f la nil, khong the goi method tren nil
  end
  f:close()
  return tenfile.." da duoc tao!"
end

function M.ghidefile(tenfile, noidung) --public function
  local pathfile = timduongdan(tenfile) -- ! fix: dung ham private tra ve nil thay vi chuoi thong bao
  if not pathfile then
    return nil, tenfile.." chua duoc tao!"
  end
  local f = io.open(pathfile, "w")
  if not f then
    return nil, tenfile.." khong mo duoc de ghi!"
  end
  f:write(noidung)
  f:close()
  return tenfile.." da ghi de thanh cong!"
end

function M.docfile(tenfile) --public function
  local pathfile = timduongdan(tenfile) -- ! fix: tranh truong hop pathfile la chuoi "file khong ton tai"
  if not pathfile then
    return nil, tenfile.." khong ton tai!"
  end
  local f = io.open(pathfile, "r")
  if not f then
    return nil, tenfile.." khong mo duoc de doc!"
  end
  local noidung = f:read("*all")
  f:close()
  return noidung
end

function M.dichuyenfile(file, folder) --public function
  local pathfile = timduongdan(file) -- ! fix: dung ham private thay vi getpath (tranh nhan chuoi loi lam duong dan)
  if not pathfile then
    return nil, file.." khong ton tai!"
  end
  local dichden = folder.."/"..file --linux
  local kq, err = os.rename(pathfile, dichden)
  if kq then
    return "di file "..file.." toi folder "..folder.." thanh cong!"
  else
    return tostring(err)
  end
end

function M.xoafile(file) --public function
  local path = timduongdan(file) -- ! fix: goi lai ham private thay vi lap code tim duong dan
  if not path then
    return nil, "file khong ton tai"
  end
  local kq, err = os.remove(path)
  if kq then
    return "xoa file "..file.." thanh cong!"
  else
    return tostring(err)
  end
end

return M
