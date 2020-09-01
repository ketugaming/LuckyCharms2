--[[
LuckyCharms2 r41
Last Changed By: neer
Last Changed: 2012-10-01T18:23:27Z
]]

--Locals
local LC2_Realm = GetRealmName(); --Get Realm for Profile.
local LC2_Char = UnitName("player"); --Get char name for profile.
local LC2Profile = LC2_Realm.." - "..LC2_Char;

LuckyCharms.Config = {};

function LuckyCharms.Config.AncRadio(status,startup)
	if(status == "show") then
		LuckyCharmConfig_AncRadioShow:SetChecked(1);
		LuckyCharmConfig_AncRadioHide:SetChecked(nil);
		LuckyCharmConfig_AncRadioAuto:SetChecked(nil);
	elseif(status == "hide") then
		LuckyCharmConfig_AncRadioShow:SetChecked(nil);
		LuckyCharmConfig_AncRadioHide:SetChecked(1);
		LuckyCharmConfig_AncRadioAuto:SetChecked(nil);
	else
		LuckyCharmConfig_AncRadioShow:SetChecked(nil);
		LuckyCharmConfig_AncRadioHide:SetChecked(nil);
		LuckyCharmConfig_AncRadioAuto:SetChecked(1);
	end
	if(startup == 0) then
		if(status == "show") then
			LuckyCharmAnchorBar:Show();
		elseif(status == "auto") then
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(LuckyCharmAnchorBar:IsShown()~=1) then
					LuckyCharmAnchorBar:Show();
				end
			else
				if(LuckyCharmAnchorBar:IsShown()==1) then
					LuckyCharmAnchorBar:Hide();
				end
			end
		else
			LuckyCharmAnchorBar:Hide();
		end
		LC2_Settings[LC2Profile].ancstatus = status;
	end
end

function LuckyCharms.Config.AncRadioPos(value,startup)
	if (value == "left") then
		LuckyCharmConfig_AncRadioLeft:SetChecked(1);
		LuckyCharmConfig_AncRadioRight:SetChecked(nil);
		LuckyCharmConfig_AncRadioTop:SetChecked(nil);
		LuckyCharmConfig_AncRadioBottom:SetChecked(nil);
	elseif (value=="right") then
		LuckyCharmConfig_AncRadioLeft:SetChecked(nil);
		LuckyCharmConfig_AncRadioRight:SetChecked(1);
		LuckyCharmConfig_AncRadioTop:SetChecked(nil);
		LuckyCharmConfig_AncRadioBottom:SetChecked(nil);
	elseif (value=="top") then
		LuckyCharmConfig_AncRadioLeft:SetChecked(nil);
		LuckyCharmConfig_AncRadioRight:SetChecked(nil);
		LuckyCharmConfig_AncRadioTop:SetChecked(1);
		LuckyCharmConfig_AncRadioBottom:SetChecked(nil);
	else
		LuckyCharmConfig_AncRadioLeft:SetChecked(nil);
		LuckyCharmConfig_AncRadioRight:SetChecked(nil);
		LuckyCharmConfig_AncRadioTop:SetChecked(nil);
		LuckyCharmConfig_AncRadioBottom:SetChecked(1);
	end
	if(startup == 0) then
		LC2_Settings[LC2Profile].ancpos = value;
	end
	LuckyCharms.DrawCharms();
	--LuckyCharms.Config.UpdateKOPosOpt();
end

--Ready Check Options
function LuckyCharms.Config.RCRadio(status,startup)
	if(status == "show") then
		LuckyCharmConfigRC_RCRadioShow:SetChecked(1);
		LuckyCharmConfigRC_RCRadioHide:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioAuto:SetChecked(nil);
	elseif(status == "hide") then
		LuckyCharmConfigRC_RCRadioShow:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioHide:SetChecked(1);
		LuckyCharmConfigRC_RCRadioAuto:SetChecked(nil);
	else
		LuckyCharmConfigRC_RCRadioShow:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioHide:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioAuto:SetChecked(1);
	end
	if(startup == 0)then
		if(status == "show") then
			LCReadyCheck:Show();
		elseif(status == "auto") then
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(LCReadyCheck:IsShown()~=1) then
					LCReadyCheck:Show();
				end
			else
				if(LCReadyCheck:IsShown()==1) then
					LCReadyCheck:Hide();
				end
			end
		else
			LCReadyCheck:Hide();
		end
		LC2_Settings[LC2Profile].rcstatus = status;
	end
end

function LuckyCharms.Config.RCRadioPos(value,startup)
	if (value == "left") then
		LuckyCharmConfigRC_RCRadioLeft:SetChecked(1);
		LuckyCharmConfigRC_RCRadioRight:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioTop:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioBottom:SetChecked(nil);
	elseif (value=="right") then
		LuckyCharmConfigRC_RCRadioLeft:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioRight:SetChecked(1);
		LuckyCharmConfigRC_RCRadioTop:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioBottom:SetChecked(nil);
	elseif (value=="top") then
		LuckyCharmConfigRC_RCRadioLeft:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioRight:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioTop:SetChecked(1);
		LuckyCharmConfigRC_RCRadioBottom:SetChecked(nil);
	else
		LuckyCharmConfigRC_RCRadioLeft:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioRight:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioTop:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioBottom:SetChecked(1);
	end
	if(startup == 0)then
		LuckyCharms.RCAnchor(value);
		LC2_Settings[LC2Profile].rcpos = value;
	end
end
--end Ready Check Options

