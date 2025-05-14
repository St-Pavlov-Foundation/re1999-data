module("modules.logic.settings.model.SettingsRoleVoiceModel", package.seeall)

local var_0_0 = class("SettingsRoleVoiceModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.setCharVoiceLangPrefValue(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = type(arg_2_1) == "number" and LangSettings.shortcutTab[arg_2_1] or arg_2_1

	arg_2_0:statCharVoiceData(StatEnum.EventName.ChangeCharVoiceLang, arg_2_2, var_2_0)

	local var_2_1 = PlayerModel.instance:getPlayerPrefsKey(SettingsEnum.CharVoiceLangPrefsKey .. arg_2_2 .. "_")

	PlayerPrefsHelper.setString(var_2_1, var_2_0)
end

function var_0_0.getCharVoiceLangPrefValue(arg_3_0, arg_3_1)
	local var_3_0 = PlayerModel.instance:getPlayerPrefsKey(SettingsEnum.CharVoiceLangPrefsKey .. arg_3_1 .. "_")
	local var_3_1 = PlayerPrefsHelper.getString(var_3_0)
	local var_3_2 = false

	if type(var_3_1) ~= "string" or string.nilorempty(var_3_1) then
		var_3_1 = GameConfig:GetCurVoiceShortcut()
		var_3_2 = true
	end

	return LangSettings.shortCut2LangIdxTab[var_3_1], var_3_1, var_3_2
end

function var_0_0.statCharVoiceData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = HeroConfig.instance:getHeroCO(arg_4_2)

	if not var_4_0 then
		return
	end

	local var_4_1 = {
		[StatEnum.EventProperties.HeroId] = tonumber(arg_4_2),
		[StatEnum.EventProperties.HeroName] = var_4_0.name
	}

	if arg_4_1 == StatEnum.EventName.ChangeCharVoiceLang then
		local var_4_2, var_4_3, var_4_4 = arg_4_0:getCharVoiceLangPrefValue(arg_4_2)
		local var_4_5 = GameConfig:GetCurVoiceShortcut()

		var_4_1[StatEnum.EventProperties.CharVoiceLang] = arg_4_3
		var_4_1[StatEnum.EventProperties.GlobalVoiceLang] = var_4_5
		var_4_1[StatEnum.EventProperties.CharVoiceLangBefore] = var_4_4 and var_4_5 or var_4_3
	end

	StatController.instance:track(arg_4_1, var_4_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
