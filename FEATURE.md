# Feature

This file explains what feature this branch is for.

## feature/crafting
This branch is for the crafting feature.

This feature changes how adding an 'enchant:#####' link works.
The change will no longer blindly add values for both the crafted item, and crafting items, individually.
It will instead, behave as if you need to build N number of the crafted item.

Currently, needing N of a recipe will add N of the crafted item, and N*m of the needed reagents.
This is broken since one may already have x of the crafted items, or cannot store all of the items, or it takes a long time to make all the items.
Also, creating items as you go does not reduce the amount of reagents needed, only the reagents in your inventory.

### Differencs
The intention here is that by adding 'enchant:#####' x 5 will be handled slightly different than adding an item.

The 'enchant:#####' will have a 'needToMake' value added to the crafted item record.
A sub table 'reagents' will also be added to record the ratio of reagents to crafted item.
'needed' will now reflect the sum of the 'total' and 'needToMake'.
Making an item will decrement the 'needToMake'

A reagent record will be added for that player, with a 'neededFor' record to point to the crafted item.


[1] = {
	[realm] = {
		[name] = {
			['needed'] = 9,
			['total'] = 4,
			['needToMake'] = 5,
			['reagents'] = {
				[2] = {
					['ratio'] = 2,
				},
				[3] = {
					['ratio'] = 1,
				},
				[4] = {
					['ratio'] = 3,
				},
			},
		},
	},
},
[2] = {
	[realm] = {
		[name] = {
			['needed']
	}
}
}




## Notes:

Code from Auc-Advanced/CorePost.lua
-- Local tooltip for getting soulbound line from tooltip contents
local ScanTip = CreateFrame("GameTooltip", "AppraiserTip", UIParent, "GameTooltipTemplate")
local ScanTip2 = _G["AppraiserTipTextLeft2"]
local ScanTip3 = _G["AppraiserTipTextLeft3"]
local ScanTip4 = _G["AppraiserTipTextLeft4"]
local ScanTip5 = _G["AppraiserTipTextLeft5"]
local ScanTip6 = _G["AppraiserTipTextLeft6"]
local ScanTip7 = _G["AppraiserTipTextLeft7"]


-- Used to check for bound items in bags - only checks for strings indicating item is already bound
-- In particular we do not check for ITEM_BIND_ON_PICKUP, as for our tests,
-- that could only occur on an *unbound* recipe that creates a BoP item
local BindTypes = {
	[ITEM_SOULBOUND] = "Bound",
	[ITEM_BIND_QUEST] = "Quest",
	[ITEM_CONJURED] = "Conjured",
	[ITEM_BNETACCOUNTBOUND] = "Accountbound",
}
if ITEM_ACCOUNTBOUND then
	-- may be obsolete, check in case it is removed by a patch
	BindTypes[ITEM_ACCOUNTBOUND] = "Accountbound"
end

===========
Code from Auc-Advanced/Modules/Auc-Util-AutoMagic/Core.lua

local BindTypes = {
	[ITEM_SOULBOUND] = "Bound",
	[ITEM_BIND_ON_PICKUP] = "Bound",
}
--tooltip checks soulbound status
function lib.isSoulbound(bag, slot)
	ScanTip:SetOwner(UIParent, "ANCHOR_NONE")
	ScanTip:ClearLines()
	ScanTip:SetBagItem(bag, slot)
	return BindTypes[ScanTip2:GetText()] or BindTypes[ScanTip3:GetText()]
end

ToolTip:SetHyperlink( <Link> )
	Link = HyperLink or 'linktype:linkdata'