--Kill Order Options
function LuckyCharms.Config.KORadio(status,startup)
	if(status == "show") then
		LuckyCharmConfigKO_KORadioShow:SetChecked(1);
		LuckyCharmConfigKO_KORadioHide:SetChecked(nil);
		LuckyCharmConfigKO_KORadioAuto:SetChecked(nil);
	elseif(status == "hide") then
		LuckyCharmConfigKO_KORadioShow:SetChecked(nil);
		LuckyCharmConfigKO_KORadioHide:SetChecked(1);
		LuckyCharmConfigKO_KORadioAuto:SetChecked(nil);
	else
		LuckyCharmConfigKO_KORadioShow:SetChecked(nil);
		LuckyCharmConfigKO_KORadioHide:SetChecked(nil);
		LuckyCharmConfigKO_KORadioAuto:SetChecked(1);
	end
	if(startup == 0)then
		if(status == "show") then
			LCKillOrder:Show();
		elseif(status == "auto") then
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(LCKillOrder:IsShown()~=1) then
					LCKillOrder:Show();
				end
			else
				if(LCKillOrder:IsShown()==1) then
					LCKillOrder:Hide();
				end
			end
		else
			LCKillOrder:Hide();
		end
		LC2_Settings[LC2Profile].kostatus = status;
	end
end

function LuckyCharms.Config.KORadioPos(value,startup)
	if (value == "left") then
		LuckyCharmConfigKO_KORadioLeft:SetChecked(1);
		LuckyCharmConfigKO_KORadioRight:SetChecked(nil);
		LuckyCharmConfigKO_KORadioTop:SetChecked(nil);
		LuckyCharmConfigKO_KORadioBottom:SetChecked(nil);
	elseif (value=="right") then
		LuckyCharmConfigKO_KORadioLeft:SetChecked(nil);
		LuckyCharmConfigKO_KORadioRight:SetChecked(1);
		LuckyCharmConfigKO_KORadioTop:SetChecked(nil);
		LuckyCharmConfigKO_KORadioBottom:SetChecked(nil);
	elseif (value=="top") then
		LuckyCharmConfigKO_KORadioLeft:SetChecked(nil);
		LuckyCharmConfigKO_KORadioRight:SetChecked(nil);
		LuckyCharmConfigKO_KORadioTop:SetChecked(1);
		LuckyCharmConfigKO_KORadioBottom:SetChecked(nil);
	else
		LuckyCharmConfigKO_KORadioLeft:SetChecked(nil);
		LuckyCharmConfigKO_KORadioRight:SetChecked(nil);
		LuckyCharmConfigKO_KORadioTop:SetChecked(nil);
		LuckyCharmConfigKO_KORadioBottom:SetChecked(1);
	end
	if(startup == 0)then
		LuckyCharms.Config.KOAnchor(value);
		LC2_Settings[LC2Profile].kopos = value;
	end
end

function LuckyCharms.Config.KORWToggle()
	if(LC2_Settings[LC2Profile].korw == 1) then
		LC2_Settings[LC2Profile].korw = 0;
		LuckyCharmConfigKO_KOcbRW:SetChecked(nil);
	else
		LC2_Settings[LC2Profile].korw = 1;
		LuckyCharmConfigKO_KOcbRW:SetChecked(1);
	end
end

function LuckyCharms.Config.KOPRChatToggle()
	if(LC2_Settings[LC2Profile].kopr == 1) then
		LC2_Settings[LC2Profile].kopr = 0;
		LuckyCharmConfigKO_KOcbPR:SetChecked(nil);
	else
		LC2_Settings[LC2Profile].kopr = 1;
		LuckyCharmConfigKO_KOcbPR:SetChecked(1);
	end
end

function LuckyCharms.Config.KOCCToggle()
	if(LC2_Settings[LC2Profile].kocc == 1) then
		LC2_Settings[LC2Profile].kocc = 0;
		LuckyCharmConfigKO_KOCCRW:SetChecked(nil);
	else
		LC2_Settings[LC2Profile].kocc = 1;
		LuckyCharmConfigKO_KOCCRW:SetChecked(1);
	end
end

function LuckyCharms.Config.KOPrintToggle()
	if(LC2_Settings[LC2Profile].koprint == 1) then
		LC2_Settings[LC2Profile].koprint = 0;
		LuckyCharmConfigKO_KOPrintCheck:SetChecked(nil);
	else
		LC2_Settings[LC2Profile].koprint = 1;
		LuckyCharmConfigKO_KOPrintCheck:SetChecked(1);
	end
end
--end Kill Order Options

function LuckyCharms.Config.TTRadio(tips,startup)
	if(tips == 1) then
		LuckyCharmConfig_RadioTTEnable:SetChecked(1);
		LuckyCharmConfig_RadioTTDisable:SetChecked(nil);
	elseif(tips == 0) then
		LuckyCharmConfig_RadioTTEnable:SetChecked(nil);
		LuckyCharmConfig_RadioTTDisable:SetChecked(1);
	end
	if(startup == 0) then
		LC2_Settings[LC2Profile].tooltips = tips;
	end
end
--End Configuration Window

