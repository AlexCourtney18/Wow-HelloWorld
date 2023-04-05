--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...;
core.Config = {} -- adds Config table to add on namespace

local Config = core.Config
local UIConfig

------------------------------------------------------------------------------------------------------------------------------------------
SLASH_HELLO1 = "/helloworld"
SLASH_VAULT1 = "/vault"

SLASH_RELOADUI1 = "/rl" -- Quicker reloading
SlashCmdList.RELOADUI = ReloadUI

SLASH_FRAMESTK1 = "/fs" -- For quicker access to frame stack
SlashCmdList.FRAMESTK = function()
    LoadAddOn("Blizzard_DebugTools")
    FrameStackTooltip_Toggle()
end

-- To be able to use the left and right arrows in the edit box
-- without rotating your character!
for i = 1, NUM_CHAT_WINDOWS do
    _G["ChatFrame" .. i .. "EditBox"]:SetAltArrowKeyMode(false)
end

------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------
-- Config functions
--------------------------------------

function Config:Toggle()
    local menu = UIConfig or Config:CreateMenu()
    menu:SetShown(not menu:IsShown())
end

function Config:GetThemeColor()
    local c = defaults.theme
    return c.r, c.g, c.b, c.hex
end

function Config:CreateButton(point, relativeFrame, relativePoint, yOffset, text)
    local btn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate")
    btn:SetPoint(point, relativeFrame, relativePoint, 0, yOffset)
    btn:SetSize(140, 40)
    btn:SetText(text)
    btn:SetNormalFontObject("GameFontNormalLarge")
    btn:SetHighlightFontObject("GameFontHighlightLarge")
    return btn
end

function Config:CreateMenu()
    UIConfig = CreateFrame("Frame", "VaultFrame", UIParent, "BasicFrameTemplateWithInset")
    UIConfig:SetSize(260, 360)
    UIConfig:SetPoint("Center")

    UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0)
    UIConfig.title:SetText("Beriech's Vault Viewer")

    ---------------------------------
    -- Buttons
    ---------------------------------

    -- Save Button:
    UIConfig.saveBtn = self:CreateButton("CENTER", UIConfig, "TOP", 0, -70, "Save")

    -- Reset Button:
    UIConfig.resetBtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate")
    UIConfig.resetBtn:SetPoint("TOP", UIConfig.saveBtn, "BOTTOM", 0, -10)
    UIConfig.resetBtn:SetSize(140, 40)
    UIConfig.resetBtn:SetText("Reset")
    UIConfig.resetBtn:SetNormalFontObject("GameFontNormalLarge")
    UIConfig.resetBtn:SetHighlightFontObject("GameFontHighlightLarge")

    -- Load Button:
    UIConfig.loadBtn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate")
    UIConfig.loadBtn:SetPoint("TOP", UIConfig.resetBtn, "BOTTOM", 0, -10)
    UIConfig.loadBtn:SetSize(140, 40)
    UIConfig.loadBtn:SetText("Load")
    UIConfig.loadBtn:SetNormalFontObject("GameFontNormalLarge")
    UIConfig.loadBtn:SetHighlightFontObject("GameFontHighlightLarge")

    ---------------------------------
    -- Sliders
    ---------------------------------

    -- Slider 1:
    UIConfig.slider1 = CreateFrame("SLIDER", nil, UIConfig, "OptionsSliderTemplate")
    UIConfig.slider1:SetPoint("TOP", UIConfig.loadBtn, "Bottom", 0, -20)
    UIConfig.slider1:SetMinMaxValues(1, 100)
    UIConfig.slider1:SetValue(50)
    UIConfig.slider1:SetValueStep(25)
    UIConfig.slider1:SetObeyStepOnDrag(true)

    -- Slider 2:
    UIConfig.slider2 = CreateFrame("SLIDER", nil, UIConfig, "OptionsSliderTemplate")
    UIConfig.slider2:SetPoint("TOP", UIConfig.slider1, "BOTTOM", 0, -20)
    UIConfig.slider2:SetMinMaxValues(1, 100)
    UIConfig.slider2:SetValue(40)
    UIConfig.slider2:SetValueStep(25)
    UIConfig.slider2:SetObeyStepOnDrag(true)

    ---------------------------------
    -- Check Buttons
    ---------------------------------

    -- Check Button 1:
    UIConfig.checkBtn1 = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate")
    UIConfig.checkBtn1:SetPoint("TOPLEFT", UIConfig.slider2, "BOTTOMLEFT", -10, -40)
    UIConfig.checkBtn1.text:SetText("My Check Button!")

    -- Check Button 2:
    UIConfig.checkBtn2 = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate")
    UIConfig.checkBtn2:SetPoint("TOPLEFT", UIConfig.checkBtn1, "BOTTOMLEFT", 0, -10)
    UIConfig.checkBtn2.text:SetText("Another Check Button!")
    UIConfig.checkBtn2:SetChecked(true)

    UIConfig:Hide()
    return UIConfig
