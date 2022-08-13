local function RenderText(x, y, scale, text)
	SetTextScale(1.0, scale)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y)
end

local function GetTextWidth(text, scale)
    BeginTextCommandWidth("CELL_EMAIL_BCON")
    AddTextComponentSubstringPlayerName(text)
    SetTextScale(1.0, scale)
    return EndTextCommandGetWidth(true) -- crash
end

local function GetLineCount(text)
    BeginTextCommandLineCount("CELL_EMAIL_BCON")
    AddTextComponentSubstringPlayerName(text)
    return GetTextScreenLineCount(0, 0) -- this cause a crash too
end

local LINES <const> = 30
local TEXT <const> = "🍕 pizza"

Citizen.CreateThread(function()
    while true do Wait(0)
        GetTextWidth(TEXT, 0.3)

        for i = 1, LINES do
            local spacer = i / 40
            RenderText(0.5, 0 + spacer, 0.3, TEXT)
        end
    end
end)

--[[
    __Lua_InvokeNative: execution failed: Error executing native 0x85f061da64ed2f67 at address 0x7ff6ca3302ba.
    SCRIPT ERROR: Execution of native 85f061da64ed2f67 in script host failed: Error executing native 0x85f061da64ed2f67 at address 0x7ff6ca3302ba.
    > [global chunk] (EndTextCommandGetWidth.lua:7)
    > fn (@repro_gfx_err/client.lua:26)
]]