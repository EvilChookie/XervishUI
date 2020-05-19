local A, L = ...
L.addonName = A

XervishUI = {}
XervishUI.addonName = A

-- Credit to Zork for rLib:
function XervishUI:RegisterCallback(event, callback, ...)
    if not self.eventFrame then
        self.eventFrame = CreateFrame("Frame")
        function self.eventFrame:OnEvent(event, ...)
        for callback, args in next, self.callbacks[event] do
            callback(args, ...)
        end
        end
        self.eventFrame:SetScript("OnEvent", self.eventFrame.OnEvent)
    end
    if not self.eventFrame.callbacks then self.eventFrame.callbacks = {} end
    if not self.eventFrame.callbacks[event] then self.eventFrame.callbacks[event] = {} end
    self.eventFrame.callbacks[event][callback] = {...}
    self.eventFrame:RegisterEvent(event)
end

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