--Ready Check Configuration
function LuckyCharms.Config.RCOnLoad(panel)
		panel.name = READY_CHECK.." "..LC2TXT_CONF;
		panel.parent = "LuckyCharms2"; 
		panel.default = function(self)
			LuckyCharms.Config.ResetRC();
		end  
		InterfaceOptions_AddCategory(panel); 
		
		LuckyCharmConfigRCTitle:SetText(LC2NAME.." "..LC2Version);
		LuckyCharmConfigRCSubTitle:SetText("|cFFFFFFFF"..READY_CHECK.." "..LC2TXT_CONF.."|r");
		--Ready Check button
		LuckyCharmConfigRCDisplay:SetText(READY_CHECKB.." "..DISPLAY..":");
		LuckyCharmConfigRCDisplayDefault:SetText(CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_AUTO.."|r");
		LuckyCharmConfigRCDisplayPos:SetText(READY_CHECKB.." "..LC2TXT_POSITION..":");
		LuckyCharmConfigRCDisplayPosDefault:SetText(CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_TOP.."|r");
		LuckyCharmConfigRC_RCRadioShowText:SetText("|cFFFFFFFF"..LC2TXT_SHOWN.."|r");
		LuckyCharmConfigRC_RCRadioHideText:SetText("|cFFFFFFFF"..LC2TXT_HIDDEN.."|r");
		LuckyCharmConfigRC_RCRadioAutoText:SetText("|cFFFFFFFF"..LC2TXT_AUTO.."|r");
		LuckyCharmConfigRC_RCRadioLeftText:SetText("|cFFFFFFFF"..LC2TXT_LEFT.."|r");
		LuckyCharmConfigRC_RCRadioRightText:SetText("|cFFFFFFFF"..LC2TXT_RIGHT.."|r");
		LuckyCharmConfigRC_RCRadioTopText:SetText("|cFFFFFFFF"..LC2TXT_TOP.."|r");
		LuckyCharmConfigRC_RCRadioBottomText:SetText("|cFFFFFFFF"..LC2TXT_BOTTOM.."|r");
end
--end Radio Check Configuration

function LuckyCharms.Config.InitSlider(slider)
	slider:SetValue(LC2_Settings[LC2Profile].barscale);
end

function LuckyCharms.Config.InitAlphaSlider(slider)
	slider:SetValue(LC2_Settings[LC2Profile].alpha);
end

function LuckyCharms.Config.SliderChange(slider)
	local sl = _G[slider];
	local newVal = string.format("%.1f",sl:GetValue());
	_G[slider .. "Text"]:SetText(newVal);
	LuckyCharms.Config.ModScale(newVal);
end

function LuckyCharms.Config.SliderAlphaChange(slider)
	local sl = _G[slider];
	local newVal = string.format("%.1f",sl:GetValue());
	_G[slider .. "Text"]:SetText(newVal);
	LuckyCharms.Config.ModAlpha(newVal);
end

function LuckyCharms.Config.Radio(status,startup)
	if(status == "show") then
		LuckyCharmConfig_RadioShow:SetChecked(1);
		LuckyCharmConfig_RadioHide:SetChecked(nil);
		LuckyCharmConfig_RadioAuto:SetChecked(nil);
	elseif(status == "hide") then
		LuckyCharmConfig_RadioShow:SetChecked(nil);
		LuckyCharmConfig_RadioHide:SetChecked(1);
		LuckyCharmConfig_RadioAuto:SetChecked(nil);
	else
		LuckyCharmConfig_RadioShow:SetChecked(nil);
		LuckyCharmConfig_RadioHide:SetChecked(nil);
		LuckyCharmConfig_RadioAuto:SetChecked(1);
	end
	if(startup == 0) then
		if(status == "show") then
			LuckyCharmBar:Show();
		elseif(status == "auto") then
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(LuckyCharmBar:IsShown()~=1) then
					LuckyCharmBar:Show();
				end
			else
				if(LuckyCharmBar:IsShown()==1) then
					LuckyCharmBar:Hide();
				end
			end
		else
			LuckyCharmBar:Hide();
		end
		LC2_Settings[LC2Profile].barstatus = status;
	end
end

--Start of Configuration Window
function LuckyCharms.Config.OnLoad(panel)
	panel.name = "LuckyCharms2"; 
	panel.default = function(self)
		LuckyCharms.Config.ResetMain();
	end
	InterfaceOptions_AddCategory(panel); 

	LuckyCharmConfigTitle:SetText(LC2NAME.." "..LC2Version);
	LuckyCharmConfigSubTitle:SetText("|cFFFFFFFF"..LC2TXT_GENERAL.." "..LC2TXT_CONF.."|r");
	LuckyCharmConfigScale:SetText(LC2TXT_CBAR.." "..LC2TXT_SCALE..":\n"..CHAT_DEFAULT..": |cFF4DBD331.0|r");
	LuckyCharmConfigAlpha:SetText(LC2TXT_CBAR.." "..OPACITY..":\n"..CHAT_DEFAULT..": |cFF4DBD331.0|r");
	LuckyCharmConfigDisplay:SetText(LC2TXT_CBAR.." "..DISPLAY..":\n"..CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_AUTO.."|r");
	LuckyCharmConfigToolTips:SetText(LC2TXT_CBAR.." "..LC2TXT_TOOLTIPS..":\n"..CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_ENABLED.."|r");
	
	LuckyCharmConfig_RadioShowText:SetText("|cFFFFFFFF"..LC2TXT_SHOWN.."|r");
	LuckyCharmConfig_RadioHideText:SetText("|cFFFFFFFF"..LC2TXT_HIDDEN.."|r");
	LuckyCharmConfig_RadioAutoText:SetText("|cFFFFFFFF"..LC2TXT_AUTO.."|r");
	--Tooltips
	LuckyCharmConfig_RadioTTEnableText:SetText("|cFFFFFFFF"..LC2TXT_ENABLED.."|r");
	LuckyCharmConfig_RadioTTDisableText:SetText("|cFFFFFFFF"..ADDON_DISABLED.."|r");
	--Anchor Bar
	LuckyCharmConfigAncDisplay:SetText(LC2TXT_ANCHOR.." "..DISPLAY..":\n"..CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_SHOWN.."|r");
	--LuckyCharmConfigAncDisplayDefault:SetText(CHAT_DEFAULT..": "..LC2TXT_SHOWN);
	LuckyCharmConfig_AncRadioShowText:SetText("|cFFFFFFFF"..LC2TXT_SHOWN.."|r");
	LuckyCharmConfig_AncRadioHideText:SetText("|cFFFFFFFF"..LC2TXT_HIDDEN.."|r");
	LuckyCharmConfig_AncRadioAutoText:SetText("|cFFFFFFFF"..LC2TXT_AUTO.."|r");
	LuckyCharmConfigDisplayPos:SetText(LC2TXT_CBAR.." "..LC2TXT_POSITION..":\n"..CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_LEFT.."|r");
	--LuckyCharmConfigDisplayPosDefault:SetText(CHAT_DEFAULT..": "..LC2TXT_LEFT.."|r");
	LuckyCharmConfig_AncRadioLeftText:SetText("|cFFFFFFFF"..LC2TXT_LEFT.."|r");
	LuckyCharmConfig_AncRadioRightText:SetText("|cFFFFFFFF"..LC2TXT_RIGHT.."|r");
	LuckyCharmConfig_AncRadioTopText:SetText("|cFFFFFFFF"..LC2TXT_TOP.."|r");
	LuckyCharmConfig_AncRadioBottomText:SetText("|cFFFFFFFF"..LC2TXT_BOTTOM.."|r");
	LuckyCharmConfigProfile:SetText(LC2TXT_PROFILE..":");
