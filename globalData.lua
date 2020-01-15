-- Pseudo-global space
--
-- Recommended in lieu of using global variables.
-- This file is as vital as scene_template.lua.
--
-- See https://docs.coronalabs.com/tutorial/basics/globals/index.html
-- 
-- Usage: This file contains only this content:
--     local M = {}
--
--     return M
--
-- Then, in your .lua module, put this line at or near the top:
--     local globalData = require( "globalData" )
--
-- To declare a pseudo-global variable:
--     globalData.xyz = "Hello there"
--
-- To access the pseudo-global variable:
--     local greeting = globalData.xyz

local M = {}

return M
