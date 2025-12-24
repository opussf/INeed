INEED_SLUG, INEED   = ...

function INEED.Fulfill_OnShow()
	local thing = next( INEED.fulfillList )
	print( thing )

	name, _, _, _, _, _, _, _, _, icon = GetItemInfo(thing)
	icon = GetItemIcon(thing)

	-- INEED_FulfillFrame_Item_1_Icon:SetTexture( icon )

	-- INEED_FulfillFrame_Item_1.icon:SetTexture( thing )


	SetItemButtonTexture(INEED_FulfillFrameItem1, icon)
	SetItemButtonCount(INEED_FulfillFrameItem1Item1, 5)
	-- SetItemButtonDesaturated(INEED_FulfillFrame_Item1, false)

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