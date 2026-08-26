local logo = require("frontend.ui_logo")
local menu = require("frontend.ui_menu")
local leave = require("frontend.ui_leave")
local timekeepin = require("frontend.ui_timekeepin")
local timekeepout = require("frontend.ui_timekeepout")
local M = {}

--private


--public
function M.load(s, kq) --public function
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
  end
end

return M