end

------------------------------------------------------------------------------------------------------------------------------------------

local function showGreeting(name, level)
    local greeting = "Hello, " .. name .. "! Level " .. level .. " God!"
    message(greeting)
end

-- /helloworld
local function HelloWorldHandler(name)
    local userAddedName = string.len(name) > 0

    if (userAddedName) then
        showGreeting(name)
    else
        local playerName = UnitName("player")
        local playerLevel = UnitLevel("player")
        showGreeting(playerName, playerLevel)
    end
end

-- /vault
local function VaultHandler()
    local activities = C_WeeklyRewards.GetActivities()
    print("TEST")
    for i, activityInfo in ipairs(activities) do
        if (not activityType or activityInfo.type == activityType) and activityInfo.progress >= activityInfo.threshold then
            print(#activities, "Activity Info")
            return true
        end
    end

    return false
end

SlashCmdList["HELLO"] = HelloWorldHandler
SlashCmdList["VAULT"] = VaultHandler

------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------
-- Additional Information
--------------------------------------

-- local UIConfig = CreateFrame("Frame", "VaultFrame", UIParent, "BasicFrameTemplateWithInset");

--[[
    CreateFrame arguments:
    1. The tyoe of frame - "Frame"
    2. The global frame name = "VaultFrame"
    3. The Parent frame (NOT a string!!) - UIParent
    4. A comma separated LIST (string list) of XML templates to inherit from
        - this does NOT need to be a comma separated list however
        - I'm only using 1 XML template - "BasicFrameTemplateWithInset"
]]

-- UIConfig:SetSize(260, 360); -- width, height
-- UIConfig:SetPoint("Center"); -- point, relativeFrame, relativePoint, xOffset, yOffset

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

-- UIConfig IS the parent frame for all other child frames and layered
-- regions will add on to it, to make it graphical!

-- Child frames and regions:

-- UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY");
-- UIConfig.title:SetFontObject("GameFontHighlight");
-- UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0);
-- UIConfig.title:SetText("Beriech's Vault Viewer");

--[[
    -- Full List of Font Objects:
    GameFontNormal
    GameFontNormalSmall
    GameFontNormalLarge
    GameFontHighlight
    GameFontHighlightSmall
    GameFontHighlightSmallOutline
    GameFontHighlightLarge
    GameFontDisable
    GameFontDisableSmall
    GameFontDisableLarge
    GameFontGreen
    GameFontGreenSmall
    GameFontGreenLarge
    GameFontRed
    GameFontRedSmall
    GameFontRedLarge
    GameFontWhite
    GameFontDarkGraySmall
    NumberFontNormalYellow
    NumberFontNormalSmallGray
    QuestFontNormalSmall
    DialogButtonHighlightText
    ErrorFont
    TextStatusBarText
    CombatLogFont
]]