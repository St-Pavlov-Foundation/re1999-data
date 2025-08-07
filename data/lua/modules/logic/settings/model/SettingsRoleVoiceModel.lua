module("modules.logic.settings.model.SettingsRoleVoiceModel", package.seeall)

local var_0_0 = class("SettingsRoleVoiceModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.setCharVoiceLangPrefValue(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = type(arg_2_1) == "number" and LangSettings.shortcutTab[arg_2_1] or arg_2_1

	if not arg_2_0:isHeroSp01(arg_2_2) and (var_2_0 == LangSettings.shortcutTab[LangSettings.jp] or var_2_0 == LangSettings.shortcutTab[LangSettings.kr]) then
		return
	end

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

		if not arg_3_0:isHeroSp01(arg_3_1) and (var_3_1 == LangSettings.shortcutTab[LangSettings.jp] or var_3_1 == LangSettings.shortcutTab[LangSettings.kr]) then
			var_3_1 = LangSettings.shortcutTab[LangSettings.en]
		end
	end

	return LangSettings.shortCut2LangIdxTab[var_3_1], var_3_1, var_3_2
end

function var_0_0.isHeroSp01(arg_4_0, arg_4_1)
	local var_4_0 = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.S01SpRole), "#")

	return (LuaUtil.tableContains(var_4_0, arg_4_1))
end

function var_0_0.statCharVoiceData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = HeroConfig.instance:getHeroCO(arg_5_2)

	if not var_5_0 then
		return
	end

	local var_5_1 = {
		[StatEnum.EventProperties.HeroId] = tonumber(arg_5_2),
		[StatEnum.EventProperties.HeroName] = var_5_0.name
	}

	if arg_5_1 == StatEnum.EventName.ChangeCharVoiceLang then
		local var_5_2, var_5_3, var_5_4 = arg_5_0:getCharVoiceLangPrefValue(arg_5_2)
		local var_5_5 = GameConfig:GetCurVoiceShortcut()

		var_5_1[StatEnum.EventProperties.CharVoiceLang] = arg_5_3
		var_5_1[StatEnum.EventProperties.GlobalVoiceLang] = var_5_5
		var_5_1[StatEnum.EventProperties.CharVoiceLangBefore] = var_5_4 and var_5_5 or var_5_3
	end

	StatController.instance:track(arg_5_1, var_5_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
