require("modules.hotkey")
require("modules.screen")
require("modules.window")
require("modules.switchInput")
require("modules.launcher")
require("modules.system")

function reloadConfigCallback(files)
  local doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

local configPath = os.getenv("HOME") .. "/.hammerspoon/"
reloadWatcher = hs.pathwatcher.new(configPath, reloadConfigCallback):start()

hs.notify.new({
  title="Hammerspoon",
  informativeText="Config Reload Success",
  withdrawAfter=1,
}):send()