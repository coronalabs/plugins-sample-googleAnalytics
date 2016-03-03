
local googleAnalytics = require( "plugin.googleAnalytics" )
local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

local appFont = composer.getVariable( "appFont" )


-- UI handler function
local function uiEvent( event )

	-- Log event with Google Analytics
	print( "Google Analytics event logged: userAction | buttonSelected | " .. tostring(event.target.id) )
	googleAnalytics.logEvent( "userAction", "buttonSelected", tostring(event.target.id) )
end


function scene:create( event )

	local sceneGroup = self.view

	local sceneTitle = display.newText( sceneGroup, "Scene 1", display.contentCenterX, 115, appFont, 20 )

	-- Create test button 1
	local testButton1 = widget.newButton(
	{
		id = "button1",
		label = "Button 1",
		shape = "rectangle",
		x = display.contentCenterX,
		y = 175,
		width = 188,
		height = 32,
		font = appFont,
		fontSize = 16,
		fillColor = { default={ 0.12,0.32,0.52,1 }, over={ 0.12,0.32,0.52,1 } },
		labelColor = { default={ 1,1,1,1 }, over={ 1,1,1,0.8 } },
		onRelease = uiEvent
	})
	sceneGroup:insert( testButton1 )

	-- Create test button 2
	local testButton2 = widget.newButton(
	{
		id = "button2",
		label = "Button 2",
		shape = "rectangle",
		x = display.contentCenterX,
		y = 225,
		width = 188,
		height = 32,
		font = appFont,
		fontSize = 16,
		fillColor = { default={ 0.14,0.34,0.54,1 }, over={ 0.14,0.34,0.54,1 } },
		labelColor = { default={ 1,1,1,1 }, over={ 1,1,1,0.8 } },
		onRelease = uiEvent
	})
	sceneGroup:insert( testButton2 )

	local radioLabel = display.newText( sceneGroup, "Radio Button Set", display.contentCenterX, 276, appFont, 14 )

	-- Create radio button set
	local radioGroup = display.newGroup()
	sceneGroup:insert( radioGroup )

	local radioButtonPos = { display.contentCenterX-55, display.contentCenterX, display.contentCenterX+55 }

	for i = 1,#radioButtonPos do
		local isOn = false; if ( i == 1 ) then isOn = true end
		local radioButton = widget.newSwitch(
		{
			sheet = composer.getVariable( "assets" ),
			width = 34,
			height = 34,
			frameOn = 1,
			frameOff = 2,
			x = radioButtonPos[i],
			y = 310,
			style = "radio",
			id = "radioButton"..i,
			initialSwitchState = isOn,
			onPress = uiEvent
		})
		radioGroup:insert( radioButton )
	end
end


function scene:show( event )

	if ( event.phase == "did" ) then
		-- Log screen name (scene name) to Google Analytics
		print( 'Google Analytics call: screen name of "' .. composer.getSceneName( "current" ) .. '" logged' )
		googleAnalytics.logScreenName( composer.getSceneName( "current" ) )
	end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )

return scene
