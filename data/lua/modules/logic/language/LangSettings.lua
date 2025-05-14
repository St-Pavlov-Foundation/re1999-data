module("modules.logic.language.LangSettings", package.seeall)

local var_0_0 = class("LangSettings", BaseConfig)

var_0_0.zh = 1
var_0_0.tw = 2
var_0_0.en = 4
var_0_0.kr = 8
var_0_0.jp = 16
var_0_0.de = 32
var_0_0.fr = 64
var_0_0.thai = 128
var_0_0.shortcutTab = {
	[var_0_0.zh] = "zh",
	[var_0_0.tw] = "tw",
	[var_0_0.en] = "en",
	[var_0_0.kr] = "kr",
	[var_0_0.jp] = "jp",
	[var_0_0.de] = "de",
	[var_0_0.fr] = "fr",
	[var_0_0.thai] = "thai"
}
var_0_0.shortCut2LangIdxTab = {
	zh = var_0_0.zh,
	tw = var_0_0.tw,
	en = var_0_0.en,
	kr = var_0_0.kr,
	jp = var_0_0.jp,
	de = var_0_0.de,
	fr = var_0_0.fr,
	thai = var_0_0.thai
}
var_0_0.aihelpKey = {
	[var_0_0.zh] = "zh-CN",
	[var_0_0.tw] = "zh-TW",
	[var_0_0.en] = "en",
	[var_0_0.kr] = "ko",
	[var_0_0.jp] = "ja",
	[var_0_0.de] = "de",
	[var_0_0.fr] = "fr",
	[var_0_0.thai] = "th"
}
var_0_0._captionsSetting = {
	[var_0_0.zh] = true,
	[var_0_0.tw] = true,
	[var_0_0.en] = false,
	[var_0_0.kr] = true,
	[var_0_0.jp] = true
}
var_0_0.pcWindowsTitle = {
	[var_0_0.zh] = "重返未来：1999",
	[var_0_0.tw] = "重返未來：1999",
	[var_0_0.en] = "reverse:1999",
	[var_0_0.kr] = "reverse:1999",
	[var_0_0.jp] = "reverse:1999",
	[var_0_0.de] = "reverse:1999",
	[var_0_0.fr] = "reverse:1999",
	[var_0_0.thai] = "reverse:1999"
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._curLang = GameConfig:GetCurLangType()
	arg_1_0._defaultLang = GameConfig:GetDefaultLangType()
	arg_1_0._curLangShortcut = var_0_0.shortcutTab[arg_1_0._curLang]
	arg_1_0._captionsActive = var_0_0._captionsSetting[arg_1_0._curLang] ~= false
	arg_1_0._supportedLangs = {}

	local var_1_0 = GameConfig:GetSupportedLangs()
	local var_1_1 = var_1_0.Length

	for iter_1_0 = 0, var_1_1 - 1 do
		arg_1_0._supportedLangs[var_1_0[iter_1_0]] = true
	end

	local var_1_2
end

function var_0_0.init(arg_2_0)
	GameLanguageMgr.instance:setStoryIndexByShortCut(arg_2_0._curLangShortcut)

	if BootNativeUtil.isWindows() then
		local var_2_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.WindowsTitle, nil)

		if not string.nilorempty(var_2_0) then
			return
		end

		local var_2_1 = var_0_0.pcWindowsTitle[arg_2_0._curLang]

		if not var_2_1 then
			logError("can not get windows title for cur lang = " .. arg_2_0._curLangShortcut)

			return
		end

		ZProj.WindowsHelper.Instance:SetWindowsTitle(var_2_1)
		PlayerPrefsHelper.setString(PlayerPrefsKey.WindowsTitle, var_2_1)
	end
end

function var_0_0.supportLang(arg_3_0, arg_3_1)
	return arg_3_0._supportedLangs[arg_3_1] ~= nil
end

function var_0_0.langCaptionsActive(arg_4_0)
	return arg_4_0._captionsActive
end

function var_0_0.getCurLang(arg_5_0)
	return arg_5_0._curLang
end

function var_0_0.getDefaultLang(arg_6_0)
	return arg_6_0._defaultLang
end

function var_0_0.getCurLangShortcut(arg_7_0)
	return var_0_0.shortcutTab[arg_7_0._curLang]
end

function var_0_0.getDefaultLangShortcut(arg_8_0)
	return var_0_0.shortcutTab[arg_8_0._defaultLang]
end

