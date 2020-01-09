
local composer = require( "composer" )
local widget = require( "widget" ) -- for the pushbutton

local scene = composer.newScene()

local ipAddrField
local snField
local devNameField
local modelField
local fwField
local rteField
local licenseField
local uptimeField
local ipAddrLabel
local snLabel
local devNameLabel
local modelLabel
local fwLabel
local rteLabel
local licenseLabel
local uptimeLabel

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoMenu()
  composer.gotoScene( "menu" )
end

local function fieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			print( textField().text )
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
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
                --
		-- The text field's native piece starts hidden, we show it after we are on screen.on

		-- lets make the fields fit our adaptive screen better
		-- Why 150? The labels are around 120px wide. We want at least a 10px margin on either side of the labels
		-- and fields and we need some space betwen the label and the field. Let's start with 10px each

		local fieldWidth = display.contentWidth - 150
		if fieldWidth > 250 then
			fieldWidth = 250
		end

		ipAddrField = native.newTextField( 130, ipAddrLabel.y, fieldWidth, 30 )
		ipAddrField:addEventListener( "userInput", fieldHandler( function() return ipAddrField end ) ) 
		sceneGroup:insert( ipAddrField)
		ipAddrField.anchorX = 0
		ipAddrField.placeholder = "xxx.xxx.xxx.xxx"

		snField = native.newTextField( 130, snLabel.y, fieldWidth, 30 )
		sceneGroup:insert( snField)
		snField.anchorX = 0

		devNameField = native.newTextField( 130, devNameLabel.y, fieldWidth, 30 )
		sceneGroup:insert( devNameField)
		devNameField.anchorX = 0

		modelField = native.newTextField( 130, modelLabel.y, fieldWidth, 30 )
		sceneGroup:insert( modelField)
		modelField.anchorX = 0

		fwField = native.newTextField( 130, fwLabel.y, fieldWidth, 30 )
		sceneGroup:insert( fwField)
		fwField.anchorX = 0

		rteField = native.newTextField( 130, rteLabel.y, fieldWidth, 30 )
		sceneGroup:insert( rteField)
		rteField.anchorX = 0

		licenseField = native.newTextField( 130, licenseLabel.y, fieldWidth, 30 )
		sceneGroup:insert( licenseField)
		licenseField.anchorX = 0

		uptimeField = native.newTextField( 130, uptimeLabel.y, fieldWidth, 30 )
		sceneGroup:insert( uptimeField)
		uptimeField.anchorX = 0

                -- TODO: populate the textFields, if they already have values assigned.

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

                -- TODO: Save all textField values before removing them.
                --
		-- remove native.newTextFields since they contain native objects.
		ipAddrField:removeSelf()
		ipAddrField = nil
		snField:removeSelf()
		snField = nil
		devNameField:removeSelf()
		devNameField = nil
		modelField:removeSelf()
		modelField = nil
		fwField:removeSelf()
		fwField = nil
		rteField:removeSelf()
		rteField = nil
		licenseField:removeSelf()
		licenseField = nil
		uptimeField:removeSelf()
		uptimeField = nil

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
