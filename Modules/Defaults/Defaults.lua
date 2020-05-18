local A, L = ...

function xUI_SetDefaults()
    -- ENABLE: AutoLoot
    SetCVar("autoLootDefault", 1)

    -- ENABLE: Dismount in Flight
    SetCVar("autoDismountFlying", 1)

    -- ENABLE: Classic Chat Style
    SetCVar("chatStyle", "classic")

    -- ENABLE: Numbers for Cooldowns
    SetCVar("countdownForCooldowns", 1)

    -- ENABLE: Target of Target
    SetCVar("showTargetOfTarget", 1)

    -- ADJUST: Spell alerts to 100% Opacity
    SetCVar("spellActivationOverlayOpacity", 1)

    -- DISABLE: Personal Power Bar
    SetCVar("nameplateShowSelf", 0)

    -- DISABLE: Chat Bubbles
    SetCVar("chatBubbles", 0)
    SetCVar("chatBubblesParty", 0)

    -- DISALBE: Tutorials
    SetCVar("showTutorials", 0)

    -- DISALBE: Adjust my Camera
    SetCVar("cameraSmoothStyle", 0)

    -- DISABLE: Profanity Filter
    SetCVar("profanityFilter", 0)

    -- DISABLE: Always show ActionBars
    SetCVar("alwaysShowActionBars", 0)

    -- DISABLE: Names
    SetCVar("UnitNameFriendlyPlayerName", 0)
    SetCVar("UnitNameFriendlyMinionName", 0)
    SetCVar("UnitNameEnemyMinionName", 0)
    SetCVar("UnitNameHostleNPC", 0)
    SetCVar("UnitNameInteractiveNPC", 0)

    -- DISABLE: Combat Text:
    SetCVar("floatingCombatTextCombatDamage", 1)
	SetCVar("floatingCombatTextCombatHealing", 1)
	SetCVar("enableFloatingCombatText", 1)

    -- MOVE: Objective Tracker (so it lines up with Minimap):
    -- Calls to ObjectiveTrackerFrame:SetPoint are easily taintable - this avoids taint.
    -- Credit: http://www.wowinterface.com/forums/showthread.php?t=46733
    local PointGettingSet
    hooksecurefunc(ObjectiveTrackerFrame, "SetPoint", function(self)
        if PointGettingSet then return end
        PointGettingSet = true
        self:ClearAllPoints()
        self:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -10, -210)
        PointGettingSet = false
    end)
end

XervishUI:RegisterCallback("PLAYER_LOGIN", xUI_SetDefaults)