--[[
 File: d:\Games\World of Warcraft Public Test\_ptr_\Interface\Addons\LuckyCharms2\vars.lua
 
 File Overview: Variables File
 
 Project: LuckyCharms2
 
 Project Path: d:\Games\World of Warcraft Public Test\_ptr_\Interface\Addons\LuckyCharms2
 
 Created Date: Monday, October 12th 2020, 6:46:03 pm
 
 Author: KetuSolo
 ___
 Last Modified: Monday, October 12th 2020, 7:43:59 pm
 
 Modified By: KetuSolo
 ___
 Copyright (c) 2020 Ketu Gaming
 ___
 ]]
LC2_Realm = GetRealmName(); -- Get Realm for Profile.
LC2_Char = UnitName("player"); -- Get char name for profile.
LC2Profile = LC2_Realm .. " - " .. LC2_Char;

-- Set Defaults
PrevSettVer = "";
charmArr = {}; -- Charm Array
charmArr[1] = {};
charmArr[1][0] = RAID_TARGET_1; -- Star
charmArr[1][1] = "{" .. ICON_TAG_RAID_TARGET_STAR1 .. "}";
charmArr[2] = {};
charmArr[2][0] = RAID_TARGET_2; -- Circle
charmArr[2][1] = "{" .. ICON_TAG_RAID_TARGET_CIRCLE1 .. "}";
charmArr[3] = {};
charmArr[3][0] = RAID_TARGET_3; -- Diamond
charmArr[3][1] = "{" .. ICON_TAG_RAID_TARGET_DIAMOND1 .. "}";
charmArr[4] = {};
charmArr[4][0] = RAID_TARGET_4; -- Triangle
charmArr[4][1] = "{" .. ICON_TAG_RAID_TARGET_TRIANGLE1 .. "}";
charmArr[5] = {};
charmArr[5][0] = RAID_TARGET_5; -- Moon
charmArr[5][1] = "{" .. ICON_TAG_RAID_TARGET_MOON1 .. "}";
charmArr[6] = {};
charmArr[6][0] = RAID_TARGET_6; -- Square
charmArr[6][1] = "{" .. ICON_TAG_RAID_TARGET_SQUARE1 .. "}";
charmArr[7] = {};
charmArr[7][0] = ICON_TAG_RAID_TARGET_CROSS2; -- Cross
charmArr[7][1] = "{" .. ICON_TAG_RAID_TARGET_CROSS1 .. "}";
charmArr[8] = {};
charmArr[8][0] = RAID_TARGET_8; -- Skull
charmArr[8][1] = "{" .. ICON_TAG_RAID_TARGET_SKULL1 .. "}";

-- Enchanced CC Members Array
CCMembers = {};
LuckyCharms = {};
LuckyCharms.Config = {};
LuckyCharms.Flares = {};
LuckyCharms.Flares.Config = {};