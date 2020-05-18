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