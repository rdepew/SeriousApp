
local composer = require( "composer" )
local widget = require( "widget" ) -- for the pushbutton

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoMqtt() -- "game" is what we're calling the main app screen
  composer.gotoScene( "mqtt_listener" )
end

local function gotoZum() -- "game" is what we're calling the main app screen
  composer.gotoScene( "zumViewer" )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  local sceneGroup = self.view
  -- Code here runs when the scene is first created but has not yet appeared on screen

  local myText = display.newEmbossedText( "hello", display.contentCenterX, 100, native.systemFontBold, 40 )
  myText:setFillColor( 0.5 )
  myText:setText( "Serious App" )
  local color =
  {
    highlight = { r=1, g=1, b=1 },
    shadow = { r=0.3, g=0.3, b=0.3 }
  }
  myText:setEmbossColor( color )
  sceneGroup:insert( myText )

  -- Functions to handle button events
  local function handleButton1Event( event )
    if ( "ended" == event.phase ) then
      print( "Button1 was pressed and released" )
      gotoMqtt()
    end
  end

  local function handleButton2Event( event )
    if ( "ended" == event.phase ) then
      print( "Button2 was pressed and released" )
      gotoZum()
    end
  end

  -- Create the widgets
  local button1 = widget.newButton(
    {
      left = 50,
      top = 200, 
      id = "button1",
      label = "Touch here for MQTT listener",
      onEvent = handleButton1Event
    }
  )
  sceneGroup:insert( button1 )
  
  local button2 = widget.newButton(
    {
      left = 50,
      top = 300, 
      id = "button2",
      label = "Touch here for ZumLink monitor",
      onEvent = handleButton2Event
    }
  )
  sceneGroup:insert( button2 )

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
