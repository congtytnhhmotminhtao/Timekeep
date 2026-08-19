local M = {}
--private
local function kiemtraTable(t) --private function
  if type(t) ~= "table" or not t.__x or not t.__y then
    error("paper: do khong phai to giay", 2)
  end
end

local function kiemtraKichThuoc(x, y) --private function
  if x < 1 or y < 1 then
    error("paper: ban co am mot to giay sao?", 2)
  end
end

local function kiemtraToaDo(t, x, y) --private function
  if x < 1 or x > t.__x or y < 1 or y > t.__y then
    error("paper: nay toi o day ma!", 2)
  end
end
--public
local function kiemtraChuoi(s) --private function
  if type(s) ~= "string" then
    error("paper: meo hay ban nen cam but", 2)
  end
end

function M.taopaper(x, y, format) --public function
  if x == nil or y == nil then
    error("paper: toi khong ton tai!?", 2)
  end
  kiemtraKichThuoc(x, y)
  local paper = {}
  local defFormat = format or " "
  for i = 1, x do
    paper[i] = {}
    for j = 1, y do
      paper[i][j] = defFormat
    end
  end
  paper.__x, paper.__y, paper.__format = x, y, defFormat
  return paper
end

function M.datlaipaper(t) --public function
  kiemtraTable(t)
  for i = 1, t.__x do
    for j = 1, t.__y do
      t[i][j] = t.__format
    end
  end
end

function M.topaper(t, to) --public function
  kiemtraTable(t)
  kiemtraChuoi(to)
  for i = 1, t.__x do
    for j = 1, t.__y do
      t[i][j] = to
    end
  end
end

function M.laypaper(t, x, y) --public function
  kiemtraTable(t)
  kiemtraToaDo(t, x, y)
  return t[x][y]
end

function M.kichthuocpaper(t)
  kiemtraTable(t)
  return t.__x, t.__y
end

function M.inpaper(t) --public function
  kiemtraTable(t)
  local draw = ""
  for i = 1, t.__x do
    for j = 1, t.__y do
      draw = draw..t[i][j]
    end
    print(draw)
    draw = ""
  end
end

function M.ve(t, s, x, y) --public function
  kiemtraTable(t)
  kiemtraChuoi(s)
  if #s > 1 then --chi cho ve 1 kytu
    error("paper: ve qua tay", 2)
  end
  kiemtraToaDo(t, x, y)
  t[x][y] = s
end

function M.viet(t, s, x, y, cachviet)
  kiemtraTable(t)
  kiemtraChuoi(s)
  kiemtraToaDo(t, x, y)
  cachviet = cachviet or "phai"
  for i = 1, #s do
    if cachviet == "phai" then
      t[x][y] = s:sub(i, i)
      y = y + 1
    elseif cachviet == "trai" then
      t[x][y] = s:sub(i, i)
      y = y - 1
    elseif cachviet == "tren" then
      t[x][y] = s:sub(i, i)
      x = x - 1
    elseif cachviet == "duoi" then
      t[x][y] = s:sub(i, i)
      x = x + 1
    else
      error("paper: viet kieu gi co?", 2)
    end
    if not t[x] or not t[x][y] then
      return
    end
  end
end

function M.log(t, s) --public function
  kiemtraTable(t)
  local mode = s or "binh thuong"
  kiemtraChuoi(mode)
  
  for i = 1, t.__x do
    for j = 1, t.__y do
      if mode == "binh thuong" then
        t[i][j] = string.format("(%d, %d) ", i, j)
      elseif mode == "chi tiet" then
        t[i][j] = string.format("(x=%d, y=%d) ", i, j)
      elseif mode == "truc xy" then
        if i == 1 and j == 1 then
          t[i][j] = "+"
        elseif i == 1 and j == t.__y then
          t[i][j] = ">y"
        elseif i == t.__x and j == 1 then
          t[i][j] = "v/x"
        elseif i == 1 then
          t[i][j] = string.format("%d", j)
        elseif j == 1 then
          t[i][j] = string.format("%d", i)
        end
      end
    end
  end
end

