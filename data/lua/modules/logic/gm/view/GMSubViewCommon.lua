module("modules.logic.gm.view.GMSubViewCommon", package.seeall)

local var_0_0 = class("GMSubViewCommon", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "其他"
end

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

local var_0_1 = tolua.findtype("UnityEngine.UI.InputField+LineType")
local var_0_2 = System.Enum.Parse(var_0_1, "MultiLineSubmit")
local var_0_3 = System.Enum.Parse(var_0_1, "MultiLineNewline")

function var_0_0.initViewContent(arg_2_0)
	if arg_2_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_2_0)
	arg_2_0:addTitleSplitLine("服务端GM多行输入")

	arg_2_0._gmInput = arg_2_0:addInputText("L0", "", "GM ...", nil, nil, {
		w = 1000,
		h = 500
	})
	arg_2_0._gmInput.inputField.lineType = var_0_3

	arg_2_0._gmInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewMultiServerGM, ""))
	arg_2_0:addButton("L0", "发送", arg_2_0._onClickOk, arg_2_0)
	arg_2_0:addTitleSplitLine("检查")
	arg_2_0:addButton("L1", "资源完整性验证", arg_2_0._onClickCheckMD5, arg_2_0)
	arg_2_0:addButton("L1", "配置描述Tag检测", arg_2_0._onClickCheckSkillTag, arg_2_0)
	arg_2_0:addButton("L1", "扫描无用配置", arg_2_0._onClickCheckUnuseConfig, arg_2_0)

	arg_2_0._langDrop = arg_2_0:addDropDown("L1", "UI多语言", nil, arg_2_0._onLangDropChange, arg_2_0)

	arg_2_0:addTitleSplitLine("BGM")
	arg_2_0:addButton("L2", "显示BGM播放进度", arg_2_0._onClickBGMProgress, arg_2_0)
	arg_2_0:addButton("L2", "视频资源列表", arg_2_0._onClickVideoList, arg_2_0)
	arg_2_0:addTitleSplitLine("剧情")

	arg_2_0._inpClearStoryValue = arg_2_0:addInputText("L3", "", "剧情id", nil, nil, {
		w = 1000
	})

	arg_2_0:addButton("L3", "重置剧情", arg_2_0._onClickClearStory, arg_2_0)

	arg_2_0._inpFinishStoryValue = arg_2_0:addInputText("L4", "", "剧情id", nil, nil, {
		w = 1000
	})

	arg_2_0:addButton("L4", "完成剧情", arg_2_0._onClickFinishStory, arg_2_0)
	arg_2_0:addButton("L5", "监听按键", arg_2_0._onClickListenKeyboard, arg_2_0)
	arg_2_0:addTitleSplitLine("内置浏览器")

	arg_2_0._inpUrl = arg_2_0:addInputText("L6", "", "url", nil, nil, {
		w = 1000
	})

	arg_2_0:addButton("L6", "打开链接", arg_2_0._onClickOpenWebView, arg_2_0)

	arg_2_0.recordUserToggle = arg_2_0:addToggle("L6", "携带用\n户信息", nil, nil, {
		fsize = 20
	})

	arg_2_0:addTitleSplitLine("按键")

	arg_2_0._switchKeyToggle = arg_2_0:addToggle("L7", "切换按键功能", arg_2_0._switchKeyInput, arg_2_0, {
		fsize = 40
	})
	arg_2_0._switchKeyToggle.isOn = UnityEngine.PlayerPrefs.GetInt("PCInputSwitch", 0) == 1
	arg_2_0.langList = {}
	arg_2_0.langShortCutList = {}
	arg_2_0.curUILang = LangSettings.instance:getCurLang()

	local var_2_0 = 0
	local var_2_1 = 0

	for iter_2_0, iter_2_1 in pairs(LangSettings.shortcutTab) do
		table.insert(arg_2_0.langList, iter_2_0)
		table.insert(arg_2_0.langShortCutList, iter_2_1)

		if iter_2_0 == arg_2_0.curUILang then
			var_2_0 = var_2_1
		end

		var_2_1 = var_2_1 + 1
	end

	arg_2_0._langDrop:ClearOptions()
	arg_2_0._langDrop:AddOptions(arg_2_0.langShortCutList)
	arg_2_0._langDrop:SetValue(var_2_0)
end

function var_0_0._onClickOpenWebView(arg_3_0)
	local var_3_0 = arg_3_0._inpUrl:GetText()

	if string.nilorempty(var_3_0) then
		return
	end

	WebViewController.instance:openWebView(var_3_0, arg_3_0.recordUserToggle.isOn)
end

function var_0_0.removeEvents(arg_4_0)
	var_0_0.super.removeEvents(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._tickListenKeyboard, arg_4_0)
end

