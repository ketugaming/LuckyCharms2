--[[
 File: f:\Games\World of Warcraft\_retail_\Interface\AddOns\LuckyCharms2\LuckyCharms2.lua
 
 File Overview: Main Coding File
 
 Project: LuckyCharms2
 
 Project Path: f:\Games\World of Warcraft\_retail_\Interface\AddOns\LuckyCharms2
 
 Created Date: Saturday, August 29th 2020, 8:20:29 am
 
 Author: Ketutastic
 ___
 Last Modified: Monday, October 12th 2020, 8:30:07 pm
 
 Modified By: KetuSolo
 ___
 Copyright (c) 2020 Ketu Gaming
 ___
 ]] 
 -- Locals
-- local LC2_Realm = GetRealmName(); -- Get Realm for Profile.
-- local LC2_Char = UnitName("player"); -- Get char name for profile.
-- local LC2Profile = LC2_Realm .. " - " .. LC2_Char;
local LBF = LibStub("Masque", true);
--DEFAULT_CHAT_FRAME:AddMessage("LC2 Using Profile: " .. LC2Profile);
-- local LC2IsLoaded = false;

-- Additional Combat mechanisms
LuckyCharms.waiting = false;
LuckyCharms.waitEvents = {};

-- Define Dynamic Images
local unlockImage = "Interface\\AddOns\\LuckyCharms2\\images\\menuunlock";
local lockImage = "Interface\\AddOns\\LuckyCharms2\\images\\menulock";

-- Generic Function to Print Chat Message
function LuckyCharms.Message(text)
    DEFAULT_CHAT_FRAME:AddMessage("|cffffd200" .. LC2NAME .. ":|r " .. tostring(text));
end
-- End Chat Function



function LuckyCharms.RCAnchor(New_rcpos)
    local f = _G["LCReadyCheck"];
    if (f) then
        f:ClearAllPoints();
        if (New_rcpos == "left") then
            f:SetPoint("LEFT", "LuckyCharmAnchorBar", "RIGHT", -2, 0);
        elseif (New_rcpos == "right") then
            f:SetPoint("RIGHT", "LuckyCharmAnchorBar", "LEFT", 2, 0);
        elseif (New_rcpos == "top") then
            f:SetPoint("BOTTOMRIGHT", "LuckyCharmAnchorBar", "TOPRIGHT", 0, -2);
        else
            f:SetPoint("TOPLEFT", "LuckyCharmAnchorBar", "BOTTOMLEFT", 0, 2);
        end
        LC2_Settings[LC2Profile].rcpos = New_rcpos;
        LuckyCharms.Config.RCRadioPos(New_rcpos, 1);
    end
end

function LuckyCharms.AddonLoaded(arg1)
    if (arg1 == LC2NAME) then
        -- -- Initialize Enchanced CC Members Array
        for i = 1, 11 do
            CCMembers[LC2Txt_CCClass[i]] = {};
        end
        -- CCMembers[LC2Txt_CCClass[1]] = {};
        -- CCMembers[LC2Txt_CCClass[2]] = {};
        -- CCMembers[LC2Txt_CCClass[3]] = {};
        -- CCMembers[LC2Txt_CCClass[4]] = {};
        -- CCMembers[LC2Txt_CCClass[5]] = {};
        -- CCMembers[LC2Txt_CCClass[6]] = {};
        -- CCMembers[LC2Txt_CCClass[7]] = {};
        -- CCMembers[LC2Txt_CCClass[8]] = {};

        -- Check for settings array.  Used for Profiles.
        if (not LC2_Settings) then LC2_Settings = {}; end
        -- Check for Profile Settings
        if (not LC2_Settings[LC2Profile]) then
            LC2_Settings[LC2Profile] = {};
        end
        -- Check for Settings Verison.  Use for upgrades
        if (not LC2_Settings[LC2Profile].SettVer) then
            -- LuckyCharms.Message("Setting Ver Not Found");--Debug
            PrevSettVer = "";
            LC2_Settings[LC2Profile].SettVer = LC2SettVer;
        else
            -- LuckyCharms.Message("Setting Ver Found.");--Debug
            PrevSettVer = LC2_Settings[LC2Profile].SettVer;
        end
        -- Check for Settings, otherwise set defaults.
        if (not LC2_Settings[LC2Profile].barstatus) then
            LC2_Settings[LC2Profile].barstatus = "auto"; -- Charmbar display status
        end
        if (not LC2_Settings[LC2Profile].barscale) then
            LC2_Settings[LC2Profile].barscale = 1.0; -- LC2 scale
        end
        if (not LC2_Settings[LC2Profile].tooltips) then
            LC2_Settings[LC2Profile].tooltips = 1; -- Show Tooltips
        end
        if (not LC2_Settings[LC2Profile].ancstatus) then
            LC2_Settings[LC2Profile].ancstatus = "show"; -- Anchor display status
        end
        if (not LC2_Settings[LC2Profile].ancpos) then
            LC2_Settings[LC2Profile].ancpos = "left"; -- Anchor Position, relative to charmbar
        end
        if (not LC2_Settings[LC2Profile].alpha) then
            LC2_Settings[LC2Profile].alpha = 1; -- LC2 Alpha
        end
        if (not LC2_Settings[LC2Profile].rcpos) then
            LC2_Settings[LC2Profile].rcpos = "top"; -- Ready Check Button Position, Relative to Anchor
        end
        if (not LC2_Settings[LC2Profile].rcstatus) then
            LC2_Settings[LC2Profile].rcstatus = "auto"; -- Ready Check Button Display Status
        end
        if (not LC2_Settings[LC2Profile].kopos) then
            LC2_Settings[LC2Profile].kopos = "top"; -- Kill Order Position, Relative to CharmBar
        end
        if (not LC2_Settings[LC2Profile].kostatus) then
            LC2_Settings[LC2Profile].kostatus = "auto"; -- Display Status of the Kill Order Bar
        end
        if (not LC2_Settings[LC2Profile].komode) then
            LC2_Settings[LC2Profile].komode = "icons"; -- Kill Order Print Mode: text,icons
        end
        if (not LC2_Settings[LC2Profile].korw) then
            LC2_Settings[LC2Profile].korw = 1; -- Enable Kill Order Print to Raid Warning.
        end
        if (not LC2_Settings[LC2Profile].kopr) then
            LC2_Settings[LC2Profile].kopr = 1; -- Enable Kill Order Print to Party/Raid.
        end
        if (not LC2_Settings[LC2Profile].koctp) then
            LC2_Settings[LC2Profile].koctp = "top";
        end
        if (not LC2_Settings[LC2Profile].korder) then
            LC2_Settings[LC2Profile].korder = {8, 7, 6, 1, 2, 3, 4, 5}; -- Kill Order Array
        end
        if (not LC2_Settings[LC2Profile].charmcc) then
            -- Charm CC Assignment Array
            LC2_Settings[LC2Profile].charmcc = {};
            for i = 1, 8 do
                LC2_Settings[LC2Profile].charmcc[i] =
                    {["name"] = "", ["icon"] = ""};
            end
        end
        if (not LC2_Settings[LC2Profile].kocc) then
            LC2_Settings[LC2Profile].kocc = 1; -- Enable CC Print to selected frames.
        end
        if (not LC2_Settings[LC2Profile].koprint) then
            LC2_Settings[LC2Profile].koprint = 1; -- Enable CC Print to selected frames.
        end
        if (not LC2_Settings[LC2Profile].charmStatus) then
            LC2_Settings[LC2Profile].charmStatus = {1, 1, 1, 1, 1, 1, 1, 1}; -- Charm Status Array 0-Disabled,1-Enabled
        end
        if (not LC2_Settings[LC2Profile].locked) then
            LC2_Settings[LC2Profile].locked = 0; -- Lock Anchor
        end

        LuckyCharms.Config.Upgrade();

        -- Setup UI
        LuckyCharms.Config.ModScale(LC2_Settings[LC2Profile].barscale);
        LuckyCharms.Config.InitSlider(LuckyCharmConfig_Slider1);
        LuckyCharms.Config.InitAlphaSlider(LuckyCharmConfig_SliderAlpha);
        -- Main Charm Bar
        if (LC2_Settings[LC2Profile].barstatus == "show") then
            LuckyCharmBar:Show();
        else
            LuckyCharmBar:Hide();
        end
        -- Anchor Bar
        if (LC2_Settings[LC2Profile].ancstatus == "show") then
            LuckyCharmAnchorBar:Show();
        else
            LuckyCharmAnchorBar:Hide();
        end
        -- Ready Check Button
        if (LC2_Settings[LC2Profile].rcstatus == "show") then
            LCReadyCheck:Show();
        else
            LCReadyCheck:Hide();
        end
        -- Kill Order Bar
        if (LC2_Settings[LC2Profile].kostatus == "show") then
            LCKillOrder:Show();
        else
            LCKillOrder:Hide();
        end

        LuckyCharms.Config.ModAlpha(LC2_Settings[LC2Profile].alpha);
        LuckyCharms.RCAnchor(LC2_Settings[LC2Profile].rcpos);
        LuckyCharms.Config.KOAnchor(LC2_Settings[LC2Profile].kopos);
        LuckyCharms.Config.Radio(LC2_Settings[LC2Profile].barstatus, 1);
        LuckyCharms.Config.AncRadio(LC2_Settings[LC2Profile].ancstatus, 1);
        LuckyCharms.Config.AncRadioPos(LC2_Settings[LC2Profile].ancpos, 1);
        LuckyCharms.Config.TTRadio(LC2_Settings[LC2Profile].tooltips, 1);
        LuckyCharms.Config.RCRadio(LC2_Settings[LC2Profile].rcstatus, 1);
        LuckyCharms.Config.RCRadioPos(LC2_Settings[LC2Profile].rcpos, 1);
        LuckyCharms.Config.KORadio(LC2_Settings[LC2Profile].kostatus, 1);

        -- -- Set Check Boxes on KO Config
        LuckyCharmConfigKO_LC1CBDis:SetChecked(LC2_Settings[LC2Profile].charmStatus[1]);
        LuckyCharmConfigKO_LC2CBDis:SetChecked(LC2_Settings[LC2Profile].charmStatus[2]);
        LuckyCharmConfigKO_LC3CBDis:SetChecked(LC2_Settings[LC2Profile].charmStatus[3]);
        LuckyCharmConfigKO_LC4CBDis:SetChecked(LC2_Settings[LC2Profile].charmStatus[4]);
        LuckyCharmConfigKO_LC5CBDis:SetChecked(LC2_Settings[LC2Profile].charmStatus[5]);
        LuckyCharmConfigKO_LC6CBDis:SetChecked(LC2_Settings[LC2Profile].charmStatus[6]);
        LuckyCharmConfigKO_LC7CBDis:SetChecked(LC2_Settings[LC2Profile].charmStatus[7]);
        LuckyCharmConfigKO_LC8CBDis:SetChecked(LC2_Settings[LC2Profile].charmStatus[8]);
        LuckyCharmConfigKO_KOcbPR:SetChecked(LC2_Settings[LC2Profile].kopr);
        LuckyCharmConfigKO_KOcbRW:SetChecked(LC2_Settings[LC2Profile].korw);
        LuckyCharmConfigKO_KOCCRW:SetChecked(LC2_Settings[LC2Profile].kocc);
        LuckyCharmConfigKO_KOPrintCheck:SetChecked(LC2_Settings[LC2Profile].koprint);

        if (LC2_Settings[LC2Profile].locked == 0) then
            LCBDragButtonIcon:SetTexture(unlockImage);
        else
            LCBDragButtonIcon:SetTexture(lockImage);
        end

        LCRCButton:SetText(READY_CHECKABBRV);
        LCKOButton:SetText(LC2TXT_KOABBRV);
        LuckyCharms.Config.InitConfigDropDowns();
        LuckyCharms.DrawCharms();
        LuckyCharms.UpdateCCAssignments();
        LuckyCharms.InitCCButtons();

        if (not LBF) then
            -- LuckyCharms.Message("Setting BG, Border, TexCoords");--Debug
            _G["LuckyCharmBar"]:SetBackdrop(
                {
                    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
                    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                    tile = true,
                    tileSize = 10,
                    edgeSize = 16,
                    insets = {left = 4, right = 4, top = 4, bottom = 4}
                });

            -- _G["LuckyCharmBar"]:SetBackdrop(BACKDROP_TOAST_12_12);
            -- _G["LuckyCharmAnchorBar"]:SetBackdrop(BACKDROP_TOAST_12_12);
            _G["LuckyCharmAnchorBar"]:SetBackdrop(
                {
                    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
                    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                    tile = true,
                    tileSize = 10,
                    edgeSize = 16,
                    insets = {left = 4, right = 4, top = 4, bottom = 4}
                });
        end

        LuckyCharms.SetTexCoords();

        LuckyCharms.Message(LC2Version .. " " .. LC2TXT_LOADED);
    end