function var_0_0.getCurLangKeyByShortCut(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getCurLangShortcut()

	if not arg_9_1 and GameChannelConfig.isEfun() then
		return LanguageEnum.Lang2KeyEFun[var_9_0] or var_9_0
	end

	return LanguageEnum.Lang2KeyGlobal[var_9_0] or var_9_0
end

function var_0_0.SetCurLangType(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(var_0_0.shortcutTab) do
		if iter_10_1 == arg_10_1 then
			arg_10_0._curLang = iter_10_0

			break
		end
	end

	arg_10_0._curLangShortcut = arg_10_1

	SLFramework.LanguageMgr.Instance:SetCurLangType(arg_10_1)
	GameLanguageMgr.instance:setStoryIndexByShortCut(arg_10_1)
end

function var_0_0._lang(arg_11_0, arg_11_1)
	return LangConfig.instance:getLangTxt(arg_11_0._curLangShortcut, arg_11_1)
end

function var_0_0._serverLang(arg_12_0, arg_12_1)
	return LangConfig.instance:getServerLangTxt(arg_12_0._curLangShortcut, arg_12_1)
end

function var_0_0._luaLang(arg_13_0, arg_13_1)
	return LangConfig.instance:getLangTxtFromeKey(arg_13_0._curLangShortcut, arg_13_1)
end

var_0_0.empty = ""

function var_0_0._formatLuaLang(arg_14_0, ...)
	if ... == nil then
		logError("LangSettings._formatLuaLang args can not be nil!")

		return var_0_0.empty
	end

	local var_14_0 = {
		...
	}
	local var_14_1 = var_14_0[1]

	if var_14_1 == nil then
		logError("LangSettings._formatLuaLang key can not be nil!")

		return var_0_0.empty
	end

	local var_14_2 = arg_14_0:_luaLang(var_14_1)

	return string.format(var_14_2, unpack(var_14_0, 2))
end

function var_0_0._langVideoUrl(arg_15_0, arg_15_1)
	local var_15_0 = video_lang.configDict[arg_15_1]
	local var_15_1 = GameConfig:GetCurVoiceShortcut()
	local var_15_2 = GameConfig:GetDefaultVoiceShortcut()

	if var_15_0 then
		if tabletool.indexOf(var_15_0.supportLang, var_15_1) then
			local var_15_3 = string.format("%s/%s", var_15_1, arg_15_1)

			return ResUrl.getVideo(var_15_3)
		elseif tabletool.indexOf(var_15_0.supportLang, var_15_2) then
			local var_15_4 = string.format("%s/%s", var_15_2, arg_15_1)

			return ResUrl.getVideo(var_15_4)
		end
	end

	return ResUrl.getVideo(arg_15_1)
end

var_0_0.instance = var_0_0.New()

function lang(arg_16_0)
	return var_0_0.instance:_lang(arg_16_0)
end

function serverLang(arg_17_0)
	return var_0_0.instance:_serverLang(arg_17_0)
end

function luaLang(arg_18_0)
	return var_0_0.instance:_luaLang(arg_18_0)
end

function formatLuaLang(...)
	return var_0_0.instance:_formatLuaLang(...)
end

function luaLangUTC(arg_20_0)
	local var_20_0 = luaLang(arg_20_0)

	if var_0_0.instance:isOverseas() then
		var_20_0 = ServerTime.ReplaceUTCStr(var_20_0)
	else
		var_20_0 = string.gsub(var_20_0, "%(UTC%+8%)", "")
		var_20_0 = string.gsub(var_20_0, "（UTC%+8）", "")
	end

	return var_20_0
end

function var_0_0.isOverseas(arg_21_0)
	if arg_21_0.__isOverseas == nil then
		local var_21_0 = SDKMgr.instance:getGameId()

		if tostring(var_21_0) == "50001" then
			arg_21_0.__isOverseas = false
		else
			arg_21_0.__isOverseas = true
		end
	end

	return arg_21_0.__isOverseas
end

function var_0_0.isZh(arg_22_0)
	return arg_22_0:getCurLang() == var_0_0.zh
end

function var_0_0.isTw(arg_23_0)
	return arg_23_0:getCurLang() == var_0_0.tw
end

function var_0_0.isEn(arg_24_0)
	return arg_24_0:getCurLang() == var_0_0.en
end

function var_0_0.isKr(arg_25_0)
	return arg_25_0:getCurLang() == var_0_0.kr
end

function var_0_0.isJp(arg_26_0)
	return arg_26_0:getCurLang() == var_0_0.jp
end

function var_0_0.isDe(arg_27_0)
	return arg_27_0:getCurLang() == var_0_0.de
end

function var_0_0.isFr(arg_28_0)
	return arg_28_0:getCurLang() == var_0_0.fr
end

function var_0_0.isThai(arg_29_0)
	return arg_29_0:getCurLang() == var_0_0.thai
end

function langVideoUrl(arg_30_0)
	return var_0_0.instance:_langVideoUrl(arg_30_0)
end

setGlobal("lang", lang)
setGlobal("serverLang", serverLang)
setGlobal("luaLang", luaLang)
setGlobal("formatLuaLang", formatLuaLang)
setGlobal("langVideoUrl", langVideoUrl)
setGlobal("luaLangUTC", luaLangUTC)

return var_0_0
