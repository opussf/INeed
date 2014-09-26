function test.beforeOffline()
	INEED_data = {}
	INEED_data["7073"] = {
		["testRealm"]={ ["otherTestName"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ['inMail']=1, ["added"] = 1405487303, ["updated"] = 1405487303 },
						["yetAnotherName"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ["added"] = 1405487302, ["updated"] = 1405487362 },
						["third"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ["added"] = 1405487362, ["updated"] = 1405487422 }, },
		["otherTestRealm"]={ ["otherTestName"]={ ['needed']=10, ['total']=0, ['faction']="Alliance", ["added"] = 1405487304, ["updated"] = 1405487304 }, -- del
						["otherTestName2"]={ ['needed']=10, ['total']=0, ['faction']="Alliance", ["added"] = 1405487306, ["updated"] = 1405487305 } },
	}
	INEED_OFFLINE.isRunning = false
	INEED_OFFLINE.setMetaData()
end

function test.testOffline_setMetaData_items()
	test.beforeOffline()
	assertEquals( 1, INEED_OFFLINE.metaData.itemCount )
end
function test.testOffline_setMetaData_realms()
	test.beforeOffline()
	assertEquals( 2, INEED_OFFLINE.metaData.realmCount )
end
function test.testOffline_setMetaData_players()
	test.beforeOffline()
	assertEquals( 5, INEED_OFFLINE.metaData.playerCount )
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
function test.testOffline_showStats()
	-- fail if the showStats fails
	test.beforeOffline()
	INEED_OFFLINE.showStats()
end
--[[
function test.testOffline_09()
	test.beforeOffline()
	fail("09")
end
function test.testOffline_10()
	test.beforeOffline()
	fail("10")
end
function test.testOffline_11()
	test.beforeOffline()
	fail("11")
end
function test.testOffline_12()
	test.beforeOffline()
	fail("12")
end
]]
