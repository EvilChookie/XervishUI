function SetUnitDefaults(self)
    self:RegisterForClicks("AnyDown")
    self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)
end

function hex(r, g, b)
	if r then
		if (type(r) == "table") then
			if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
		end
		return ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
	end
end

-- Function to hide the order hall bar
function HideCommandBar()
	OrderHallCommandBar:HookScript("OnShow", function()
		OrderHallCommandBar:Hide()
	end)
end

-- Run function when Blizzard addon has loaded
if IsAddOnLoaded("Blizzard_OrderHallUI") then
	HideCommandBar()
else
	local waitFrame = CreateFrame("FRAME")
	waitFrame:RegisterEvent("ADDON_LOADED")
	waitFrame:SetScript("OnEvent", function(self, event, arg1)
		if arg1 == "Blizzard_OrderHallUI" then
			HideCommandBar()
			waitFrame:UnregisterAllEvents()
		end
	end)
end

-------------------
-- Castbar Creation
-------------------
colors = {}
colors.bgMultiplier = 0.3

colors.castbar = {
	default = {1,0.7,0},
	defaultBG = {1*colors.bgMultiplier,0.7*colors.bgMultiplier,0},
	shielded = {0.7,0.7,0.7},
	shieldedBG = {0.7*colors.bgMultiplier,0.7*colors.bgMultiplier,0.7*colors.bgMultiplier},
  }

local function SetCastBarColorShielded(self)
	self.__owner:SetStatusBarColor(unpack(colors.castbar.shielded))
	self.__owner.bg:SetVertexColor(unpack(colors.castbar.shieldedBG))
end

local function SetCastBarColorDefault(self)
	self.__owner:SetStatusBarColor(unpack(colors.castbar.default))
	self.__owner.bg:SetVertexColor(unpack(colors.castbar.defaultBG))
end

function xUF_CreateCastBar(isPlayerBar)
	-- Configuration:
	local texture = "Interface\\Addons\\SharedMedia\\statusbar\\Striped.tga"
	local c = {}

    -- Set up some basics:
	local Castbar = CreateFrame('StatusBar', nil, self)
	Castbar:SetStatusBarTexture(texture)

    -- Add a background
    local Background = Castbar:CreateTexture(texture, 'BACKGROUND')
    Background:SetAllPoints(Castbar)
	Background:SetColorTexture(0.1, 0.1, 0.1, 0.9)

    -- Add a spark
    local Spark = Castbar:CreateTexture(texture, 'OVERLAY')
    Spark:SetSize(20, 20)
	Spark:SetBlendMode('ADD')

    -- Add a timer
    local Time = Castbar:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
	Time:SetPoint('RIGHT', Castbar, -5, 0)
	
    -- Add spell text
    local Text = Castbar:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
	Text:SetPoint('LEFT', Castbar, 5, 0)
	
    -- Add spell icon
    local Icon = Castbar:CreateTexture(nil, 'OVERLAY')
	Icon:SetSize(20, 20)
	Icon:SetTexCoord(.08, .92, .08, .92)

    -- Add Shield
	local shield = Castbar:CreateTexture(nil,"BACKGROUND",nil,-8)
	shield.__owner = Castbar
	Castbar.Shield = shield
	--use a trick here...we use the show/hide on the shield texture to recolor the castbar
	hooksecurefunc(shield,"Show",SetCastBarColorShielded)
	hooksecurefunc(shield,"Hide",SetCastBarColorDefault)
	
    -- Add safezone
	local SafeZone = Castbar:CreateTexture(nil, 'OVERLAY')

	-- Is this a player bar or a non player bar?
	if isPlayerBar then
		Icon:SetPoint('TOPLEFT', Castbar, -20, 0)
		c = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
		Castbar:SetStatusBarColor(c.r, c.g, c.b, 1)
	else
		Icon:SetPoint('TOPRIGHT', Castbar, 20, 0)
		Castbar:SetFillStyle("REVERSE")
		Castbar:SetStatusBarColor(0, 1, 0, 1)
	end

	-- Font Sizes and Shadows
	Time:SetFont("Fonts\\SKURRI.ttf", 10, nil)
	Text:SetFont("Fonts\\SKURRI.ttf", 10, nil)
	Time:SetShadowOffset(0, 0)
	Text:SetShadowOffset(0, 0)
	
    -- Register it with oUF
    Castbar.bg = Background
    Castbar.Spark = Spark
    Castbar.Time = Time
    Castbar.Text = Text
    Castbar.Icon = Icon
    Castbar.Shield = Shield
	Castbar.SafeZone = SafeZone
	
	return Castbar
