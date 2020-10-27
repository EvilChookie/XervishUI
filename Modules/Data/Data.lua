local A, L = ...

function xUI_Draw_Stat_Panel()
    -- Create the frame for all of this:
    local statFrame = CreateFrame("Frame",nil, UIParent)

    -- Text Frame
    statFrame.text = statFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statFrame.text:SetPoint("CENTER")

    -- Show us the text frame!
    statFrame:SetFrameStrata("BACKGROUND")
    statFrame:SetWidth(256)
    statFrame:SetHeight(18)
    statFrame:SetPoint("TOP", 0, -10)
    statFrame:Show()

    -- Put together some variables for our stat text:
    local timer = 0

    local function seperator()
        return " • "
    end

    -- Experience:
    local function getExperience()
        if UnitLevel("player") < GetMaxLevelForPlayerExpansion() then
            -- Return XP as a percentage
            local percentXP = string.format("%.2f", (UnitXP("player")/UnitXPMax("player"))*100)

            -- What if we're rested?
            if GetRestState() == 1 then
                return string.format("%sXP: %s%% (Rested: %s)", seperator(), percentXP, GetXPExhaustion()/2)                
            else
                return string.format("%sXP: %s%%", seperator(), percentXP)
            end
        else 
            return ""
        end
    end

    -- Reputation:
    local function getReputation()
        if GetWatchedFactionInfo() then
            local name, standing, min, max, value, factionID = GetWatchedFactionInfo()
            local percentRep = string.format("%.2f", ((value - min)/(max-min))*100)
            return string.format("%s%s - %s%% - %s", seperator(), name, percentRep, _G['FACTION_STANDING_LABEL'..standing])
        else 
            return ""
        end
    end

    -- Register a function that updates the text
    statFrame.TimeSinceLastUpdate = 0
    statFrame:SetScript("OnUpdate", function(self, elapsed)
        self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	
        if (self.TimeSinceLastUpdate > 1.0) then
            local down, up, lagHome, lagWorld = GetNetStats()
            self.text:SetFormattedText("")
            self.text:SetFormattedText("%s%s%s%s%s%s%s",
                string.format("%.0f FPS", GetFramerate()),
                seperator(),
                string.format("Home: %.0f ms", lagHome),
                seperator(),
                string.format("World: %.0f ms", lagWorld),
                -- Because rep and XP are optional, they handle the seperator inside their functions
                getExperience(),
                getReputation()
            )
            self.TimeSinceLastUpdate = 0;
        end
    end)
end

XervishUI:RegisterCallback("PLAYER_LOGIN", xUI_Draw_Stat_Panel)