end

--Kill Order Configuration
function LuckyCharms.Config.KillOrderLoad(panel)
	panel.name = LC2TXT_KILLORDER.." "..LC2TXT_CONF;
	panel.parent = "LuckyCharms2"; 
	InterfaceOptions_AddCategory(panel);
	
	LuckyCharmConfigKOTitle:SetText(LC2NAME.." "..LC2Version);
	LuckyCharmConfigKOSubTitle:SetText("|cFFFFFFFF"..LC2TXT_KILLORDER.." "..LC2TXT_CONF.."|r");
	LuckyCharmConfigKODisplay:SetText(LC2TXT_KOFRAME.." "..DISPLAY..":");
	LuckyCharmConfigKODisplayDefault:SetText(CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_AUTO.."|r");
	LuckyCharmConfigKODisplayPos:SetText(LC2TXT_KOFRAME.." "..LC2TXT_POSITION..":");
	LuckyCharmConfigKODisplayPosDefault:SetText(CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_TOP.."|r");
	LuckyCharmConfigKO_KORadioShowText:SetText("|cFFFFFFFF"..LC2TXT_SHOWN.."|r");
	LuckyCharmConfigKO_KORadioHideText:SetText("|cFFFFFFFF"..LC2TXT_HIDDEN.."|r");
	LuckyCharmConfigKO_KORadioAutoText:SetText("|cFFFFFFFF"..LC2TXT_AUTO.."|r");
	--LuckyCharms.Message(ancpos);
	LuckyCharmConfigKO_KORadioLeftText:SetText("|cFFFFFFFF"..LC2TXT_LEFT.."|r");
	LuckyCharmConfigKO_KORadioRightText:SetText("|cFFFFFFFF"..LC2TXT_RIGHT.."|r");
	LuckyCharmConfigKO_KORadioTopText:SetText("|cFFFFFFFF"..LC2TXT_TOP.."|r");
	LuckyCharmConfigKO_KORadioBottomText:SetText("|cFFFFFFFF"..LC2TXT_BOTTOM.."|r");
	
	LuckyCharmConfigKOKOPRChat:SetText(LC2Txt_KOPR..":");
	LuckyCharmConfigKORaidWarning:SetText(LC2Txt_KORaidWarning..":");
	LuckyCharmConfigKOCCDisplay:SetText(LC2TXT_CCWITHRW..":");
	LuckyCharmConfigKOKOPrint:SetText(LC2TXT_PRINTKO..":");
	
	LuckyCharmConfigKONoteMode:SetText(LC2TXT_KONOTIFICATIONMODE..":");
	
	LuckyCharmConfigKO_LC1TxtDis:SetText(LC2TXT_ENABLED..":");
	LuckyCharmConfigKO_LC2TxtDis:SetText(LC2TXT_ENABLED..":");
	LuckyCharmConfigKO_LC3TxtDis:SetText(LC2TXT_ENABLED..":");
	LuckyCharmConfigKO_LC4TxtDis:SetText(LC2TXT_ENABLED..":");
	LuckyCharmConfigKO_LC5TxtDis:SetText(LC2TXT_ENABLED..":");
	LuckyCharmConfigKO_LC6TxtDis:SetText(LC2TXT_ENABLED..":");
	LuckyCharmConfigKO_LC7TxtDis:SetText(LC2TXT_ENABLED..":");
	LuckyCharmConfigKO_LC8TxtDis:SetText(LC2TXT_ENABLED..":");
end

function LuckyCharms.Config.UpdateCharmStatus(charmNum, btnRef)
	local lc = _G["LuckyCharm"..charmNum];
	if(LC2_Settings[LC2Profile].charmStatus[charmNum] == 1) then
		LC2_Settings[LC2Profile].charmStatus[charmNum] = 0;
		btnRef:SetChecked(nil);
	else
		LC2_Settings[LC2Profile].charmStatus[charmNum] = 1;
		btnRef:SetChecked(1);
	end
	LuckyCharms.DrawCharms();
	LuckyCharms.SetTexCoords();
