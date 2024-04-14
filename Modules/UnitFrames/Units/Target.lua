local A, L = ...
local oUF = L.oUF

local CreateTarget = function(self)
    SetUnitDefaults(self)

    self:SetSize(140, 40)
    self:SetPoint("CENTER", UIParent, 355, -300)
    self.unitType = "target"

    -- HP Value
    local hpVal = self:CreateFontString(nil, "OVERLAY")
    hpVal:SetFont("Interface\\AddOns\\XervishUI\\Fonts\\Catamaran-Black.ttf", 48, "THINOUTLINE")
    hpVal:SetPoint("TOPLEFT", self, 0, -2)

    -- Name
    local name = self:CreateFontString(nil, "OVERLAY")
    name:SetFont("Fonts\\ARIALN.ttf", 28, "THINOUTLINE")
    name:SetPoint("LEFT", hpVal, 150, 0)

    -- Detail Block
    local hpPower = self:CreateFontString(nil, "OVERLAY")
    hpPower:SetFont("Fonts\\SKURRI.ttf", 12, "THINOUTLINE")
    hpPower:SetPoint("LEFT", self, 0, -30)

    -- Castbar!
    self.Castbar = xUF_CreateCastBar(false)
    self.Castbar:SetSize(200, 20)
    self.Castbar:SetPoint("LEFT", hpVal, 0, -40)

    -- PvP Indicator
    local PvPIndicator = self:CreateTexture(nil, 'ARTWORK', nil, 1)
    PvPIndicator:SetSize(30, 30)
    PvPIndicator:SetPoint('LEFT', name, "RIGHT")
    local Badge = self:CreateTexture(nil, 'ARTWORK')
    Badge:SetSize(30, 30)
    Badge:SetPoint('CENTER', PvPIndicator, 'CENTER', 15)
    PvPIndicator.Badge = Badge
    self.PvPIndicator = PvPIndicator

    -- Setup the Tags:
    self:Tag(hpVal, "[xUF_HP]")
    self:Tag(name, "[xUF_Name]")
    self:Tag(hpPower, "HP: [curhp] • [xUF_PowerType]: [xUF_SmartPowerValue]")
end

oUF:RegisterStyle("xUF_Target", CreateTarget)
oUF:SetActiveStyle("xUF_Target")
oUF:Spawn("target","xUF_TargetFrame")