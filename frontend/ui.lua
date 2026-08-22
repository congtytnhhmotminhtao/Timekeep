local logo = require("frontend.ui_logo")
local menu = require("frontend.ui_menu")

local leave = require("frontend.ui_leave")

local M = {}

--private


--public
function M.load(s) --public function
  if s == "logo" then
    logo.ui()
  elseif s == "menu" then
    menu.ui()
  elseif s == "leave" then
    leave.ui()
  end
end

return M

