local M = {}

--============================================================
-- DECODE: chuỗi ltn -> table Lua
-- Thuật toán: single-pass, non-recursive, dùng itable làm con trỏ độ sâu.
-- stacktable[itable]  = table đang xây ở tầng đó
-- keyTheoTang[itable] = key mà table này sẽ được gán vào ở tầng CHA
--                       (nil nghĩa là "không có key", tức phần tử mảng)
--============================================================

local function parseLiteral(tokenParts, laChuoi)
  if laChuoi then
    return table.concat(tokenParts), true -- string luôn giữ nguyên, kể cả rỗng ""
  end

  if #tokenParts == 0 then
    return nil, false -- không có gì để chốt
  end
  local tokens = table.concat(tokenParts)

  if tokens == "true" then
    return true, true
  elseif tokens == "false" then
    return false, true
  elseif tokens == "nil" then
    return nil, false -- nil -> bỏ qua, không gán field (đúng rule đã chốt)
  end

  local so = tonumber(tokens)
  if so ~= nil then
    return so, true
  end

  -- Không quote nhưng cũng không phải true/false/nil/số -> lỗi cú pháp
  error(("LTN: giá trị không hợp lệ: '%s'"):format(tokens))
end

function M.giaima(s)
  if s == nil or s:match("^%s*$") then
    error("LTN: chuỗi rỗng")
  end

  local stacktable = {}
  local keyTheoTang = {}
  local itable = 0
  local hasKey = false
  local isKey = nil
  local dangTrongChuoi = false
  local laChuoiVuaDong = false -- token vừa chốt có phải string không (phân biệt "" vs không có gì)
  local dangEscape = false
  local tokenParts = {}
  local ketQuaGoc = nil
  local daMoRoot = false
  local vuaCoPhanTu = false        -- vừa thêm 1 phần tử (literal HOẶC table lồng) cho slot hiện tại
  local daGapPhanCachTheoTang = {} -- mỗi tầng: đã từng gặp dấu "," trong tầng đó chưa

  local function ganValue(value, coGiaTri)
    if not coGiaTri then
      tokenParts = {}
      hasKey = false
      isKey = nil
      laChuoiVuaDong = false
      return
    end
    if hasKey then
      stacktable[itable][isKey] = value
    else
      table.insert(stacktable[itable], value)
    end
    tokenParts = {}
    hasKey = false
    isKey = nil
    laChuoiVuaDong = false
    vuaCoPhanTu = true
  end

  for i = 1, #s do
    local kytu = s:sub(i, i)

    if dangTrongChuoi then
      if dangEscape then
        if kytu == "n" then
          table.insert(tokenParts, "\n")
        elseif kytu == "t" then
          table.insert(tokenParts, "\t")
        elseif kytu == '"' or kytu == "\\" then
          table.insert(tokenParts, kytu)
        else
          -- escape lạ -> giữ nguyên cả dấu \ lẫn ký tự sau nó
          table.insert(tokenParts, "\\")
          table.insert(tokenParts, kytu)
        end
        dangEscape = false
      elseif kytu == "\\" then
        dangEscape = true
      elseif kytu == '"' then
        dangTrongChuoi = false
        laChuoiVuaDong = true
      else
        table.insert(tokenParts, kytu)
      end

    elseif kytu == '"' then
      if #tokenParts > 0 then
        error("LTN: dấu \" xuất hiện giữa token không hợp lệ tại vị trí " .. i)
      end
      dangTrongChuoi = true

    elseif kytu == " " or kytu == "\t" or kytu == "\n" or kytu == "\r" then
      -- bỏ qua whitespace ngoài chuỗi

    elseif kytu == "{" then
      if itable == 0 and daMoRoot then
        error("LTN: chỉ được phép có 1 table gốc mỗi file")
      end
      if itable == 0 then daMoRoot = true end
      itable = itable + 1
      stacktable[itable] = {}
      keyTheoTang[itable] = isKey
      daGapPhanCachTheoTang[itable] = false
      isKey = nil
      hasKey = false
      tokenParts = {}
      laChuoiVuaDong = false
      vuaCoPhanTu = false

    elseif kytu == "=" then
      if itable == 0 then
        error("LTN: không được có key = {} ở ngoài table gốc")
      end
      isKey = table.concat(tokenParts)
      if isKey == "" then
        error("LTN: key rỗng tại vị trí " .. i)
      end
      tokenParts = {}
      hasKey = true

    elseif kytu == "," then
      if itable == 0 then
        error("LTN: dấu , nằm ngoài table gốc tại vị trí " .. i)
      end
      daGapPhanCachTheoTang[itable] = true
      if #tokenParts > 0 or laChuoiVuaDong then
        local value, coGiaTri = parseLiteral(tokenParts, laChuoiVuaDong)
        ganValue(value, coGiaTri)
      elseif not vuaCoPhanTu then
        -- buffer rỗng VÀ chưa có table lồng nào vừa đóng cho slot này -> phẩy dư
        error("LTN: dấu phẩy dư hoặc dấu phẩy cuối tại vị trí " .. i)
      end
      vuaCoPhanTu = false -- sang slot mới, reset lại

    elseif kytu == "}" then
      if itable == 0 then
        error("LTN: dư dấu } tại vị trí " .. i)
      end

      -- Chốt nốt phần tử cuối (nếu có), vd {1,2,3} -> "3" chưa qua dấu ","
      if #tokenParts > 0 or laChuoiVuaDong then
        local value, coGiaTri = parseLiteral(tokenParts, laChuoiVuaDong)
        ganValue(value, coGiaTri)
      elseif not vuaCoPhanTu and daGapPhanCachTheoTang[itable] then
        -- đã từng có dấu "," trong tầng này, nhưng slot cuối lại rỗng -> phẩy cuối
        error("LTN: dấu phẩy dư hoặc dấu phẩy cuối tại vị trí " .. i)
      end
      -- (nếu #tokenParts==0 và daGapPhanCach==false -> table rỗng hợp lệ "{}", ko làm gì)

      local keyCuaTangNay = keyTheoTang[itable]
      local banVuaDong = stacktable[itable]
      stacktable[itable] = nil
      keyTheoTang[itable] = nil
      daGapPhanCachTheoTang[itable] = nil
      itable = itable - 1

      if itable >= 1 then
        if keyCuaTangNay ~= nil then
          stacktable[itable][keyCuaTangNay] = banVuaDong
        else
          table.insert(stacktable[itable], banVuaDong)
        end
        vuaCoPhanTu = true -- table lồng vừa đóng CHÍNH LÀ phần tử của tầng cha
      else
        ketQuaGoc = banVuaDong
      end

    else
      table.insert(tokenParts, kytu)
    end
  end

  if dangTrongChuoi then
    error("LTN: chuỗi (string) chưa được đóng bằng dấu \"")
  end
  if itable ~= 0 then
    error("LTN: thiếu dấu } — table chưa đóng hết (còn " .. itable .. " tầng)")
  end

  return ketQuaGoc
end

--============================================================
-- ENCODE: table Lua -> chuỗi ltn
--============================================================

local function escapeChuoi(str)
  str = str:gsub("\\", "\\\\")
  str = str:gsub('"', '\\"')
  str = str:gsub("\n", "\\n")
  str = str:gsub("\t", "\\t")
  return str
end

local maHoaGiaTri -- forward declare

local function maHoaTable(t, danhChoNguoi, capDoSau)
  local phanTu = {}
  local thut = danhChoNguoi and string.rep("\t", capDoSau + 1) or ""
  local xuongDong = danhChoNguoi and "\n" or ""
  local dongMo = danhChoNguoi and string.rep("\t", capDoSau) or ""

  local daXuLyIndex = {}

  -- phần mảng trước (giữ đúng thứ tự 1,2,3...)
  for idx, v in ipairs(t) do
    table.insert(phanTu, thut .. maHoaGiaTri(v, danhChoNguoi, capDoSau + 1))
    daXuLyIndex[idx] = true
  end

  -- phần có key (string key, hoặc số nhưng không liên tục từ 1)
  for k, v in pairs(t) do
    local boQua = (type(k) == "number" and daXuLyIndex[k])
    if not boQua then
      if type(k) ~= "string" then
        error("LTN: chỉ hỗ trợ key dạng string, gặp key kiểu " .. type(k))
      end
      table.insert(phanTu, thut .. k .. "=" .. maHoaGiaTri(v, danhChoNguoi, capDoSau + 1))
    end
  end

  if #phanTu == 0 then
    return "{}"
  end

  return "{" .. xuongDong .. table.concat(phanTu, "," .. xuongDong)
       .. xuongDong .. dongMo .. "}"
end

maHoaGiaTri = function(v, danhChoNguoi, capDoSau)
  local kieu = type(v)
  if kieu == "table" then
    return maHoaTable(v, danhChoNguoi, capDoSau)
  elseif kieu == "string" then
    return '"' .. escapeChuoi(v) .. '"'
  elseif kieu == "number" or kieu == "boolean" then
    return tostring(v)
  elseif kieu == "nil" then
    return "nil"
  else
    error("LTN: không hỗ trợ mã hoá kiểu " .. kieu)
  end
end

function M.mahoa(t, danhChoNguoi)
  if type(t) ~= "table" then
    error("LTN: giá trị gốc phải là table")
  end
  return maHoaTable(t, danhChoNguoi, 0)
end

return M
