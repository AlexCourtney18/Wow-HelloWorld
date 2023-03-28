
SLASH_HELLO1 = '/helloworld'
SLASH_VAULT1 = '/vault'

SLASH_RELOADUI1 = '/rl' -- Quicker reloading
SlashCmdList.RELOADUI = ReloadUI

SLASH_FRAMESTK1 = '/fs' -- For quicker access to frame stack
SlashCmdList.FRAMESTK = function ()
    LoadAddOn('Blizzard_DebugTools')
    FrameStackTooltip_Toggle()
end

-- To be able to use the left and right arrows in the edit box
-- without rotating your character!
for i = 1, NUM_CHAT_WINDOWS do
    _G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
end

------------------------------------------------------------------------------------------------------------------------------------------

local UIConfig = CreateFrame("Frame", "VaultFrame", UIParent, "BasicFrameTemplateWithInset");

--[[
    CreateFrame arguments:
    1. The tyoe of frame - "Frame"
    2. The global frame name = "VaultFrame"
    3. The Parent frame (NOT a string!!) - UIParent
    4. A comma separated LIST (string list) of XML templates to inherit from
        - this does NOT need to be a comma separated list however
        - I'm only using 1 XML template - "BasicFrameTemplateWithInset"
]]

UIConfig:SetSize(300, 360); -- width, height
UIConfig:SetPoint("Center", UIParent, "Center"); -- point, relativeFrame, relativePoint, xOffset, yOffset

-- Point and relativePoint ("CENTER") could have been any of the following options:

--[[
    "TOPLEFT"
    "TOP"
    "TOPRIGHT"
    "LEFT"
    "CENTER"
    "RIGHT"
    "BOTTOMLEFT"
    "BOTTOM"
    "BOTTOMRIGHT"
]]


------------------------------------------------------------------------------------------------------------------------------------------

local function showGreeting(name, level) 
    local greeting = "Hello, " .. name .. "! Level " .. level .. " God!" 
    message(greeting)
end

-- /helloworld 
local function HelloWorldHandler(name)
    local userAddedName = string.len(name) > 0

    if(userAddedName) then
        showGreeting(name)
    else 
        local playerName = UnitName("player")
        local playerLevel = UnitLevel("player")
        showGreeting(playerName, playerLevel)
    end
end

-- /vault
local function VaultHandler()
    local activities = C_WeeklyRewards.GetActivities();
    print("TEST")
	for i, activityInfo in ipairs(activities) do
		if (not activityType or activityInfo.type == activityType) and activityInfo.progress >= activityInfo.threshold then
            print(#activities, "Activity Info")
			return true;
		end
	end

    
	return false;
end

SlashCmdList["HELLO"] = HelloWorldHandler
SlashCmdList["VAULT"] = VaultHandler


