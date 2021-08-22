local googleAnalytics = require "plugin.googleAnalytics"
local json = require "json"
local widget = require "widget"

googleAnalytics.init()


local background = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
background.alpha = .95
background:setFillColor(.7,0,0)

local title = display.newText( "Google Analytics", display.contentCenterX, display.contentCenterY-180 , native.systemFont, 25 )

local logScreenName = widget.newButton( {
    label = "Log Screen Name (Home)",
    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
    id = "logImageShare",
    onRelease = function ( )
        googleAnalytics.logScreenName("Home")
    end
} )
logScreenName.x, logScreenName.y = display.contentCenterX, display.contentCenterY-100


local logImageShare = widget.newButton( {
    label = "Log Image Share",
    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
    id = "logImageShare",
    onRelease = function ( )
        googleAnalytics.logEvent( "share_image",{ fileType="png", imageNum=49})
    end
} )
logImageShare.x, logImageShare.y = display.contentCenterX, display.contentCenterY-60


local logButtonPress = widget.newButton( {
    label = "Log Button Press",
    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
    id = "logButtonPress",
    onRelease = function ( )
        googleAnalytics.logEvent( "menu_screen", "button_press", "menu", 10 )
    end
} )
logButtonPress.x, logButtonPress.y = display.contentCenterX, display.contentCenterY-20