function var_0_0._onClickOk(arg_5_0)
	local var_5_0 = arg_5_0._gmInput:GetText()

	if string.nilorempty(var_5_0) then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewMultiServerGM, var_5_0)

	local var_5_1 = string.split(var_5_0, "\n")

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		iter_5_1 = string.trim(iter_5_1)

		if not string.nilorempty(iter_5_1) then
			GMRpc.instance:sendGMRequest(iter_5_1)
		end
	end
end

function var_0_0._onClickCheckMD5(arg_6_0)
	MessageBoxController.instance:showMsgBoxByStr("正在验证资源完整性", MsgBoxEnum.BoxType.Yes)

	local var_6_0 = ResCheckMgr.instance:_getAllLocalLang()
	local var_6_1, var_6_2 = ResCheckMgr.instance:_getDLCInfo(var_6_0)

	arg_6_0.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	arg_6_0.eventDispatcher:AddListener(arg_6_0.eventDispatcher.ResChecker_Finish, arg_6_0._onResCheckFinish, arg_6_0)
	SLFramework.ResChecker.Instance:CheckAllRes(var_6_0, var_6_1, var_6_2)
end

function var_0_0._onResCheckFinish(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1 = arg_7_1 and "验证通过" or "资源完整性验证失败！！请查看日志"

	arg_7_0.eventDispatcher:RemoveListener(arg_7_0.eventDispatcher.ResChecker_Finish)

	arg_7_0.eventDispatcher = nil

	MessageBoxController.instance:showSystemMsgBoxByStr(var_7_1, MsgBoxEnum.BoxType.Yes)
end

function var_0_0._onClickBGMProgress(arg_8_0)
	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0) == 0 then
		GameFacade.showToast(ToastEnum.IconId, "show bgm progress")
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewBGMProgress, 1)
	else
		GameFacade.showToast(ToastEnum.IconId, "hide bgm progress")
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0)
	end
end

function var_0_0._onClickVideoList(arg_9_0)
	ViewMgr.instance:openView(ViewName.GMVideoList)
end

