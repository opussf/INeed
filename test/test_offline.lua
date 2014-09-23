function test.beforeOffline()
	INEED_data = {}
	INEED_data["7073"] = {
		["testRealm"]={ ["otherTestName"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ['inMail']=1, ["added"] = 1405487303, ["updated"] = 1405487303 },
						["yetAnotherName"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ["added"] = 1405487302, ["updated"] = 1405487362 },
						["third"]={ ['needed']=10, ['total']=1, ['faction']="Alliance", ["added"] = 1405487362, ["updated"] = 1405487422 }, },
		["otherTestRealm"]={ ["otherTestName"]={ ['needed']=10, ['total']=0, ['faction']="Alliance", ["added"] = 1405487304, ["updated"] = 1405487304 }, -- del
						["otherTestName2"]={ ['needed']=10, ['total']=0, ['faction']="Alliance", ["added"] = 1405487306, ["updated"] = 1405487305 } },
	}
end

function test.testOffline_setCounts_items()
	test.beforeOffline()
	INEED_OFFLINE.setCounts()
	assertEquals( 1, INEED_OFFLINE.metaData.itemCount )
end
function test.testOffline_setCount_realms()
	test.beforeOffline()
	INEED_OFFLINE.setCounts()
	assertEquals( 2, INEED_OFFLINE.metaData.realmCount )
end
function test.testOffline_setCount_players()
	test.beforeOffline()
	INEED_OFFLINE.setCounts()
	assertEquals( 5, INEED_OFFLINE.metaData.playerCount )
end
function test.testOffline_setCount_oldestAdded()
	test.beforeOffline()
	INEED_OFFLINE.setCounts()
	assertEquals( 1405487302, INEED_OFFLINE.metaData.oldestAdded )
end
function test.testOffline_setCount_oldestUpdated()
	test.beforeOffline()
	INEED_OFFLINE.setCounts()
	assertEquals( 1405487303, INEED_OFFLINE.metaData.oldestUpdated )
end
--[[
function test.testOffline_06()
	test.beforeOffline()
	fail("06")
end
function test.testOffline_07()
	test.beforeOffline()
	fail("07")
end
function test.testOffline_08()
	test.beforeOffline()
	fail("08")
end
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
