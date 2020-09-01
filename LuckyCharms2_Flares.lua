--[[
 File: f:\Games\World of Warcraft\_retail_\Interface\AddOns\LuckyCharms2\LuckyCharms2_Flares.lua
 
 File Overview: Falres Code
 
 Project: LuckyCharms2
 
 Project Path: f:\Games\World of Warcraft\_retail_\Interface\AddOns\LuckyCharms2
 
 Created Date: Saturday, August 29th 2020, 8:20:29 am
 
 Author: Ketutastic
 ___
 Last Modified: Tuesday, September 1st 2020, 11:54:12 am
 
 Modified By: Ketutastic
 ___
 Copyright (c) 2020 Ketu Gaming
 ___
 ]]

--Globals
local LC2_Realm = GetRealmName(); --Get Realm for Profile.
local LC2_Char = UnitName("player"); --Get char name for profile.
local LC2Profile = LC2_Realm.." - "..LC2_Char;
local LBF = LibStub("Masque",true);

local BLIP_TEX_COORDS = {
  ["WARRIOR"]={0,0.125,0,0.25}, ["PALADIN"]={0.125,0.25,0,0.25},
  ["HUNTER"]={0.25,0.375,0,0.25}, ["ROGUE"]={0.375,0.5,0,0.25},
  ["PRIEST"]={0.5,0.625,0,0.25}, ["DEATHKNIGHT"]={0.625,0.75,0,0.25},
  ["SHAMAN"]={0.75,0.875,0,0.25}, ["MAGE"]={0.875,1,0,0.25},
  ["WARLOCK"]={0,0.125,0.25,0.5}, ["DRUID"]={0.25,0.375,0.25,0.5},
  ["MONK"]={0.125,0.25,0.25,0.5}
}

LuckyCharms.Flares = {};

function LuckyCharmsFlaresOnLoad(self)
	self:RegisterEvent('ADDON_LOADED');
end

function LuckyCharmsFlaresOnEvent(self,event,...)
	if(event == "ADDON_LOADED") then
		local arg1 = ...;
		if(arg1 == LC2NAME) then
			if(not LC2_Settings[LC2Profile].FlareBarScale) then
				LC2_Settings[LC2Profile].FlareBarScale=1.0;
			end
			if(not LC2_Settings[LC2Profile].FlareBarAlpha) then
				LC2_Settings[LC2Profile].FlareBarAlpha=1;
			end
			if(not LC2_Settings[LC2Profile].wmbarstatus) then
				LC2_Settings[LC2Profile].wmbarstatus="auto";
			end
			if(not LC2_Settings[LC2Profile].FlareBarOrient) then
				LC2_Settings[LC2Profile].FlareBarOrient="h";
			end
			if(not LC2_Settings[LC2Profile].FlareBarSpacing) then
				LC2_Settings[LC2Profile].FlareBarSpacing=0;
			end
			--World Marker Bar
			if(LC2_Settings[LC2Profile].wmbarstatus == "show") then
				LuckyCharmsFlares_main:Show();
			else
				LuckyCharmsFlares_main:Hide();
			end

			--ButtonFacade Support
			if(not LBF) then
		  	--Set Frame Backdrop  Future BF support
				LuckyCharmsFlares_main:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		  		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile=true,tileSize=10,edgeSize=16,
		  		insets = {left=4, right=4, top=4, bottom=4}
		  	});
			end
			--End ButtonFacade Support
			
			LuckyCharms.Flares.Config.ModScale(LC2_Settings[LC2Profile].FlareBarScale);
			LuckyCharms.Flares.Config.ModAlpha(LC2_Settings[LC2Profile].FlareBarAlpha);
			LuckyCharms.Flares.Config.InitScaleSlider(LuckyCharmFlaresConfig_SliderScale);
			LuckyCharms.Flares.Config.InitAlphaSlider(LuckyCharmFlaresConfig_SliderAlpha);
			LuckyCharms.Flares.Config.InitSliderButtonSpacing(LuckyCharmFlaresConfig_SliderButtonSpacing);
			LuckyCharms.Flares.Config.WMRadio(LC2_Settings[LC2Profile].wmbarstatus,1);
			
			LuckyCharms.Flares.AddButtons();
			LuckyCharms.Flares.SetTexCoords();
			
			LuckyCharms.Flares.Config.WMRadioOrient(LC2_Settings[LC2Profile].FlareBarOrient,1);
		end
	end
end

