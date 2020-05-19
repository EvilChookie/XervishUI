local A, L = ...
local oUF = L.oUF

local function xUF_DPS_Style(self, unit)

end

local function xUF_Healer_Style(self, unit)

end

oUF:RegisterStyle('XervishDPS', xUF_DPS_Style)
oUF:RegisterStyle('XervishHealer', xUF_Healer_Style)

oUF:Factory(function(self)
    local name = select(2, GetSpecializationInfo(GetSpecialization()))
    local role =  GetSpecializationRole(GetSpecialization())

    if role == "HEALER" then
        print("Using Healer Layout")
        oUF:SetActiveStyle('XervishHealer')
    else
        print("Using DPS Layout")
        oUF:SetActiveStyle('XervishDPS')
    end

    -- -- self:SpawnHeader(nil, nil, 'custom [group:party] show; [@raid3,exists] show; [@raid26,exists] show; hide',
    -- self:SpawnHeader(nil, nil, 'show',
	-- 	'showParty', true,
	-- 	'showRaid', true,
	-- 	'showPlayer', true,
	-- 	'yOffset', -6,
	-- 	'groupBy', 'ASSIGNEDROLE',
	-- 	'groupingOrder', 'TANK,HEALER,DAMAGER',
	-- 	'oUF-initialConfigFunction', [[
	-- 		self:SetHeight(19)
	-- 		self:SetWidth(126)
	-- 	]]
    -- ):SetPoint('TOP', UIParent, 'BOTTOM', 0, -10)
end)