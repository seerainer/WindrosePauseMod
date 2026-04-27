-- PauseMod for Windrose (UE5 / UE4SS experimental)
-- Toggles game pause with Pause/Break or Ctrl+P.
-- Uses GameplayStatics:SetGamePaused which works on BP_R5PlayerController_C.

local isPaused = false

local function GetPC()
    local pcs = FindAllOf("BP_R5PlayerController_C") or FindAllOf("PlayerController")
    if not pcs then return nil end
    for _, pc in pairs(pcs) do
        if pc and pc:IsValid() then return pc end
    end
    return nil
end

local GameplayStatics = nil
local function GetGS()
    if GameplayStatics and GameplayStatics:IsValid() then return GameplayStatics end
    GameplayStatics = StaticFindObject("/Script/Engine.Default__GameplayStatics")
    if not GameplayStatics or not GameplayStatics:IsValid() then return nil end
    return GameplayStatics
end

local function TogglePause()
    local pc = GetPC()
    if not pc then
        print("[PauseMod] No PlayerController found.")
        return
    end
    local gs = GetGS()
    if not gs then
        print("[PauseMod] GameplayStatics not found.")
        return
    end

    local target = not isPaused
    local ok, err = pcall(function()
        gs:SetGamePaused(pc, target)
    end)

    if ok then
        isPaused = target
        print(isPaused and "[PauseMod] Game PAUSED" or "[PauseMod] Game RESUMED")
    else
        print("[PauseMod] SetGamePaused failed: " .. tostring(err))
    end
end

RegisterKeyBind(Key.PAUSE, {}, TogglePause)
RegisterKeyBind(Key.P, {ModifierKey.CONTROL}, TogglePause)

print("[PauseMod] Loaded. Pause/Break or Ctrl+P to toggle pause.")
