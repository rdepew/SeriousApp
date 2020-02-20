-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local color = require( "colors.defalt" )
 
-- Hide status bar
-- display.setStatusBar( display.HiddenStatusBar )
 
-- Seed the random number generator
-- math.randomseed( os.time() )

-- Default background color
display.setDefault("background", unpack(color.mainbg))

 
-- Go to the menu screen
composer.gotoScene( "menu" )
