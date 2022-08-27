INEED_options = {
	["showProgress"] = true,
	["showSuccess"] = true,
	["audibleSuccess"] = true,
	["doEmote"] = true,
	["emote"] = "CHEER",
	["showGlobal"] = true,
	["barCount"] = 6,
	["hideInCombat"] = true,
	["displayUIList"] = true,
	["displayUIListDisplaySeconds"] = 300, -- 5 minute default
	["autoRepair"] = true,
	["fillBars"] = true,
	["displayUIListFillbarsSeconds"] = 300, -- show filled bars for another 5 minutes
}

function INEED.OptionsPanel_OnLoad(panel)
	panel.name = "INeed";
	INEEDOptionsFrame_Title:SetText(INEED_MSG_ADDONNAME.." "..INEED_MSG_VERSION);
	--panel.parent=""
	panel.okay = INEED.OptionsPanel_OKAY;
	panel.cancel = INEED.OptionsPanel_Cancel;
	--panel.default = FB.OptionsPanel_Default;
	panel.refresh = INEED.OptionsPanel_Refresh;

	InterfaceOptions_AddCategory(panel);
	InterfaceAddOnsList_Update();
	--FB.OptionsPanel_TrackPeriodSlider_OnLoad()
end
function INEED.OptionsPanel_Reset()
	-- Called from Addon_Loaded
	INEED.OptionsPanel_Refresh()
end
function INEED.OptionsPanel_OKAY()
	-- Data was recorded, clear the temp
	INEED.oldValues = nil
end
function INEED.OptionsPanel_Cancel()
	-- reset to temp and update the UI
	if INEED.oldValues then
		for key,val in pairs(INEED.oldValues) do
			--FB.Print(key..":"..val);
			INEED_options[key] = val;
		end
	end
	INEED.oldValues = nil;
end

function INEED.OptionsPanel_Refresh()
	-- Called when options panel is opened.
--	INEEDOptionsFrame_ShowProgress:SetChecked(INEED_options["showProgress"])
--	INEEDOptionsFrame_AlertOnSuccess:SetChecked(INEED_options["showSuccess"])
--	INEEDOptionsFrame_AudibleAlert:SetChecked(INEED_options["audibleSuccess"])
--	INEEDOptionsFrame_DoEmote:SetChecked(INEED_options["doEmote"])
--	INEEDOptionsFrame_PlaySound:SetChecked(INEED_options["playSoundFile"])

	INEEDOptionsFrame_DoEmoteEditBox:SetText(INEED_options["emote"])
	INEEDOptionsFrame_DisplayBarCount:SetValue(INEED_options["barCount"])
	--INEEDOptionsFrame_DisplayFor:SetValue(INEED_options["displayUIListDisplaySeconds"])

	--INEED.Print("Options Panel Refresh: "..INEED_options["emote"])

end

function INEED.OptionPanel_KeepOriginalValue( option )
	if INEED.oldValues then
		INEED.oldValues[option] = INEED.oldValues[option] or INEED_options[option];
	else
		INEED.oldValues={[option]=INEED_options[option]};
	end
end

function INEED.OptionsPanel_CheckButton_OnLoad( self, option, text )
	--FB.Print("CheckButton_OnLoad( "..option..", "..text.." ) -> "..(FB_options[option] and "checked" or "nil"));
	getglobal(self:GetName().."Text"):SetText(text);
	self:SetChecked(INEED_options[option]);
end
function INEED.OptionsPanel_EditBox_OnLoad( self, option )
	self:SetText(INEED_options[option])
	self:SetCursorPosition(0)
	if self:IsNumeric() then
		self:SetValue(INEED_options[option])
	end
end

-- OnClick for checkbuttons
function INEED.OptionsPanel_CheckButton_OnClick( self, option )
	INEED.OptionPanel_KeepOriginalValue( option )
	INEED_options[option] = self:GetChecked()
end
function INEED.OptionsPanel_EditBox_TextChanged( self, option )
	INEED.OptionPanel_KeepOriginalValue( option )
	INEED_options[option] = (self:IsNumeric() and tonumber(self:GetText()) or self:GetText())
	if self:IsNumeric() then
		self:SetValue(INEED_options[option])
	end
end

-- Duration field events
function INEED.OptionsPanel_Duration_OnShow( self, option )
	local duration = INEED_options[option] or 0
	INEED.Print( "show: "..self:GetName() ..":"..(option or "nil")..":"..(duration or "nil") )
	if string.find( self:GetName(), "Days" ) then
		local days = math.floor( duration/86400 )
		self:SetNumber( days )
		--INEED.Print( "days: "..days )
	elseif string.find( self:GetName(), "Hours" ) then
		local hours = math.floor( (duration/3600)%24 )
		self:SetNumber( hours )
		--INEED.Print( "hours: "..hours )
	elseif string.find( self:GetName(), "Minutes" ) then
		local minutes = math.floor( (duration/60)%60 )
		--self:SetText( tostring( minutes ) )
		self:SetNumber( minutes )
		--INEED.Print( "minutes: "..minutes )
	elseif string.find( self:GetName(), "Seconds" ) then
		local seconds = math.floor( (duration%60) )
		--self:SetText( tostring( seconds ) )
		self:SetNumber( seconds )
		--INEED.Print( "seconds: "..seconds )
	end
end
function INEED.OptionsPanel_Duration_TextChanged( self, option )
	INEED.Print( "Changed: "..self:GetName() ..":"..(option or "nil") )
	local duration = INEED_options[option] or 0
	local newValue
	if string.find( self:GetName(), "Days" ) then
		local days = tonumber( self:GetText() ) or 0
		local originalSec = math.floor( duration/86400 ) * 86400
		newValue = (duration - originalSec) + (days * 86400)
		--INEED.Print( "days: "..(days or "nil")..":"..INEED_options[option] )
	elseif string.find( self:GetName(), "Hours" ) then
		local hours = tonumber( self:GetText() ) or 0
		local originalSec = math.floor( (duration/3600)%24 ) * 3600
		newValue = (duration - originalSec) + (hours * 3600)
		--INEED.Print( "hours: "..(hours or "nil")..":"..INEED_options[option] )
	elseif string.find( self:GetName(), "Minutes" ) then
		local minutes = tonumber( self:GetText() ) or 0
		local originalSec = math.floor( (duration/60)%60 ) * 60
		newValue = (duration - originalSec) + (minutes * 60)
	elseif string.find( self:GetName(), "Seconds" ) then
		local seconds = tonumber( self:GetText() ) or 0
		local originalSec = math.floor( (duration%60) )
		newValue = (duration - originalSec) + (seconds ) -- * 1
	end
	INEED.OptionPanel_KeepOriginalValue( option )
	INEED_options[option] = newValue
end

-- Slider events
function INEED.OptionsPanel_Slider_ValueChanged( self, option )
	if INEED.oldValues then
		INEED.oldValues[option] = INEED.oldValues[option] or INEED_options[option]
	else
		INEED.oldValues={[option]=INEED_options[option]}
	end
	INEED_options[option] = floor(self:GetValue())
end