end

function LuckyCharms.Config.UpdateKOPosOpt()
	--LuckyCharms.Message(LC2_Settings[LC2Profile].ancpos);
	--LuckyCharms.Message(LC2_Settings[LC2Profile].kopos);
	if(LC2_Settings[LC2Profile].ancpos == "left" or LC2_Settings[LC2Profile].ancpos == "right") then
		LuckyCharmConfigKO_KORadioLeft:Hide();
		LuckyCharmConfigKO_KORadioRight:Hide();
		LuckyCharmConfigKO_KORadioTop:Show();
		LuckyCharmConfigKO_KORadioBottom:Show();
	else
		LuckyCharmConfigKO_KORadioTop:Hide();
		LuckyCharmConfigKO_KORadioBottom:Hide();
		LuckyCharmConfigKO_KORadioLeft:Show();
		LuckyCharmConfigKO_KORadioRight:Show();
	end
end

function LuckyCharms.Config.KONoteModeDD_Initialise(self)
	--[[
	--level = level or 1 --drop down menus can have sub menus. The value of "level" determines the drop down sub menu tier.
	local info = UIDropDownMenu_CreateInfo();
	info.text = "First Menu Item"; --the text of the menu item
	info.value = 0; -- the value of the menu item. This can be a string also.
	info.func = function() MyDropDownMenuItem_OnClick() end; --sets the function to execute when this item is clicked
	info.owner = self:GetParent(); --binds the drop down menu as the parent of the menu item. This is very important for dynamic drop down menues.
	info.checked = nil; --initially set the menu item to being unchecked with a yellow tick
	info.icon = nil; --we can use this to set an icon for the drop down menu item to accompany the text
	UIDropDownMenu_AddButton(info, level); --Adds the new button to the drop down menu specified in the UIDropDownMenu_Initialise function. In this case, it's MyDropDownMenu
]]
	local info = UIDropDownMenu_CreateInfo();
	
	info.text = LC2TXT_KOICONS;
	info.value = "icons";
	info.func = function() LuckyCharms.Config.KONoteModeDD_OnClick(self, "icons") end;
	info.owner = self:GetParent();
	info.checked = nil;
	info.icon = nil;
	UIDropDownMenu_AddButton(info, 1);
	
	info.text = LC2TXT_KOTEXT;
	info.value = "text";
	info.func = function() LuckyCharms.Config.KONoteModeDD_OnClick(self, "text") end;
	info.owner = self:GetParent();
	info.checked = nil;
	info.icon = nil;
	UIDropDownMenu_AddButton(info, 1);
end

function LuckyCharms.Config.KONoteModeDD_OnClick(self, arg1)
	--LuckyCharms.Message(arg1);
	UIDropDownMenu_SetSelectedValue(self, arg1);
  LC2_Settings[LC2Profile].komode = arg1;
end

function LuckyCharms.Config.KOLCFind(charm)
	local order = nil;
	for i=1, 8 do
		if(LC2_Settings[LC2Profile].korder[i] == charm) then
			order = i;
		end
	end
	return order;
end

function LuckyCharms.Config.KOLCDD_Initialise(self)
	local info = UIDropDownMenu_CreateInfo();
	for i=1, 8 do
		info.text = i;
		info.value = i;
		info.func = function() LuckyCharms.Config.KOLCDD_OnClick(self,i) end;
		info.owner = self:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, 1);
	end
end

function LuckyCharms.Config.KOLCDD_OnClick(self,arg1)
	UIDropDownMenu_SetSelectedValue(self, arg1);
	local temp = nil;
	if(self == KOLC1DD) then
		temp = LC2_Settings[LC2Profile].korder[arg1];
		LC2_Settings[LC2Profile].korder[LuckyCharms.Config.KOLCFind(1)] = temp;
		LC2_Settings[LC2Profile].korder[arg1] = 1;
	elseif(self == KOLC2DD) then
		temp = LC2_Settings[LC2Profile].korder[arg1];
		LC2_Settings[LC2Profile].korder[LuckyCharms.Config.KOLCFind(2)] = temp;
		LC2_Settings[LC2Profile].korder[arg1] = 2;
	elseif(self == KOLC3DD) then
		temp = LC2_Settings[LC2Profile].korder[arg1];
		LC2_Settings[LC2Profile].korder[LuckyCharms.Config.KOLCFind(3)] = temp;
		LC2_Settings[LC2Profile].korder[arg1] = 3;
	elseif(self == KOLC4DD) then
		temp = LC2_Settings[LC2Profile].korder[arg1];
		LC2_Settings[LC2Profile].korder[LuckyCharms.Config.KOLCFind(4)] = temp;
		LC2_Settings[LC2Profile].korder[arg1] = 4;
	elseif(self == KOLC5DD) then
		temp = LC2_Settings[LC2Profile].korder[arg1];
		LC2_Settings[LC2Profile].korder[LuckyCharms.Config.KOLCFind(5)] = temp;
		LC2_Settings[LC2Profile].korder[arg1] = 5;
	elseif(self == KOLC6DD) then
		temp = LC2_Settings[LC2Profile].korder[arg1];
		LC2_Settings[LC2Profile].korder[LuckyCharms.Config.KOLCFind(6)] = temp;
		LC2_Settings[LC2Profile].korder[arg1] = 6;
	elseif(self == KOLC7DD) then
		temp = LC2_Settings[LC2Profile].korder[arg1];
		LC2_Settings[LC2Profile].korder[LuckyCharms.Config.KOLCFind(7)] = temp;
		LC2_Settings[LC2Profile].korder[arg1] = 7;
	elseif(self == KOLC8DD) then
		temp = LC2_Settings[LC2Profile].korder[arg1];
		LC2_Settings[LC2Profile].korder[LuckyCharms.Config.KOLCFind(8)] = temp;
		LC2_Settings[LC2Profile].korder[arg1] = 8;
	end
	LuckyCharms.Config.KOLCUpdate();
