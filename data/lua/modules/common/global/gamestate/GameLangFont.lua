module("modules.common.global.gamestate.GameLangFont", package.seeall)

local var_0_0 = class("GameLangFont")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.ctor(arg_1_0)
	arg_1_0._loadStatus = var_0_1
	arg_1_0._SettingStatus = var_0_1
	arg_1_0._registerFontDict = {}
	arg_1_0._id2TmpFontUrlDict = {}
	arg_1_0._id2TextFontUrlDict = {}
	arg_1_0._id2TmpFontAssetDict = {}
	arg_1_0._id2TextFontAssetDict = {}

	arg_1_0:_loadFontAsset()
	ZProj.LangFontAssetMgr.Instance:SetLuaCallback(arg_1_0._callback, arg_1_0)
end

function var_0_0._callback(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		arg_2_0._registerFontDict[arg_2_1] = true

		if arg_2_0._loadStatus == var_0_3 then
			arg_2_0:_setFontAsset(arg_2_1)
		else
			arg_2_0:_loadFontAsset()
		end
	else
		arg_2_0._registerFontDict[arg_2_1] = nil

		if arg_2_1.id > 0 and not string.nilorempty(arg_2_1.str1) then
			local var_2_0 = arg_2_1.tmpText

			if var_2_0 then
				gohelper.destroy(var_2_0.fontSharedMaterial)
			end
		end
	end
end

function var_0_0.changeFontAsset(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._loadStatus = var_0_1
	arg_3_0._loadFontAssetCallback = arg_3_1
	arg_3_0._loadFontAssetcallbackObj = arg_3_2

	arg_3_0:_loadFontAsset()
end

function var_0_0._loadFontAsset(arg_4_0)
	if arg_4_0._loadStatus ~= var_0_1 then
		return
	end

	arg_4_0._loadStatus = var_0_2

	local var_4_0 = {}

	arg_4_0._id2TmpFontUrlDict = {}
	arg_4_0._id2TextFontUrlDict = {}

	local var_4_1 = LangSettings.shortcutTab[GameConfig:GetCurLangType()]
	local var_4_2 = lua_setting_lang.configDict[var_4_1]

	for iter_4_0 = 1, 2 do
		local var_4_3 = "fontasset" .. iter_4_0

		if not string.nilorempty(var_4_2[var_4_3]) then
			local var_4_4 = string.format("font/meshpro/%s.asset", var_4_2[var_4_3])

			table.insert(var_4_0, var_4_4)

			arg_4_0._id2TmpFontUrlDict[iter_4_0] = var_4_4
		end

		local var_4_5 = "textfontasset" .. iter_4_0

		if not string.nilorempty(var_4_2[var_4_5]) then
			local var_4_6 = string.format("font/%s", var_4_2[var_4_5])

			table.insert(var_4_0, var_4_6)

			arg_4_0._id2TextFontUrlDict[iter_4_0] = var_4_6
		end
	end

	if arg_4_0._loader then
		arg_4_0._loader:dispose()
	end

	arg_4_0._loader = MultiAbLoader.New()

	arg_4_0._loader:setPathList(var_4_0)
	arg_4_0._loader:startLoad(arg_4_0._onFontLoaded, arg_4_0)
end

function var_0_0._onFontLoaded(arg_5_0)
	arg_5_0._loadStatus = var_0_3
	arg_5_0._id2TmpFontAssetDict = {}
	arg_5_0._id2TextFontAssetDict = {}

	local var_5_0 = arg_5_0._loader:getAssetItemDict()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		for iter_5_2, iter_5_3 in pairs(arg_5_0._id2TmpFontUrlDict) do
			if iter_5_3 == iter_5_0 then
				arg_5_0._id2TmpFontAssetDict[iter_5_2] = iter_5_1:GetResource()
			end
		end

		for iter_5_4, iter_5_5 in pairs(arg_5_0._id2TextFontUrlDict) do
			if iter_5_5 == iter_5_0 then
				arg_5_0._id2TextFontAssetDict[iter_5_4] = iter_5_1:GetResource()
			end
		end
	end

	for iter_5_6, iter_5_7 in pairs(arg_5_0._registerFontDict) do
		arg_5_0:_setFontAsset(iter_5_6)
	end

	if arg_5_0._loadFontAssetCallback then
		arg_5_0._loadFontAssetCallback(arg_5_0._loadFontAssetcallbackObj)
	end

	arg_5_0._loadFontAssetCallback = nil
	arg_5_0._loadFontAssetcallbackObj = nil
end

function var_0_0._setFontAsset(arg_6_0, arg_6_1)
	if gohelper.isNil(arg_6_1) then
		return
	end

	local var_6_0 = arg_6_1.id

	if var_6_0 > 0 then
		local var_6_1 = arg_6_1.tmpText

		if var_6_1 then
			local var_6_2 = arg_6_0._id2TmpFontAssetDict[var_6_0]

			if var_6_2 then
				var_6_1.font = var_6_2
			end

			local var_6_3 = arg_6_1.str1

			if not string.nilorempty(var_6_3) then
				local var_6_4 = SLFramework.UGUI.GuiHelper.ParseColor(var_6_3)
				local var_6_5 = UnityEngine.Color32.New(var_6_4.r * 255, var_6_4.g * 255, var_6_4.b * 255, var_6_4.a * 255)
				local var_6_6 = UnityEngine.Object.Instantiate(var_6_1.fontSharedMaterial)

				var_6_1.fontSharedMaterial = var_6_6

				var_6_6:EnableKeyword("OUTLINE_ON")

				var_6_1.outlineColor = var_6_5
				var_6_1.outlineWidth = arg_6_1.int1 / 1000
			elseif arg_6_1.instanceMaterial then
				var_6_1.fontSharedMaterial = UnityEngine.Object.Instantiate(var_6_1.fontSharedMaterial)
			end
		else
			local var_6_7 = arg_6_1.tmpInputText

			if var_6_7 then
				local var_6_8 = arg_6_0._id2TmpFontAssetDict[var_6_0]

				if var_6_8 then
					var_6_7.fontAsset = var_6_8
				end
			end
		end

		return
	end

	local var_6_9 = arg_6_1.textId

	if var_6_9 > 0 then
		local var_6_10 = arg_6_1.text

		if var_6_10 then
			local var_6_11 = arg_6_0._id2TextFontAssetDict[var_6_9]

			if var_6_11 then
				var_6_10.font = var_6_11
			end
		end
	end
end

function var_0_0.ControlDoubleEn(arg_7_0)
	local var_7_0 = ViewMgr.instance:getUIRoot()

	arg_7_0.languageMgr = SLFramework.LanguageMgr.Instance

	local var_7_1 = var_7_0:GetComponentsInChildren(typeof(SLFramework.LangCaptions), true)

	arg_7_0._comps = {}

	ZProj.AStarPathBridge.ArrayToLuaTable(var_7_1, arg_7_0._comps)
	TaskDispatcher.runRepeat(arg_7_0._onRepectSetEnActive, arg_7_0, 0)
end

function var_0_0._onRepectSetEnActive(arg_8_0)
	for iter_8_0 = 1, 100 do
		if #arg_8_0._comps > 0 then
			local var_8_0 = arg_8_0._comps[#arg_8_0._comps]

			table.remove(arg_8_0._comps, #arg_8_0._comps)

			if not gohelper.isNil(var_8_0) then
				arg_8_0.languageMgr:ApplyLangCaptions(var_8_0)
			end
		end
	end

	if #arg_8_0._comps == 0 then
		arg_8_0:_stopSetEnActive()
	end
end

function var_0_0._stopSetEnActive(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onRepectSetEnActive, arg_9_0)

	if arg_9_0._comps then
		arg_9_0._comps = nil
	end
end

return var_0_0
