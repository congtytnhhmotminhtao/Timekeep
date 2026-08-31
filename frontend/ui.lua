local logo = require("frontend.ui_logo")
local menu = require("frontend.ui_menu")
local leave = require("frontend.ui_leave")
local timekeepin = require("frontend.ui_timekeepin")
local timekeepout = require("frontend.ui_timekeepout")
local history = require("frontend.ui_history")
local setting = require("frontend.ui_setting")
local M = {}

--private


--public
function M.load(s, kq, trang, phienchitiet, tien) --public function
  if s == "logo" then
    logo.ui()
  elseif s == "menu" then
    menu.ui()
  elseif s == "leave" then
    leave.ui()
  elseif s == "timekeepin" then
    timekeepin.ui(kq)
  elseif s == "timekeepout" then
    timekeepout.ui(kq)
  elseif s == "history" then
    history.ui(trang)
  elseif s == "history_chitiet" then
    history.chitiet(phienchitiet)
  elseif s == "history_luong" then
    history.tongluongui(tien)
  elseif s == "setting" then
    setting.ui()
  end
end

return M

