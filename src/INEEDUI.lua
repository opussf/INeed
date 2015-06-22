-- General functions
INEED.UIListBarWidth = 250
INEED.UIListBarHeight = 12
INEED.UIList_bars = {}
function INEED.UIListAssureBars( barsNeeded )
	-- make sure that there are enough bars to handle the need
	-- frameIn = frame to add bars to
	-- barsNeeded = # of bars to assure exist.
	-- barTable = table to add bars to (remove later to tie a table to the frame) (frameIn:GetName().."_bars")
	-----
	-- checks and adds bars to frameIn_bars
	--
	-- Hard coding to support the List Frame for now.  Generalize later
	-- Based on function from FactionBars

	-- INEED.UIList_bars

	local count = 0
	for b in pairs(INEED.UIList_bars) do
		count = count + 1
	end
	--INEED.Print("Bars I need: "..barsNeeded..". Bars I have: "..count)
	if (barsNeeded > count) then
		for i = count+1, barsNeeded do
			-- Create a bar
			INEED.Print("Creating bar# "..i)
			local newBar = CreateFrame( "StatusBar", "INEED.UIListBar"..i, INEEDUIListFrame, "INEEDUIListBarTemplate" )
			newBar:SetWidth( INEED.UIListBarWidth )
			newBar:SetHeight( INEED.UIListBarHeight )
			if (i == 1) then
				newBar:SetPoint( "TOPLEFT", "INEEDUIListFrame", "TOPLEFT" )
			else
				newBar:SetPoint( "TOPLEFT", INEED.UIList_bars[i-1], "BOTTOMLEFT" )
			end
			local text = newBar:CreateFontString("INEED.UIListText"..i, "OVERLAY", "INEEDUIListBarTextTemplate" )
			newBar.text = text
			text:SetPoint("TOPLEFT", newBar, "TOPLEFT", 5, 0)

			INEED.UIList_bars[i] = newBar
		end
	end
	return max(count, barsNeeded)
end


-- List display functions
function INEED.UIListOnLoad()
	INEED.Print("Loading UI - List")
	INEEDUIListFrame:Hide()
end
function INEED.UIListOnUpdate()
	-- Create a sorted index table of most recent updated items
	if (INEED.UIListLastUpdate or 0) + 1 > time() then
		return -- no need to update
	end
	INEED.UIListLastUpdate = time()

	local count = 0
	local sortedDisplayItems = {}

	-- need progress, link, updated..  for items that I need.
	for itemID in pairs(INEED_data) do
		if INEED_data[itemID][INEED.realm] and INEED_data[itemID][INEED.realm][INEED.name] then
			local updatedTS = INEED_data[itemID][INEED.realm][INEED.name].updated or INEED_data[itemID][INEED.realm][INEED.name].added
			--INEED.Print(itemID..":"..(time()-updatedTS).." <? "..(INEED_options["displayUIListDisplaySeconds"] or "nil") )
			if ((time() - updatedTS) < (INEED_options["displayUIListDisplaySeconds"] or 0)) then
					-- I need this item, and it has been updated within the update window
				table.insert( sortedDisplayItems,
						{["updated"] = updatedTS,
						 ["itemPre"] = "item:",
						 ["id"] = itemID,  -- itemPre..id can be used to get the link.
						 ["total"] = INEED_data[itemID][INEED.realm][INEED.name].total,
						 ["needed"] = INEED_data[itemID][INEED.realm][INEED.name].needed,
						 ["linkStr"] = (select( 2, GetItemInfo( itemID ) ) or "item:"..itemID)
				})
				count = count + 1
			end
		end
	end
	-- process currency
	for curID in pairs(INEED_currency) do
		local updatedTS = INEED_currency[curID].updated or INEED_currency[curID].added
		if ((time() - updatedTS) < (INEED_options["displayUIListDisplaySeconds"] or 0)) then
			table.insert( sortedDisplayItems,
					{["updated"] = updatedTS,
					 ["itemPre"] = "currency:",
					 ["id"] = curID,
					 ["total"] = INEED_currency[curID].total,
					 ["needed"] = INEED_currency[curID].needed,
					 ["linkStr"] = (GetCurrencyLink( curID ) or ("currency:"..curID))
			})
			count = count + 1
		end
	end
	-- return early, no need to sort an empty table.
	if (count == 0) then
		INEEDUIListFrame:Hide()
		INEED.Print("Hide List Frame: "..time())
		return;
	end
	INEEDUIListFrame:Show()
	-- sort table by updated, use itemPre..id as subsort
	table.sort( sortedDisplayItems, function(a,b) return (a.updated>b.updated or (a.updated==b.updated and (a.itemPre..a.id)<(b.itemPre..b.id) ) ); end)

	local barsNeeded = min(count, INEED_options["barCount"])
	local barCount = INEED.UIListAssureBars( barsNeeded )

	INEEDUIListFrame:SetHeight( INEED.UIListBarHeight*barsNeeded )

	for i = 1, barsNeeded do
		local data = sortedDisplayItems[i]
		local linkString = data.linkStr
		local outStr = string.format( "%i/%i %s", data.total, data.needed, linkString )

		INEED.UIList_bars[i]:SetMinMaxValues( 0, data.needed )
		INEED.UIList_bars[i]:SetValue( data.total )
		INEED.UIList_bars[i].text:SetText( outStr )
		INEED.UIList_bars[i]:SetStatusBarColor( 0, 0.3, 0.9 )


		INEED.UIList_bars[i]:SetFrameStrata("BACKGROUND")
		INEED.UIList_bars[i]:Show()
	end
	for barsHide = barsNeeded + 1, barCount do
		if INEED.UIList_bars[barsHide]:IsShown() then
			INEED.Print("Hiding: "..barsHide)
			INEED.UIList_bars[barsHide]:Hide()
		end
	end
