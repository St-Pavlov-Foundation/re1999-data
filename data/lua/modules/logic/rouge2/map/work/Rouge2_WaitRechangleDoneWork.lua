﻿-- chunkname: @modules/logic/rouge2/map/work/Rouge2_WaitRechangleDoneWork.lua

module("modules.logic.rouge2.map.work.Rouge2_WaitRechangleDoneWork", package.seeall)

local Rouge2_WaitRechangleDoneWork = class("Rouge2_WaitRechangleDoneWork", BaseWork)

function Rouge2_WaitRechangleDoneWork:ctor()
	return
end

function Rouge2_WaitRechangleDoneWork:onStart()
	if not Rouge2_Model.instance:inRouge() then
		self:onDone(false)

		return
	end

	if Rouge2_MapModel.instance:isInteractiving() then
		self:onDone(true)

		return
	end

	if not self:checkNeedContinueFight() then
		self:onDone(true)

		return
	end

	local chapterId, episodeId = self:_getContinueFightEpisodeId()

	if not chapterId or not episodeId or chapterId == 0 or episodeId == 0 then
		self:onDone(true)

		return
	end

	local fightEventCo = Rouge2_MapConfig.instance:getFightEvent(episodeId)
	local dieTwice = fightEventCo and fightEventCo.dieTwice or 0

	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.Rouge2FightFailConfirm, MsgBoxEnum.BoxType.Yes_No, luaLang("rouge2_continue_fight"), "RE CHALLENGE", luaLang("rouge2_abort_fight"), "QUIT", self.continueFight, self.endRouge, nil, self, self, nil, dieTwice)

	return true
end

function Rouge2_WaitRechangleDoneWork:checkNeedContinueFight()
	if Rouge2_MapModel.instance:isNormalLayer() then
		local curNode = Rouge2_MapModel.instance:getCurNode()
		local eventMo = curNode and curNode.eventMo

		return eventMo and not curNode:isFinishEvent() and eventMo.fightFail == true
	elseif Rouge2_MapModel.instance:isMiddle() then
		local curPieceMo = Rouge2_MapModel.instance:getCurPieceMo()

		return curPieceMo and not curPieceMo:isFinish() and curPieceMo:isFightFail()
	end
end

function Rouge2_WaitRechangleDoneWork:continueFight()
	local chapterId, episodeId = self:_getContinueFightEpisodeId()

	DungeonFightController.instance:enterFight(chapterId, episodeId)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
end

function Rouge2_WaitRechangleDoneWork:_getContinueFightEpisodeId()
	local chapterId = Rouge2_MapEnum.ChapterId
	local episodeId

	if Rouge2_MapModel.instance:isNormalLayer() then
		episodeId = self:_getNodeFightEpisodeId()
	else
		local curPieceMo = Rouge2_MapModel.instance:getCurPieceMo()
		local selectId = curPieceMo and curPieceMo:getLastSelectId()
		local co = lua_rouge2_piece_select.configDict[selectId]
		local paramArray = string.splitToNumber(co.triggerParam, "#")

		episodeId = paramArray[1]

		Rouge2_MapModel.instance:setEndId(paramArray[2])
	end

	return chapterId, episodeId
end

function Rouge2_WaitRechangleDoneWork:_getNodeFightEpisodeId()
	local nodeMo = Rouge2_MapModel.instance:getCurNode()
	local eventCo = nodeMo:getEventCo()
	local eventMo = nodeMo.eventMo
	local eventType = eventCo and eventCo.type
	local isFightEvent = Rouge2_MapHelper.isFightEvent(eventType)

	if isFightEvent then
		local fightEventCo = Rouge2_MapConfig.instance:eventId2FightEventCo(eventCo.id)

		return fightEventCo and fightEventCo.episodeId
	end

	local isChoiceEvent = Rouge2_MapHelper.isChoiceEvent(eventType)

	if isChoiceEvent then
		return eventMo and eventMo:getChoiceEpisodeId()
	end
end

function Rouge2_WaitRechangleDoneWork:onOpenViewFinish(viewName)
	if viewName ~= ViewName.Rouge2_HeroGroupFightView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)

	local fightParam = FightModel.instance:getFightParam()

	fightParam.isReplay = false
	fightParam.multiplication = 1

	DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
	self:onDone(true)
end

function Rouge2_WaitRechangleDoneWork:endRouge()
	Rouge2_Rpc.instance:sendRouge2AbortRequest(self._onReceiveEndReply, self)
end

function Rouge2_WaitRechangleDoneWork:_onReceiveEndReply()
	ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenView, self.onBeforeOpenView, self)
	Rouge2_MapHelper.backToMainScene()
end

function Rouge2_WaitRechangleDoneWork:onBeforeOpenView(viewName)
	if viewName ~= ViewName.Rouge2_EnterView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.BeforeOpenView, self.onBeforeOpenView, self)
	Rouge2_Controller.instance:startEndFlow()
end

function Rouge2_WaitRechangleDoneWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.BeforeOpenView, self.onBeforeOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
end

return Rouge2_WaitRechangleDoneWork
