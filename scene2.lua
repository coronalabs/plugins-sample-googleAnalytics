
local googleAnalytics = require( "plugin.googleAnalytics" )
local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

local appFont = composer.getVariable( "appFont" )
local slider1
local slider2

-- UI handler function
local function uiEvent( event )
	
	if ( event.target.value ) then
		if ( event.phase == "ended" ) then
			-- Log event with Google Analytics
			print( "Google Analytics event logged: userAction | set" .. tostring(event.target.id) .. " | " .. tostring(event.value) )
			googleAnalytics.logEvent( "userAction", "set"..tostring(event.target.id), tostring(event.value) )
		end

	elseif ( event.target.isOn == true or event.target.isOn == false ) then

		if ( event.target.isOn == true ) then
			-- Log event with Google Analytics
			print( "Google Analytics event logged: userAction | optionOn | " .. tostring(event.target.id) )
			googleAnalytics.logEvent( "userAction", "optionOn", tostring(event.target.id) )
		elseif ( event.target.isOn == false ) then
			-- Log event with Google Analytics
			print( "Google Analytics event logged: userAction | optionOff | " .. tostring(event.target.id) )
			googleAnalytics.logEvent( "userAction", "optionOff", tostring(event.target.id) )
		end
	end
	return true
end


function scene:create( event )

	local sceneGroup = self.view

	local sceneTitle = display.newText( sceneGroup, "scene 2", display.contentCenterX, 115, appFont, 20 )

	local sliderLabel = display.newText( sceneGroup, "sliders", display.contentCenterX, 160, appFont, 14 )

	-- Create slider 1
	slider1 = widget.newSlider(
	{
		sheet = composer.getVariable( "assets" ),
		width = 206,
        value = 80,
		handleFrame = 5,
		leftFrame = 6,
		middleFrame = 7,
		rightFrame = 8,
		fillFrame = 9,
		frameWidth = 4,
		frameHeight = 4,
		handleWidth = 29,
		handleHeight = 29,
        x = display.contentCenterX,
		y = 190,
		id = "Slider1",
        listener = uiEvent
	})
	sceneGroup:insert( slider1 )

	-- Create slider 2
	slider2 = widget.newSlider(
	{
		sheet = composer.getVariable( "assets" ),
		width = 206,
        value = 20,
		handleFrame = 5,
		leftFrame = 6,
		middleFrame = 7,
		rightFrame = 8,
		fillFrame = 9,
		frameWidth = 4,
		frameHeight = 4,
		handleWidth = 29,
		handleHeight = 29,
        x = display.contentCenterX,
		y = 225,
		id = "Slider2",
        listener = uiEvent
	})
	sceneGroup:insert( slider2 )

	local checkboxLabel = display.newText( sceneGroup, "checkbox set", display.contentCenterX, 276, appFont, 14 )

	-- Create checkbox set
	local checkboxPos = { display.contentCenterX-55, display.contentCenterX, display.contentCenterX+55 }

	for i = 1,#checkboxPos do
		local checkbox = widget.newSwitch(
		{
			sheet = composer.getVariable( "assets" ),
			width = 34,
			height = 34,
			frameOn = 3,
			frameOff = 4,
			x = checkboxPos[i],
			y = 310,
			style = "checkbox",
			id = "option"..i,
			initialSwitchState = false,
			onPress = uiEvent
		})
		sceneGroup:insert( checkbox )
	end
end


function scene:show( event )

	if ( event.phase == "will" ) then
		-- Correct slider alignment on scene show
		if ( slider1.contentWidth > 206 ) then
			if ( slider1.value < 50 ) then
				slider1.anchorX = 1 ; slider1.x = display.contentCenterX + 103
			else
				slider1.anchorX = 0 ; slider1.x = display.contentCenterX - 103
			end
		end
		if ( slider2.contentWidth > 206 ) then
			if ( slider2.value < 50 ) then
				slider2.anchorX = 1 ; slider2.x = display.contentCenterX + 103
			else
				slider2.anchorX = 0 ; slider2.x = display.contentCenterX - 103
			end
		end

	elseif ( event.phase == "did" ) then
		-- Log screen name (scene name) to Google Analytics
		print( 'Google Analytics call: screen name of "' .. composer.getSceneName( "current" ) .. '" logged' )
		googleAnalytics.logScreenName( composer.getSceneName( "current" ) )
	end
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )

return scene
