#!/usr/bin/env lua

dataFile = arg[1]
exportType = arg[2]

function FileExists( name )
   local f = io.open( name, "r" )
   if f then io.close( f ) return true else return false end
end
function DoFile( filename )
	local f = assert( loadfile( filename ) )
	return f()
end

function ExportXML()
	strOut = "<?xml version='1.0' encoding='utf-8' ?>\n"
	strOut = strOut .. "<ineed>\n"

	for itemID, ineedStruct in pairs( INEED_data ) do
		strOut = strOut .. string.format( '\t<item id="%s">', itemID )
		for realm, realmStruct in pairs( ineedStruct ) do
			strOut = strOut .. string.format( '\n\t\t<realm name="%s">', realm )
			strOut = strOut .."\t</realm>\n"
		end
		strOut = strOut .. "\t</item>\n"
	end

	strOut = strOut .. "</ineed>"
	return strOut

end
function ExportJSON()
	strOut = '{"INEED": {\n'
	for itemID, ineedStruct in pairs( INEED_data ) do
		strOut = strOut .. string.format( '\t"%s": {', itemID )
		for realm, realmStruct in pairs( ineedStruct ) do
			strOut = strOut .. string.format( '\n\t\t"%s": {', realm )
			strOut = strOut .. "\t},\n"
		end
	end

	return strOut
end

functionList = {
	["xml"] = ExportXML,
	["json"] = ExportJSON,
}

func = functionList[string.lower( exportType )]

if dataFile and FileExists( dataFile ) and exportType and func then
	DoFile( dataFile )
	strOut = func()
	print( strOut )
else
	io.stderr:write( "Something is wrong.  Lets review:\n" )
	io.stderr:write( "Data file provided: "..( dataFile and " True" or "False" ).."\n" )
	io.stderr:write( "Data file exists  : "..( FileExists( dataFile ) and " True" or "False" ).."\n" )
	io.stderr:write( "ExportType given  : "..( exportType and " True" or "False" ).."\n" )
	io.stderr:write( "ExportType valid  : "..( func and " True" or "False" ).."\n" )
end

