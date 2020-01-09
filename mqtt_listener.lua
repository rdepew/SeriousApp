
local composer = require( "composer" )
local widget = require( "widget" ) -- for the pushbutton

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoMenu()
  composer.gotoScene( "menu" )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
  local title = display.newText( "MQTT Listener", display.contentCenterX, 5, native.systemFontBold)
  title:setFillColor( 0 )
  sceneGroup:insert( title )

  -- Functions to handle button events
  local function handleQuitEvent( event )
    if ( "ended" == event.phase ) then
      print( "Me no nike MQTT Listener" )
      gotoMenu()
    end
  end
  
  -- Create the widgets
  local quitButton = widget.newButton(
    {
      left = 50,
      top = 400,
      id = "quitButton",
      label = "Quit and return to menu",
      onEvent = handleQuitEvent
    }
  )
  sceneGroup:insert( quitButton )


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