end

function LuckyCharms.DragOnEnter(self)
    -- LuckyCharms.Message(self);--Debug
    if (LC2_Settings[LC2Profile].tooltips == 1) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:SetText("|cFFFFFFFF" .. LC2NAME .. "!|r", nil, nil, nil,
                            nil, 0);
        GameTooltip:AddLine(LC2TT_LEFTCLICKHOLD);
        if (LuckyCharms.IsLocked() == 1) then
            GameTooltip:AddLine(LC2TT_LEFTSHIFTUNLOCK);
        else
            GameTooltip:AddLine(LC2TT_LEFTSHIFTLOCK);
        end
        GameTooltip:AddLine(LC2TT_RIGHTCLICK);
        GameTooltip:Show();
    end
end

function LuckyCharms.DragUp(_, button)
    if (LuckyCharmAnchor.isMoving) then
        LuckyCharmAnchor:StopMovingOrSizing();
        LuckyCharmAnchor.isMoving = false;
    end
end

function LuckyCharms.DragDown(_, button)
    if (LuckyCharms.IsLocked() == 0 and button == "LeftButton") then
        LuckyCharmAnchor:StartMoving();
        LuckyCharmAnchor.isMoving = true;
    end
end

function LuckyCharms.DragOnClick(_, button)
    -- LuckyCharms.Message(tostring(button));--Debug
    if (button == 'LeftButton') then
        if (IsShiftKeyDown()) then LuckyCharms.ToggleLock(); end
    end
    if (button == 'RightButton') then
        InterfaceOptionsFrame_OpenToCategory("LuckyCharms2");
        InterfaceOptionsFrame_OpenToCategory("LuckyCharms2");
    end
end

