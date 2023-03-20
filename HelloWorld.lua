
SLASH_HELLO1 = '/helloworld'
SLASH_VAULT1 = '/vault'

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

local function VaultHandler()
    local activities = C_WeeklyRewards.GetActivities();
    print("TEST")
	for i, activityInfo in ipairs(activities) do
		if (not activityType or activityInfo.type == activityType) and activityInfo.progress >= activityInfo.threshold then
			return true;
		end
	end

    
	return false;



end

SlashCmdList["HELLO"] = HelloWorldHandler
SlashCmdList["VAULT"] = VaultHandler