function var_0_0._onClickClearRougeStories(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(lua_rouge_story_list.configList) do
		local var_10_0 = string.splitToNumber(iter_10_1.storyIdList, "#")

		for iter_10_2, iter_10_3 in ipairs(var_10_0) do
			GMRpc.instance:sendGMRequest(string.format("delete story %s", iter_10_3))
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickFinishRougeStories(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(lua_rouge_story_list.configList) do
		local var_11_0 = string.splitToNumber(iter_11_1.storyIdList, "#")

		for iter_11_2, iter_11_3 in ipairs(var_11_0) do
			StoryRpc.instance:sendUpdateStoryRequest(iter_11_3, -1, 0)
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickClearStory(arg_12_0)
	local var_12_0 = string.splitToNumber(arg_12_0._inpClearStoryValue:GetText(), "#")

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		GMRpc.instance:sendGMRequest(string.format("delete story %s", iter_12_1))
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickFinishStory(arg_13_0)
	local var_13_0 = string.splitToNumber(arg_13_0._inpFinishStoryValue:GetText(), "#")

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		StoryRpc.instance:sendUpdateStoryRequest(iter_13_1, -1, 0)
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickListenKeyboard(arg_14_0)
	if not arg_14_0._keyCodes then
		arg_14_0._keyCodeStrs = {}
		arg_14_0._keyCodes = {}

		local var_14_0 = UnityEngine.KeyCode

		for iter_14_0 = 8, 329 do
			local var_14_1 = var_14_0.IntToEnum(iter_14_0)

			if var_14_1 then
				local var_14_2 = var_14_1:ToString()

				table.insert(arg_14_0._keyCodes, var_14_1)
				table.insert(arg_14_0._keyCodeStrs, var_14_2)
			end
		end
	end

	TaskDispatcher.cancelTask(arg_14_0._tickListenKeyboard, arg_14_0)
	TaskDispatcher.runRepeat(arg_14_0._tickListenKeyboard, arg_14_0, 0.01)
	GameFacade.showToast(ToastEnum.IconId, "请按下键盘，按键码将复制到粘贴板")
end

local var_0_4 = UnityEngine.Input

function var_0_0._tickListenKeyboard(arg_15_0)
	if var_0_4.anyKey then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._keyCodes) do
			if var_0_4.GetKey(iter_15_1) then
				local var_15_0 = arg_15_0._keyCodeStrs[iter_15_0]

				logError(var_15_0)
				GameFacade.showToast(ToastEnum.IconId, var_15_0)
				ZProj.GameHelper.SetSystemBuffer(var_15_0)

				break
			end
		end
	end
end

function var_0_0._onClickCheckSkillTag(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(lua_skill_eff_desc.configList) do
		if var_16_0[iter_16_1.name] and iter_16_1.name ~= "？？？" then
			logError(string.format("技能Tag 重复 [%s] %d -> %d", iter_16_1.name, iter_16_1.id, var_16_0[iter_16_1.name]))
		end

		var_16_0[iter_16_1.name] = iter_16_1.id
	end

	FightConfig.instance:setGetDescFlag(true)
	arg_16_0:_checkDescHaveTag(var_16_0, "skill_effect", "desc")
	arg_16_0:_checkDescHaveTag(var_16_0, "skill_buff", "desc", arg_16_0._isCheckBuff)
	arg_16_0:_checkDescHaveTag(var_16_0, "skill_eff_desc", "desc")
	arg_16_0:_checkDescHaveTag(var_16_0, "equip_skill", "baseDesc")
	arg_16_0:_checkDescHaveTag(var_16_0, "rule", "desc")
	arg_16_0:_checkDescHaveTag(var_16_0, "rouge_desc", "desc")
	FightConfig.instance:setGetDescFlag(false)
end

function var_0_0._onClickCheckUnuseConfig(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(ModuleMgr.instance._moduleSettingList) do
		local var_17_1 = iter_17_1.config

		if var_17_1 then
			for iter_17_2, iter_17_3 in ipairs(var_17_1) do
				local var_17_2 = _G[iter_17_3]

				if var_17_2 then
					local var_17_3 = var_17_2.instance:reqConfigNames()

					if var_17_3 then
						for iter_17_4, iter_17_5 in ipairs(var_17_3) do
							var_17_0[iter_17_5] = true
						end
					end
				end
			end
		end
	end

	local var_17_4 = SLFramework.FrameworkSettings.AssetRootDir .. "/configs/excel2json/"
	local var_17_5 = SLFramework.FileHelper.GetDirFilePaths(var_17_4)
	local var_17_6 = ""
	local var_17_7 = var_17_5.Length

	for iter_17_6 = 0, var_17_7 - 1 do
		local var_17_8 = var_17_5[iter_17_6]

		if not string.find(var_17_8, ".meta") then
			local var_17_9 = SLFramework.FileHelper.GetFileName(var_17_8, false)

			if not var_17_0[string.gsub(var_17_9, "json_", "")] then
				var_17_6 = var_17_6 .. var_17_9 .. "\n"
			end
		end
	end

	logError(var_17_6)
end

function var_0_0._isCheckBuff(arg_18_0, arg_18_1)
	if arg_18_1 and arg_18_1.isNoShow == 1 then
		return false
	end

	return true
end

function var_0_0._checkDescHaveTag(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = _G["lua_" .. arg_19_2]

	if not var_19_0 then
		logError(arg_19_2 .. "配置不存在 !!!!!!!!!!!!!")

		return
	end

	for iter_19_0, iter_19_1 in ipairs(var_19_0.configList) do
		local var_19_1 = iter_19_1[arg_19_3]

		if arg_19_4 and not arg_19_4(arg_19_0, iter_19_1) or var_19_1:find("不外显") then
			-- block empty
		elseif type(var_19_1) == "string" then
			string.gsub(var_19_1, "%[(.-)%]", function(arg_20_0)
				if not arg_19_1[arg_20_0] then
					logError(string.format("%s.%s id:%s tag不存在 ->  %s\n%s", arg_19_2, arg_19_3, iter_19_1[1], arg_20_0, var_19_1))
				end

				return arg_20_0
			end)
			string.gsub(var_19_1, "【(.-)】", function(arg_21_0)
				if not arg_19_1[arg_21_0] then
					logError(string.format("%s.%s id:%s tag不存在 ->  %s\n%s", arg_19_2, arg_19_3, iter_19_1[1], arg_21_0, var_19_1))
				end

				return arg_21_0
			end)
		else
			logError(arg_19_2 .. "." .. arg_19_3 .. "配置字段不存在 !!!!!!!!!!!!!")

			break
		end
	end
end

function var_0_0._onLangDropChange(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.langList[arg_22_1 + 1]

	if var_22_0 == arg_22_0.curLang then
		return
	end

	local var_22_1 = GameConfig:GetCurLangType()

	GameConfig:SetCurLangType(arg_22_0.langShortCutList[arg_22_1 + 1])

	LangSettings.instance._curLang = var_22_0
	LangSettings.instance._captionsActive = LangSettings._captionsSetting[var_22_0] ~= false

	UnityEngine.PlayerPrefs.SetInt("CurLanguageType", var_22_1)
	UnityEngine.PlayerPrefs.Save()
end

function var_0_0._switchKeyInput(arg_23_0, arg_23_1, arg_23_2)
	UnityEngine.PlayerPrefs.SetInt("PCInputSwitch", arg_23_2 and 1 or 0)
	UnityEngine.PlayerPrefs.Save()
	PCInputController.instance:Switch()
end

return var_0_0