end

----------------
-- oUF Functions
----------------

-- What type of power does the frame need to display?
oUF.Tags.Events["xUF_PowerType"] = "ACTIVE_TALENT_GROUP_CHANGED UPDATE_SHAPESHIFT_COOLDOWN UNIT_POWER_FREQUENT SPELLS_CHANGED"
oUF.Tags.Methods["xUF_PowerType"] = function(u)

	if select(2,UnitPowerType(u)) then
		local powerToken = select(2,UnitPowerType(u))

		-- Clean up the string:
		powerToken = gsub(powerToken, "_", " ")
		powerToken = string.lower(powerToken)
		powerToken = powerToken:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)

		return powerToken
	else
		return UnitPowerType(u)
	end
end

-- This is a smart value. No point in showing a percentage for things like rage or fury!
-- For power values that go over 100, this will also show percentages for them (so 150/150 energy will be displayed as "150 (100%)")
oUF.Tags.Events["xUF_SmartPowerValue"] = "ACTIVE_TALENT_GROUP_CHANGED UPDATE_SHAPESHIFT_COOLDOWN UNIT_POWER_FREQUENT SPELLS_CHANGED"
oUF.Tags.Methods["xUF_SmartPowerValue"] = function(u)
	local powerType = select(2, UnitPowerType(u))
	local power = UnitPower(u)
	local maxpower = UnitPowerMax(u)
	local percentage = ((power/maxpower)*100)
	if (powerType == "MANA") then
		return string.format("%d (%d%%)", power, percentage)
	elseif maxpower > 100 then
		return string.format("%d (%d%%)", power, percentage)
	else
		return power
	end
end

-- Colour our plate name, based on it's class or reaction to us.
oUF.Tags.Events["xUF_Name"] = "UNIT_HEALTH UNIT_CLASSIFICATION_CHANGED UNIT_CONNECTION UNIT_FACTION"
oUF.Tags.Methods["xUF_Name"] = function(u)
	local _, class = UnitClass(u)
    local reaction = UnitReaction(u, "player")
    local name = GetUnitName(u)
    local color

	if UnitIsDead(u) or UnitIsGhost(u) or not UnitIsConnected(u) then
		color = "|cffA0A0A0"
	elseif UnitIsTapDenied(u) then
		color = hex(oUF.colors.tapped)
	elseif u == "pet" then
		color = hex(oUF.colors.class[class])
	elseif UnitIsPlayer(u) then
		color = hex(oUF.colors.class[class])
	elseif reaction then
		color = hex(oUF.colors.reaction[reaction])
	else
		color = hex(1, 1, 1)
    end
    
    return (color .. name .."|r")
end

-- A quick tag for status (Dead, Disconnect or Ghost)
oUF.Tags.Events["xUF_Status"] = 'UNIT_HEALTH'
oUF.Tags.Methods["xUF_Status"] = function(u)
	if UnitIsDead(u) then
		return "|cffCFCFCF Dead|r"
	elseif UnitIsGhost(u) then
		return "|cffCFCFCF Ghost|r"
	elseif not UnitIsConnected(u) then
		return "|cffCFCFCF Off|r"
	end
end

-- Colour our health absed on percentage. As health goes up or down increases the amount of red or green that's present
oUF.Tags.Events["xUF_HP"] = 'UNIT_HEALTH UNIT_MAXHEALTH'
oUF.Tags.Methods["xUF_HP"] = function(u)
    local h = UnitHealth(u) / UnitHealthMax(u)
    local healthPercentage = h * 100
    local color = hex(1 - h, h, 0.2)
    return string.format("%s%d%%|r", color, healthPercentage)
end