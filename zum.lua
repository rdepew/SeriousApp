
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

  local title = display.newText( "ZumLink Viewer", display.contentCenterX, 0, native.systemFontBold, 24)
  title:setFillColor( 0 )
  sceneGroup:insert( title )


  ipAddrLabel = display.newText( "IP Address", 10, title.y + 40, native.systemFont, 18 )
  ipAddrLabel:setFillColor( 0.3, 0.3, 0.3 )
  ipAddrLabel.anchorX = 0
  sceneGroup:insert( ipAddrLabel )

  snLabel = display.newText( "Serial Number", 10, ipAddrLabel.y + 30, native.systemFont, 18 )
  snLabel:setFillColor( 0.3, 0.3, 0.3 )
  snLabel.anchorX = 0
  sceneGroup:insert( snLabel )

  devNameLabel = display.newText( "Device Name", 10, snLabel.y + 30, native.systemFont, 18 )
  devNameLabel:setFillColor( 0.3, 0.3, 0.3 )
  devNameLabel.anchorX = 0
  sceneGroup:insert( devNameLabel )

  modelLabel = display.newText( "Device Model", 10, devNameLabel.y + 30, native.systemFont, 18 )
  modelLabel:setFillColor( 0.3, 0.3, 0.3 )
  modelLabel.anchorX = 0
  sceneGroup:insert( modelLabel )

  fwLabel = display.newText( "Firmware Version", 10, modelLabel.y + 30, native.systemFont, 18 )
  fwLabel:setFillColor( 0.3, 0.3, 0.3 )
  fwLabel.anchorX = 0
  sceneGroup:insert( fwLabel )

  rteLabel = display.newText( "RTE Version", 10, fwLabel.y + 30, native.systemFont, 18 )
  rteLabel:setFillColor( 0.3, 0.3, 0.3 )
  rteLabel.anchorX = 0
  sceneGroup:insert( rteLabel )

  licenseLabel = display.newText( "Licenses", 10, rteLabel.y + 30, native.systemFont, 18 )
  licenseLabel:setFillColor( 0.3, 0.3, 0.3 )
  licenseLabel.anchorX = 0
  sceneGroup:insert( licenseLabel )

  uptimeLabel = display.newText( "Up Time", 10, licenseLabel.y + 30, native.systemFont, 18 )
  uptimeLabel:setFillColor( 0.3, 0.3, 0.3 )
  uptimeLabel.anchorX = 0
  sceneGroup:insert( uptimeLabel )

  -- Functions to handle button events
  local function handleQuitEvent( event )
    if ( "ended" == event.phase ) then
      print( "Quit button was pressed and released" )
      gotoMenu()
    end
  end
  
  -- Create the widgets
  local quitButton = widget.newButton(
    {
      left = 50,
      -- top = display.contentHeight-25,
      top = 400,
      -- id = "quit",
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
