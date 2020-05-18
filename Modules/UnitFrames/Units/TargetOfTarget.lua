--player style func
local CreateTarget = function(self)
    SetUnitDefaults(self)

    self:SetSize(120,18)
    self:SetPoint("TOPLEFT", xUF_TargetFrame, 0, 20)
    self.unitType = "targettarget"

    --create the unit strings
    local name = self:CreateFontString(nil, "OVERLAY")
    name:SetFont("Fonts\\SKURRI.ttf", 12, "THINOUTLINE")
    name:SetPoint("LEFT", self, 0, 0)

    self:Tag(name, "» [xUF_Name] ([perhp]%)")
end

oUF:RegisterStyle("xUF_ToT", CreateTarget)
oUF:SetActiveStyle("xUF_ToT")
oUF:Spawn("targettarget","xUF_ToTFrame")