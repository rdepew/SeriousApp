local composer = require( "composer" )
local widget = require( "widget" ) -- for the pushbutton
local json = require( "json" )
local zumlink = require( "zumlink" )

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

local ipAddr

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoMenu()
  composer.gotoScene( "menu" )
end

local function errorPopup( title, msg )
  local alert = native.showAlert( title, msg, { "Bummer" } )
  -- Dismiss "alert" after 10 seconds if user has not responded
  local function cancelMyAlert()
      native.cancelAlert( alert )
  end
  timer.performWithDelay( 10000, cancelMyAlert )
end

-- j: the JSON string we're searching.
-- it: the thing we're searching for.
-- x: the contents of it[]'value'].
--    x starts out as an empty string.
--    Once it's no longer empty, we're done.
-- n: How many recursions we've done so far.
local function find_in_dump(j, it, x, n)
  if x ~= "" then
    print("What am I doing here? x is found. Going up from level " .. n)
    return x
  end
  -- print("Recursion level " .. n .. "-----------")
  if type(j) == 'table' then
    for k, v in pairs(j) do
      if k ~= it then
        -- print("Key is " .. k .. ", not " .. it .. ". Going down.")
        x = find_in_dump(v, it, "", n+1)
        if x ~= "" then
          -- print("x is found. Going up from level " .. n)
          return x
        end
      else
        -- print("FOUND IT")
        x = v['value']
        -- print("value of " .. k .. " is: " ..x)
        return x
      end
    end
    -- print(it .. " not found at this level. Going up.")
    return ""
  else
    -- print("Bottomed out at object: " .. j .. ". Going up.")
    return ""
  end
end


local function systeminfo_cb( response )
    -- print("In systeminfo_cb")
    local r2=response:sub( 2, response:len() - 2 ) -- strip square brackets and newline
    local decoded, pos, msg = json.decode( r2 )
    if not decoded then
        print( "Decode failed at "..tostring(pos)..": "..tostring(msg) )
    else
        -- print( json.prettify( decoded ))
        -- If decoded.RESULT.MESSAGE is "OK", then the command executed successfully.
        -- print( decoded.RESULT.MESSAGE )
        snField.text = decoded.RESPONSE.pages.systemInfo.serialNumber
        devNameField.text = decoded.RESPONSE.pages.systemInfo.deviceName
        modelField.text =  decoded.RESPONSE.pages.systemInfo.deviceModel
        fwField.text =  decoded.RESPONSE.pages.systemInfo.deviceFirmwareVersion
        rteField.text =  decoded.RESPONSE.pages.systemInfo.rteVersion
        licenseField.text =  decoded.RESPONSE.pages.systemInfo.licenses
    end
end

local function uptime_cb( response )
    print( "In uptime_cb" )
    local r2=response:sub( 2, response:len() - 2 ) -- strip square brackets and newline
    local decoded, pos, msg = json.decode( r2 )
    if not decoded then
        print( "Decode failed at "..tostring(pos)..": "..tostring(msg) )
    else
        -- print( json.prettify( decoded ))
        -- If decoded.RESULT.MESSAGE is "OK", then the command executed successfully.
        -- print( decoded.RESULT.MESSAGE )
        uptimeField.text = string.format("%d", decoded.RESPONSE.pages.date.upTime )
    end
end

local function dump_cb( response )
    -- print("In dump_cb")
    -- print( response )
    t = string.find( response, "Network error" )
    if string.find( response, "Network error" ) then
        errorPopup( "Network Error", response:sub(16) .. " - " .. ipAddr )
        return
    end
    local decoded, pos, msg = json.decode( response )
    if not decoded then
        print( "Decode failed at "..tostring(pos)..": "..tostring(msg) )
    else
        -- print( json.prettify( decoded )) -- For debugging purposes
        -- If decoded[1].RESULT.MESSAGE is "OK", then the command executed successfully.
        print( decoded[1].RESULT.MESSAGE )
        -- TODO: These magic numbers are untenable. These numbers work for
        -- FWT1315TB.9, but there's no guarantee they'll work for other
        -- FW versions.
        -- We need to find a way to deduce the array index from the name of
        -- the tag. This is a stupid redundancy that we ought to work around.
        -- Maybe I can just delete all of the square brackets, wiping out the
        -- arrays, and just deal -- with a squiggly-bracket JSON object.
        -- TODO: Try that in a future commit.
        snField.text = find_in_dump(decoded, 'serialNumber', "", 1)
        devNameField.text = find_in_dump(decoded, 'deviceName', "", 1)
        modelField.text =  find_in_dump(decoded, 'deviceModel', "", 1)
        fwField.text =  find_in_dump(decoded, 'deviceFirmwareVersion', "", 1)
        rteField.text =  find_in_dump(decoded, 'rteVersion', "", 1)
        licenseField.text =  find_in_dump(decoded, 'licenses', "", 1)
        uptimeField.text =  find_in_dump(decoded, 'upTime', "", 1)
    end
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
                        ipAddr = zumlink.verifyIpAddress( textField().text )
                        if ( ipAddr == "" ) then
                          print( textField().text .. " is not a valid address" )
                        end
                        textField().text = ipAddr
                        zumlink.cmd( ipAddr, "dump", dump_cb )
			-- Hide keyboard
			native.setKeyboardFocus( nil )
                        -- Show spinner here
                        
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
