
local composer = require( "composer" )
local widget = require( "widget" ) -- for the pushbutton

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame() -- "game" is what we're calling the main app screen
  composer.gotoScene( "game" )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  local sceneGroup = self.view
  -- Code here runs when the scene is first created but has not yet appeared on screen

  local myText = display.newEmbossedText( "hello", 200, 100, native.systemFontBold, 40 )
  myText:setFillColor( 0.5 )
  myText:setText( "Serious App" )
  local color =
  {
    highlight = { r=1, g=1, b=1 },
    shadow = { r=0.3, g=0.3, b=0.3 }
  }
  myText:setEmbossColor( color )

  -- Function to handle button events
  local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
      print( "Button was pressed and released" )
      gotoGame()
    end
  end

  -- Create the widget
  local button1 = widget.newButton(
    {
      left = 100,
      top = 200, 
      id = "button1",
      label = "Touch here to start",
      onEvent = handleButtonEvent
    }
  )

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
