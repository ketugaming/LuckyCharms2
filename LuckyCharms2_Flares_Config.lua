--[[
LuckyCharms2 r41
Last Changed By: KetuSolo
Last Changed: 2012-10-01T18:23:27Z
]]

--Locals
-- local LC2_Realm = GetRealmName(); --Get Realm for Profile.
-- local LC2_Char = UnitName("player"); --Get char name for profile.
-- local LC2Profile = LC2_Realm.." - "..LC2_Char;

-- LuckyCharms.Flares.Config = {};

function LuckyCharms.Flares.Config.OnLoad(panel)
	panel.name = LC2TXT_WMBAR.." "..LC2TXT_CONF;
	panel.parent = "LuckyCharms2";
	InterfaceOptions_AddCategory(panel); 

	LuckyCharmFlaresConfig_Title:SetText(LC2NAME.." "..LC2Version);
	LuckyCharmFlaresConfig_SubTitle:SetText("|cFFFFFFFF"..LC2TXT_WMBAR.." "..LC2TXT_CONF.."|r");
	LuckyCharmFlaresConfig_Scale:SetText(LC2TXT_WMBAR.." "..LC2TXT_SCALE..":\n"..CHAT_DEFAULT..": |cFF4DBD331.0|r");
	LuckyCharmFlaresConfig_Alpha:SetText(LC2TXT_WMBAR.." "..OPACITY..":\n"..CHAT_DEFAULT..": |cFF4DBD331.0|r");
	LuckyCharmFlaresConfig_FlareDisplay:SetText(LC2TXT_WMBAR.." "..DISPLAY..":\n"..CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_AUTO.."|r");
	LuckyCharmFlaresConfig_WMShowText:SetText("|cFFFFFFFF"..LC2TXT_SHOWN.."|r");
	LuckyCharmFlaresConfig_WMHideText:SetText("|cFFFFFFFF"..LC2TXT_HIDDEN.."|r");
	LuckyCharmFlaresConfig_WMAutoText:SetText("|cFFFFFFFF"..LC2TXT_AUTO.."|r");
	LuckyCharmFlaresConfig_FlareOrientation:SetText(LC2TXT_WMBAR.." "..LC2TXT_ORIENTATION..":\n"..CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_HORIZONTAL.."|r");
	LuckyCharmFlaresConfig_WMHorizontalText:SetText("|cFFFFFFFF"..LC2TXT_HORIZONTAL.."|r");
	LuckyCharmFlaresConfig_WMVerticalText:SetText("|cFFFFFFFF"..LC2TXT_VERTICAL.."|r");
	LuckyCharmFlaresConfig_ButtonSpacing:SetText(LC2TXT_WMBAR.." "..LC2TXT_BUTTONSPACING..":\n"..CHAT_DEFAULT..": |cFF4DBD330|r");
end

function LuckyCharms.Flares.Config.WMRadio(status,startup)
	if(status == "show") then
		LuckyCharmFlaresConfig_WMShow:SetChecked(1);
		LuckyCharmFlaresConfig_WMHide:SetChecked(nil);
		LuckyCharmFlaresConfig_WMAuto:SetChecked(nil);
	elseif(status == "hide") then
		LuckyCharmFlaresConfig_WMShow:SetChecked(nil);
		LuckyCharmFlaresConfig_WMHide:SetChecked(1);
		LuckyCharmFlaresConfig_WMAuto:SetChecked(nil);
	else
		LuckyCharmFlaresConfig_WMShow:SetChecked(nil);
		LuckyCharmFlaresConfig_WMHide:SetChecked(nil);
		LuckyCharmFlaresConfig_WMAuto:SetChecked(1);
	end
	if(startup == 0) then
		if(status == "show") then
			LuckyCharmsFlares_main:Show();
		elseif(status == "auto") then
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(not LuckyCharmsFlares_main:IsShown()) then
					LuckyCharmsFlares_main:Show();
				end
			else
				if(LuckyCharmsFlares_main:IsShown()) then
					LuckyCharmsFlares_main:Hide();
				end
			end
		else
			LuckyCharmsFlares_main:Hide();
		end
		LC2_Settings[LC2Profile].wmbarstatus = status;
	end
	--LuckyCharms.Message(LC2_Settings[LC2Profile].wmbarstatus);--Debug