function LuckyCharms.OnCharmClick(mouseButton, self)
    local button = self:GetName();
    -- LuckyCharms.Message(tostring(button)..mouseButton);
    local charmNum = 0;

    if (button == "LuckyCharm1") then
        charmNum = 1;
    elseif (button == "LuckyCharm2") then
        charmNum = 2;
    elseif (button == "LuckyCharm3") then
        charmNum = 3;
    elseif (button == "LuckyCharm4") then
        charmNum = 4;
    elseif (button == "LuckyCharm5") then
        charmNum = 5;
    elseif (button == "LuckyCharm6") then
        charmNum = 6;
    elseif (button == "LuckyCharm7") then
        charmNum = 7;
    elseif (button == "LuckyCharm8") then
        charmNum = 8;
    end

    if (mouseButton == 'LeftButton') then
        local uct = UnitCreatureType("target");
        if (uct ~= nil and charmNum ~= 0) then
            -- LuckyCharms.Message(uct.." "..charmNum.." "..LC2_Settings[LC2Profile].charmcc[charmNum]["name"]);--Debug
            -- for k,v in pairs(LC2_Settings[LC2Profile].charmcc[charmNum]) do print(k,v) end --debug
            if (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] ~= nil and
                LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] ~= "") then
                --Target Unit Type ANY
                if (
                    LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 1 or -- Druid Cyclone
                    LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 3 or -- Hunter Freezing Trap
                    LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 4 or -- Hunter Wyvern Sting
                    LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 15 or -- Warlock Fear 
                    LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 16 or -- Druid Entangling Roots
                    LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 18 or -- Death Knight Death Grip
                    LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 19 -- Monk Paralysis
                ) then
                    SetRaidTarget("target", charmNum);
                --Target Unit Type Beasts
                elseif (uct ~= LC2TXT_UTYPE[1]) then
                    if(
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 2 or -- Druid Hibernate
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 5 or --Polymorph, Mage
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 9 or --Sap, Rogue
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 10 or --Hex, Shaman
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 20 --Imprison, Demon Hunter
                    ) then
                        SetRaidTarget("target", charmNum);
                    else
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    end
                --Target Unit Type Demon
                elseif (uct ~= LC2TXT_UTYPE[3]) then
                    if(
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 6 or --Repentance, Paladin
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 9 or --Sap, Rogue
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 13 or --Banish, Warlock
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 14 or --Enslave Demon, Warlock
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 20 --Imprison, Demon Hunter
                    ) then
                        SetRaidTarget("target", charmNum);
                    else
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    end
                --Target Unit Type Undead
                elseif (uct ~= LC2TXT_UTYPE[6]) then
                    if(
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 6 or --Repentance, Paladin
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 7 or --Shackle Undead, Priest
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 17 --Control Undead, DK
                    ) then
                        SetRaidTarget("target", charmNum);
                    else
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    end
                --Target Unit Type Humanoid
                elseif (uct ~= LC2TXT_UTYPE[7]) then
                    if(
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 5 or --Polymorph, Mage
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 6 or --Repentance, Paladin
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 8 or --Mind Control, Priest
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 9 or --Sap, Rogue
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 10 or --Hex, Sham
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 12 or --Seduction Warlock Succ
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 20 --Imprison, Demon Hunter
                    ) then
                        SetRaidTarget("target", charmNum);
                    else
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    end
                --Target Unit Type Dragonkin
                elseif (uct ~= LC2TXT_UTYPE[2]) then
                    if(
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 2 or -- Druid Hibernate
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 6 or --Repentance, Paladin
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 9 --Sap, Rogue
                    ) then
                        SetRaidTarget("target", charmNum);
                    else
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    end
                --Target Unit Type Elemental
                elseif (uct ~= LC2TXT_UTYPE[4]) then
                    if(
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 11 or --Bind Elemental, Sham *Removed
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 13 --Banish, Warlock
                    ) then
                        SetRaidTarget("target", charmNum);
                    else
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    end
                --Target Unit Type Abbarition
                elseif (uct ~= LC2TXT_UTYPE[14]) then
                    if(
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 13--Banish, Warlock
                    ) then
                        SetRaidTarget("target", charmNum);
                    else
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    end
                --Target Unit Type Giant
                elseif (uct ~= LC2TXT_UTYPE[5]) then
                    if(
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 6 --Repentance, Paladin
                    ) then
                        SetRaidTarget("target", charmNum);
                    else
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    end
                --Target Unit Type Critter
                elseif (uct ~= LC2TXT_UTYPE[8]) then
                    if(
                        LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 5 --Polymorph, Mage
                    ) then
                        SetRaidTarget("target", charmNum);
                    else
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    end
                end
                
                --[[
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 2) then -- Druid Hibernate
                    if (uct ~= LC2TXT_UTYPE[1] and uct ~= LC2TXT_UTYPE[2]) then -- Beasts, Dragonkin
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                --Target Unit Type 
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 5) then -- Mage Polymorph
                    if (uct ~= LC2TXT_UTYPE[1] and uct ~= LC2TXT_UTYPE[7] and
                        uct ~= LC2TXT_UTYPE[8]) then -- Humanoid, Beast, Critter
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                --Target Unit Type 
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 6) then -- Repentance (Talent), Paladin
                    if (uct ~= LC2TXT_UTYPE[7] and uct ~= LC2TXT_UTYPE[6] and
                        uct ~= LC2TXT_UTYPE[5] and uct ~= LC2TXT_UTYPE[3] and
                        uct ~= LC2TXT_UTYPE[2]) then -- Humanoid, Undead, Dragonkin, Giant, Demon
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                --Target Unit Type 
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 7) then -- Shackle Undead, Priest
                    if (uct ~= LC2TXT_UTYPE[6]) then -- Undead
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                --Target Unit Type 
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 8) then -- Mind Control, Priest
                    if (uct ~= LC2TXT_UTYPE[7]) then -- Humanoid
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                --Target Unit Type 
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 9) then -- Sap, Rogue
                    if (uct ~= LC2TXT_UTYPE[7] and uct ~= LC2TXT_UTYPE[1] and
                        uct ~= LC2TXT_UTYPE[3] and uct ~= LC2TXT_UTYPE[2]) then -- Humanoid, Beasts, Demons, Dragonkin
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 10) then -- Hex, Shaman
                    if (uct ~= LC2TXT_UTYPE[1] and uct ~= LC2TXT_UTYPE[7]) then -- Humanoid, Beast
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 11) then -- Shaman Bind Elemental
                    if (uct ~= LC2TXT_UTYPE[4]) then -- Elemental
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 12) then -- Seduction, Warlock
                    if (uct ~= LC2TXT_UTYPE[7]) then -- Humanoid
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 13) then -- Banish, Warlock
                    if (uct ~= LC2TXT_UTYPE[3] and uct ~= LC2TXT_UTYPE[4]) then -- Demon, Elemental
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                elseif (LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 14) then -- Enslave Demon
                    if (uct ~= LC2TXT_UTYPE[3]) then -- Demon
                        LuckyCharms.Message(
                            "|cFFEE0000" ..
                                LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
                        UIErrorsFrame:AddMessage(
                            LC2_Settings[LC2Profile].charmcc[charmNum]["name"] ..
                                " " .. SPELL_FAILED_BAD_TARGETS, 1.0, 0.0, 0.0,
                            53, 5);
                    else
                        SetRaidTarget("target", charmNum);
                    end
                end
                ]]
            else
                SetRaidTarget("target", charmNum);
            end
        elseif (charmNum == 0) then
            SetRaidTarget("target", charmNum);
        else
            LuckyCharms.Message(ERR_GENERIC_NO_TARGET);
        end
    elseif (mouseButton == 'RightButton') then
        if (IsShiftKeyDown()) then
            LuckyCharms.ClearCCAssignments(charmNum);
        else
            -- LuckyCharms.Message("DEBUG: RightMouseButton Click! "..charmNum);
            if (charmNum == 1) then
                CC1DD = CreateFrame("Frame", "CC1DD", LuckyCharm1,
                                    "UIDropDownMenuTemplate");
                UIDropDownMenu_Initialize(CC1DD, LuckyCharms.CCDD_Init, "MENU");
                ToggleDropDownMenu(1, nil, CC1DD, LuckyCharm1, 0, 0);
            elseif (charmNum == 2) then
                CC2DD = CreateFrame("Frame", "CC2DD", LuckyCharm2,
                                    "UIDropDownMenuTemplate");
                UIDropDownMenu_Initialize(CC2DD, LuckyCharms.CCDD_Init, "MENU");
                ToggleDropDownMenu(1, nil, CC2DD, LuckyCharm2, 0, 0);
            elseif (charmNum == 3) then
                CC3DD = CreateFrame("Frame", "CC3DD", LuckyCharm3,
                                    "UIDropDownMenuTemplate");
                UIDropDownMenu_Initialize(CC3DD, LuckyCharms.CCDD_Init, "MENU");
                ToggleDropDownMenu(1, nil, CC3DD, LuckyCharm3, 0, 0);
            elseif (charmNum == 4) then
                CC4DD = CreateFrame("Frame", "CC4DD", LuckyCharm4,
                                    "UIDropDownMenuTemplate");
                UIDropDownMenu_Initialize(CC4DD, LuckyCharms.CCDD_Init, "MENU");
                ToggleDropDownMenu(1, nil, CC4DD, LuckyCharm4, 0, 0);
            elseif (charmNum == 5) then
                CC5DD = CreateFrame("Frame", "CC5DD", LuckyCharm5,
                                    "UIDropDownMenuTemplate");
                UIDropDownMenu_Initialize(CC5DD, LuckyCharms.CCDD_Init, "MENU");
                ToggleDropDownMenu(1, nil, CC5DD, LuckyCharm5, 0, 0);
            elseif (charmNum == 6) then
                CC6DD = CreateFrame("Frame", "CC6DD", LuckyCharm6,
                                    "UIDropDownMenuTemplate");
                UIDropDownMenu_Initialize(CC6DD, LuckyCharms.CCDD_Init, "MENU");
                ToggleDropDownMenu(1, nil, CC6DD, LuckyCharm6, 0, 0);
            elseif (charmNum == 7) then
                CC7DD = CreateFrame("Frame", "CC7DD", LuckyCharm7,
                                    "UIDropDownMenuTemplate");
                UIDropDownMenu_Initialize(CC7DD, LuckyCharms.CCDD_Init, "MENU");
                ToggleDropDownMenu(1, nil, CC7DD, LuckyCharm7, 0, 0);
            elseif (charmNum == 8) then
                CC8DD = CreateFrame("Frame", "CC8DD", LuckyCharm8,
                                    "UIDropDownMenuTemplate");
                UIDropDownMenu_Initialize(CC8DD, LuckyCharms.CCDD_Init, "MENU");
                ToggleDropDownMenu(1, nil, CC8DD, LuckyCharm8, 0, 0);
            elseif (charmNum == 0) then
                LuckyCharms.ClearCCAssignments(nil);
            end
        end
    end
end

