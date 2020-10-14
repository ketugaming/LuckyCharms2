--[[
 File: f:\Games\World of Warcraft\_retail_\Interface\AddOns\LuckyCharms2\localization.lua
 
 File Overview: LuckyCharms 2 Localization Entry
 
 Project: LuckyCharms2
 
 Project Path: f:\Games\World of Warcraft\_retail_\Interface\AddOns\LuckyCharms2
 
 Created Date: Saturday, August 29th 2020, 8:20:29 am
 
 Author: KetuSolo
 ___
 Last Modified: Wednesday, October 14th 2020, 10:46:33 am
 
 Modified By: KetuSolo
 ___
 Copyright (c) 2020 Ketu Gaming
 ___
 ]]
function Localize()
	local locale = GetLocale();
	--DEFAULT_CHAT_FRAME:AddMessage("|cffffd200LC2:|r Call Localize");
	--DEFAULT_CHAT_FRAME:AddMessage("|cffffd200LC2:|r LOCALE:"..locale);
--[[
"frFR": French
"deDE": German
"enUS": American english (what should be "enGB" clients return "enUS", too)
"koKR": Korean
"zhCN": Chinese (simplified)
"zhTW": Chinese (traditional)
"ruRU": Russian (UI AddOn)
"esES": Spanish (Spain)
"esMX": Spanish (Mexico)
]]

	if ( locale == "deDE" ) then
		LC2LocalizeDE();
	else
		LC2LocalizeEN();
	end

	--Version
	LC2Version = "v9.0.0.101420";
	LC2SettVer = "1.3";
	-- Maybe add All fears later (Fleeing on WH)? //QUESTION 
	-- Maybe add All stuns later (Stunned on WH)? //QUESTION 

	--Crowd Control Spells {idx,spellid}
	--Last CCID = 29
	LC2Txt_DruidCC = {--Spell IDs of CC spells for Druids
		--{1,33786},--Cyclone, Druid, 1 Any [1] *Moved to PVP Talent
		{2,2637},--Hibernate, Druid, 1 Beast,Dragonkin [2]
		{16,339},--Entangling Roots, Druid, Any [3]
	};

	LC2Txt_HunterCC = {--Spell IDs of CC spells for Hunters
		{3,3355},--Freezing Trap, Hunter, 1 Any [1]
		{4,19386},--Wyvern Sting, Hunter, 1 Any [2]: Addl IDs 260457
		{22,194275},--Wyvern Hatchet Toss, Hunter, 1 Any [3]
		{29,162480},--Steel Trap, Hunter, 1 Any
	};

	LC2Txt_MageCC = {--Spell IDs of CC spells for Mage
		{5,118},--Polymorph, Mage, 1 Humanoid, Beast, Critter [1]: Addl IDs 161372,28272,161354,61780,161355,161353,61721,28271,277792,61305,277787,126819
		{27,82691},--Ring of Frost, Mage, 10 Any
	};

	LC2Txt_PaladinCC = {--Spell IDs of CC spells for Paladin
		{6,20066},--Repentance (Talent), Paladin, 1 Humanoid, Undead, Dragonkin, Giant, Demon [1]
		{21,10326},--Turn Evil, Paladin, 1 Undead, Aberration, Demon [2] 145067
	};

	LC2Txt_PriestCC = {--Spell IDs of CC spells for Priest
		{7,9484},--Shackle Undead, Priest, 1 Undead [1]
		{8,605},--Mind Control, Priest, 1 Humanoid [2] 205364
	};

	LC2Txt_RogueCC = {--Spell IDs of CC spells for Rogue
		{9,6770},--Sap, Rogue, 1 Humanoid, Beasts, Demons, Dragonkin [1]
		{23,2094},--Blind, Rogue, 1 Any [2]
		{26,1725},--Distract, Rogue, Any [3]
	};

	LC2Txt_ShamanCC = {--Spell IDs of CC spells for Shaman
		{10,51514},--Hex, Shaman, 1 Humanoid, Beast [1]: Addl Ids 211010,210873,211015,211004,309328,277784,277778,269352
		--{11,76780},--Bind Elemental, Shaman 1 Elemental [2] *REMOVED
	};

	LC2Txt_WarlockCC = {--Spell IDs of CC spells for Warlocks
		{12,6358},--Seduction (Succubus), Warlock, 1 Humanoid [1]  261589
		{13,710},--Banish, Warlock, 1 Demon, Aberration, or Elemental [2]
		{14,1098},--Subjugate Demon, Warlock, 1 demon [3] *Formerly Enslave Demon
		{15,5782},--Fear, Warlock, Any [4]
	};

	LC2Txt_DeathKnightCC = {
		{17,111673},--Control Undead, Death Knight, 1 Undead [1]
		{18,49576},--Death Grip, Death Knight, Any [2] 311977
		{24,207167},--Blinding Sleet, DK (Frost), Any [3]
		{28,96294},--Chains of Ice, DK, 1 Any
	};

	LC2Txt_MonkCC = {
		{19,115078},--Paralysis, Monk, 1 Any [1]
		{25,198909},--Song of Chi-Ji, Monk, Any [2]
	};

	LC2Txt_DemonHunterCC = {
		{20,217832},--Imprison, Demon Hunter, 1 Demon, Beast, Humanoid [1]
	};
	--end Crowd Control Spells

	--ENGLISH Crowd Control Classes
	LC2Txt_CCClassEN = {
		"DRUID", --[1]
		"HUNTER", --[2]
		"MAGE", --[3]
		"PALADIN", --[4]
		"PRIEST", --[5]
		"ROGUE", --[6]
		"SHAMAN", --[7]
		"WARLOCK", --[8]
		"DEATHKNIGHT", --[9]
		"MONK", --[10]
		"DEMONHUNTER", --[11]
	};
	--[[
	DEATHKNIGHT="Death Knight",
    WARRIOR="Warrior",
    ROGUE="Rogue",
    MAGE="Mage",
    PRIEST="Priest",
    WARLOCK="Warlock",
    HUNTER="Hunter",
    SHAMAN="Shaman",
    DRUID="Druid",
    MONK="Monk",
	PALADIN="Paladin",
	DEMONHUNTER="Demon Hunter",
   ]]
	--end ENGLISH Crowd Control Classes
	--Crowd Control Classes
	
	LC2Txt_CCClass = {
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[1]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[2]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[3]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[4]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[5]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[6]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[7]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[8]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[9]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[10]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[11]]
	};

	--DEFAULT_CHAT_FRAME:AddMessage("|cffffd200LC2:|r CLASSES LOADED");

	--end Crowd Control Classes

	--Combos
	LC2TT_RC = LC2TT_RCPERFORM.." "..READY_CHECK;
	READY_CHECKB = READY_CHECK.." "..LC2TXT_BTN;
	LC2Txt_KORaidWarning = LC2TXT_SHOWIN.." "..CHAT_MSG_RAID_WARNING;
	LC2Txt_KOPR = LC2TXT_SHOWIN.." "..CHAT_MSG_PARTY.."/"..CHAT_MSG_RAID;
	LC2ERR_PartyLead = ERR_NOT_LEADER.." "..LC2ERR_PARTYLEADTXT;
end
