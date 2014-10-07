function test.beforeOffline()
	INEED_data = {}
	INEED_data["7073"] = {
		["testRealm"]={ ["otherTestName"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ['inMail']=1, ["added"] = 1405487303, ["updated"] = 1405487303 },
						["yetAnotherName"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ["added"] = 1405487302, ["updated"] = 1405487362 },
						["third"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ["added"] = 1405487362, ["updated"] = 1405487422 }, },
		["otherTestRealm"]={ ["otherTestName"]={ ['needed']=10, ['total']=0, ['faction']="Alliance", ["added"] = 1405487304, ["updated"] = 1405487304 }, -- del
						["otherTestName2"]={ ['needed']=10, ['total']=0, ['faction']="Alliance", ["added"] = 1405487306, ["updated"] = 1405487305 },
						["noUpdated"]={ ['needed']=10, ['total']=0, ['faction']="Alliance", ["added"] = 1405487307 } },
	}
	INEED_OFFLINE.isRunning = false
	INEED_OFFLINE.setMetaData()
end

function test.testOffline_setMetaData_items()
	-- count of items
	test.beforeOffline()
	assertEquals( 1, INEED_OFFLINE.metaData.itemCount )
end
function test.testOffline_setMetaData_realms()
	-- count of realms
	test.beforeOffline()
	assertEquals( 2, INEED_OFFLINE.metaData.realmCount )
end
function test.testOffline_setMetaData_players()
	-- count of players
	test.beforeOffline()
	assertEquals( 6, INEED_OFFLINE.metaData.playerCount )
end
function test.testOffline_setMetaData_oldestAdded()
	test.beforeOffline()
	assertEquals( 1405487302, INEED_OFFLINE.metaData.oldestAdded )
end
function test.testOffline_setMetaData_oldestUpdated()
	test.beforeOffline()
	assertEquals( 1405487303, INEED_OFFLINE.metaData.oldestUpdated )
end
function test.testOffline_setMetaData_realmNames()
	test.beforeOffline()
	assertEquals( "otherTestRealm", INEED_OFFLINE.metaData.realmNames[1] )
	assertEquals( "testRealm", INEED_OFFLINE.metaData.realmNames[2] )
end
function test.testOffline_setMetaData_playerNames()
	test.beforeOffline()
	assertEquals( "otherTestName-otherTestRealm", INEED_OFFLINE.metaData.playerNames[1] )
	assertEquals( "otherTestName-testRealm", INEED_OFFLINE.metaData.playerNames[2] )
end
function test.testOffline_setMetaData_itemData_realm()
	test.beforeOffline()
	assertEquals( "testRealm", INEED_OFFLINE.metaData.itemData[1].realm )
end
function test.testOffline_setMetaData_itemData_name()
	test.beforeOffline()
	assertEquals( "otherTestName", INEED_OFFLINE.metaData.itemData[1].name )
end
function test.testOffline_setMetaData_itemData_fullName()
	test.beforeOffline()
	assertEquals( "otherTestName-testRealm", INEED_OFFLINE.metaData.itemData[1].fullName )
end
function test.testOffline_setMetaData_itemData_added()
	test.beforeOffline()
	assertEquals( 1405487303, INEED_OFFLINE.metaData.itemData[1].added )
end
function test.testOffline_setMetaData_itemData_updated()
	test.beforeOffline()
	assertEquals( 1405487303, INEED_OFFLINE.metaData.itemData[1].updated )
end


function test.testOffline_showStats()
	-- fail if the showStats fails
	test.beforeOffline()
	INEED_OFFLINE.showStats()
end