function LuckyCharms.CCDD_Init(self, level)
    -- LuckyCharms.Message(self:GetName());
    -- Creating test data structure
    local Test1_Data = {};
    local n = table.getn(LC2Txt_CCClass);
    for i = 1, n do
        Test1_Data[LC2Txt_CCClass[i]] = {};
        local x = 0;
        local arr = nil;
        if (i == 1) then
            x = table.getn(LC2Txt_DruidCC);
            arr = LC2Txt_DruidCC;
        elseif (i == 2) then
            x = table.getn(LC2Txt_HunterCC);
            arr = LC2Txt_HunterCC;
        elseif (i == 3) then
            x = table.getn(LC2Txt_MageCC);
            arr = LC2Txt_MageCC;
        elseif (i == 4) then
            x = table.getn(LC2Txt_PaladinCC);
            arr = LC2Txt_PaladinCC;
        elseif (i == 5) then
            x = table.getn(LC2Txt_PriestCC);
            arr = LC2Txt_PriestCC;
        elseif (i == 6) then
            x = table.getn(LC2Txt_RogueCC);
            arr = LC2Txt_RogueCC;
        elseif (i == 7) then
            x = table.getn(LC2Txt_ShamanCC);
            arr = LC2Txt_ShamanCC;
        elseif (i == 8) then
            x = table.getn(LC2Txt_WarlockCC);
            arr = LC2Txt_WarlockCC;
        elseif (i == 9) then
            x = table.getn(LC2Txt_DeathKnightCC);
            arr = LC2Txt_DeathKnightCC;
        elseif (i == 10) then
            x = table.getn(LC2Txt_MonkCC);
            arr = LC2Txt_MonkCC;
        elseif (i == 11) then
            x = table.getn(LC2Txt_DemonHunterCC);
            arr = LC2Txt_DemonHunterCC;
        end

        local z = 1;
        for k, v in pairs(arr) do
            -- print(v[1],v[2]);
            local name, rank, icon, cost, isFunnel, powerType, castTime,
                  minRange, maxRange = GetSpellInfo(v[2]);
            Test1_Data[LC2Txt_CCClass[i]][z] =
                {
                    ["name"] = name,
                    ["icon"] = icon,
                    ["ccid"] = v[1],
                    ["spellid"] = v[2]
                };
            z = z + 1;
        end
    end

    level = level or 1;
    if (level == 1) then
        for key, subarray in pairs(Test1_Data) do
            -- LuckyCharms.Message(key);
            local n = table.getn(CCMembers[key]);
            -- LuckyCharms.Message("DEBUG: Number Members: "..n);
            if (n > 0) then
                -- LuckyCharms.Message("Person Found");
                local info = UIDropDownMenu_CreateInfo();
                -- info.icon = "Interface\\Icons\\Ability_Druid_Maul";
                info.hasArrow = true; -- creates submenu
                info.notCheckable = true;
                info.text = key;
                info.value = {["Level1_Key"] = key};
                UIDropDownMenu_AddButton(info, level);
            end -- if n > 0
        end -- for key, subarray
    end -- if level 1

    if (level == 2) then
        local Level1_Key = UIDROPDOWNMENU_MENU_VALUE["Level1_Key"];
        local info = UIDropDownMenu_CreateInfo();
        -- LuckyCharms.Message(self:GetName());
        -- LuckyCharms.Message(Level1_Key);
        for i, v in pairs(CCMembers) do
            if (i == Level1_Key) then
                local n = table.getn(CCMembers[i]);
                for x = 1, n do
                    -- LuckyCharms.Message(tostring(v[x]));
                    -- LuckyCharms.Message(table.getn(CCMembers[i][0]));
                    -- info.icon = "Interface\\Icons\\Ability_Druid_Maul";
                    info.hasArrow = true; -- creates submenu
                    info.notCheckable = true;
                    info.text = v[x];
                    info.value = {
                        ["Level1_Key"] = Level1_Key,
                        ["Level2_Key"] = i,
                        ["Level2_Value"] = v[x]
                    };
                    UIDropDownMenu_AddButton(info, level);
                end -- for i,n
            end -- if i == Level1_Key
        end -- for i,v
    end -- if level 2

    if (level == 3) then
        -- getting values of first menu
        -- LuckyCharms.Message(tostring(UIDROPDOWNMENU_MENU_VALUE["Level2_Value"][1]));
        local Level1_Key = UIDROPDOWNMENU_MENU_VALUE["Level1_Key"];
        local Level2_Key = UIDROPDOWNMENU_MENU_VALUE["Level2_Key"];
        local Level2_Value = UIDROPDOWNMENU_MENU_VALUE["Level2_Value"];
        local info = UIDropDownMenu_CreateInfo();
        subarray = Test1_Data[Level1_Key];
        for key, subsubarray in pairs(subarray) do

            info.hasArrow = false; -- no submenues this time
            info.notCheckable = true;
            info.text = subsubarray["name"];
            info.icon = subsubarray["icon"];
            info.owner = self;
            local arg1 = {
                ["Level1_Key"] = Level1_Key,
                ["Level2_Key"] = Level2_Key,
                ["Level2_Value"] = Level2_Value,
                ["Level3_Key"] = key,
                ["Level3_Value"] = subsubarray["name"],
                ["Level3_Icon"] = subsubarray["icon"],
                ["Level3_CCID"] = subsubarray["ccid"],
                ["Level3_SPELLID"] = subsubarray["spellid"]
            };
            info.func = function()
                LuckyCharms.CCDD_OnClick(self, arg1)
            end;
            info.value = arg1;
            -- Tooltips
            info.tooltipTitle = "LC2CCShowTooltip";
            info.tooltipText = subsubarray["spellid"];
            -- info.tooltipOnButton = true;

            UIDropDownMenu_AddButton(info, level);
        end -- for key,subsubarray
    end -- if level 3
end



function LuckyCharms.CCDD_OnClick(self, arg1)
    local owner = self:GetName();
    -- local ccSet = arg1["Level2_Value"].." - "..arg1["Level3_Value"];
    local ccSet = arg1["Level2_Value"];
    local ccIcon = arg1["Level3_Icon"];
    -- LuckyCharms.Message(owner);--Debug
    -- LuckyCharms.Message(ccIcon);--Debug
    -- LuckyCharms.Message(arg1["Level3_CCID"]);--Debug

    local cNum = tonumber(string.sub(owner, 3, 3));
    -- LuckyCharms.Message(cNum);--Debug
    LC2_Settings[LC2Profile].charmcc[cNum]["name"] = ccSet;
    LC2_Settings[LC2Profile].charmcc[cNum]["icon"] = ccIcon;
    LC2_Settings[LC2Profile].charmcc[cNum]["ccid"] = arg1["Level3_CCID"];
    LC2_Settings[LC2Profile].charmcc[cNum]["spellid"] = arg1["Level3_SPELLID"];
    local btnIcon = _G["LCKillOrder_C" .. cNum .. "Icon"];
    local btn = _G["LCKillOrder_C" .. cNum];
    btnIcon:SetTexture(ccIcon);
    btn:Enable();
    if (not btn:IsShown()) then btn:Show(); end

    LuckyCharms.UpdateCCAssignments();
end

function LuckyCharms.UpdateCCAssignments()
    if (string.len(LC2_Settings[LC2Profile].charmcc[1]["name"]) > 0) then
        LuckyCharm1Title:SetText(LC2TXT_CCABBRV);
    end
    if (string.len(LC2_Settings[LC2Profile].charmcc[2]["name"]) > 0) then
        LuckyCharm2Title:SetText(LC2TXT_CCABBRV);
    end
    if (string.len(LC2_Settings[LC2Profile].charmcc[3]["name"]) > 0) then
        LuckyCharm3Title:SetText(LC2TXT_CCABBRV);
    end
    if (string.len(LC2_Settings[LC2Profile].charmcc[4]["name"]) > 0) then
        LuckyCharm4Title:SetText(LC2TXT_CCABBRV);
    end
    if (string.len(LC2_Settings[LC2Profile].charmcc[5]["name"]) > 0) then
        LuckyCharm5Title:SetText(LC2TXT_CCABBRV);
    end
    if (string.len(LC2_Settings[LC2Profile].charmcc[6]["name"]) > 0) then
        LuckyCharm6Title:SetText(LC2TXT_CCABBRV);
    end
    if (string.len(LC2_Settings[LC2Profile].charmcc[7]["name"]) > 0) then
        LuckyCharm7Title:SetText(LC2TXT_CCABBRV);
    end
    if (string.len(LC2_Settings[LC2Profile].charmcc[8]["name"]) > 0) then
        LuckyCharm8Title:SetText(LC2TXT_CCABBRV);
    end
end

