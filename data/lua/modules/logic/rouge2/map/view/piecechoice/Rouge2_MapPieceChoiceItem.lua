﻿-- chunkname: @modules/logic/rouge2/map/view/piecechoice/Rouge2_MapPieceChoiceItem.lua

module("modules.logic.rouge2.map.view.piecechoice.Rouge2_MapPieceChoiceItem", package.seeall)

local Rouge2_MapPieceChoiceItem = class("Rouge2_MapPieceChoiceItem", Rouge2_MapChoiceBaseItem)

function Rouge2_MapPieceChoiceItem:_editableInitView()
	Rouge2_MapPieceChoiceItem.super._editableInitView(self)

	self._checkItem1 = Rouge2_MapPieceChoiceCheckItem.Get(self._gocheck1)
	self._checkItem2 = Rouge2_MapPieceChoiceCheckItem.Get(self._gocheck2)

	self._checkItem1:onSelect(false)
	self._checkItem2:onSelect(true)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onChoiceItemStatusChange, self.onStatusChange, self)
end

function Rouge2_MapPieceChoiceItem:onClickSelf()
	if Rouge2_MapModel.instance:isInteractiving() then
		return
	end

	if Rouge2_MapModel.instance:isPlayingDialogue() then
		return
	end

	if self:canShowLockUI() then
		return
	end

	self:handleNormalChoice()
end

function Rouge2_MapPieceChoiceItem:handleNormalChoice()
	if self.status == Rouge2_MapEnum.ChoiceStatus.Select then
		self.animator:Play("select", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Rouge2.SelectChoice)
		TaskDispatcher.cancelTask(self.onNormalChoiceSelectAnimDone, self)
		TaskDispatcher.runDelay(self.onNormalChoiceSelectAnimDone, self, Rouge2_MapEnum.ChoiceSelectAnimDuration)
		UIBlockMgr.instance:startBlock(Rouge2_MapEnum.WaitChoiceItemAnimBlock)
	else
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onChoiceItemStatusChange, self.dataId)
	end
end

function Rouge2_MapPieceChoiceItem:onNormalChoiceSelectAnimDone()
	UIBlockMgr.instance:endBlock(Rouge2_MapEnum.WaitChoiceItemAnimBlock)

	local choiceCo = lua_rouge2_piece_select.configDict[self.choiceId]
	local triggerType = choiceCo.triggerType
	local endEpisodeId = self.pieceMo:getEndEpisodeId()

	if triggerType == Rouge2_MapEnum.PieceTriggerType.EndFight and endEpisodeId and endEpisodeId ~= 0 then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectPieceChoice, self.pieceMo, self.choiceId)

		return
	end

	self:clearCallback()

	local layer = Rouge2_MapModel.instance:getLayerId()
	local middleLayer = Rouge2_MapModel.instance:getMiddleLayerId()
	local index = Rouge2_MapModel.instance:getCurPosIndex()

	self.callbackId = Rouge2_Rpc.instance:sendRouge2PieceTalkSelectRequest(layer, middleLayer, index, self.choiceId, self.onReceiveMsg, self)
end

function Rouge2_MapPieceChoiceItem:onReceiveMsg()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectPieceChoice, self.pieceMo, self.choiceId)
end

function Rouge2_MapPieceChoiceItem:onStatusChange(dataId)
	if self.status == Rouge2_MapEnum.ChoiceStatus.Lock then
		return
	end

	local status

	if dataId then
		if dataId == self.dataId then
			status = Rouge2_MapEnum.ChoiceStatus.Select
		else
			status = Rouge2_MapEnum.ChoiceStatus.UnSelect
		end
	else
		status = Rouge2_MapEnum.ChoiceStatus.Normal
	end

	if status == self.status then
		return
	end

	self.status = status

	self:refreshUI()
end

function Rouge2_MapPieceChoiceItem:update(choiceId, pieceMo, index)
	Rouge2_MapPieceChoiceItem.super.update(self, index)

	self.choiceId = choiceId
	self.dataId = choiceId
	self.pieceMo = pieceMo
	self.choiceCo = lua_rouge2_piece_select.configDict[choiceId]
	self.desc = Rouge2_MapHelper.buildChoiceDesc(self.choiceCo.content)
	self.title = self.choiceCo.title
	self.status = Rouge2_MapPieceTriggerHelper.getChoiceStatus(pieceMo, choiceId)
	self.tip = Rouge2_MapPieceTriggerHelper.getTip(self.pieceMo, self.choiceId, self.status)

	self:refreshUI()
	self:playUnlockAnim()
	self:updateCheckInfo()
end

function Rouge2_MapPieceChoiceItem:updateCheckInfo()
	self._checkItem1:updateInfo(self.pieceMo, self.choiceCo)
	self._checkItem2:updateInfo(self.pieceMo, self.choiceCo)
end

function Rouge2_MapPieceChoiceItem:canShowLockUI()
	return self.status == Rouge2_MapEnum.ChoiceStatus.Lock
end

function Rouge2_MapPieceChoiceItem:playUnlockAnim()
	if not self.choiceCo then
		return
	end

	local activeType = Rouge2_MapUnlockHelper.getUnlockTypeAndParam(self.choiceCo.active)

	if activeType == 0 then
		return
	end

	if Rouge2_MapController.instance:checkPieceChoicePlayedUnlockAnim(self.choiceId) then
		return
	end

	if Rouge2_MapUnlockHelper.checkIsUnlock(self.choiceCo.active) then
		self.animator:Play("unlock", 0, 0)
		Rouge2_MapController.instance:playedPieceChoiceEvent(self.choiceId)
	end
end

function Rouge2_MapPieceChoiceItem:destroy()
	Rouge2_MapPieceChoiceItem.super.destroy(self)
end

return Rouge2_MapPieceChoiceItem
