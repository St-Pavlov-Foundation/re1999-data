module("modules.logic.versionactivity2_7.act191.view.Act191AdventureView", package.seeall)

slot0 = class("Act191AdventureView", BaseView)

function slot0.onInitView(slot0)
	slot0._goLive2d = gohelper.findChild(slot0.viewGO, "live2dcontainer/#go_Live2d")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#txt_Title")
	slot0._btnEnemyInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#txt_Title/#btn_EnemyInfo")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#txt_Desc")
	slot0._txtTarget = gohelper.findChildText(slot0.viewGO, "#txt_Target")
	slot0._goReward = gohelper.findChild(slot0.viewGO, "#go_Reward")
	slot0._btnNext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Next")
	slot0._txtNext = gohelper.findChildText(slot0.viewGO, "#btn_Next/#txt_Next")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnemyInfo:AddClickListener(slot0._btnEnemyInfoOnClick, slot0)
	slot0._btnNext:AddClickListener(slot0._btnNextOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnemyInfo:RemoveClickListener()
	slot0._btnNext:RemoveClickListener()
end

function slot0._btnEnemyInfoOnClick(slot0)
	if slot0.battleId then
		EnemyInfoController.instance:openAct191EnemyInfoView(slot0.battleId)
	end
end

function slot0._btnNextOnClick(slot0)
	if slot0.nodeDetailMo.type == Activity191Enum.NodeType.RewardEvent then
		Activity191Rpc.instance:sendGain191RewardEventRequest(Activity191Model.instance:getCurActId(), slot0.onGainRewardReply, slot0)
	elseif slot0.nodeDetailMo.type == Activity191Enum.NodeType.BattleEvent then
		Activity191Controller.instance:enterFightScene(slot0.nodeDetailMo)
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)

	slot0.nodeDetailMo = slot0.viewParam
	slot0.eventCo = lua_activity191_event.configDict[slot0.nodeDetailMo.eventId]
	slot0._txtTitle.text = GameUtil.setFirstStrSize(slot0.eventCo.title, 62)
	slot0._txtDesc.text = slot0.eventCo.desc
	slot0._txtTarget.text = slot0.eventCo.task

	if slot0.nodeDetailMo.type == Activity191Enum.NodeType.RewardEvent then
		slot0._txtNext.text = luaLang("act191adventureview_gainreward")

		gohelper.setActive(slot0._btnEnemyInfo, false)
	elseif slot0.nodeDetailMo.type == Activity191Enum.NodeType.BattleEvent then
		slot0._txtNext.text = luaLang("act191adventureview_start")

		gohelper.setActive(slot0._btnEnemyInfo, true)

		slot0.battleId = DungeonConfig.instance:getEpisodeCO(lua_activity191_fight_event.configDict[slot0.nodeDetailMo.fightEventId].episodeId) and slot3.battleId
	end

	slot0._uiSpine = GuiModelAgent.Create(slot0._goLive2d, true)

	if FightConfig.instance:getSkinCO(slot0.eventCo.skinId) then
		slot0._uiSpine:setResPath(slot1, function ()
			uv0._uiSpine:setLayer(UnityLayer.Unit)
		end, slot0)

		if not string.nilorempty(slot0.eventCo.offset) then
			slot2 = string.splitToNumber(slot0.eventCo.offset, "#")

			recthelper.setAnchor(slot0._goLive2d.transform, slot2[1], slot2[2])

			if slot2[3] then
				transformhelper.setLocalScale(slot0._goLive2d.transform, slot3, slot3, 1)
			end
		end
	end

	for slot6, slot7 in ipairs(GameUtil.splitString2(slot0.eventCo.rewardView, true)) do
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.RewardItem, slot0._goReward), Act191RewardItem):setData(slot7[1], slot7[2])
	end
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
end

function slot0.onGainRewardReply(slot0, slot1, slot2)
	if slot2 == 0 then
		ViewMgr.instance:closeView(slot0.viewName)

		if not Activity191Controller.instance:checkOpenGetView() then
			Activity191Controller.instance:nextStep()
		end
	end
end

return slot0
