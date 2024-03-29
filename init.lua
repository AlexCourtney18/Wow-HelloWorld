local _, core = ... --Namespace

--------------------------------------
-- Custom Slash Command
--------------------------------------
core.commands = {
    ["config"] = core.Config.Toggle, -- this is a function (no knowledge of Config object)
    ["help"] = function()
        print(" ");
        core:Print("List of slash commands:");
        core:Print("|cff00cc66/at config|r - shows config menu");
        core:Print("|cff00cc66/at help|r - shows help info");
        print(" ");
    end,
    ["example"] = {
        ["test"] = function(...)
            core:Print("My Value:", tostringall(...));
        end
    }
}

local function HandleSlashCommands(str)
    
    if (#str == 0) then
        -- User just enetered "/at" with no additional args.
        core.commands.help()
        return
    end

    local args = {}
    for _, arg in ipairs({string.split(" ", str)}) do
        if (#arg > 0) then
            table.insert(args, arg)
        end
    end

    local path = core.commands -- required for updating found table

    for id, arg in ipairs(args) do
        if (#arg > 0) then -- if string length is greater than 0
            arg = arg:lower()
            if (path[arg]) then
                if (type(path[arg]) == "function") then
                    -- all remaining args passed to our function!
                    path[arg](select(id + 1, unpack(args)))
                    return
                elseif (type(path[arg]) == "table") then
                    path = path[arg] -- another sub-table found!
                end
            else
                -- does not exist!
                core.commands.help()
                return
            end
        end
    end
end

function core:Print(...)
    local hex = select(4, self.Config:GetThemeColor())
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Aura Tracker:")
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...))
end

-- WARNING: self automatically becomes events frame!
function core:init(event, name)
    if (name ~= "HelloWorld") then
        return
    end

    -- To be able to use the left and right arrows in the edit box
    -- without rotating your character!
    for i = 1, NUM_CHAT_WINDOWS do
        _G["ChatFrame" .. i .. "EditBox"]:SetAltArrowKeyMode(false)
    end

    ----------------------------------
    -- Register Slash Commands!
    ----------------------------------
    SLASH_HELLO1 = "/helloworld"
    SLASH_VAULT1 = "/vault"

    SLASH_RELOADUI1 = "/rl" -- Quicker reloading
    SlashCmdList.RELOADUI = ReloadUI

    SLASH_FRAMESTK1 = "/fs" -- For quicker access to frame stack
    SlashCmdList.FRAMESTK = function()
        LoadAddOn("Blizzard_DebugTools")
        FrameStackTooltip_Toggle()
    end

    SLASH_AuraTracker1 = "/at";
    SlashCmdList.AuraTracker = HandleSlashCommands;

    core:Print("Welcome back", UnitName("player") .. "!")
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", core.init)
