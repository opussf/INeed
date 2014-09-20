#!/usr/bin/env lua

-- This script Will let you manage your INEED lists offline.
-- Perfect for adding needed items when you cannot log into Wow, say at work, or some other remote location.
-- While I can guarantee that the structure of the data file will not be corrupted, I cannot make any guarantee as
--   to bad data given (realm, char name, item id)

INEED_OFFLINE = {}

-- Data file:
INEED_OFFLINE.dataFile = "/Applications/World of Warcraft/WTF/Account/OPUSSF/SavedVariables/INEED.lua"
INEED_data = {}

function INEED_OFFLINE.dofile( filename )
	local f = assert( loadfile( filename ) )
	return f()
end
function INEED_OFFLINE.setCounts()
	INEED_OFFLINE.metaData = {}
	local itemCount = 0
	local realmCount = 0
	local realms = {}
	for itemID, _ in pairs( INEED_data ) do
		itemCount = itemCount + 1
		for realm, _ in pairs( INEED_data[itemID] ) do
			realms[realm] = 1
		end
	end
	for k, v in pairs( realms ) do
		realmCount = realmCount + 1
	end
	INEED_OFFLINE.metaData.itemCount = itemCount
	INEED_OFFLINE.metaData.realmCount = realmCount
end

INEED_OFFLINE.dofile( INEED_OFFLINE.dataFile )

--for itemID, _ in pairs( INEED_data ) do
--	print("itemID: "..itemID)
--end
