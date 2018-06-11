--[[

  Author: Panzer1119
  
  Date: Edited 11 Jun 2018 - 08:38 PM
  
  Original Source: https://github.com/Panzer1119/CCAES/blob/master/aes_keygen.lua
  
  Direct Download: https://raw.githubusercontent.com/Panzer1119/CCAES/master/aes_keygen.lua

]]--

os.loadAPI("libs/utils.lua")

local p_name = utils.getRunningProgram(shell)

args = {...}

function printUsages()
	print("Usages: ")
	print("")
	print("Maxmimum length is 244")
	print("")
	print(p_name .. " gen <length> <filename>")
	print("		> generates an aes key")
	print("")
	print(p_name .. " gen-disk <length> <filename> [filename on disk, if blank it's the first filename]")
	print("		> generates an aes key and copies it to a disk")
	utils.exit()
end

function keyGen(length, filename, filename_disk)	
	if fs.exists(filename) or (filename_disk ~= nil and fs.exists(filename_disk)) then
		print("Generating new AES key will overwrite")
		write("your current one. Continue? [y/N]: ")
		if not read():lower():find("y") then
			return
		end
	end
	print("Generating new AES key...")
	--print("This can take up to a few minutes.")
	local start = os.clock()
	local key = sr.randomString(length)
	if (key == nil) then
		printUsages()
	end
	local f_key = io.open(filename, "w")
	f_key:write(textutils.serialize({key=key, length=length}))
	f_key:close()
	if (filename_disk ~= nil) then
		f_key = io.open(filename_disk, "w")
		f_key:write(textutils.serialize(privateKey))
		f_key:close()
	end
	print("")
	print("Finished! Took " .. math.ceil((os.clock() - start) * 1000) .. " ms.")
	if (filename_disk ~= nil) then
		print("Keys saved to " .. filename .. " and " .. filename_disk)
	else
		print("Key saved to " .. filename)
	end
end

if (args[1] == nil or args[2] == nil or args[3] == nil) then
	printUsages()
end
local length = tonumber(args[2])
local filename = tostring(args[3])
if (args[1] == "gen") then
	--print("gen " .. filename .. " l = " .. length)
	keyGen(length, filename, nil)
	utils.exit()
end
if (args[1] == "gen-disk") then
	local filename_disk = "disk/" .. filename
	if (args[4] ~= nil) then
		filename_disk = "disk/" .. tostring(args[4])
	end
	--print("gen-disk " .. filename .. " VS " .. filename_disk .. " l = " .. length)
	keyGen(length, filename, filename_disk)
	utils.exit()
end
printUsages()
