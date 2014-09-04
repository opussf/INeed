INeed
=====

This addon is a shopping list, item fulfillment addon.

Idea:
The initial idea here was to track items that a player 'needs' for one reason or another,
that is not already tracked elsewhere.

Problem to solve:
Some professions need many items to craft a single item. Some of those items may take days to gather.
This would let someone create a shopping list of items that are needed.

Show which of your alts need how many of that item (tooltip).

Some items are vendor sold, and this will try to purchase the needed items when available for sale.
(This will be an option, possibly setting a max purchase price)
(Something like a spending account could also be setup for this. IE, give INeed 10G, as soon as it spends 10G
  for items, it will only alert the user that it found an item for sale, but will not purchase. This would be
  turned off by simply setting this to 0G, setting it to a negative value would make it unlimited -- if desired)



The interface is: "INeed <this item> <quantity>"
/ineed <itemLink>       -- needs 1 of item
/ineed <itemLink> 120   -- needs 120 of item
/ineed <itemLink> 0     -- needs 0 of item (will clear tracking)
/ineed item:9999        -- can be used instead of actual link (for scripting)
/ineed list             -- shows a list of needed items
/ineed account          -- shows the remaining amount in the spending account
/ineed account 0        -- sets the account to 0, turning off auto purchase
/ineed account 10000    -- sets account to 1 Gold
/ineed account 1g       -- sets account to 1 Gold
/ineed account 1g20s5c  -- sets account to 1 Gold, 20 Silver, and 5 Copper
/ineed remove <charName>-<realmName> -- removes tracking of all items for a specific character

Goals:
* Easy to start tracking items
* Show info with the item (tooltip)
* Show tracking info
* An alert once the goal for an item has been reached.
* The ability to see a shopping list of items
* An alert to a player logging that another character needs something in your inv


Versions:
0.10    Crontab feature scrapped.
        Create a "toMake" field for items made from an enchant(profession)
        -- not listed in fulfillment list
        -- not affected by current amount
        -- "toMake" decremented when items made
        -- success is to decrement "toMake" to 0
0.09    List panel to show needed items
        Option to open next to profession tab when something needed can be crafted.
0.08    Adding crontab like syntax for repeat -- Removing to a different addon
0.07    Adding tracking of currencies.  /in currency:###  -- incomplete for now
0.06    Needing a number of items less than the number already have does not track item.
        Fixed a bug around not getting an item link when the item is addded with item:#### and item not in cache
0.05    Timestamp of when item added.
        Delete a char "/in remove <name>-<rname>
        Nice options panel.
0.04	Account bug found and fixed.
		Can now use "account +value" to add a value, or "account -value" to remove a value
		^^^ Good for adding sum from vendor trash selling, or setting up a daily allowance
0.03	Putting progress announements to UIErrorFrame
0.02	Adding in spending account.
		adding item via item:9999 working
		Also hacked together a unittesting frame work

0.01	Initial work, command line works, tracking works, alert message on fulfilment, auto purchase
