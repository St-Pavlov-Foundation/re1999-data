module("modules.logic.language.LangConfig", package.seeall)

local var_0_0 = class("LangConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"language",
		"language_coder",
		"language_prefab",
		"language_server",
		"video_lang"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getLangTxt(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = lua_language.configDict[arg_4_2]

	if var_4_0 then
		return var_4_0["content" .. arg_4_1]
	end

	return arg_4_2
end

function var_0_0.getServerLangTxt(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = lua_language_server.configDict[arg_5_2]

	if var_5_0 then
		return var_5_0["content" .. arg_5_1]
	end

	return arg_5_2
end

function var_0_0.getLangTxtFromeKey(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = lua_language_coder.configDict[arg_6_2] or lua_language_prefab.configDict[arg_6_2]

	if not var_6_0 then
		logError("语言表key[language_coder.xlsx/language_prefab.xlsx]中找不到key = " .. arg_6_2 .. " 请检查！")

		return arg_6_2
	end

	local var_6_1 = arg_6_0:getLangTxt(arg_6_1, var_6_0.lang)

	if LuaUtil.isEmptyStr(var_6_1) then
		return var_6_0.lang
	end

	return var_6_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
