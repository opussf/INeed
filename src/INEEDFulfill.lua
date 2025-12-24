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
	INEED.Fulfill_BuildItemDisplay()

	-- local count = 0

	-- for itemID, needList in INEED.Sorted( INEED.fulfillList ) do
	-- 	count = count + 1
	-- 	local itemFrame = INEED.Fulfill_ItemFrames[count]
	-- 	local icon = GetItemIcon( itemID )

	-- 	SetItemButtonTexture( itemFrame, icon )
	-- end

	-- for clearNum = count + 1, #INEED.Fulfill_ItemFrames do
	-- 	SetItemButtonTexture( INEED.Fulfill_ItemFrames[clearNum], nil )
	-- end

---------------

	-- local thing = next( INEED.fulfillList )
	-- print( thing )

	-- name, _, _, _, _, _, _, _, _, icon = GetItemInfo(thing)
	-- icon = GetItemIcon(thing)

	-- -- INEED_FulfillFrame_Item_1_Icon:SetTexture( icon )

	-- -- INEED_FulfillFrame_Item_1.icon:SetTexture( thing )


	-- SetItemButtonTexture(INEED_FulfillFrameItem1, icon)
	-- SetItemButtonCount(INEED_FulfillFrameItem1Item1, 5)
	-- -- SetItemButtonDesaturated(INEED_FulfillFrame_Item1, false)

end

function INEED.Fulfill_BuildItemDisplay()
	local frame = INEED_FulfillFrame
	local width, height = frame:GetSize()
	local rowSize = math.floor( width / 32 )
	local colSize = math.floor( (height - 50) / 32 )
	local itemFrame

	print( width, height, rowSize, colSize )

	if not INEED.Fulfill_ItemFrames then
		INEED.Fulfill_ItemFrames = {}

		for itemFrameNum = 1, rowSize * colSize do
			itemFrame = CreateFrame( "Button", "INEED_FulfillFrameItem"..itemFrameNum, INEED_FulfillFrame, "INEEDItemTemplate" )
			INEED.Fulfill_ItemFrames[itemFrameNum] = itemFrame
			local col = itemFrameNum % rowSize
			local row = math.floor( itemFrameNum / rowSize ) + 1

			if row == 1 then
				itemFrame:SetPoint( "TOP", "INEED_FulfillFrameFilter", "BOTTOM" )
			-- else
			-- 	itemFrame:SetPoint( "TOP", INEED.Fulfill_ItemFrames[itemFrameNum-rowSize], "BOTTOM" )
			end
			if col == 1 then
				itemFrame:SetPoint( "LEFT", "INEED_FulfillFrame", "LEFT" )
			else
				itemFrame:SetPoint( "LEFT", INEED.Fulfill_ItemFrames[itemFrameNum-1], "RIGHT" )
			end
			INEED.Fulfill_ItemFrames[itemFrameNum] = itemFrame
			print( itemFrameNum, col, row )
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