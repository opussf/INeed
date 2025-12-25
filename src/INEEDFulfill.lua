INEED_SLUG, INEED   = ...

function INEED.Sorted( t, f )
	local a = {}
	for n in pairs( t ) do table.insert( a, n ) end
	table.sort( a, f ) -- @TODO: Look into giving a sort function here.
	local i = 0
	local iter = function()
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end

function INEED.Fulfill_OnShow()
	INEED_FulfillFrame:RegisterEvent("BAG_UPDATE")
	INEED.Fulfill_BuildItemDisplay()

	local count = 1
	local sortedItems = {}
	for k in pairs( INEED.fulfillList ) do table.insert(sortedItems, k) end
	table.sort( sortedItems )

	while count <= #INEED.Fulfill_ItemFrames do
		itemID = sortedItems[count]
		-- print( count, itemID )
		local itemFrame = INEED.Fulfill_ItemFrames[count]
		local name, itemLink, icon = nil, nil, nil
		if itemID then
			name, itemLink, _, _, _, _, _, _, _, icon = GetItemInfo( itemID )
		end

		itemFrame.itemLink = itemLink
		SetItemButtonTexture( itemFrame, icon )

		count = count + 1
	end
end
function INEED.Fulfill_OnHide()
	print( "OnHide" )
	INEED_FulfillFrame:UnregisterEvent("BAG_UPDATE")
end
function INEED.Fulfill_BAG_UPDATE( self )
	INEED.Fulfill_OnShow()
end

function INEED.Fulfill_BuildItemDisplay()
	local width, height = INEED_FulfillFrame:GetSize()
	local rowSize = math.floor( width / 32 )
	local colSize = math.floor( (height - 50) / 32 )
	local itemFrame

	-- print( width, height, rowSize, colSize )

	if not INEED.Fulfill_ItemFrames then
		INEED.Fulfill_ItemFrames = {}

		for itemFrameNum = 1, rowSize * colSize do -- rowSize * colSize do
			itemFrame = CreateFrame( "Button", "INEED_FulfillFrameItem"..itemFrameNum, INEED_FulfillFrame, "INEEDItemTemplate" )
			-- INEED.Fulfill_ItemFrames[itemFrameNum] = itemFrame
			local col = ((itemFrameNum - 1) % rowSize) + 1
			local row = math.floor( (itemFrameNum-1) / rowSize ) + 1
			local strOut = ""

			if row == 1 then
				itemFrame:SetPoint( "TOP", INEED_FulfillFrameFilter, "BOTTOM" )
				strOut = "TOP to Bottom of Filter"
			else
				itemFrame:SetPoint( "TOP", INEED.Fulfill_ItemFrames[itemFrameNum-rowSize], "BOTTOM" )
				strOut = "TOP to Bottom of "..itemFrameNum-rowSize
			end
			if col == 1 then
				itemFrame:SetPoint( "LEFT", INEED_FulfillFrame, "LEFT" )
				strOut = strOut .. ", LEFT to LEFT"
			else
				itemFrame:SetPoint( "LEFT", INEED.Fulfill_ItemFrames[itemFrameNum-1], "RIGHT" )
				strOut = strOut .. ", LEFT to RIGHT of "..itemFrameNum-1
			end
			INEED.Fulfill_ItemFrames[itemFrameNum] = itemFrame
			print( itemFrameNum, col, row, strOut )
		end
	end
end


--[[



local button = _G["MyItemBagFrameItem1"]
button.icon:SetTexture(GetItemIcon(itemID))
button.Count:SetText(count)
button:SetID(slot)




SetItemButtonTexture(button, 134400)  -- spellbook icon ID
SetItemButtonCount(button, 5)
SetItemButtonDesaturated(button, false)




BagSearchBoxTemplate






	<ItemButton name="BankItemButtonTemplate" mixin="BankPanelItemButtonMixin" virtual="true">
		<Layers>
			<Layer level="BACKGROUND">
				<Texture parentKey="Background" atlas="bags-item-slot64">
					<Anchors>
						<Anchor point="TOPLEFT"/>
						<Anchor point="BOTTOMRIGHT"/>
					</Anchors>
				</Texture>
			</Layer>
			<Layer level="OVERLAY">
				<Texture parentKey="IconQuestTexture">
					<Size x="37" y="38"/>
					<Anchors>
						<Anchor point="TOP" x="0" y="0"/>
					</Anchors>
				</Texture>
			</Layer>
		</Layers>
		<Frames>
			<Cooldown parentKey="Cooldown" inherits="CooldownFrameTemplate"/>
		</Frames>
		<Scripts>
			<OnLoad method="OnLoad"/>
			<OnEnter method="OnEnter"/>
			<OnLeave method="OnLeave"/>
			<OnClick method="OnClick"/>
            <OnDragStart method="OnDragStart"/>
            <OnReceiveDrag method="OnReceiveDrag"/>
		</Scripts>
	</ItemButton>







]]