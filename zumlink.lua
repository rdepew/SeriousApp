-- Packages or libraries are called "modules" in Lua.
-- To use the module 'mymodule' in a scene or program, put this line near the top
-- of the scene file, where a C #include statement would go:
--
--     local mymodule = require "mymodule"
--
-- Then to call the 'mymodule' function 'foo':
--
--     mymodule.fool()


local zumlink = {}

function zumlink.verifyIpAddress( x )
  -- Does it have four numbers, separated by three dots?
  local ip = string.match( x, "%d+%.%d+%.%d+%.%d+" )
  if ( ip == nil ) then
    return ""
  end
  -- Are all four numbers betwen 0 and 255?
  t = {}
  for n in string.gfind(ip, "(%d+)") do
    table.insert(t, tonumber(n))
  end
  -- If it's a valid IP address, then rebuild and return it
  if ( t[1] < 255 and t[2] < 255 and t[3] < 255 and t[4] < 255 ) then
    return ( t[1] .. "." .. t[2] .. "." .. t[3] .. "." .. t[4] )
  -- If not, return an empty string.
  else
    return ""
  end
end

return zumlink
