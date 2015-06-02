# Feature

This file explains what feature this branch is for.

## feature/goalName
Allow a description string (goalName) to be given to each item as it is added (or re-added).

[ ] Optional description consumes the rest of the given line
	* /in <link> [quantity] [desc | item]
		+ quantity is the first numeric (space breaking) value
		+ desc starts as soon as quantity can not be determined, or is given.

[ ] Is saved in item block as .desc
	["79293"] = {
		["Realm"] = {
			["Name"] = {
				["desc"] = "desc",
			},
		},
	},
[ ] Test for item / currency / enchant links and expand links in the desc.
[ ] Allows item grouping?
[ ] Adds description to completed message
	* Also add to progress message?
[ ] Show in need list



### Examples
	/in item:44157 2 Make me one of these
	/in item:44157 2 2x as nice to have
	/in item:44157 2 4 times as nice
	^^^ Both need 2 of item:44157

	/in item:44157 "2 of thise is too many"
	^^^ " defines start of string, only needs 1 (default value)

	/in item:44157 2x as nice to have
	^^^ Needs 1 item:44157 (2x is not seen as numeric)
	^^^ x2 might be seen as special in the future.

	/in item:23784 4 item:44157
	^^^ Needs 4x item:23784, looks up the link for item:44157 and stores it in the .desc field.


## feature/goalName Testing ideas

* no desc works as before (no .desc is added)
* quantity and text are distinguished
* "" denote string description, even if starts with a number
*



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