local CreatePlayerPet = function(self)
    SetUnitDefaults(self)

    self:SetSize(120,18)
    self:SetPoint("RIGHT", xUF_PlayerFrame, 0, 31)
    self.unitType = "playerpet"

    --create the unit strings
    local name = self:CreateFontString(nil, "OVERLAY")
    name:SetFont("Fonts\\SKURRI.ttf", 12, nil)
    name:SetPoint("RIGHT", self, 0, 0)
    name:SetShadowOffset(1, -1)
    name.frequentUpdates = true

    self:Tag(name, "[name] ([perhp]%) «")
  end
  
  oUF:RegisterStyle("xUF_PlayerPet", CreatePlayerPet)
  oUF:SetActiveStyle("xUF_PlayerPet")
  oUF:Spawn("playerpet","xUF_PlayerPetFrame")