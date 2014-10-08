function test.beforeOffline()
	INEED_data = {}
	INEED_data["7073"] = {
		["testRealm"]={ ["otherTestName"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ['inMail']=1, ["added"] = 1405487303, ["updated"] = 1405487303 },
						["yetAnotherName"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ["added"] = 1405487302, ["updated"] = 1405487362 },
						["third"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ["added"] = 1405487362, ["updated"] = 1405487422 }, },
		["otherTestRealm"]={ ["otherTestName"]={ ['needed']=10, ['total']=0, ['faction']="Alliance", ["added"] = 1405487304, ["updated"] = 1405487304 }, -- del
						["otherTestName2"]={ ['needed']=10, ['total']=0, ['faction']="Alliance", ["added"] = 1405487306, ["updated"] = 1405487305 },
						["noAdded"]={ ['needed']=10, ['total']=1, ['faction']="Alliance" },
						["noUpdated"]={ ['needed']=10, ['total']=0, ['faction']="Alliance", ["added"] = 1405487307 } },
	}
	INEED_OFFLINE.isRunning = false
	INEED_OFFLINE.setMetaData()
end

function test.testOffline_setMetaData_itemCount()
	-- count of items
	test.beforeOffline()
	assertEquals( 1, INEED_OFFLINE.metaData.itemCount )
end
function test.testOffline_setMetaData_realmCount()
	-- count of realms
	test.beforeOffline()
	assertEquals( 2, INEED_OFFLINE.metaData.realmCount )
end
function test.testOffline_setMetaData_playerCount()
	-- count of players
	test.beforeOffline()
	assertEquals( 7, INEED_OFFLINE.metaData.playerCount )
end
function test.testOffline_setMetaData_oldestAdded()
	-- set to 1 for no added
	test.beforeOffline()
	assertEquals( 1, INEED_OFFLINE.metaData.oldestAdded )
end
function test.testOffline_setMetaData_oldestUpdated()
	-- set to 1 for no updated
	test.beforeOffline()
	assertEquals( 1, INEED_OFFLINE.metaData.oldestUpdated )
end
function test.testOffline_setMetaData_realmNamesSorted()
	-- sorted by name
	test.beforeOffline()
	assertEquals( "otherTestRealm", INEED_OFFLINE.metaData.realmNames[1] )
	assertEquals( "testRealm", INEED_OFFLINE.metaData.realmNames[2] )
end
function test.testOffline_setMetaData_playerNamesSorted()
	-- sorted by name
	test.beforeOffline()
	assertEquals( "noAdded-otherTestRealm", INEED_OFFLINE.metaData.playerNames[1] )
	assertEquals( "noUpdated-otherTestRealm", INEED_OFFLINE.metaData.playerNames[2] )
end
function test.testOffline_setMetaData_itemData_realm()
	-- sorted by Updated
	test.beforeOffline()
	assertEquals( "otherTestRealm", INEED_OFFLINE.metaData.itemData[1].realm )
end
function test.testOffline_setMetaData_itemData_name()
	-- sorted by Updated
	test.beforeOffline()
	assertEquals( "noAdded", INEED_OFFLINE.metaData.itemData[1].name )
end
function test.testOffline_setMetaData_itemData_fullName()
	-- sorted by Updated
	test.beforeOffline()
	assertEquals( "noAdded-otherTestRealm", INEED_OFFLINE.metaData.itemData[1].fullName )
end
function test.testOffline_setMetaData_itemData_added()
	-- sorted by Updated
	test.beforeOffline()
	assertEquals( 1, INEED_OFFLINE.metaData.itemData[1].added )
end
function test.testOffline_setMetaData_itemData_updated()
	-- sorted by Updated
	test.beforeOffline()
	assertEquals( 1, INEED_OFFLINE.metaData.itemData[1].updated )
end


function test.testOffline_showStats()
	-- fail if the showStats fails
	test.beforeOffline()
	INEED_OFFLINE.showStats()
end
