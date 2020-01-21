local window = require "hs.window"
local hotkey = require "hs.hotkey"
-- Screen enhancement
function focusScreen(option)
  local current = window:focusedWindow():screen()

  -- get target screen's windows
  local target = options == "Left" and current:previous() or current:next()
  local wins = hs.fnutils.filter(window.orderedWindows(), function(win)
    return win:screen() == target;
  end)

  -- focus target screen window
  local winToFocus = #wins > 0 and wins[1] or window.desktop()
  winToFocus:focus()

  -- move cursor to target screen center
  local point = hs.geometry.rectMidPoint(target:fullFrame())
  hs.mouse.setAbsolutePosition(point)
  -- move cursor to current screen edge
  hs.mouse.setRelativePosition(hs.geometry.point(0, point.y))
end


function winmovescreen(how)
   local win = window.focusedWindow()
   if how == "left" then
      win:moveOneScreenWest()
   elseif how == "up" then
      win:moveOneScreenNorth()
   elseif how == "right" then
      win:moveOneScreenEast()
   elseif how == "down" then
      win:moveOneScreenSouth()
   end
end

-- binding cmd + left as focus left screen
hotkey.bind({ "ctrl", "shift" }, "Left", hs.fnutils.partial(focusScreen, "Left"))
-- binding cmd + right as focus right screen
hotkey.bind({ "ctrl", "shift" }, "Right", hs.fnutils.partial(focusScreen, "Right"))

-- Move between screens
hotkey.bind(ctrlCmd, "H",  hs.fnutils.partial(winmovescreen, "left"))
hotkey.bind(ctrlCmd, "L", hs.fnutils.partial(winmovescreen, "right"))
hotkey.bind(ctrlCmd, "J",    hs.fnutils.partial(winmovescreen, "up"))
hotkey.bind(ctrlCmd, "K",  hs.fnutils.partial(winmovescreen, "down"))