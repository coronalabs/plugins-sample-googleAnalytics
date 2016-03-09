
-- Abstract: Google Analytics
-- Version: 1.0
-- Sample code is MIT licensed; see http://www.coronalabs.com/links/code/license
---------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

------------------------------
-- RENDER THE SAMPLE CODE UI
------------------------------
local sampleUI = require( "sampleUI.sampleUI" )
sampleUI:newUI( { theme="darkgrey", title="Google Analytics", showBuildNum=true } )

------------------------------
-- CONFIGURE STAGE
------------------------------

local composer = require( "composer" )
display.getCurrentStage():insert( sampleUI.backGroup )
display.getCurrentStage():insert( composer.stage )
display.getCurrentStage():insert( sampleUI.frontGroup )
composer.recycleOnSceneChange = false

----------------------
-- BEGIN SAMPLE CODE
----------------------

-- Require libraries/plugins
local googleAnalytics = require( "plugin.googleAnalytics" )
local widget = require( "widget" )

-- Set app font
local appFont = sampleUI.appFont
composer.setVariable( "appFont", appFont )

-- Preset the app name and tracking ID (replace these with your own for testing/release)
-- These values must be set/obtained in the Google Analytics dashboard: https://analytics.google.com/
local appName = "[YOUR-APP-NAME]"
local trackingID = "[YOUR-TRACKING-ID]"

-- Set local variables
local titleBarBottom = sampleUI.titleBarBottom
local setupComplete = false

-- Prompt/alert user for setup
if ( system.getInfo( "environment" ) == "device" ) then

	if ( tostring(appName) == "[YOUR-APP-NAME]" or tostring(trackingID) == "[YOUR-TRACKING-ID]" ) then
		local alert = native.showAlert( "Important", 'Confirm that you have specified your unique app name and tracking ID within "main.lua" on lines 39 and 40. These values must be set/obtained in the Google Analytics dashboard.', { "OK", "dashboard" },
			function( event )
				if ( event.action == "clicked" and event.index == 2 ) then
					system.openURL( "https://analytics.google.com/" )
				end
			end )
	else
		setupComplete = true
		-- Initialize Google Analytics
		googleAnalytics.init( appName, trackingID )
	end
end

-- Create asset image sheet
local assets = graphics.newImageSheet( "assets.png",
	{
		frames = {
			{ x=0, y=0, width=34, height=34 },
			{ x=36, y=0, width=34, height=34 },
			{ x=0, y=36, width=34, height=34 },
			{ x=36, y=36, width=34, height=34 },
			{ x=73, y=3, width=29, height=29 },
			{ x=70, y=35, width=4, height=4 },
			{ x=80, y=43, width=4, height=4 },
			{ x=101, y=43, width=4, height=4 },
			{ x=80, y=35, width=4, height=4 }
		},
		sheetContentWidth=105, sheetContentHeight=70
	}
)
composer.setVariable( "assets", assets )


-- Scene buttons handler function
local function handleSceneButton( event )

	if ( event.target.id == "scene1" and composer.getSceneName( "current" ) == "scene2" ) then

		-- Log event with Google Analytics
		print( 'Google Analytics event logged: "userAction" | "go to scene" | "scene1"' )
		googleAnalytics.logEvent( "userAction", "go to scene", "scene1" )

		-- Update scene buttons
		composer.getVariable( "scene2Button" ).alpha = 0.7
		composer.getVariable( "scene1Button" ).alpha = 1

		-- Go to scene
		composer.gotoScene( "scene1", { effect="slideRight", time=600 } )

	elseif ( event.target.id == "scene2" and composer.getSceneName( "current" ) == "scene1" ) then

		-- Log event with Google Analytics
		print( 'Google Analytics event logged: "userAction" | "go to scene" | "scene2"' )
		googleAnalytics.logEvent( "userAction", "go to scene", "scene2" )

		-- Update scene buttons
		composer.getVariable( "scene1Button" ).alpha = 0.7
		composer.getVariable( "scene2Button" ).alpha = 1

		-- Go to scene
		composer.gotoScene( "scene2", { effect="slideLeft", time=600 } )
	end
end


-- Create "scene 1" scene button
local scene1Button = widget.newButton(
	{
		id = "scene1",
		label = "Scene 1",
		width = display.actualContentWidth/2,
		height = 36,
		font = appFont,
		fontSize = 16,
		shape = "rectangle",
		fillColor = { default={ 0.55,0.125,0.125,1 }, over={ 0.605,0.138,0.138,1 } },
		labelColor = { default={ 1,1,1,1 }, over={ 1,1,1,1 } },
		onRelease = handleSceneButton,
	})
scene1Button.anchorX = 1
scene1Button.anchorY = 0
scene1Button.x = display.contentCenterX
scene1Button.y = titleBarBottom
scene1Button:setEnabled( false )
scene1Button.alpha = 0
composer.stage:insert( scene1Button )
composer.setVariable( "scene1Button", scene1Button )

-- Create "scene 2" scene button
local scene2Button = widget.newButton(
	{
		id = "scene2",
		label = "Scene 2",
		width = display.actualContentWidth/2,
		height = 36,
		font = appFont,
		fontSize = 16,
		shape = "rectangle",
		fillColor = { default={ 0.55,0.125,0.125,1 }, over={ 0.605,0.138,0.138,1 } },
		labelColor = { default={ 1,1,1,1 }, over={ 1,1,1,1 } },
		onRelease = handleSceneButton
	})
scene2Button.anchorX = 0
scene2Button.anchorY = 0
scene2Button.x = display.contentCenterX
scene2Button.y = titleBarBottom
scene2Button:setEnabled( false )
scene2Button.alpha = 0
composer.stage:insert( scene2Button )
composer.setVariable( "scene2Button", scene2Button )


-- Go to initial scene
if ( setupComplete == true ) then
	scene1Button:setEnabled( true )
	scene1Button.alpha = 1
	scene2Button:setEnabled( true )
	scene2Button.alpha = 0.7
	composer.gotoScene( "scene1" )
end
