# Feature

## ExpandedOptions

Fix the options panel.  
SetValue error is happening.

Expand the options.

Add options to control:
* number of bars to show (Already part of it, set up in options panel)
* to fill bars (with older items) (limit of older items?)
	- 5 of the oldest items would reduce the size of the window.
* to use added (oldest first) or to use updated (oldest still drops off)
* Height and width of bars (possible)
* Header info (name and account amount)

Add options to panel:
* How long to show an updated item
* Number of bars to show
* Height and width of bars

* Slush fund
* Autorepair from the slush fund
* Autopurchase receipt


[x] showProgress
[ ] showSuccess
[ ] audibleSuccess
[ ] doEmote
[ ] emote
[ ] playSoundFile
[ ] soundFile
[ ] showGlobal
[ ] barCount
[ ] hideInCombat
[ ] displayUIList
[ ] displayUIListDisplaySeconds
[ ] autoRepair
[ ] autoTrain
[ ] fillBars
[ ] displayUIListFillbarsSeconds



## othersNeedUI

After looking at some possible changes, this one seemed to be best.

Simply, show the needed items for others in the UI.

Future update on this, maybe limit this by an option?

## showAccount

Show the account info in the UI frame title.

'INEED - 199g 56s 19c'

This will also remove the print to the chat window of the account amount change.

Use 'INEED.UITitleText' as a field to keep the formatted text.

When should this be set?

Should there be an option to control this?

## accountMax

Sometimes, when starting, or for other reasons, the value of the spending account is more than what the character has.
Adjust the account value down to match the amount the toon has.

Adjust this when spending / gold changed.

## combatHide
Add an option to hide in combat.

Time to put the option into the option pane.

## Tithe
This has been an idea for ages, but it was stymied by the classic 'give it a name' problem.
I've decided to go with the term 'tithe', even though it conotates the wrong details, specifically that the amount is paid to an external entity.

The idea is to be able to give the addon an ability to auto-fill the spending account.

After talking to many people, the idea of using 'slush' as the term has solidified.

I think that I want to have:
1) A way to set a % gain.
2) A way to set a maximum value
3) A way to set an amount.


/in account 1% 50g   --> 1% slush up to 50g
/in account 50g 1%   --> 1% slush up to 50g, start with 50g.
/in account 1%       --> 1% slush, no max, no initial value
/in account 50g      --> 50g account value
/in slush 1% 50g     --> slush values, 1% with a maximum of 50g from slush

/in account 100g     --> sets the account amount
/in slush 1%         --> sets a %, no maximum
/in slush 1% 50g     --> % with a maximum
/in slush 1% 0g      --> %, clears maximum
/in slush 0% 0g      --> clears percent






## Achievements
/in achievement:10722
"|cffffff00|Hachievement:10722:Player-3661-06DAB4ED:0:0:0:-1:524288:0:0:0|h[The Wish Remover]|h|r"

Add achievement tracking.
If the achievement requires items, add them to the list as well.

## Record unknown links used.

## feature/arch
This feature will introduce the ability to scan the Archeology tab for projects that are in progress, and add the items to your need list.

The new command will be: '/in arch'

While the original vision is to only add the items to complete current projects, it might also expand to include adding the accelerated items as well.

The 'arch' command will scan all current projects only.
http://wowprogramming.com/docs/api/GetArchaeologyRaceInfo
http://wowprogramming.com/docs/api/GetNumArchaeologyRaces
http://wowprogramming.com/docs/api/GetArtifactProgress


## feature/goldValue
Allow the player to need an amount of gold.

  /in 25g
  /in 25g 35s
  /in gold 25g
(Should be able to use the same function as the account command)

Store in INEED_gold for all.

INEED_gold = {["realm"]["player"] = {["needed"] = 15000, ["total"] = 70000, ["faction"] = "Alliance", ["added"] = ts, ["updated"] = ts},}

INEED_gold["realm"]["player"] will be cleared once the value is reached.


-----------------------------------------

Define a tithe amount.
While tithe is a 10% payment to a church or organization, or a tax, there is no idea of setting aside a percentage for savings, at least no name.
I've seen the phrase "tithe thyself" as a description of saving, but nothing else.

The tithe will be a way to automaticly add money to the spending account for INeed.

  /in title 0
Turns off the tithe

  /in tithe 10
Sets the tithe to 10%

  /in tithe 100
Sets the tithe to 100%

  /in tithe
Shows the tithe percentage.

Store this in:
  INEED_account["tithe"]

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