end

function LuckyCharms.Config.KOLCUpdate()
	UIDropDownMenu_SetSelectedValue(KOLC1DD, LuckyCharms.Config.KOLCFind(1));
	UIDropDownMenu_SetSelectedValue(KOLC2DD, LuckyCharms.Config.KOLCFind(2));
	UIDropDownMenu_SetSelectedValue(KOLC3DD, LuckyCharms.Config.KOLCFind(3));
	UIDropDownMenu_SetSelectedValue(KOLC4DD, LuckyCharms.Config.KOLCFind(4));
	UIDropDownMenu_SetSelectedValue(KOLC5DD, LuckyCharms.Config.KOLCFind(5));
	UIDropDownMenu_SetSelectedValue(KOLC6DD, LuckyCharms.Config.KOLCFind(6));
	UIDropDownMenu_SetSelectedValue(KOLC7DD, LuckyCharms.Config.KOLCFind(7));
	UIDropDownMenu_SetSelectedValue(KOLC8DD, LuckyCharms.Config.KOLCFind(8));
	LuckyCharms.DrawCharms();
end
--end Kill Order Configuration

function LuckyCharms.Config.KOAnchor(New_kopos)
	--LuckyCharms.Message(New_kopos);
	LCKillOrder:ClearAllPoints();
	LCKOButton:ClearAllPoints();
	if(New_kopos == "left") then
		LCKillOrder:SetPoint("TOPRIGHT","LuckyCharmBar","TOPLEFT",2,0);
		if(LC2_Settings[LC2Profile].ancpos == "bottom") then
			LCKOButton:SetPoint("BOTTOM","LCKillOrder","BOTTOM",0,14);
		else
			LCKOButton:SetPoint("TOPRIGHT","LCKillOrder","TOPRIGHT",-4,-13);
		end
	elseif(New_kopos == "right") then
		LCKillOrder:SetPoint("TOPLEFT","LuckyCharmBar","TOPRIGHT",-4,0);
		if(LC2_Settings[LC2Profile].ancpos == "bottom") then
			LCKOButton:SetPoint("BOTTOM","LCKillOrder","BOTTOM",2,14);
		else
			LCKOButton:SetPoint("TOPRIGHT","LCKillOrder","TOPRIGHT",4,-13);
		end
	elseif(New_kopos == "top") then
		LCKillOrder:SetPoint("BOTTOMLEFT","LuckyCharmBar","TOPLEFT",0,-2);
		if(LC2_Settings[LC2Profile].ancpos == "right") then
			LCKOButton:SetPoint("TOPLEFT","LCKillOrder","TOPLEFT",14,-2);
		else
			LCKOButton:SetPoint("TOPRIGHT","LCKillOrder","TOPRIGHT",-14,-2);
		end
	else
		LCKillOrder:SetPoint("TOPLEFT","LuckyCharmBar","BOTTOMLEFT",0,2);
		if(LC2_Settings[LC2Profile].ancpos == "right") then
			LCKOButton:SetPoint("TOPLEFT","LCKillOrder","TOPLEFT",14,-2);
		else
			LCKOButton:SetPoint("TOPRIGHT","LCKillOrder","TOPRIGHT",-14,-2);
		end
	end
	LC2_Settings[LC2Profile].kopos = New_kopos;
	LuckyCharms.Config.KORadioPos(New_kopos,1);
	LuckyCharms.KOCTextPos(New_kopos);
end

--Initialize Profile Drop Down Menu
function LuckyCharms.Config.ConfProfileDD_Init(self)
	local info = UIDropDownMenu_CreateInfo();
	for key, subarray in pairs(LC2_Settings) do
    info.text = key;
    info.value = key;
    info.checked = nil;
    info.owner = self:GetParent();
		info.icon = nil;
    info.func = function() LuckyCharms.Config.ConfProfileDD_OnClick(self,key) end;
    UIDropDownMenu_AddButton(info, 1);
	end -- for key, subarray
end
--Profile Drop Down On Click.  Copy to current character.
function LuckyCharms.Config.ConfProfileDD_OnClick(self,arg1)
	LuckyCharms.Config.deepCopy(LC2_Settings[arg1],LC2_Settings[LC2Profile]);
	LuckyCharms.Config.Reload(arg1);
end
--Copy tables, taken from Gatherer Addon
function LuckyCharms.Config.deepCopy( source, dest )
	for k, v in pairs(source) do
		if ( type(v) == "table" ) then
			if not ( type(dest[k]) == "table" ) then
				dest[k] = {}
			end
			LuckyCharms.Config.deepCopy(v, dest[k])
		else
			dest[k] = v
		end
	end
end

