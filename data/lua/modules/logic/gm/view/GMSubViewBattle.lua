module("modules.logic.gm.view.GMSubViewBattle", package.seeall)

local var_0_0 = class("GMSubViewBattle", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "战斗"
end

function var_0_0.initViewContent(arg_2_0)
	if arg_2_0._isInit then
		return
	end

	arg_2_0:addButton("L0", "发送战斗日志到企业微信", arg_2_0.onClickSendFightLogBtn, arg_2_0)
	arg_2_0:addButton("L1", "打印出角色平均伤害，平均承伤，平均治疗", arg_2_0._onClickShowBattleCharaterParam, arg_2_0)
	arg_2_0:addButton("L2", "开启战斗录制", arg_2_0._onClickEnableGMFightRecord, arg_2_0)
	arg_2_0:addButton("L2", "保存战斗录制", arg_2_0._onClickSaveRecord, arg_2_0)
	arg_2_0:addButton("L2", "选取录像文件", arg_2_0._onClickGMFightRecordReplay, arg_2_0)
	arg_2_0:addButton("L3", "打开战场日志", arg_2_0._onClickGMFightLog, arg_2_0)
	arg_2_0:addButton("L3", "复制最后一回合协议数据", arg_2_0.onClickCopyLatRoundProtoDataNormal, arg_2_0)
	arg_2_0:addLabel("L4", "通过战斗id进入一牌一动")
	arg_2_0:addInputText("L4", PlayerPrefsHelper.getString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, ""), nil, arg_2_0._onLastBattleIdYiPaiYiDongChange, arg_2_0)
	arg_2_0:addButton("L4", "进入战斗", arg_2_0._onClickEnterYiPaiYiDong, arg_2_0)
	arg_2_0:addLabel("L5", "实时统计buff类层数 : ")

	arg_2_0.buffTypeInput = arg_2_0:addInputText("L5", "6003", "buff类id")
	arg_2_0.statBuffToggle = arg_2_0:addToggle("L5", "", arg_2_0.onStatBuffToggleValueChange, arg_2_0)
	arg_2_0.statBuffToggle.isOn = GMFightController.instance:statingBuffType()
	arg_2_0.effectTypeInput = arg_2_0:addInputText("L6", "", "指定effectType: id1;id2;id2", nil, nil, {
		w = 600
	})

	arg_2_0:addButton("L6", "复制最后一回合处理后的数据_前端用", arg_2_0.onClickCopyLatRoundDataForClient, arg_2_0)
	arg_2_0:addButton("L7", "复制最后一回合处理前的数据_前端用", arg_2_0.onClickCopyLastOriginRoundDataForClient, arg_2_0)
	arg_2_0:addButton("L7", "复制最后一回合protobuff数据", arg_2_0.onClickCopyLastSrcRoundProtoData, arg_2_0)
	arg_2_0:addLabel("L8", "设定战斗版本号(本次登录有效)")
	arg_2_0:addInputText("L8", FightModel.GMForceVersion or "版本号", nil, arg_2_0._onVersionChange, arg_2_0)
	arg_2_0:addButton("L9", "使用新卡牌代码逻辑", arg_2_0.onClickUseNewCardScript, arg_2_0)
	arg_2_0:addButton("L9", "使用旧卡牌代码逻辑", arg_2_0.onClickUseOldCardScript, arg_2_0)

	arg_2_0.rightTopElementsInput = arg_2_0:addInputText("L10", "", "显示右边上层UI", nil, nil, {
		w = 600
	})

	arg_2_0:addButton("L10", "显示右边上层UI", arg_2_0.onClickShowRightElements, arg_2_0)

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(FightRightElementEnum.Elements) do
		table.insert(var_2_0, iter_2_1)
	end

	arg_2_0.rightTopElementsInput:SetText(table.concat(var_2_0, ","))

	arg_2_0.rightBottomElementsInput = arg_2_0:addInputText("L11", "", "显示右边低层UI", nil, nil, {
		w = 600
	})

	arg_2_0:addButton("L11", "显示所有底层UI", arg_2_0.onClickShowRightBottomElements, arg_2_0)

	local var_2_1 = {}

	for iter_2_2, iter_2_3 in pairs(FightRightBottomElementEnum.Elements) do
		table.insert(var_2_1, iter_2_3)
	end

	arg_2_0.rightBottomElementsInput:SetText(table.concat(var_2_1, ","))

	arg_2_0._isInit = true
end

