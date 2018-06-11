--[[

  Author: haggen
  
  Date: Edited 02 Feb 2018
  
  Original Source: https://gist.github.com/haggen/2fd643ea9a261fea2094
  
  Direct Download: (slietly different version, update is in the comments) https://gist.github.com/haggen/2fd643ea9a261fea2094/raw/e9f2ada3154a3d207231d7426e4a00835c298a64/string.random.lua

]]--

charset = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(charset, string.char(c)) end
    for c = 65, 90  do table.insert(charset, string.char(c)) end
    for c = 97, 122 do table.insert(charset, string.char(c)) end
end

function randomString(length)
    if not length or length <= 0 then return '' end
    math.randomseed(os.clock()^5)
    return randomString(length - 1) .. charset[math.random(1, #charset)]
end