end
function INEED.UIListOnDragStart()
	INEEDUIListFrame:StartMoving()
end
function INEED.UIListOnDragStop()
	INEEDUIListFrame:StopMovingOrSizing()
end


--[[
function FB.UpdateBars()
	-- Create a sorted index table of data from barData, count the table too
	local count = 0;
	local sortedKeys = {};
	for fac, val in pairs(FB.barData) do
		table.insert(sortedKeys, {["fac"]=fac, ["maxTS"]=val.maxTS});
		count = count + 1;
	end
	if (count == 0) then
		FB_Frame:Hide();
		--FB.Print("Hide Frame");
		return;
	end
	local barCount = FB.AssureBars( count );
	-- the key to sort on is the maxTS
	table.sort(sortedKeys, function(a,b) return (a.maxTS>b.maxTS or (a.maxTS==b.maxTS and a.fac<b.fac)); end);
	local showBars = min(#sortedKeys, FB_options.numBars);
	FB_Frame:SetHeight(FB.barHeight*showBars);

	for i = 1, showBars do
		local fac = sortedKeys[i].fac;

		local val = FB.barData[fac];
		FB.bars[i]:SetMinMaxValues(0, val["barTopValue"]);
		FB.bars[i]:SetValue(val["barEarnedValue"]);
		FB.bars[i].text:SetText(val["outStr"]);
		FB.bars[i]:SetStatusBarColor(val["barColor"]["r"],
				val["barColor"]["g"], val["barColor"]["b"]);
		FB.bars[i]:SetFrameStrata("LOW");
		FB.bars[i]:Show();
	end
	for barsHide = showBars+1, barCount do
		--FB.Print("Hiding: "..barsHide);
		FB.bars[barsHide]:Hide();
	end

end
]]
--[[
		b1  n1  c = 3, bn = 3 = min(3,6), bc = 6 = ab(3) -- need to hide 4,5,6
		b2  n2
		b3  n3
		b4
		b5
		b6

		b1  n1  c = 10, bn = 6 = min(10,6), bc = 6 = ab(6) -- need to hide bn -> bc
		b2  n2
		b3  n3
		b4  n4
		b5  n5
		b6  n6
		    n7
		    n8
		    n9
		    n10

]]