-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
 
-- Hide status bar
-- display.setStatusBar( display.HiddenStatusBar )
 
-- Seed the random number generator
-- math.randomseed( os.time() )

-- Default background color
display.setDefault("background", 226/255, 146/255, 67/255)

 
-- Go to the menu screen
composer.gotoScene( "menu" )
