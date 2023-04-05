local _, core = ...; --Namespace

--------------------------------------
-- Custom Slash Command
--------------------------------------
core.commands = {
    ["config"] = core.Config.Toggle, -- this is a function (no knowledge of Config object)
    
        ["help"] = function ()
            print(" ");
            core:Print("List of slash commands:")
            core:Print("|cff00cc66/at config|r - shows config menu");
            core:Print("|cff00cc66/at help|r - shows help info");
            print(" ");
        end,

        ["example"] = {
            ["test"] = function(...)
                core:Print("My Value:", tostringall(...));
            end
        }
};


function core:Print(...)
    local hex = select(4, self.Config:GetThemeColor());
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Aura Tracker:");
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...));
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
    SlashCmdList.RELOADUI = ReloadUI;

    SLASH_FRAMESTK1 = "/fs" -- For quicker access to frame stack
    SlashCmdList.FRAMESTK = function()
        LoadAddOn("Blizzard_DebugTools")
        FrameStackTooltip_Toggle()
    end

    SLASH_AuraTracker1 = "/at";
    SlashCmdList.AuraTacker = HandleSlashCommands;

    core:Print("Welcome back", UnitName("player") .. "!");
end


local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", core.init);