function LuckyCharms.ClearCCAssignments(ccCharm)
    if (ccCharm == nil) then
        for i = 1, 8 do
            local lct = _G["LuckyCharm" .. i .. "Title"];
            if (lct) then lct:SetText(nil); end
        end
        LC2_Settings[LC2Profile].charmcc = {};
        for i = 1, 8 do
            LC2_Settings[LC2Profile].charmcc[i] =
                {["name"] = "", ["icon"] = "", ["ccid"] = "", ["spellid"] = ""};
            local btn = _G["LCKillOrder_C" .. i];
            local btnIcon = _G["LCKillOrder_C" .. i .. "Icon"];
            btnIcon:SetTexture(nil);
            btn:Disable();
            btn:Hide();
        end
    else
        if (ccCharm ~= 0) then
            LC2_Settings[LC2Profile].charmcc[ccCharm]["name"] = "";
            LC2_Settings[LC2Profile].charmcc[ccCharm]["icon"] = "";
            LC2_Settings[LC2Profile].charmcc[ccCharm]["ccid"] = "";
            LC2_Settings[LC2Profile].charmcc[ccCharm]["spellid"] = "";
            local btn = _G["LCKillOrder_C" .. ccCharm];
            local btnIcon = _G["LCKillOrder_C" .. ccCharm .. "Icon"];
            btnIcon:SetTexture(nil);
            btn:Disable();
            btn:Hide();

            if (ccCharm == 1) then
                LuckyCharm1Title:SetText(nil);
            elseif (ccCharm == 2) then
                LuckyCharm2Title:SetText(nil);
            elseif (ccCharm == 3) then
                LuckyCharm3Title:SetText(nil);
            elseif (ccCharm == 4) then
                LuckyCharm4Title:SetText(nil);
            elseif (ccCharm == 5) then
                LuckyCharm5Title:SetText(nil);
            elseif (ccCharm == 6) then
                LuckyCharm6Title:SetText(nil);
            elseif (ccCharm == 7) then
                LuckyCharm7Title:SetText(nil);
            elseif (ccCharm == 8) then
                LuckyCharm8Title:SetText(nil);
            end
        end
    end
end

function LuckyCharms.ButtonTips(button)
    if (LC2_Settings[LC2Profile].tooltips == 1) then
        if (button == "LuckyCharm1") then
            GameTooltip:SetOwner(LuckyCharm1, "ANCHOR_RIGHT");
            GameTooltip:SetText(RAID_TARGET_1, nil, nil, nil, nil, 1);
            GameTooltip:AddLine(LC2TT_SETCC);
            GameTooltip:AddLine(LC2TT_CLEAR1CC);
        elseif (button == "LuckyCharm2") then
            GameTooltip:SetOwner(LuckyCharm2, "ANCHOR_RIGHT");
            GameTooltip:SetText(RAID_TARGET_2, nil, nil, nil, nil, 1);
            GameTooltip:AddLine(LC2TT_SETCC);
            GameTooltip:AddLine(LC2TT_CLEAR1CC);
        elseif (button == "LuckyCharm3") then
            GameTooltip:SetOwner(LuckyCharm3, "ANCHOR_RIGHT");
            GameTooltip:SetText(RAID_TARGET_3, nil, nil, nil, nil, 1);
            GameTooltip:AddLine(LC2TT_SETCC);
            GameTooltip:AddLine(LC2TT_CLEAR1CC);
        elseif (button == "LuckyCharm4") then
            GameTooltip:SetOwner(LuckyCharm4, "ANCHOR_RIGHT");
            GameTooltip:SetText(RAID_TARGET_4, nil, nil, nil, nil, 1);
            GameTooltip:AddLine(LC2TT_SETCC);
            GameTooltip:AddLine(LC2TT_CLEAR1CC);
        elseif (button == "LuckyCharm5") then
            GameTooltip:SetOwner(LuckyCharm5, "ANCHOR_RIGHT");
            GameTooltip:SetText(RAID_TARGET_5, nil, nil, nil, nil, 1);
            GameTooltip:AddLine(LC2TT_SETCC);
            GameTooltip:AddLine(LC2TT_CLEAR1CC);
        elseif (button == "LuckyCharm6") then
            GameTooltip:SetOwner(LuckyCharm6, "ANCHOR_RIGHT");
            GameTooltip:SetText(RAID_TARGET_6, nil, nil, nil, nil, 1);
            GameTooltip:AddLine(LC2TT_SETCC);
            GameTooltip:AddLine(LC2TT_CLEAR1CC);
        elseif (button == "LuckyCharm7") then
            GameTooltip:SetOwner(LuckyCharm7, "ANCHOR_RIGHT");
            GameTooltip:SetText(RAID_TARGET_7, nil, nil, nil, nil, 1);
            GameTooltip:AddLine(LC2TT_SETCC);
            GameTooltip:AddLine(LC2TT_CLEAR1CC);
        elseif (button == "LuckyCharm8") then
            GameTooltip:SetOwner(LuckyCharm8, "ANCHOR_RIGHT");
            GameTooltip:SetText(RAID_TARGET_8, nil, nil, nil, nil, 1);
            GameTooltip:AddLine(LC2TT_SETCC);
            GameTooltip:AddLine(LC2TT_CLEAR1CC);
        elseif (button == "LuckyCharm0") then
            GameTooltip:SetOwner(LuckyCharm0, "ANCHOR_RIGHT");
            GameTooltip:SetText(KEY_NUMLOCK_MAC, nil, nil, nil, nil, 1);
            GameTooltip:AddLine(LC2TT_CLEARCC);
        elseif (button == "LCRCButton") then
            GameTooltip:SetOwner(LCRCButton, "ANCHOR_RIGHT");
            GameTooltip:SetText(LC2TT_RC, nil, nil, nil, nil, 1);
        elseif (button == "LCKOButton") then
            GameTooltip:SetOwner(LCKOButton, "ANCHOR_RIGHT");
            GameTooltip:SetText(LC2TT_KO, nil, nil, nil, nil, 1);
        end
        GameTooltip:Show();
    end
end

function LuckyCharms.InitCCButtons()
    for i = 1, 8 do
        local btn = _G["LCKillOrder_C" .. i];
        local btnIcon = _G["LCKillOrder_C" .. i .. "Icon"];
        if (string.len(LC2_Settings[LC2Profile].charmcc[i]["name"]) > 0) then
            btn:Enable();
            btnIcon:SetTexture(LC2_Settings[LC2Profile].charmcc[i]["icon"]);
            if (not btn:IsShown()) then btn:Show(); end
        else
            if (btn:IsShown()) then btn:Hide(); end
            btn:Disable();
        end
    end -- for i,8
end

function LuckyCharms.CCButtonTips(button)
    if (LC2_Settings[LC2Profile].tooltips == 1) then
        GameTooltip:ClearLines();

        -- LuckyCharms.Message(button);
        if (button == "LCKillOrder_C1") then
            GameTooltip:SetOwner(LCKillOrder_C1, "ANCHOR_RIGHT");
            GameTooltip:SetSpellByID(
                LC2_Settings[LC2Profile].charmcc[1]["spellid"]);
            GameTooltip:AppendText(" - " ..
                                       LC2_Settings[LC2Profile].charmcc[1]["name"]);
        elseif (button == "LCKillOrder_C2") then
            GameTooltip:SetOwner(LCKillOrder_C2, "ANCHOR_RIGHT");
            GameTooltip:SetSpellByID(
                LC2_Settings[LC2Profile].charmcc[2]["spellid"]);
            GameTooltip:AppendText(" - " ..
                                       LC2_Settings[LC2Profile].charmcc[2]["name"]);
        elseif (button == "LCKillOrder_C3") then
            GameTooltip:SetOwner(LCKillOrder_C3, "ANCHOR_RIGHT");
            GameTooltip:SetSpellByID(
                LC2_Settings[LC2Profile].charmcc[3]["spellid"]);
            GameTooltip:AppendText(" - " ..
                                       LC2_Settings[LC2Profile].charmcc[3]["name"]);
        elseif (button == "LCKillOrder_C4") then
            GameTooltip:SetOwner(LCKillOrder_C4, "ANCHOR_RIGHT");
            GameTooltip:SetSpellByID(
                LC2_Settings[LC2Profile].charmcc[4]["spellid"]);
            GameTooltip:AppendText(" - " ..
                                       LC2_Settings[LC2Profile].charmcc[4]["name"]);
        elseif (button == "LCKillOrder_C5") then
            GameTooltip:SetOwner(LCKillOrder_C5, "ANCHOR_RIGHT");
            GameTooltip:SetSpellByID(
                LC2_Settings[LC2Profile].charmcc[5]["spellid"]);
            GameTooltip:AppendText(" - " ..
                                       LC2_Settings[LC2Profile].charmcc[5]["name"]);
        elseif (button == "LCKillOrder_C6") then
            GameTooltip:SetOwner(LCKillOrder_C6, "ANCHOR_RIGHT");
            GameTooltip:SetSpellByID(
                LC2_Settings[LC2Profile].charmcc[6]["spellid"]);
            GameTooltip:AppendText(" - " ..
                                       LC2_Settings[LC2Profile].charmcc[6]["name"]);
        elseif (button == "LCKillOrder_C7") then
            GameTooltip:SetOwner(LCKillOrder_C7, "ANCHOR_RIGHT");
            GameTooltip:SetSpellByID(
                LC2_Settings[LC2Profile].charmcc[7]["spellid"]);
            GameTooltip:AppendText(" - " ..
                                       LC2_Settings[LC2Profile].charmcc[7]["name"]);
        elseif (button == "LCKillOrder_C8") then
            GameTooltip:SetOwner(LCKillOrder_C8, "ANCHOR_RIGHT");
            GameTooltip:SetSpellByID(
                LC2_Settings[LC2Profile].charmcc[8]["spellid"]);
            GameTooltip:AppendText(" - " ..
                                       LC2_Settings[LC2Profile].charmcc[8]["name"]);
        end
        GameTooltip:Show();
    end -- if tooltips == 1
