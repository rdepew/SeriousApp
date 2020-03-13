-- file defalt.lua
--
-- Default color palette and scheme
-- The misspelling of the filename is intentional, so as not to confuse
-- it with any keywords or reserved words called "default"
--
-- Author: Ray Depew
-- Created: 19 Feb 2020
--
-- Overview
-- --------
-- Corona's display.setDefault() command allows one to specify colors.
-- setDefault() takes two arguments: first, a "key" representing the 
-- default color value to set. The four "color keys" are:
-- * background - default is black
-- * fillColor - default is white (this also sets text color)
-- * strokeColor - default is white
-- * lineColor - default is white
--
-- The command syntax is as follows:
-- * display.setDefault(key, value)
-- * display.setDefault(key, r, g, b, alpha)
-- * display.setDefault(key, r, g, b)
-- * display.setDefault(key, gray, alpha)
-- * display.setDefault(key, gray)
--
-- Black is 0, 0, 0. White is 1, 1, 1. 
--
-- Specifying colors
-- -----------------
--
-- Colors can be stored in a list of 3 values, or 4 if alpha is also 
-- specified. Examples:
-- black = { 0, 0, 0 }
-- white = { 1, 1, 1 }
-- red = { 1, 0, 0 }
--
-- In order to use colors specified as a list, one must use the unpack()
-- command:
--  display.setDefault( "lineColor", unpack( red ))
--
-- Color organization in this app
-- ------------------------------
--
-- The 'colors' directory contains Lua files that do nothing but specify 
-- color schemes. To activate a new color scheme in an application, put 
-- this line at the top of your application file:
--
--   local color = require( "colors.<colorfilename>" )
--
-- DO NOT INCLUDE the ".lua" suffix on the colorfilename in that command.
--
-- Then, in the body of your code, to specify (for example) a background
-- color:
--
--   display.setDefault( "background", unpack( color.mainbg ))
--
-- You can use any other variable name besides 'color' in the commands in 
-- your app. Taking and modifying the examples above:
--
--   local xyzzy = require( "colors.defalt" )
--
--   display.setDefault( "background", unpack( xyzzy.mainbg ))
--
-- Organization of this file
-- -------------------------
--
-- The color file consists of two parts: 
--
-- * a palette, where the colors are defined. The palette remains local.
-- * a color scheme, where the colors of the palette are assigned to different GUI
--   elements.
--
-- Where can I find colors defined?
-- --------------------------------
--
-- For common RGB values, see
-- * https://en.wikipedia.org/wiki/Web_colors
--   or
-- * https://en.wikipedia.org/wiki/X11_color_names


-- The palette --
--
local palette = {}

palette.black = { 0, 0, 0 }
palette.white = { 1, 1, 1 }
palette.red = { 1, 0, 0 }
palette.green = { 0, 1, 0 }
palette.blue = { 0, 0, 1 }
palette.yellow = { 1, 1, 0 }
palette.magenta = { 1, 0, 1 }
palette.cyan = { 0, 1, 1 }
palette.silver = { 0.75,0.75, 0.75 }
palette.gray = { 0.5,0.5, 0.5 }
palette.charcoal = { 0.25,0.25, 0.25 }
palette.pumpkin = { 226/255, 146/255, 67/255 }

-- The color scheme --
--
local color = {}

color.menubg = palette.blue
color.menufg = palette.white
color.menuSelected = palette.yellow
color.menuInactive = palette.gray

-- color.mainbg = palette.white
color.mainbg = palette.pumpkin
color.mainfg = palette.black
color.mainSelected = palette.red
color.mainInactive = palette.gray

color.titlebg = palette.white
color.titlefg = palette.black
color.titleInactive = palette.gray

color.textLabelbg = palette.white
color.textLabelfg = palette.black
color.textLabelSelected = palette.red
color.textLabelInactive = palette.gray

color.textFieldbg = palette.white
color.textFieldfg = palette.black
color.textFieldSelected = palette.red
color.textFieldInactive = palette.gray

return color