function LuckyCharms.Flares.AddButtons()
	for i=1,9 do
		local b = _G["LuckyCharm2Flare"..i];
		if(not b) then
			if(i~=9)then
				b = CreateFrame("Button","LuckyCharm2Flare"..i,LuckyCharmsFlares_main,"LC2_FlareBtnVirtual");
				b:SetAttribute("type", "macro");
				b:SetAttribute("macrotext1", "/wm "..i);
				b:SetScript("OnEnter", function(self) if (LC2_Settings[LC2Profile].tooltips == 1) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine(_G["WORLD_MARKER"..i],0.88,0.65,0); GameTooltip:Show() end end);
				b:SetScript("OnLeave", function(self) GameTooltip:Hide() end);
	
				local t = _G["LuckyCharm2Flare"..i.."Icon"];
				t:SetTexture("interface\\minimap\\partyraidblips");
			else
				--Clear Flares
				b = CreateFrame("Button","LuckyCharm2Flare"..i,LuckyCharmsFlares_main,"LC2_FlareBtnVirtual");
				b:SetAttribute("type", "macro")
				b:SetAttribute("macrotext1", "/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton\n/click DropDownList1Button9")
				b:SetScript("OnEnter", function(self) if (LC2_Settings[LC2Profile].tooltips == 1) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine(LC2FTT_LEFTCLICK.." "..REMOVE_WORLD_MARKERS,0.88,0.65,0); GameTooltip:AddLine(LC2FTT_RIGHTCLICK,0.88,0.65,0);GameTooltip:Show() end end)
				b:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
				b:SetScript("OnMouseDown", function(self,button) if (button=="RightButton") then LuckyCharmsFlares_main:StartMoving() end end)
				b:SetScript("OnMouseUp", function(self) LuckyCharmsFlares_main:StopMovingOrSizing() end)
	
				local t = _G["LuckyCharm2Flare"..i.."Icon"];
				t:SetTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up");
			end
		end
	end
	LuckyCharms.Flares.SetButtonPoints(LC2_Settings[LC2Profile].FlareBarOrient);
end

function LuckyCharms.Flares.SetButtonPoints(orient)
	if(orient == "h")then
		--Horizontal Orientation
			LuckyCharmsFlares_main:SetWidth(195 + (LC2_Settings[LC2Profile].FlareBarSpacing*8));
			LuckyCharmsFlares_main:SetHeight(30);
			for i=1,9 do
				local b = _G["LuckyCharm2Flare"..i];
				if(b) then
					b:ClearAllPoints();
					if(i==1)then
						b:SetPoint("TOPLEFT", LuckyCharmsFlares_main, "TOPLEFT",5,-5);
					else
						b:SetPoint("LEFT", _G["LuckyCharm2Flare"..i-1], "RIGHT",LC2_Settings[LC2Profile].FlareBarSpacing,0);
					end
				end
			end
		else
			--Vertical Orientation
			LuckyCharmsFlares_main:SetWidth(30);
			LuckyCharmsFlares_main:SetHeight(195 + (LC2_Settings[LC2Profile].FlareBarSpacing*8));
			for i=1,9 do
				local b = _G["LuckyCharm2Flare"..i];
				if(b) then
					b:ClearAllPoints();
					if(i==1)then
						b:SetPoint("TOPLEFT", LuckyCharmsFlares_main, "TOPLEFT",5,-5);
					else
						b:SetPoint("TOP", _G["LuckyCharm2Flare"..i-1], "BOTTOM",0,-LC2_Settings[LC2Profile].FlareBarSpacing);
					end
				end
			end
		end
end

function LuckyCharms.Flares.SetTexCoords()
	for i=1,8 do
		local f = _G["LuckyCharm2Flare"..i.."Icon"];
		if(f)then
			if(i==1)then
				f:SetTexCoord(unpack(BLIP_TEX_COORDS["SHAMAN"]));--Blue Flare
			elseif(i==2)then
				f:SetTexCoord(unpack(BLIP_TEX_COORDS["HUNTER"]));--Green Flare
			elseif(i==3)then
				f:SetTexCoord(unpack(BLIP_TEX_COORDS["WARLOCK"]));--Purple Flare
			elseif(i==4)then
				f:SetTexCoord(unpack(BLIP_TEX_COORDS["DEATHKNIGHT"]));--Red Flare
			elseif(i==5)then
				f:SetTexCoord(unpack(BLIP_TEX_COORDS["ROGUE"]));--Yellow Flare
			elseif(i==6)then
				f:SetTexCoord(unpack(BLIP_TEX_COORDS["DRUID"]));--Orange Flare
			elseif(i==7)then
				f:SetTexCoord(unpack(BLIP_TEX_COORDS["MAGE"]));--Silver Flare
			elseif(i==8)then
				f:SetTexCoord(unpack(BLIP_TEX_COORDS["PRIEST"])); --White Flare
			end
		end
	end
end
