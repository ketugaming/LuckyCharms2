# LuckyCharms2 Change Log

## v9.0.0.10122020

* ShadowLands Pre-Patch Ready.
* Updated CC Spell list.
* Fixed issue with clearing world markers.

## v8.0.3.09012020

* Ready for BFA.
* Fixed Flares/World Marker background when in vertical orientation.
* Fixed Flares/World Marker background size when spacing the buttons.
* Fixed Frame Reference Error.

## v7.2.0.04112017

* Bump TOC

## v7.1.5.02162017

* All bars will now hide during pet battles.

## v7.1.5.01192017

* Bug Fix: Hopefully the last bug fix regarding combat lockdown.

## v7.1.0.01062017

* Migrate Translations and update constants.
* Contribute to LuckyCharms2 translations through the project site on CurseForge!

## v7.1.0.01042017

* Bug Fix: Errors when in combat and party/raid members change when display settings are set to auto.

## v7.1.0.12232016

* Bug Fix: Not opening addon options page properly.

## v7.1.0

* Update to Legion.
* Fix Masque Compatibility.
* Verified All Tooltips.

## v6.0.0

* update for warlords adding new world markers
* still need to fix world markers tooltip

## v5.0.2

* Bug Fix when not using Masque

## v5.0.1

* Fix Missing World Marker Configuration

## v5.0.0

* Updated to MOP
* Updated all calls from ButtonFacade to Masque
* Bug Fixes

## v3.1.1

* Bug Fix: World Marker Bar not resizing properly when changing button spacing.

## v3.1.0

* Massive Code reorganization and cleanup.
* Added World Marker Bar Scale configuraiton.
* Added World Marker Bar Opacity configuraiton.
* Added World Marker Bar Orientation configuraiton.
* Added World Marker Bar Button Spacing configuraiton.

## v3.0.9

* Redesigned ButtonFacade Support.  This should clear up several issues that have been reported with certain skins.

## v3.0.8

* Fixed World Marker Bar not hiding on login. Ticket #12.
* Added ButtonFacade Support to the World Marker Bar.

## v3.0.7

* Added ability to control Kill Order and CC chat printing seperately.

## v3.0.6

* Added German Localization - Thanks Wauzi0816
* Fixed Issue with Classes and localizations
* Fixed Error with Kill Order chat printing, will no longer receive "You are not in a raid" Error when in a group.
* Fixed Double printing of Kill Order when in a raid and have the Raid Warning selected.  Will now print only to Raid Warning not both Raid and raid warning.
* Added World Markers

## v3.0.5

* Added Druid Entangling Roots to CC list.

## v3.0.4

* Fixed issue of CC's printing to chat not including the spell name.
* Made CC chat printing now a spell link instead of just a spell name.
* Fixed issue of CC printing to chat not knowing if you were in a raid or party.
* Added Warlock Fear as CC.

## v3.0.3

* Fixed CC Tooltip not showing on all CC buttons.

## v3.0.2

* Added Spell Tooltips to CC Spells per Feature request Ticket #6.

## v3.0.1

* Added Shaman Bind Elemental to CC list.
* Fixed issue with CC check.  You will not be able to mark a target that the CC is not compatible with now.  You will get an error instead.

## v3.0.0

* WoW 4.0.1 Release

## v3b2

* Resolved Ticket#2 Raid Assist Charm Bar not hiding properly.
* Resolved Ticket#3 Crowd Control Bar does not display on fresh Login.
* Changed some localizations to use builtin blizzard ones.
* Changed CC spell handling, now uses spellID instead of manually entered in localizations.
* This will be the Release version for patch 4.0.1

## v3b1

* Corrected error with assigning CCs on 4.0.1

## v3b

* Updated for 4.0.1
* Beta Version, please report bugs.
* This version may not operate properly on 3.3.5

## v2.9.3

* Bug Fix for ButtonFacade and Skinning Buttons that were disabled prior to character load.

## v2.9.2

* Full ButtonFacade Support.
* Code Optimization.

## v2.9.1

* Corrected Charm Display with ButtonFacade. Still an issue with resizing under different skins.

## v2.9

* Removed custom charm images, now using builtin images of WoW making LC2 even smaller.

## v2.8.2

* Bug Fix for Copying settings from a different toon.

## v2.8.1

* Fix for "LuckyCharms2.lua:1171: attempt to index global 'bfGroup' (a nil value)"

## v2.8

* Added ability to hide charm icons.
* Added ability to re-order charm icons.
* Kill Order Bar is now a child of the charm bar and will not be shown unless the charm bar is shown.
* Minor code cleanup.
* Removed unused images from LuckyCharms2.
* Fixed ButtonFacade Support.
* Removed Kill Order Numbers from above charm bar.

## v2.7.3

* Fixed issue with misleading Ready Check button as Ready check still requires you to be the group leader.

## v2.7.2

* Updated TOC for 3.3
* Made changes to Charm Marking Auto Show to go with the any group member can mark change in 3.3.  Raid still required leader or officer to mark.
* Corrected a bug with the tooltips that was not finished in v2.7.1

## v2.7.1

* myAddOns Support
* Added Button Facade Support
* Added settings upgrade capability. No more deleting files from the wtf folder when massive variable changes occur.
* Removed CC Assignment Tooltip from main Charm Tooltip.
* Added CC Icon to Kill Order bar that shows the cc spell/ability assigned to the charm below/beside it.
* New CC icon tooltip contains details of the cc assignment.
* Text on the charm when a cc is assigned has been changed to CC so you are aware of the CC assignment.

