
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


