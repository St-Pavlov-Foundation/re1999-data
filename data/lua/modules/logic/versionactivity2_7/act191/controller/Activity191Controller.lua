module("modules.logic.versionactivity2_7.act191.controller.Activity191Controller", package.seeall)

slot0 = class("Activity191Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterActivity(slot0, slot1)
	Activity191Rpc.instance:sendGetAct191InfoRequest(slot1, slot0.enterReply, slot0)
end

function slot0.enterReply(slot0, slot1, slot2)
	if slot2 == 0 then
		slot0:openMainView()
	end
end

function slot0.openMainView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act191MainView, slot1)
end

function slot0.openFetterTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act191FetterTipView, slot1)
end

function slot0.openStoreView(slot0, slot1)
	if not VersionActivityEnterHelper.checkCanOpen(slot1) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(slot1, slot0._openStoreViewAfterRpc, slot0)
end

function slot0.openResultPanel(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act191FightSuccView, slot1)
end

function slot0.openSettlementView(slot0)
	ViewMgr.instance:openView(ViewName.Act191SettlementView)
end

function slot0.openHeroTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act191HeroTipView, slot1)
end

function slot0.openCollectionTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act191CollectionTipView, slot1)
end

function slot0.openEnhanceTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act191EnhanceTipView, slot1)
end

function slot0.openItemView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act191ItemView, slot1)
end

function slot0._openStoreViewAfterRpc(slot0, slot1, slot2)
	if slot2 == 0 then
		ViewMgr.instance:openView(ViewName.Act191StoreView)
	end
end

function slot0.enterGame(slot0)
	if Activity191Model.instance:getActInfo():getGameInfo().state == Activity191Enum.GameState.Normal then
		if slot1.curStage == 0 and slot1.curNode == 0 then
			ViewMgr.instance:openView(ViewName.Act191InitBuildView)
		else
			slot0:nextStep()
		end
	elseif slot1.state == Activity191Enum.GameState.End then
		Activity191Rpc.instance:sendEndAct191GameRequest(slot0.actId)
	end
end

function slot0.nextStep(slot0)
	slot1 = Activity191Model.instance:getActInfo():getGameInfo()

	if string.nilorempty(Activity191Helper.matchKeyInArray(slot1.nodeInfo, slot1.curNode, "nodeId").nodeStr) then
		ViewMgr.instance:openView(ViewName.Act191StageView)

		if slot1.nodeChange then
			ViewMgr.instance:openView(ViewName.Act191SwitchView)
		end
	else
		slot3 = Act191NodeDetailMO.New()

		slot3:init(slot2.nodeStr)

		if Activity191Helper.isShopNode(slot3.type) then
			ViewMgr.instance:openView(ViewName.Act191ShopView, slot3)
		elseif slot3.type == Activity191Enum.NodeType.Enhance then
			ViewMgr.instance:openView(ViewName.Act191EnhancePickView, slot3)
		elseif slot3.type == Activity191Enum.NodeType.RewardEvent then
			ViewMgr.instance:openView(ViewName.Act191AdventureView, slot3)
		elseif slot3.type == Activity191Enum.NodeType.BattleEvent then
			ViewMgr.instance:openView(ViewName.Act191AdventureView, slot3)
		elseif Activity191Helper.isPveBattle(slot3.type) then
			slot0:enterFightScene(slot3)
		elseif Activity191Helper.isPvpBattle(slot3.type) then
			slot0:enterFightScene(slot3)
		end
	end
end

function slot0.enterFightScene(slot0, slot1)
	slot2 = nil

	if Activity191Helper.isPveBattle(slot1.type) or slot1.type == Activity191Enum.NodeType.BattleEvent then
		slot2 = lua_activity191_fight_event.configDict[slot1.fightEventId].episodeId
	elseif Activity191Helper.isPvpBattle(slot1.type) then
		slot2 = tonumber(lua_activity191_const.configDict[Activity191Enum.ConstKey.PvpBattleEpisodeId].value)
	end

	slot3 = DungeonConfig.instance:getEpisodeCO(slot2)

	DungeonModel.instance:SetSendChapterEpisodeId(slot3.chapterId, slot2)
	FightController.instance:setFightParamByEpisodeAndBattle(slot2, slot3.battleId):setPreload()
	FightController.instance:enterFightScene()
end

function slot0.startFight(slot0)
	if not Activity191Model.instance:getActInfo():getGameInfo():teamHasMainHero() then
		GameFacade.showToastString("请上阵主战英雄")

		return
	end

	slot2 = DungeonModel.instance.curSendEpisodeId
	slot3 = DungeonConfig.instance:getEpisodeCO(slot2)

	FightController.instance:setFightParamByEpisodeAndBattle(slot2, slot3.battleId):setDungeon(slot3.chapterId, slot2)
	DungeonRpc.instance:sendStartDungeonRequest(slot3.chapterId, slot2)
end

function slot0.checkOpenGetView(slot0)
	slot2 = false

	for slot6, slot7 in ipairs(Activity191Model.instance:getActInfo().triggerEffectPushList) do
		if not string.nilorempty(slot7.param) then
			slot2 = true

			break
		end
	end

	if slot2 then
		ViewMgr.instance:openView(ViewName.Act191GetView)

		return true
	end

	slot1:clearTriggerEffectPush()

	return false
end

slot0.instance = slot0.New()

return slot0