--Used for loading exsisting profiles
function LuckyCharms.Config.Reload(profile)
	--Setup UI
	LuckyCharms.Config.ModScale(LC2_Settings[LC2Profile].barscale);
	LuckyCharms.Config.InitSlider(LuckyCharmConfig_Slider1);
	LuckyCharms.Config.InitAlphaSlider(LuckyCharmConfig_SliderAlpha);
	if (LC2_Settings[LC2Profile].barstatus == "show") then
		LuckyCharmBar:Show();
	else
				LuckyCharmBar:Hide();
			end
			if(LC2_Settings[LC2Profile].ancstatus == "show") then
				LuckyCharmAnchorBar:Show();
			else
				LuckyCharmAnchorBar:Hide();
			end
			if(LC2_Settings[LC2Profile].rcstatus == "show") then
				LCReadyCheck:Show();
			else
				LCReadyCheck:Hide();
			end
			if(LC2_Settings[LC2Profile].kostatus == "show") then
				LCKillOrder:Show();
			else
				LCKillOrder:Hide();
			end
			LuckyCharms.Config.ModAlpha(LC2_Settings[LC2Profile].alpha);
			--LuckyCharms.BarAnchor(LC2_Settings[LC2Profile].ancpos);
			LuckyCharms.RCAnchor(LC2_Settings[LC2Profile].rcpos);
			LuckyCharms.Config.KOAnchor(LC2_Settings[LC2Profile].kopos);
			LuckyCharms.Config.Radio(LC2_Settings[LC2Profile].barstatus,1);
			LuckyCharms.Config.AncRadio(LC2_Settings[LC2Profile].ancstatus,1);
			LuckyCharms.Config.AncRadioPos(LC2_Settings[LC2Profile].ancpos,1);
			LuckyCharms.Config.TTRadio(LC2_Settings[LC2Profile].tooltips,1);
			LuckyCharms.Config.RCRadio(LC2_Settings[LC2Profile].rcstatus,1);
			LuckyCharms.Config.RCRadioPos(LC2_Settings[LC2Profile].rcpos,1);
			LuckyCharms.Config.KORadio(LC2_Settings[LC2Profile].kostatus,1);
			LuckyCharms.Flares.Config.WMRadio(LC2_Settings[LC2Profile].wmbarstatus,1);
			
			--Set Check Boxes on KO Config
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
			
			LuckyCharms.DrawCharms();
			
			LCRCButton:SetText(READY_CHECKABBRV);
			LCKOButton:SetText(LC2TXT_KOABBRV);
			LuckyCharms.Config.InitConfigDropDowns();
			LuckyCharms.UpdateCCAssignments();
			LuckyCharms.InitCCButtons();
			LuckyCharms.Message(LC2TXT_PROFILECOPIED..": "..profile);
end

function LuckyCharms.Config.InitConfigDropDowns()
	KOLC1DD = CreateFrame("Frame", "KOLC1DD", LuckyCharmConfigKO, "UIDropDownMenuTemplate"); 
	KOLC1DD:SetPoint("TOP","LuckyCharmConfigKO_LC1","BOTTOM",0,0);
	UIDropDownMenu_SetWidth(KOLC1DD, 35);
	UIDropDownMenu_Initialize(KOLC1DD, LuckyCharms.Config.KOLCDD_Initialise);
	UIDropDownMenu_SetSelectedValue(KOLC1DD, LuckyCharms.Config.KOLCFind(1));
	
	KOLC2DD = CreateFrame("Frame", "KOLC2DD", LuckyCharmConfigKO, "UIDropDownMenuTemplate"); 
	KOLC2DD:SetPoint("TOP","LuckyCharmConfigKO_LC2","BOTTOM",0,0);
	UIDropDownMenu_SetWidth(KOLC2DD, 35);
	UIDropDownMenu_Initialize(KOLC2DD, LuckyCharms.Config.KOLCDD_Initialise);
	UIDropDownMenu_SetSelectedValue(KOLC2DD, LuckyCharms.Config.KOLCFind(2));
	
	KOLC3DD = CreateFrame("Frame", "KOLC3DD", LuckyCharmConfigKO, "UIDropDownMenuTemplate"); 
	KOLC3DD:SetPoint("TOP","LuckyCharmConfigKO_LC3","BOTTOM",0,0);
	UIDropDownMenu_SetWidth(KOLC3DD, 35);
	UIDropDownMenu_Initialize(KOLC3DD, LuckyCharms.Config.KOLCDD_Initialise);
	UIDropDownMenu_SetSelectedValue(KOLC3DD, LuckyCharms.Config.KOLCFind(3));
	
	KOLC4DD = CreateFrame("Frame", "KOLC4DD", LuckyCharmConfigKO, "UIDropDownMenuTemplate"); 
	KOLC4DD:SetPoint("TOP","LuckyCharmConfigKO_LC4","BOTTOM",0,0);
	UIDropDownMenu_SetWidth(KOLC4DD, 35);
	UIDropDownMenu_Initialize(KOLC4DD, LuckyCharms.Config.KOLCDD_Initialise);
	UIDropDownMenu_SetSelectedValue(KOLC4DD, LuckyCharms.Config.KOLCFind(4));
	
	KOLC5DD = CreateFrame("Frame", "KOLC5DD", LuckyCharmConfigKO, "UIDropDownMenuTemplate"); 
	KOLC5DD:SetPoint("TOP","LuckyCharmConfigKO_LC5","BOTTOM",0,0);
	UIDropDownMenu_SetWidth(KOLC5DD, 35);
	UIDropDownMenu_Initialize(KOLC5DD, LuckyCharms.Config.KOLCDD_Initialise);
	UIDropDownMenu_SetSelectedValue(KOLC5DD, LuckyCharms.Config.KOLCFind(5));
	
	KOLC6DD = CreateFrame("Frame", "KOLC6DD", LuckyCharmConfigKO, "UIDropDownMenuTemplate"); 
	KOLC6DD:SetPoint("TOP","LuckyCharmConfigKO_LC6","BOTTOM",0,0);
	UIDropDownMenu_SetWidth(KOLC6DD, 35);
	UIDropDownMenu_Initialize(KOLC6DD, LuckyCharms.Config.KOLCDD_Initialise);
	UIDropDownMenu_SetSelectedValue(KOLC6DD, LuckyCharms.Config.KOLCFind(6));
	
	KOLC7DD = CreateFrame("Frame", "KOLC7DD", LuckyCharmConfigKO, "UIDropDownMenuTemplate"); 
	KOLC7DD:SetPoint("TOP","LuckyCharmConfigKO_LC7","BOTTOM",0,0);
	UIDropDownMenu_SetWidth(KOLC7DD, 35);
	UIDropDownMenu_Initialize(KOLC7DD, LuckyCharms.Config.KOLCDD_Initialise);
	UIDropDownMenu_SetSelectedValue(KOLC7DD, LuckyCharms.Config.KOLCFind(7));
	
	KOLC8DD = CreateFrame("Frame", "KOLC8DD", LuckyCharmConfigKO, "UIDropDownMenuTemplate"); 
	KOLC8DD:SetPoint("TOP","LuckyCharmConfigKO_LC8","BOTTOM",0,0);
	UIDropDownMenu_SetWidth(KOLC8DD, 35);
	UIDropDownMenu_Initialize(KOLC8DD, LuckyCharms.Config.KOLCDD_Initialise);
	UIDropDownMenu_SetSelectedValue(KOLC8DD, LuckyCharms.Config.KOLCFind(8));
	
	KONoteModeDD = CreateFrame("Frame", "KONoteModeDD", LuckyCharmConfigKO, "UIDropDownMenuTemplate"); 
	KONoteModeDD:SetPoint("LEFT","LuckyCharmConfigKONoteMode","RIGHT",-15,-4);
	UIDropDownMenu_SetWidth(KONoteModeDD, 80);
	UIDropDownMenu_Initialize(KONoteModeDD, LuckyCharms.Config.KONoteModeDD_Initialise);
	UIDropDownMenu_SetSelectedValue(KONoteModeDD, LC2_Settings[LC2Profile].komode);
	
	ConfProfileDD = CreateFrame("Frame", "ConfProfileDD", LuckyCharmConfig, "UIDropDownMenuTemplate"); 
	ConfProfileDD:SetPoint("LEFT","LuckyCharmConfigProfile","RIGHT",-15,-4);
	UIDropDownMenu_SetWidth(ConfProfileDD, 200);
	UIDropDownMenu_Initialize(ConfProfileDD, LuckyCharms.Config.ConfProfileDD_Init);
	UIDropDownMenu_SetSelectedValue(ConfProfileDD, LC2Profile);