## v2.7

* New saved variable handling.  Any version pre 2.7 will loose their settings.
* Ability to copy LC2 settings between characters. Profiles are available on the main configuration page.
* Enhanced CC Targets. Evaluates the group makeup and only allows selection of CC's that are available. Also, adds cc caster name to alert and tooltip. For party/raid, each cc is listed on a seperate line, however, raid warning has a limit of 2 lines at a time, so all CC's will be listed on one raid warning so the kill order can be listed on the other.
* BUG FIX: Charm Bar when set to auto did not automatically hide when you left a party/raid.

## v2.6.1

* Changed charm disabling to only affect kill order and cc messages.  Charms can still be used, but will have a red texture instead of normal to indicate they are disabled.
* BUG FIX: Charm tooltips were not displaying properly.

## v2.6

* Added ability to disable charms. Disabled charms cannot be used for marking and will not show up in kill orders.
* Added new charm images for when the charms are disabled. Charms turn red to indicate they have been disabled.
* Bug Fix: Setting display status to auto when you in a group resulted in the frame hiding.
* Bug Fix: Kill order configuration settings were not loading properly. It would appear that LC2 was not remembering the settings even though it did.

## v2.5.2

* Changed Text that is printed to chat frames to make it shorter to keep from confusing the assignments and kill order.
* Moved static error text to localization file.
* Moved other static text (Menus, etc.) to localization file.
* Changed chat message handling.  You can now choose to print to Party/Raid depending on Group configuration and/or Raid Warning.  This setting is available under kill order configuraiton.

## v2.5.1

* Corrected CPU Leak
* Change Variables_Loaded event to Addon_Loaded

## v2.5

* Crowd Control Assignments can now be added to each charm icon.
* Right click a charm to assign a cc to it.
* Shift Right click a charm to remove that cc.
* Right click clear charm to remove all ccs.
* Option added to kill order config to print the cc targets with the kill order to selected chat.
* Target check to ensure the selected cc can be applied to that target. Invalid target displayed if cc cannot be used.
* Updated charm tooltips to reflect new changes, tooltips can still be hidden via the configuration.

## v2.4

* Ready Check button is now RC in order to make space for new changes.
* Right Click the Lock to open LuckyCharms2 configuration.
* Kill Order configuration added to the addon configuration page.
* New kill order frame that shows the kill order above, below or beside the charms bar.
* New kill order button added that will print the kill order to party, raid and/or raid warning depending on group and settings.

## v2.3.1

* Updated to WoW 3.2.0

## v2.3

* Updated to WoW 2.4.0
* Updated configuration page to use WoW interface options.
* Redesigned Configuration due to new changes.
* Removed Slash Commands (The Default button in the interface options can reset all the settings for LC2)
* Updated tooltips to reflect changes in configuration options.
* Code Optimization

## v2.2.6

* Updated to WoW 2.4.0

## v2.2.5

* Updated to WoW 2.3.0
* Changed Minimum Scale to 0.1
* Added Ability to perform ready check via Ready Check Button
* Added Ready Check Button Opacity controls to config
* Added Ready Check Button Postion controls to config
* Added Ready Check Button Display status controls to config
* Added Interlink for LuckyCharms2Fu Fubar Addon to control Ready Check Button.

## v2.2.4

* Updated to WoW 2.2
* Changed Slash Command from /lc to /lc2 to resolve conflict with LootCount

## v2.2.3

* Added Opacity controls to the Config menu.
* Code Optimization.
* Supports FuBar 2.0 via FuBar-LuckyCharms2.

## v2.2.3RC1

* Release Candidate Version for FuBar Support.

If you would like to test this version, you will need FuBar 2.0, LuckyCharms2 2.2.3RC1, and FuBar-LuckyCharms2 r10000 RC1.  You will also need to restart WoW after installing this version.

-Added Functions to support FuBar and potentially any other addon that would want to intialize or configure LC2

Please note this is a beta version so there may be bugs.  If you happen to find a bug, please report it to me so that I can make sure it is fixed before the final release.

Feel free to make any suggestions or feature request that you might like to have integrated into this future release version.

## v2.2.2

* Bug Fix: Tooltip for Clear Target Button was causing an LUA error.

## v2.2.1

* Added ability to make the CharmBar Vertical
* LUA Optimizations
* Changed the background graphic to free up resources. Memory Usage is approx. 45kb.

**Note: Please remove your LuckyCharms2 folder before installing this version.**

## v2.2.0

* Added Localization Methods
* Localized for EN
* Seperated the Anchor from the CharmBar granting easier access to the configuration menu.
* Added the ability to align the CharmBar on the left or right of the anchor.
* Added the ability to show, hide, or automatically show/hide the anchor just like the charm bar.

## v2.1

* Renamed Addon Directory to match Project Name.
* Renamed Addon Files to match Project Name.
* Added Configuration Window.
* Add Option to Disable the CharmBar Tooltips.
* Updated Slash Commands to reflect the configuration window.

## v2.0

* Updated TOC
* Brand new look and feel
* Fixed Bug of printing "LuckyCharms Loaded" when zoning.
* Minor code clean up
* Added Tooltips
* Added Locking feature to prevent you from accidentally moving the bar.
* Removed click sound since the sound would not consistently function. May add this back in later if it is requested.
* Changed the chat box help to hopefully be more clear of the slash commands.
* Modified the directory structure of the addon.
