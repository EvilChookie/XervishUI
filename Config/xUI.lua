local A, L = ...

L.addonName       = A
L.addonColor      = "00FF7800"

-- General XervishUI Configuration.
L.cfg = {
    -- Fonts
    fonts = {
        fontSize = 10,
        font = "Interface\\Addons\\XervishUI\\Fonts\\ExpresswayFree.ttf"
    },

    -- ActionBars
    actionBars = {
        frameScale = 0.85,
        size = 32,
        padding = 5,
        margin = 5,
        mainBarVisibility = nil,
        additionalBarVisibility = nil
    },

    -- Fader:
    fader = {
        fadeInAlpha = 1,
        fadeInDuration = 0.3,
        fadeInSmooth = "OUT",
        fadeOutAlpha = 0,
        fadeOutDuration = 0.3,
        fadeOutSmooth = "OUT",
        fadeOutDelay = 0
    },

    -- Minimap:
    minimap = {
        scale = 1,
        mask = "Interface\\ChatFrame\\ChatFrameBackground",
        point = { "TOPRIGHT", -10, -10 }
    },

    -- DPS Layout
    dpsHeader = {
        visibility = 'raid,party,solo',
        config = {
            width = 175,
            height = 40,
            showPLayer = true,
            showParty = true,
            showRaid = true,
            xOffset = 10,
            yOffset = 10,
            point = "TOPLEFT",
            sortMethod = "INDEX",
            groupFilter = "GROUP",
            groupingOrder = "1,2,3,4,5,6,7,8",
            groupBy = nil,
            maxColumns = 1,
            unitsPerColumn = 40,
            columnSpacing = 0,
            columnAnchorPoint = "BOTTOM"
        }
    },

    -- Healer Layout
    healHeader = {
        visibility = 'raid,party,solo',
        width = 80,
        height = 80,
        showPLayer = true,
        showParty = true,
        showRaid = true,
        xOffset = 10,
        yOffset = 10,
        point = "CENTER",
        sortMethod = "INDEX",
        groupFilter = "GROUP",
        groupingOrder = "1,2,3,4,5,6,7,8",
        groupBy = nil,
        maxColumns = 8,
        unitsPerColumn = 5,
        columnSpacing = 0,
        columnAnchorPoint = "BOTTOM"
    }
}