end

function LuckyCharms.ToggleLock()
    if (LC2_Settings[LC2Profile].locked == 0 or LC2_Settings[LC2Profile].locked ==
        nil) then
        LC2_Settings[LC2Profile].locked = 1;
        LCBDragButtonIcon:SetTexture(lockImage);
    else
        LC2_Settings[LC2Profile].locked = 0;
        LCBDragButtonIcon:SetTexture(unlockImage);
    end
end

function LuckyCharms.IsLocked() return LC2_Settings[LC2Profile].locked; end

-- Create Anchors
function LuckyCharms.KOCTextPos(new_pos)
    -- LuckyCharms.Message("DEBUG: KOCTextPos Called!");
    for i = 1, 8 do
        _G["LCKillOrder_C" .. i]:ClearAllPoints();
        _G["LCKillOrder_C" .. i]:Hide();
    end

    -- LuckyCharms.Message(new_pos);--Debug
    LC2_Settings[LC2Profile].koctp = new_pos;
    LC2_Settings[LC2Profile].kopos = new_pos;

    if (new_pos == "top") then
        for i = 1, 8 do
            if (_G["LuckyCharm" .. i]) then
                _G["LCKillOrder_C" .. i]:SetPoint("BOTTOM", "LuckyCharm" .. i,
                                                  "TOP", 0, 4);
                if (_G["LuckyCharm" .. i]:IsVisible()) then
                    _G["LCKillOrder_C" .. i]:Show();
                end
            end
        end
    elseif (new_pos == "bottom") then
        for i = 1, 8 do
            if (_G["LuckyCharm" .. i]) then
                _G["LCKillOrder_C" .. i]:SetPoint("TOP", "LuckyCharm" .. i,
                                                  "BOTTOM", 0, -4);
                if (_G["LuckyCharm" .. i]:IsVisible()) then
                    _G["LCKillOrder_C" .. i]:Show();
                end
            end
        end
    elseif (new_pos == "left") then
        for i = 1, 8 do
            if (_G["LuckyCharm" .. i]) then
                _G["LCKillOrder_C" .. i]:SetPoint("RIGHT", "LuckyCharm" .. i,
                                                  "LEFT", -4, 0);
                if (_G["LuckyCharm" .. i]:IsVisible()) then
                    _G["LCKillOrder_C" .. i]:Show();
                end
            end
        end
    elseif (new_pos == "right") then
        for i = 1, 8 do
            if (_G["LuckyCharm" .. i]) then
                _G["LCKillOrder_C" .. i]:SetPoint("LEFT", "LuckyCharm" .. i,
                                                  "RIGHT", 4, 0);
                if (_G["LuckyCharm" .. i]:IsVisible()) then
                    _G["LCKillOrder_C" .. i]:Show();
                end
            end
        end
    else
        LuckyCharms.KOCTextPos("top");
    end
end
-- End Anchor Creation

-- Return Anchor Position
function LuckyCharms.RetBarPos(bpos)
    if (LC2_Settings[LC2Profile].ancpos == bpos) then
        return true;
    else
        return false;
    end
end
-- End Return Anchor Position

