local A, L = ...

L.addonName       = A
L.addonColor      = "00FF7800"

-----------------------------
-- Config
-----------------------------

L.cfg = {
    -- Fonts
    fonts = {
        fontSize = 10,
        font = "Interface\\Addons\\XervishUI\\Fonts\\ExpresswayFree.ttf"
    },

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