end

function LuckyCharms.Config.Upgrade()
		--[[
		LuckyCharms.Message("Enter Upgrade");--Debug
		LuckyCharms.Message("Prev"..PrevSettVer);--Debug
		LuckyCharms.Message("Curr"..LC2SettVer);--Debug
		]]
	if(PrevSettVer ~= LC2SettVer)then
		LuckyCharms.Message(LC2TXT_UPGRADESETTINGS..": "..LC2SettVer);
		--Upgrade Settings
		LC2_Settings[LC2Profile].SettVer = LC2SettVer;
		PrevSettVer = LC2SettVer;
		--Upgrade charmcc
		LC2_Settings[LC2Profile].charmcc={};
		for i=1, 8 do
				LC2_Settings[LC2Profile].charmcc[i] = { ["name"] = ""; ["icon"] = ""; };
		end
		--Upgrade ButtonFacade Settings
		LC2_Settings[LC2Profile].BtnFacade = {};
		LC2_Settings[LC2Profile].BtnFacade.dbinit = 0;
	end
end

function LuckyCharms.Config.ResetMain()
	LuckyCharmAnchor:ClearAllPoints();
	LuckyCharmAnchor:SetPoint("TOPLEFT",100,-100);
	LuckyCharms.Config.Radio("auto",0);
	LuckyCharms.Flares.Config.WMRadio("auto",0);
	LuckyCharms.Config.TTRadio(1,0);
	LuckyCharms.Config.AncRadio("show",0);
	LuckyCharms.Config.AncRadioPos("left",0);
	LuckyCharms.Config.ModScale(1.0);
	LuckyCharms.Config.ModAlpha(1.0);
	LuckyCharms.Config.ResetRC();
	LC2_Settings[LC2Profile].locked = 0;
	LCBDragButtonIcon:SetTexture(unlockImage);
	LuckyCharms.DrawCharms();
	LuckyCharms.Message(LC2M_DEFAULTS);
end

function LuckyCharms.Config.ResetRC()
	LuckyCharms.Config.RCRadioPos("top",0);
	LuckyCharms.Config.RCRadio("auto",0);
end

function LuckyCharms.Config.ModAlpha(value)
	LC2_Settings[LC2Profile].alpha = value;
	LuckyCharmAnchor:SetAlpha(value);
	LuckyCharmConfig_SliderAlpha:SetValue(value);
end

function LuckyCharms.Config.ModScale(value)
	LC2_Settings[LC2Profile].barscale = value;
	LuckyCharmAnchor:SetScale(value);
	_G["LuckyCharmConfig_Slider1"]:SetValue(value);
end
