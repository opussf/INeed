# Feature

This file explains what feature this branch is for.

## feature/gui
This will introduce a GUI element to the addon.

Need a GUI for:
[ ] Item list ( what you need )
	* show a list of needed items
	* user interaction includes:
		+ history (added, last updated, etc.) (via tooltip)
		+ remove








-----
Keep item actions for each item.

	["79293"] = {
		["Hyjal"] = {
			["Kasely"] = {
				["needed"] = 2,
				["total"] = 0,
				["link"] = "item:79293",
				["faction"] = "Alliance",
				["added"] = 1399858265,
				["updated"] = 1399858265,
				["history"] = {
					[ts] = 1,
					[ts] = -1,
				}
			},
		},
	},

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