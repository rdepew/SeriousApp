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

local callbackFunction -- used by networkListener()

function zumlink.verifyIpAddress( x )
  -- Does it have four numbers, separated by three dots?
  local ip = string.match( x, "^%d+%.%d+%.%d+%.%d+$" )
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


local function networkListener( event )
  if( event.isError ) then
    print( "Network error: ", event.response)
  else
    -- print( "In networkListener, RESPONSE: " .. event.response )
    callbackFunction( event.response )
  end
end

-- This stuff is useful if you're going to do a get.
local headers = {}
headers["Content-Type"] = "application/x-www-form-urlencoded"
headers["Accept-Language"] = "en-US"
headers["Authentication"] = "admin:admin"
local body = "color=red&size=small"
local params = {}
params.headers = headers
params.body = body

function zumlink.ping( ip )
  local ping = {}
  ping.prefix = "http://"
  ping.success, ping.response = network.request( ping.prefix .. ip, "GET", networkListener, params )
  if( not(ping.success) ) then
    ping.prefix = "https://"
    ping.success, ping.response = network.request( ping.prefix .. ip, "GET", networkListener, params )
    if( not(ping.success) ) then
      print( "Cannot connect to " .. ip )
      return false
    end
  end
  return true
end

-- Return a string which is the JSON object. 
-- Let the calling function sort it out.
function zumlink.cmd( ip, command, callback )
  -- TODO: Use a module-scope {} var called "zum".
  -- zum.prefix, zum.ipAddr, zum.cmd, ...
  local cmd = {}
  cmd.command = command
  local url = "http://admin:admin@" .. ip .. "/cli/" .. cmd.command
  print( url )
  callbackFunction = callback -- <-- cache callback
  network.request( url, "GET", networkListener, params )
end

return zumlink
