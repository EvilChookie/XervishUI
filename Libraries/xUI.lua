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
    }
}