function var_0_0.onClickSendFightLogBtn(arg_3_0)
	SendWeWorkFileHelper.sendFightLogFile()
end

function var_0_0.onClickShowRightElements(arg_4_0)
	if not ViewMgr.instance:getContainer(ViewName.FightView) then
		return
	end

	local var_4_0 = arg_4_0.rightTopElementsInput:GetText()

	if string.nilorempty(var_4_0) then
		for iter_4_0, iter_4_1 in pairs(FightRightElementEnum.Elements) do
			FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, iter_4_1)
		end

		return
	end

	local var_4_1 = string.splitToNumber(var_4_0, ",")

	for iter_4_2, iter_4_3 in pairs(FightRightElementEnum.Elements) do
		if tabletool.indexOf(var_4_1, iter_4_3) then
			FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, iter_4_3)
		else
			FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, iter_4_3)
		end
	end
end

function var_0_0.onClickShowRightBottomElements(arg_5_0)
	if not ViewMgr.instance:getContainer(ViewName.FightView) then
		return
	end

	local var_5_0 = arg_5_0.rightBottomElementsInput:GetText()

	if string.nilorempty(var_5_0) then
		for iter_5_0, iter_5_1 in pairs(FightRightBottomElementEnum.Elements) do
			FightController.instance:dispatchEvent(FightEvent.RightBottomElements_HideElement, iter_5_1)
		end

		return
	end

	local var_5_1 = string.splitToNumber(var_5_0, ",")

	for iter_5_2, iter_5_3 in pairs(FightRightBottomElementEnum.Elements) do
		if tabletool.indexOf(var_5_1, iter_5_3) then
			FightController.instance:dispatchEvent(FightEvent.RightBottomElements_ShowElement, iter_5_3)
		else
			FightController.instance:dispatchEvent(FightEvent.RightBottomElements_HideElement, iter_5_3)
		end
	end
end

function var_0_0.onClickCopyLatRoundDataForClient(arg_6_0)
	local var_6_0 = FightDataHelper.roundMgr:getRoundData()

	if not var_6_0 then
		return
	end

	FightLogFilterHelper.setFilterEffectList(arg_6_0.effectTypeInput:GetText())

	local var_6_1 = FightLogHelper.getFightRoundString(var_6_0)

	ZProj.GameHelper.SetSystemBuffer(var_6_1)
end

function var_0_0.onClickCopyLastOriginRoundDataForClient(arg_7_0)
	local var_7_0 = FightDataHelper.roundMgr:getOriginRoundData()

	if not var_7_0 then
		return
	end

	FightLogFilterHelper.setFilterEffectList()

	local var_7_1 = FightLogProtobufHelper.getFightRoundString(var_7_0)

	ZProj.GameHelper.SetSystemBuffer(var_7_1)
end

function var_0_0.onClickCopyLastSrcRoundProtoData(arg_8_0)
	local var_8_0 = FightDataHelper.protoCacheMgr:getLastRoundProto()

	if not var_8_0 then
		ZProj.GameHelper.SetSystemBuffer("nil")

		return
	end

	local var_8_1 = tostring(var_8_0)

	ZProj.GameHelper.SetSystemBuffer(var_8_1)
end

function var_0_0.onClickCopyLatRoundProtoDataNormal(arg_9_0)
	local var_9_0 = FightDataHelper.protoCacheMgr:getLastRoundProto()

	if not var_9_0 then
		ZProj.UGUIHelper.CopyText("没有数据")

		return
	end

	local var_9_1 = ""
	local var_9_2 = FightDataHelper.protoCacheMgr:getLastRoundNum()

	if var_9_2 then
		var_9_1 = var_9_1 .. "回合" .. var_9_2 .. "\n"
	end

	local var_9_3 = var_9_1 .. FightEditorStateLogView.processStr(tostring(var_9_0))

	ZProj.UGUIHelper.CopyText(var_9_3)
end

function var_0_0._onLastBattleIdYiPaiYiDongChange(arg_10_0, arg_10_1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, arg_10_1)
end

function var_0_0._onVersionChange(arg_11_0, arg_11_1)
	FightModel.GMForceVersion = tonumber(arg_11_1)
end

