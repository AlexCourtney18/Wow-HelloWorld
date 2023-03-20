
SLASH_HELLO1 = '/helloworld'

local function showGreeting(name) 
    local greeting = "Hello, " .. name .. "!"

    message(greeting)
end

-- /helloworld 
local function HelloWorldHandler(name)
    local userAddedName = string.len(name) > 0

    if(userAddedName) then
        showGreeting(name)
    else 
        local playerName = UnitName("player")
        showGreeting(playerName)
    end
end

SlashCmdList["HELLO"] = HelloWorldHandler


