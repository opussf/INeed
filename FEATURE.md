# Feature

Record unknown links used.



## feature/gui
This will introduce a GUI element to the addon.

Need a GUI for:
[ ] Item list ( what you need )
	* opened: /ineed list
	* closed: /ineed list
	* show  : a list of needed items
	    + progress
	    + item link
	* user interaction includes:
		+ history (added, last updated, etc.) (via tooltip)
		+ remove
	* can be moved, uber simple display for longtime display

[ ] Progress of items
	* opened: when an item is updated, or changed (not triggered on removal)
	* closed: after last item expires off of list.
	* show items updated in the last 5/10/15 minutes
	* simple layout (can it be added to the quest item list?)
		+ progress
		+ item link
	* can be dismissed, auto closes (option)
	* uber simple

[ ] Mail opened (fulfill list)
	* when a mailbox is opened (and items need to be sent)
	* show a list of items that can be fulfilled
		+ your amount 'bags (bank)'
		+ item link
		+ list of "toon name" "amount needed"
		5::5 [item link] - toon1 5, toon2 6, toon3 7"
	* dismissed when mailbox closed
	* anchored to the right of the mailbox
	* clicking on a toon name could auto-create a mail to that person with all the items they can be sent.


[ ] Profession opened
	* when a Profession window is opened (delay opening by 1 second)
	* show a list of items that can be made and for whom
		+ amount can be made
		+ item link
			* "toon name" "amount needed"
			2x [item link] - toon1 5, toon2 6
	* dismissed when merchant closed
	* anchored to the right of the Profession window

[ ] Merchant opened
	* when a merchant is opened, open 2 windows
		+ reciept window (shows all items purchased / sold to this Merchant)
			* reset when Merchant window closed.
			* have gold display for account amount
			* allow drag/drop of gold amount to window
			* allow edit of gold amount in window
		+ items needed window
			* replicate the 'Profession' window, but only items for this toon.


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

## feature/goalName
Allow a description string (goalName) to be given to each item as it is added (or re-added).

[ ] Optional description consumes the rest of the given line
	* /in <link> [quantity] [desc]
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