function var_0_0._onClickEnterYiPaiYiDong(arg_12_0)
	local var_12_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, "")

	if string.nilorempty(var_12_0) then
		return
	end

	local var_12_1 = tonumber(var_12_0)

	if var_12_1 and lua_battle.configDict[var_12_1] then
		local var_12_2 = FightController.instance:setFightParamByBattleId(var_12_1)

		HeroGroupModel.instance:setParam(var_12_1, nil, nil)

		local var_12_3 = HeroGroupModel.instance:getCurGroupMO()

		if not var_12_3 then
			logError("current HeroGroupMO is nil")
			GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

			return
		end

		local var_12_4, var_12_5 = var_12_3:getMainList()
		local var_12_6, var_12_7 = var_12_3:getSubList()
		local var_12_8 = var_12_3:getAllHeroEquips()

		arg_12_0:closeThis()

		for iter_12_0, iter_12_1 in ipairs(lua_episode.configList) do
			if iter_12_1.battleId == var_12_1 then
				var_12_2.episodeId = iter_12_1.id
				FightResultModel.instance.episodeId = iter_12_1.id

				DungeonModel.instance:SetSendChapterEpisodeId(iter_12_1.chapterId, iter_12_1.id)

				break
			end
		end

		if not var_12_2.episodeId then
			var_12_2.episodeId = 10101
		end

		var_12_2:setMySide(var_12_3.clothId, var_12_4, var_12_6, var_12_8)

		var_12_2.fightActType = FightEnum.FightActType.Season2

		FightController.instance:sendTestFightId(var_12_2)
	end
end

function var_0_0._onClickShowBattleCharaterParam(arg_13_0)
	local var_13_0 = GMBattleModel.instance:getBattleParam()

	if not string.nilorempty(var_13_0) then
		local var_13_1 = string.gsub(var_13_0, "{", "\n{\n")
		local var_13_2 = string.gsub(var_13_1, ",", ",\n")

		logError(var_13_2)
	else
		logError("数据为空")
	end
end

function var_0_0._onClickEnableGMFightRecord(arg_14_0)
	GMBattleModel.instance:setGMFightRecordEnable()
	GameFacade.showToast(ToastEnum.IconId, "开启战斗录制，请在结算界面点击保存")
end

function var_0_0._onClickSaveRecord(arg_15_0)
	arg_15_0:addEventCb(FightController.instance, FightEvent.OnGMFightWithRecordAllReply, arg_15_0._onGetRecord, arg_15_0)
	FightRpc.instance:sendGetFightRecordAllRequest()
end

function var_0_0._onGetRecord(arg_16_0)
	arg_16_0:removeEventCb(FightController.instance, FightEvent.OnGMFightWithRecordAllReply, arg_16_0._onGetRecord, arg_16_0)
	FightGMRecordView.saveRecord()
end

function var_0_0._onClickGMFightRecordReplay(arg_17_0)
	local var_17_0 = WindowsUtil.getSelectFileContent("选取战斗录制文件", "json")
	local var_17_1 = cjson.decode(var_17_0)
	local var_17_2 = ProtoTestCaseMO.New()

	var_17_2:deserialize(var_17_1)

	local var_17_3 = var_17_2:buildProtoMsg()
	local var_17_4 = var_17_1.fightParam

	FightController.instance:setFightParamByEpisodeId(var_17_4.episodeId, true, 1, var_17_4.battleId).isShowSettlement = false

	FightRpc.instance:sendFightWithRecordAllRequest(var_17_3)
end

function var_0_0._onClickGMFightLog(arg_18_0)
	ViewMgr.instance:openView(ViewName.FightEditorStateView)
	ViewMgr.instance:closeView(ViewName.GMToolView)
end

function var_0_0.onStatBuffToggleValueChange(arg_19_0)
	if not GameSceneMgr.instance:isFightScene() then
		return
	end

	if not arg_19_0._isInit then
		return
	end

	if arg_19_0.statBuffToggle.isOn then
		local var_19_0 = arg_19_0.buffTypeInput:GetText()
		local var_19_1 = tonumber(var_19_0)

		if not (var_19_1 and lua_skill_bufftype.configDict[var_19_1]) then
			GameFacade.showToastString(string.format("buff类 : %s 不存在", var_19_1))

			arg_19_0.statBuffToggle.isOn = false

			return
		end

		GMFightController.instance:startStatBuffType(var_19_1)
	else
		GMFightController.instance:stopStatBuffType()
	end
end

function var_0_0.onClickUseNewCardScript(arg_20_0)
	FightMgr.instance:changeCardScript(true)
	logError("使用新卡牌逻辑")
end

function var_0_0.onClickUseOldCardScript(arg_21_0)
	FightMgr.instance:changeCardScript(false)
	logError("使用旧卡牌逻辑")
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