function LuckyCharms.DoUpdate()
    -- LuckyCharms.Message("DEBUG: DoUpdate Called!");
    -- LuckyCharms.Message("DEBUG:" .. tostring(LC2IsLoaded));
    -- if (LC2IsLoaded) then
        local hash = {};
        local result = {};
        -- Remove duplicate wait events.
        for _, v in ipairs(LuckyCharms.waitEvents) do
            if (not hash[v]) then
                result[#result + 1] = v -- you could print here instead of saving to result table if you wanted
                hash[v] = true
            end
        end
        -- Process wait event list.
        for _, v in ipairs(result) do
            if (v == "frames") then
                LuckyCharms.UpdateFrames();
            elseif (v == "cc") then
                LuckyCharms.UpdateCCList();
            end
        end
        -- Clear wait event list.
        hash = nil;
        result = nil;
        LuckyCharms.waitEvents = {};
    -- end
end

function LuckyCharms.UpdateFrames()
    -- LuckyCharms.Message("DEBUG: UpdateFrames Called!");
    -- Charms Auto Show/Hide
    if (LC2_Settings[LC2Profile].barstatus == "auto") then
        -- LuckyCharms_msg(GetNumGroupMembers());--Debug
        if (UnitInRaid("player")) then -- In Raid
            if (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
                if (not LuckyCharmBar:IsShown()) then
                    LuckyCharmBar:Show();
                end
            else
                LuckyCharmBar:Hide();
            end
        elseif (GetNumGroupMembers() > 0) then -- In Party
            if (not LuckyCharmBar:IsShown()) then
                LuckyCharmBar:Show();
            end
        else
            LuckyCharmBar:Hide();
        end
    end
    -- Anchor Auto Show/Hide
    if (LC2_Settings[LC2Profile].ancstatus == "auto") then
        if (UnitInRaid("player")) then
            if (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
                if (not LuckyCharmAnchorBar:IsShown()) then
                    LuckyCharmAnchorBar:Show();
                end
            else
                LuckyCharmAnchorBar:Hide();
            end
        elseif (GetNumGroupMembers() > 0) then
            if (not LuckyCharmAnchorBar:IsShown()) then
                LuckyCharmAnchorBar:Show();
            end
        else
            LuckyCharmAnchorBar:Hide();
        end
    end
    -- Ready Check Auto Show/Hide
    if (LC2_Settings[LC2Profile].rcstatus == "auto") then
        if (UnitInRaid("player")) then
            if (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
                if (not LCReadyCheck:IsShown()) then
                    LCReadyCheck:Show();
                end
            else
                LCReadyCheck:Hide();
            end
        elseif (GetNumGroupMembers() > 0) then
            if (UnitIsGroupLeader("player")) then
                if (not LCReadyCheck:IsShown()) then
                    LCReadyCheck:Show();
                end
            else
                LCReadyCheck:Hide();
            end
        else
            LCReadyCheck:Hide();
        end
    end
    -- Kill Order Auto Show/Hide
    if (LC2_Settings[LC2Profile].kostatus == "auto") then
        if (UnitInRaid("player")) then
            if (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
                if (not LCKillOrder:IsShown()) then
                    LCKillOrder:Show();
                end
            else
                LCKillOrder:Hide();
            end
        elseif (GetNumGroupMembers() > 0) then
            if (not LCKillOrder:IsShown()) then LCKillOrder:Show(); end
        else
            LCKillOrder:Hide();
        end
    end
    -- World Markers Auto Show/Hide
    if (LC2_Settings[LC2Profile].wmbarstatus == "auto") then
        -- LuckyCharms.Message(GetNumPartyMembers());--Debug
        if (UnitInRaid("player")) then -- In Raid
            if (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
                if (not LuckyCharmsFlares_main:IsShown()) then
                    LuckyCharmsFlares_main:Show();
                end
            else
                LuckyCharmsFlares_main:Hide();
            end
        elseif (GetNumGroupMembers() > 0) then -- In Party
            if (not LuckyCharmsFlares_main:IsShown()) then
                LuckyCharmsFlares_main:Show();
            end
        else
            LuckyCharmsFlares_main:Hide();
        end
    end
end

function LuckyCharms.UpdateCCList()
    -- LuckyCharms.Message("DEBUG: UpdateCCList Called!");
    -- LuckyCharms_msg(GetNumGroupMembers());
    -- Clear Enchanced CC Members Array
    CCMembers[LC2Txt_CCClass[1]] = {};
    CCMembers[LC2Txt_CCClass[2]] = {};
    CCMembers[LC2Txt_CCClass[3]] = {};
    CCMembers[LC2Txt_CCClass[4]] = {};
    CCMembers[LC2Txt_CCClass[5]] = {};
    CCMembers[LC2Txt_CCClass[6]] = {};
    CCMembers[LC2Txt_CCClass[7]] = {};
    CCMembers[LC2Txt_CCClass[8]] = {};
    -- Check for Raid, otherwise check for party, otherwise nada.
    if (UnitInRaid("player")) then -- In Raid
        if (GetNumGroupMembers() > 0) then
            for i = 1, GetNumGroupMembers() do
                localizedClass, englishClass = UnitClass("raid" .. i);
                name = UnitName("raid" .. i);
                for x = 1, table.getn(LC2Txt_CCClass) do
                    if (englishClass == LC2Txt_CCClassEN[x]) then
                        table.insert(CCMembers[LC2Txt_CCClass[x]], name);
                    end
                end -- for x,table
            end -- for i,GetNumRaidMembers
        end
    elseif (GetNumGroupMembers() > 0) then
        for i = 0, GetNumGroupMembers() do
            if (i == 0) then
                localizedClass, englishClass = UnitClass("player");
                name = UnitName("player");
            else
                localizedClass, englishClass = UnitClass("party" .. i);
                name = UnitName("party" .. i);
            end -- if i==0
            for x = 1, table.getn(LC2Txt_CCClass) do
                if (englishClass == LC2Txt_CCClassEN[x]) then
                    table.insert(CCMembers[LC2Txt_CCClass[x]], name);
                end
            end -- for x,table
        end -- for i,GetNumGroupMembers
    else
        -- Not in a group or left the group.
        LuckyCharms.ClearCCAssignments(nil);
    end
    -- Testing
    -- for y=1,table.getn(LC2Txt_CCClass) do
    -- for x=1,table.getn(CCMembers[LC2Txt_CCClass[y]]) do
    -- LuckyCharms.Message(LC2Txt_CCClass[y].." "..CCMembers[LC2Txt_CCClass[y]][x]);
    -- end
    -- end
end



function LuckyCharms.SetTexCoords()
    for i = 0, 8 do
        local f = _G["LuckyCharm" .. i .. "Icon"];
        if (f) then
            -- LuckyCharms.Message(f:GetName().." Found");
            if (i == 1) then
                f:SetTexCoord(0, 0.25, 0, 0.25);
            elseif (i == 2) then
                f:SetTexCoord(0.25, 0.5, 0, 0.25);
            elseif (i == 3) then
                f:SetTexCoord(0.5, 0.75, 0, 0.25);
            elseif (i == 4) then
                f:SetTexCoord(0.75, 1, 0, 0.25);
            elseif (i == 5) then
                f:SetTexCoord(0, 0.25, 0.25, 0.5);
            elseif (i == 6) then
                f:SetTexCoord(0.25, 0.5, 0.25, 0.5);
            elseif (i == 7) then
                f:SetTexCoord(0.5, 0.75, 0.25, 0.5);
            elseif (i == 8) then
                f:SetTexCoord(0.75, 1, 0.25, 0.5);
            end
        end
    end
end

-- Draw the charms and background frame
function LuckyCharms.DrawCharms()
    -- LuckyCharms.Message("Call DrawCharms");
    local bpos = LC2_Settings[LC2Profile].ancpos;
    local c = 0;
    local space = 0;

    -- Clear Points
    LuckyCharmBar:ClearAllPoints();

    for i = 0, 8 do
        local f = _G["LuckyCharm" .. i];
        if (f) then
            --LuckyCharms.Message(f:GetName() .. " Found");
            f:Hide();
            f:ClearAllPoints();
        end
    end

    -- Draw Charms
    for i = 1, 8 do
        local charmNum = LC2_Settings[LC2Profile].korder[i];
        if (LC2_Settings[LC2Profile].charmStatus[charmNum] == 1) then
            local b = _G["LuckyCharm" .. charmNum];
            if (not b) then
                b = CreateFrame("Button", "LuckyCharm" .. charmNum,
                                LuckyCharmBar, "CharmBtnVirtual");
                -- b:RegisterForClicks("AnyUp");
                b:SetScript("OnClick", function(self, button, down)
                    LuckyCharms.OnCharmClick(button, self);
                end);
                local t = _G["LuckyCharm" .. charmNum .. "Icon"];
                t:SetTexture("Interface\\TARGETINGFRAME\\UI-RaidTargetingIcons");
                --LuckyCharms.Message("Created: " .. b:GetName());--DEBUG
            end

            --Set Anchors for KO buttons.
            -- local koBtn = _G["LCKillOrder_C" .. charmNum];
            -- if (koBtn) then
            --     koBtn:ClearAllPoints();
			-- 	koBtn:SetPoint("BOTTOM", b, "TOP", 0, 4);
			-- 	koBtn:Show();
            -- end

            if (c == 0) then
                space = 2;
            else
                space = c * 40 + 2;
            end

            if (bpos == "left" or bpos == "right") then
                if (bpos == "left") then
                    b:SetPoint("LEFT", LuckyCharmBar, "LEFT", space, -1);
                else
                    b:SetPoint("RIGHT", LuckyCharmBar, "RIGHT", -space, -1);
                end
            elseif (bpos == "top" or bpos == "bottom") then
                if (bpos == "top") then
                    b:SetPoint("BOTTOM", LuckyCharmBar, "BOTTOM", 0, space);
                else
                    b:SetPoint("TOP", LuckyCharmBar, "TOP", 0, -space);
                end
            end

            b:Show();
            c = c + 1;
        end
    end

    -- Draw Clear Button
    if (c == 0) then
        space = 2;
    else
        space = c * 40 + 2;
    end
    b = _G["LuckyCharm0"];
    if (not b) then
        b = CreateFrame("Button", "LuckyCharm0", LuckyCharmBar,
                        "CharmBtnVirtual");
        b:SetScript("OnClick", function(self, button, down)
            LuckyCharms.OnCharmClick(button, self);
        end);
    end
    t = _G["LuckyCharm0Icon"];
    t:SetTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up");
    -- End Draw Clear Button		

    if (bpos == "left" or bpos == "right") then
        if (bpos == "left") then
            b:SetPoint("LEFT", LuckyCharmBar, "LEFT", space, -1);
        else
            b:SetPoint("RIGHT", LuckyCharmBar, "RIGHT", -space, -1);
        end
    elseif (bpos == "top" or bpos == "bottom") then
        if (bpos == "top") then
            b:SetPoint("BOTTOM", LuckyCharmBar, "BOTTOM", 0, space);
        else
            b:SetPoint("TOP", LuckyCharmBar, "TOP", 0, -space);
        end
    end
    b:Show();

    -- Bar Positions
    if (bpos == "left" or bpos == "right") then
        LuckyCharmBar:SetWidth(space + 40);
        LuckyCharmBar:SetHeight(47);
        LCKillOrder:SetWidth(space + 40);
        LCKillOrder:SetHeight(28);
        if (bpos == "left") then
            LuckyCharmBar:SetPoint("LEFT", "LuckyCharmAnchorBar", "RIGHT", -2, 0);
        else
            LuckyCharmBar:SetPoint("RIGHT", "LuckyCharmAnchorBar", "LEFT", 2, 0);
        end
        if (LC2_Settings[LC2Profile].koctp == "left" or
            LC2_Settings[LC2Profile].koctp == "right") then
            LuckyCharms.Config.KORadioPos("top", 0);
        end
        LuckyCharmConfigKODisplayPosDefault:SetText(
            CHAT_DEFAULT .. ": |cFF4DBD33" .. LC2TXT_TOP .. "|r");
    elseif (bpos == "top" or bpos == "bottom") then
        LuckyCharmBar:SetWidth(47);
        LuckyCharmBar:SetHeight(space + 40);
        LCKillOrder:SetWidth(28);
        LCKillOrder:SetHeight(space + 40);
        if (bpos == "top") then
            LuckyCharmBar:SetPoint("BOTTOM", "LuckyCharmAnchorBar", "TOP", 0, 0);
        else
            LuckyCharmBar:SetPoint("TOP", "LuckyCharmAnchorBar", "BOTTOM", 0, 2);
        end
        if (LC2_Settings[LC2Profile].koctp == "top" or
            LC2_Settings[LC2Profile].koctp == "bottom") then
            LuckyCharms.Config.KORadioPos("right", 0);
        else
            LuckyCharms.Config.KOAnchor(LC2_Settings[LC2Profile].koctp);
        end
        LuckyCharmConfigKODisplayPosDefault:SetText(
            CHAT_DEFAULT .. ": |cFF4DBD33" .. LC2TXT_RIGHT .. "|r");
    end
    -- LuckyCharms.Config.AncRadioPos(bpos,1);
    LuckyCharms.Config.UpdateKOPosOpt();
    LuckyCharms.Config.KOAnchor(LC2_Settings[LC2Profile].kopos);
end

-- Kill Order Display
function LuckyCharms.PrntChatMsg()
    local order = "";
    local ccOrder = "";
    for i = 1, 8 do
        local n = LC2_Settings[LC2Profile].korder[i];
        if (LC2_Settings[LC2Profile].charmStatus[n] == 1) then
            if (LC2_Settings[LC2Profile].komode == "icons") then
                order = order .. charmArr[n][1] .. " ";
                if (string.len(LC2_Settings[LC2Profile].charmcc[n]["name"]) > 0) then
                    ccOrder = ccOrder .. charmArr[n][1] .. " - " ..
                                  LC2_Settings[LC2Profile].charmcc[n]["name"] ..
                                  " " ..
                                  GetSpellLink(
                                      LC2_Settings[LC2Profile].charmcc[n]["spellid"]) ..
                                  ", ";
                end
            else
                order = order .. charmArr[n][0] .. ", ";
                if (string.len(LC2_Settings[LC2Profile].charmcc[n]["name"]) > 0) then
                    ccOrder = ccOrder .. charmArr[n][0] .. " - " ..
                                  LC2_Settings[LC2Profile].charmcc[n]["name"] ..
                                  " " ..
                                  GetSpellLink(
                                      LC2_Settings[LC2Profile].charmcc[n]["spellid"]) ..
                                  ", ";
                end
            end
        end
    end
    if (LC2_Settings[LC2Profile].kopr == 1) then
        -- In Raid
        if (UnitInRaid("player") and LC2_Settings[LC2Profile].korw == 0) then
            if (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
                if (LC2_Settings[LC2Profile].koprint == 1) then
                    SendChatMessage("[LC2] " .. LC2TXT_KILLORDER .. ": " ..
                                        order, "RAID");
                end
                if (LC2_Settings[LC2Profile].kocc == 1) then
                    for i = 1, 8 do
                        local n = LC2_Settings[LC2Profile].korder[i];
                        if (LC2_Settings[LC2Profile].charmStatus[n] == 1) then
                            if (LC2_Settings[LC2Profile].komode == "icons") then
                                if (string.len(
                                    LC2_Settings[LC2Profile].charmcc[n]["name"]) >
                                    0) then
                                    SendChatMessage(
                                        "[LC2] " .. LC2TXT_CCABBRV .. ": " ..
                                            charmArr[n][1] .. " - " ..
                                            LC2_Settings[LC2Profile].charmcc[n]["name"] ..
                                            " " ..
                                            GetSpellLink(
                                                LC2_Settings[LC2Profile].charmcc[n]["spellid"]),
                                        "RAID");
                                end
                            else
                                if (string.len(
                                    LC2_Settings[LC2Profile].charmcc[n]["name"]) >
                                    0) then
                                    SendChatMessage(
                                        "[LC2] " .. LC2TXT_CCABBRV .. ": " ..
                                            charmArr[n][0] .. " - " ..
                                            LC2_Settings[LC2Profile].charmcc[n]["name"] ..
                                            " " ..
                                            GetSpellLink(
                                                LC2_Settings[LC2Profile].charmcc[n]["spellid"]),
                                        "RAID");
                                end
                            end
                        end
                    end -- for i,8
                end
            else
                LuckyCharms.Message(LC2ERR_RAIDLEADASSITS);
            end
            -- Check in party, no raid
        elseif (GetNumGroupMembers() > 0 and UnitInRaid("player") == nil) then
            -- Ensure party leadership
            -- if(UnitIsPartyLeader("player") == 1) then
            if (LC2_Settings[LC2Profile].koprint == 1) then
                SendChatMessage("[LC2] " .. LC2TXT_KILLORDER .. ": " .. order,
                                "PARTY");
            end
            if (LC2_Settings[LC2Profile].kocc == 1) then
                for i = 1, 8 do
                    local n = LC2_Settings[LC2Profile].korder[i];
                    if (LC2_Settings[LC2Profile].charmStatus[n] == 1) then
                        if (LC2_Settings[LC2Profile].komode == "icons") then
                            if (string.len(
                                LC2_Settings[LC2Profile].charmcc[n]["name"]) > 0) then
                                SendChatMessage(
                                    "[LC2] " .. LC2TXT_CCABBRV .. ": " ..
                                        charmArr[n][1] .. " - " ..
                                        LC2_Settings[LC2Profile].charmcc[n]["name"] ..
                                        " " ..
                                        GetSpellLink(
                                            LC2_Settings[LC2Profile].charmcc[n]["spellid"]),
                                    "PARTY");
                            end
                        else
                            if (string.len(
                                LC2_Settings[LC2Profile].charmcc[n]["name"]) > 0) then
                                SendChatMessage(
                                    "[LC2] " .. LC2TXT_CCABBRV .. ": " ..
                                        charmArr[n][0] .. " - " ..
                                        LC2_Settings[LC2Profile].charmcc[n]["name"] ..
                                        " " ..
                                        GetSpellLink(
                                            LC2_Settings[LC2Profile].charmcc[n]["spellid"]),
                                    "PARTY");
                            end
                        end
                    end
                end -- for i,8
            end
            -- else
            -- LuckyCharms.Message(LC2ERR_PartyLead);
            -- end
            -- else
            -- LuckyCharms.Message(LC2ERR_NOGROUP);
        end
    end
    if (LC2_Settings[LC2Profile].korw == 1) then
        -- if(GetNumGroupMembers() > 0 or UnitInRaid("player")) then
        if (UnitInRaid("player")) then
            if (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
                if (LC2_Settings[LC2Profile].koprint == 1) then
                    SendChatMessage("[LC2] " .. LC2TXT_KILLORDER .. ": " ..
                                        order, "RAID_WARNING");
                end
                if (LC2_Settings[LC2Profile].kocc == 1 and string.len(ccOrder) >
                    0) then
                    SendChatMessage("[LC2] " .. LC2TXT_CCABBRV .. ": " ..
                                        ccOrder, "RAID_WARNING");
                end
            else
                LuckyCharms.Message(LC2ERR_RWLEAD);
            end
        end
    end
end

--Addon OnLoad
function LuckyCharms_OnLoad(self)
    --LuckyCharms.Message("DEBUG: OnLoad Called!");
    self:RegisterEvent('PLAYER_ENTERING_WORLD');
    self:RegisterEvent('ADDON_LOADED');
    self:RegisterEvent('GROUP_ROSTER_UPDATE');
    self:RegisterEvent('PLAYER_LOGIN');
    self:RegisterEvent('PLAYER_REGEN_ENABLED');
    PetBattleFrame:HookScript("OnShow", function() self:Hide() end)
    PetBattleFrame:HookScript("OnHide", function() self:Show() end)
end

--ONEVENT
function LuckyCharms_OnEvent(self, event, ...)
    --LuckyCharms.Message(event .. " Called!"); -- Debug
    if (event == "ADDON_LOADED") then
        local arg1 = ...;
        --LuckyCharms.Message(arg1 .. " Loaded Called!"); -- Debug
        LuckyCharms.AddonLoaded(arg1);
    end

    -- Set Auto Features
    if (event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE") then
        table.insert(LuckyCharms.waitEvents, "frames");

        if InCombatLockdown() then
            LuckyCharms.waiting = true;
            return;
        end

        LuckyCharms.DoUpdate();
    end

    -- Get CC Chars List
    if (event == "GROUP_ROSTER_UPDATE") then
        table.insert(LuckyCharms.waitEvents, "cc");

        if InCombatLockdown() then
            LuckyCharms.waiting = true;
            return;
        end

        LuckyCharms.DoUpdate();
    end

    if (event == "PLAYER_REGEN_ENABLED") then
        -- LuckyCharms.Message("DEBUG: Player Left Combat!");
        if LuckyCharms.waiting then
            LuckyCharms.waiting = false;
            LuckyCharms.DoUpdate();
        end
    end
end

-- Hook the tooltips on UIDropDownMenu for CC Spell Display
-- hooksecurefunc("GameTooltip_AddNewbieTip", function(frame, normalText, r, g, b, newbieText, noNormalText)
--     if (normalText == "LC2CCShowTooltip" and LC2_Settings[LC2Profile].tooltips ==
--         1) then
--         GameTooltip_SetDefaultAnchor(GameTooltip, frame)
--         GameTooltip:ClearLines();

--         GameTooltip:SetSpellByID(newbieText);
--         GameTooltip:Show();
--     end
-- end);
