#!/usr/bin/env lua

-- This script Will let you manage your INEED lists offline.
-- Perfect for adding needed items when you cannot log into Wow, say at work, or some other remote location.
-- While I can guarantee that the structure of the data file will not be corrupted, I cannot make any guarantee as
--   to bad data given (realm, char name, item id)

INEED_OFFLINE = {}
INEED_OFFLINE.metaData = {}
INEED_OFFLINE.isRunning = true

-- Data file:
INEED_OFFLINE.dataFile = "/Applications/World of Warcraft/WTF/Account/OPUSSF/SavedVariables/INEED.lua"
INEED_data = {}



function INEED_OFFLINE.file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end
function INEED_OFFLINE.dofile( filename )
	local f = assert( loadfile( filename ) )
	return f()
end
function INEED_OFFLINE.setCounts()
	local itemCount = 0
	local realmCount = 0
	local playerCount = 0
	local oldestUpdate = os.time()
	local oldestAdded = os.time()
	local realms = {}
	local names = {}
	for itemID, _ in pairs( INEED_data ) do
		itemCount = itemCount + 1
		for realm, _ in pairs( INEED_data[itemID] ) do
			realms[realm] = 1
			for name, data in pairs( INEED_data[itemID][realm] ) do
				oldestUpdate = math.min( oldestUpdate, tonumber(data.updated or os.time()) )
				oldestAdded = math.min( oldestAdded, tonumber(data.added or os.time()) )
				names[name.."-"..realm] = 1
			end
		end
	end
	for k, v in pairs( realms ) do
		realmCount = realmCount + 1
	end
	for k, v in pairs( names ) do
		playerCount = playerCount + 1
	end

	INEED_OFFLINE.metaData.itemCount = itemCount
	INEED_OFFLINE.metaData.realmCount = realmCount
	INEED_OFFLINE.metaData.playerCount = playerCount
	INEED_OFFLINE.metaData.oldestUpdated = oldestUpdate
	INEED_OFFLINE.metaData.oldestAdded = oldestAdded
end

function INEED_OFFLINE.showStats()
	print( "Stats:" )
	print( "\titems   : "..INEED_OFFLINE.metaData.itemCount )
	print( "\trealms  : "..INEED_OFFLINE.metaData.realmCount )
	print( "\tplayers : "..INEED_OFFLINE.metaData.playerCount )
	print( "Oldest items ---")
	print( "\tadded   : "..os.date( "%x %X", INEED_OFFLINE.metaData.oldestAdded ) )
	print( "\tupdated : "..os.date( "%x %X", INEED_OFFLINE.metaData.oldestUpdate ) )
end
function INEED_OFFLINE.showInfo( type )
end

function INEED_OFFLINE.printHelp()
	for cmd, info in pairs(INEED_OFFLINE.CommandList) do
		print(string.format("\t%s %s -> %s",
			cmd, info.help[1], info.help[2]));
	end
end

INEED_OFFLINE.CommandList = {
	['help'] = {
		["func"] = INEED_OFFLINE.printHelp,
		["help"] = {"", "Prints this help text" },
	},
	['q'] = {
		["func"] = function() INEED_OFFLINE.isRunning = false; end,
		["help"] = {"", "Quit" },
	},
	['stats'] = {
		["func"] = INEED_OFFLINE.showStats,
		["help"] = {"", "Show stats"},
	},
	['show'] = {
		["func"] = INEED_OFFLINE.showInfo,
		["help"] = {"<realm>|<name>", "Show specific info"},
	},
}

function INEED_OFFLINE.parseCmd( line )
	if line then
		line = string.lower( line )
		local a,b,c = string.find( line, "(%S+)" )  --contiguous string of non-space characters
		if a then
			-- c is the matched string, strsub is everything after that, skipping the space
			return c, string.sub( line, b+2 )
		else
			return ""
		end
	end
end

function INEED_OFFLINE.performPrompt()
	io.write( "INEED: ")
	cmd, param = INEED_OFFLINE.parseCmd( io.read("*l") ) -- read a line, parse it
	if cmd then
		cmdFunc = INEED_OFFLINE.CommandList[cmd]
		if cmdFunc then
			cmdFunc.func( param )
		else
			INEED_OFFLINE.printHelp()
		end
	else
		INEED_OFFLINE.isRunning = false
	end
end

if INEED_OFFLINE.file_exists( INEED_OFFLINE.dataFile ) then
	INEED_OFFLINE.dofile( INEED_OFFLINE.dataFile )
end
INEED_OFFLINE.setCounts()

while INEED_OFFLINE.isRunning do
	INEED_OFFLINE.performPrompt()
end



--for itemID, _ in pairs( INEED_data ) do
--	print("itemID: "..itemID)
--end