function M.veduongthang(t, s, x1, y1, x2, y2) --public function
  kiemtraTable(t)
  kiemtraChuoi(s)
  kiemtraToaDo(t, x1, y1)
  kiemtraToaDo(t, x2, y2)
  local dx = math.abs(x2 - x1) --khoang cach cua x1 den x2
  local dy = math.abs(y2 - y1) --khoang cach cua y1 den y2
  local sx = x1 < x2 and 1 or -1 --quyet dinh xem nen buoc tien hay lui tu x1 den x2
  local sy = y1 < y2 and 1 or -1 --quyet dinh xem nen buoc tien hay lui tu y1 den y2
  local err = dx - dy --tinh do lenh giua khoang cach dx va dy //???

  local x, y = x1, y1 --vi tri de ve
  while true do
    t[x][y] = s
    if x == x2 and y == y2 then --kiem tra da ve den toa do dich hay chx (x2, y2)
      break
    end
    local e2 = 2 * err --???

    local xBuoc = e2 > -dy --???
    local yBuoc = e2 < dx --???
    if xBuoc then --???
      err = err - dy --???
      x = x + sx --???
    end
    if yBuoc then --???
      err = err + dx --???
      y = y + sy --???
    end
  end
end

function M.vehcn(t, s, x, y, a, b)
  kiemtraTable(t)
  kiemtraChuoi(s)

  local dTr = (a - 1) // 2       -- khoang cach ben trai
  local dPh = a - 1 - dTr        -- khoang cach ben phai
  local dTren = (b - 1) // 2     -- khoang cach len tren
  local dDuoi = b - 1 - dTren    -- khoang cach xuong duoi

  local x1, y1 = x - dTr, y - dTren   --diem1 (trai-tren)
  local x2, y2 = x - dTr, y + dDuoi   --diem2 (trai-duoi)
  local x3, y3 = x + dPh, y + dDuoi   --diem3 (phai-duoi)
  local x4, y4 = x + dPh, y - dTren   --diem4 (phai-tren)

  M.veduongthang(t, s, x1, y1, x2, y2) -- canh trai
  M.veduongthang(t, s, x2, y2, x3, y3) -- canh duoi
  M.veduongthang(t, s, x3, y3, x4, y4) -- canh phai
  M.veduongthang(t, s, x4, y4, x1, y1) -- canh tren
end

function M.vehinhtron(t, s, x, y, r)
  kiemtraTable(t)
  kiemtraChuoi(s)
  if r < 1 then
    error("paper: ban kinh phai lon hon 0", 2)
  end

  local function vediem(px, py) --private, ve co check bien an toan (khong error de tranh crash khi tron tran bien)
    if t[px] and t[px][py] then
      t[px][py] = s
    end
  end

  local function ve8diem(cx, cy, dx, dy) --loi dung tinh doi xung 8 phan cua duong tron //???(vi sao chi can tinh 1/8 cung du)
    vediem(cx + dx, cy + dy)
    vediem(cx - dx, cy + dy)
    vediem(cx + dx, cy - dy)
    vediem(cx - dx, cy - dy)
    vediem(cx + dy, cy + dx)
    vediem(cx - dy, cy + dx)
    vediem(cx + dy, cy - dx)
    vediem(cx - dy, cy - dx)
  end

  local dx, dy = 0, r     --bat dau tu diem tren cung cua duong tron (goc 90 do)
  local d = 1 - r         --he so quyet dinh, tuong tu err trong veduongthang //???(cong thuc nay tu dau ra)

  ve8diem(x, y, dx, dy)

  while dx < dy do        --chi chay den khi dx=dy (het 1/8 cung, goc 45 do)
    dx = dx + 1           --luon buoc ngang 1 don vi
    if d < 0 then          --diem giua nam trong duong tron that //???(y nghia hinh hoc cua d<0 la gi)
      d = d + 2 * dx + 1
    else                   --diem giua nam ngoai duong tron that, phai keo dy vao gan tam hon
      dy = dy - 1
      d = d + 2 * (dx - dy) + 1
    end
    ve8diem(x, y, dx, dy)
  end
end

return M

