local CreatePlayer = function(self)
    SetUnitDefaults(self)

    self:SetSize(140, 40)
    self:SetPoint("CENTER", UIParent, -350, -300)
    self.unitType = "player"

    -- HP Value
    local hpVal = self:CreateFontString(nil, "OVERLAY")
    hpVal:SetFont("Interface\\AddOns\\XervishUF\\Media\\Catamaran-Black.ttf", 48, "THINOUTLINE")
    hpVal:SetPoint("TOPRIGHT", self, 0, -2)

    -- Detail Block
    local powerBlock = self:CreateFontString(nil, "OVERLAY")
    powerBlock:SetFont("Fonts\\SKURRI.ttf", 12, "THINOUTLINE")
    powerBlock:SetPoint("RIGHT", self, 0, -30)

    -- Castbar!
    self.Castbar = xUF_CreateCastBar(true)
    self.Castbar:SetSize(200, 20)
    self.Castbar:SetPoint("RIGHT", hpVal, 0, -40)

    -- PVP Indicator
    local PvPIndicator = self:CreateTexture(nil, 'ARTWORK', nil, 1)
    PvPIndicator:SetSize(30, 30)
    PvPIndicator:SetPoint('RIGHT', name, "LEFT")
    
    local Badge = self:CreateTexture(nil, 'ARTWORK')
    Badge:SetSize(30, 30)
    Badge:SetPoint('CENTER', PvPIndicator, 'CENTER', 15)

    PvPIndicator.Badge = Badge
    self.PvPIndicator = PvPIndicator

    -- Combat Indicator
    local CombatIndicator = self:CreateTexture(nil, 'OVERLAY')
    CombatIndicator:SetSize(32, 32)
    CombatIndicator:SetPoint('RIGHT', hpVal, 32, 5)
    self.CombatIndicator = CombatIndicator

    -- Setup the Tags:
    self:Tag(hpVal, "[xUF_HP]")
    self:Tag(powerBlock, "[xUF_PowerType]: [xUF_SmartPowerValue]")
end

oUF:RegisterStyle("xUF_Player", CreatePlayer)
oUF:SetActiveStyle("xUF_Player")
oUF:Spawn("player","xUF_PlayerFrame")