end

function LuckyCharms.Flares.Config.WMRadioOrient(status,startup)
	if(status == "h") then
		LuckyCharmFlaresConfig_WMHorizontal:SetChecked(1);
		LuckyCharmFlaresConfig_WMVertical:SetChecked(nil);
	else
		LuckyCharmFlaresConfig_WMHorizontal:SetChecked(nil);
		LuckyCharmFlaresConfig_WMVertical:SetChecked(1);
	end
	if(startup == 0) then
		LuckyCharms.Flares.SetButtonPoints(status);
		LC2_Settings[LC2Profile].FlareBarOrient = status;
	end
end

function LuckyCharms.Flares.Config.InitScaleSlider(slider)
	slider:SetBackdrop(
		{
			bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
			edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
			tile = true,
			tileEdge = true,
			tileSize = 8,
			edgeSize = 8,
			insets = { left = 3, right = 3, top = 6, bottom = 6 },
		});
	slider:SetValue(LC2_Settings[LC2Profile].FlareBarScale);
end

function LuckyCharms.Flares.Config.InitAlphaSlider(slider)
	slider:SetBackdrop(
		{
			bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
			edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
			tile = true,
			tileEdge = true,
			tileSize = 8,
			edgeSize = 8,
			insets = { left = 3, right = 3, top = 6, bottom = 6 },
		});
	slider:SetValue(LC2_Settings[LC2Profile].FlareBarAlpha);
end

function LuckyCharms.Flares.Config.ModAlpha(value)
	LC2_Settings[LC2Profile].FlareBarAlpha = value;
	LuckyCharmsFlares_main:SetAlpha(value);
	LuckyCharmFlaresConfig_SliderAlpha:SetValue(value);
end

function LuckyCharms.Flares.Config.ModScale(value)
	LC2_Settings[LC2Profile].FlareBarScale = value;
	LuckyCharmsFlares_main:SetScale(value);
	LuckyCharmFlaresConfig_SliderScale:SetValue(value);
end

function LuckyCharms.Flares.Config.SliderScaleChange(slider)
	local sl = _G[slider];
	local newVal = string.format("%.1f",sl:GetValue());
	_G[slider .. "Text"]:SetText(newVal);
	LuckyCharms.Flares.Config.ModScale(newVal);
end

function LuckyCharms.Flares.Config.SliderAlphaChange(slider)
	local sl = _G[slider];
	local newVal = string.format("%.1f",sl:GetValue());
	_G[slider .. "Text"]:SetText(newVal);
	LuckyCharms.Flares.Config.ModAlpha(newVal);
end

--Button spacing slider
function LuckyCharms.Flares.Config.InitSliderButtonSpacing(slider)
	slider:SetBackdrop(
		{
			bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
			edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
			tile = true,
			tileEdge = true,
			tileSize = 8,
			edgeSize = 8,
			insets = { left = 3, right = 3, top = 6, bottom = 6 },
		});
	slider:SetValue(LC2_Settings[LC2Profile].FlareBarSpacing);
end

function LuckyCharms.Flares.Config.SliderButtonSpacingChange(slider)
	local sl = _G[slider];
	local newVal = string.format("%.1f",sl:GetValue());
	_G[slider .. "Text"]:SetText(newVal);
	LC2_Settings[LC2Profile].FlareBarSpacing = newVal;
	--slider:SetValue(newVal);
	LuckyCharms.Flares.SetButtonPoints(LC2_Settings[LC2Profile].FlareBarOrient);
end
--End Button spacing slider
