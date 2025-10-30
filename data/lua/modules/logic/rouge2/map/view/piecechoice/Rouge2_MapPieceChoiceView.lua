-- chunkname: @modules/logic/rouge2/map/view/piecechoice/Rouge2_MapPieceChoiceView.lua

module("modules.logic.rouge2.map.view.piecechoice.Rouge2_MapPieceChoiceView", package.seeall)

local Rouge2_MapPieceChoiceView = class("Rouge2_MapPieceChoiceView", Rouge2_MapChoiceBaseView)

function Rouge2_MapPieceChoiceView:_editableInitView()
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onExitPieceChoiceEvent, self.closeThis, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onSelectPieceChoice, self.onSelectPieceChoice, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onPopViewDone, self.onPopViewDone, self)
	Rouge2_MapPieceChoiceView.super._editableInitView(self)

	local goTitle = gohelper.findChild(self.viewGO, "Title")

	gohelper.setActive(goTitle, false)

	self._goFullBG = gohelper.findChild(self.viewGO, "#go_BG/#simage_FullBG")

	gohelper.setActive(self._goBG, true)
	gohelper.setActive(self._goFullBG, false)
end

function Rouge2_MapPieceChoiceView:onClickBlockOnFinishState()
	self:triggerHandle()
end

function Rouge2_MapPieceChoiceView:onSelectPieceChoice(pieceMo, choiceId)
	self._selectPieceMo = pieceMo
	self._choiceId = choiceId
	self.preSelectChoiceId = choiceId
	self._waitUpdate = true

	self:triggerSelectDesc()
end

function Rouge2_MapPieceChoiceView:onPopViewDone()
	self:triggerSelectDesc()
end

function Rouge2_MapPieceChoiceView:triggerSelectDesc()
	if not self._waitUpdate then
		return
	end

	if Rouge2_PopController.instance:isPopping() then
		return
	end

	self._waitUpdate = false

	if Rouge2_MapDialogueHelper.pieceHasLastSelectDesc(self._selectPieceMo) then
		self:changeState(Rouge2_MapEnum.ChoiceViewState.PlayingDialogue)
		self:playChoiceHideAnim()
		Rouge2_MapDialogueHelper.selectPieceDialogue(self._dialogueListComp, self._selectPieceMo, self.onSelectDialogueDone, self)

		return
	end

	self:triggerHandle()
end

function Rouge2_MapPieceChoiceView:onSelectDialogueDone()
	if self._selectPieceMo:isFinish() then
		self:changeState(Rouge2_MapEnum.ChoiceViewState.Finish)
		self:triggerHandle()

		return
	end

	local canSelectIds = self._selectPieceMo:getCanselectIds()

	if canSelectIds and #canSelectIds > 0 then
		self:changeState(Rouge2_MapEnum.ChoiceViewState.WaitSelect)
		self:playChoiceShowAnim()
		self:refreshChoice()

		return
	end

	self:triggerHandle()
end

function Rouge2_MapPieceChoiceView:triggerHandle()
	Rouge2_MapPieceTriggerHelper.triggerHandle(self._selectPieceMo, self._choiceId)

	self._selectPieceMo = nil
	self._choiceId = nil

	self:changeState(Rouge2_MapEnum.ChoiceViewState.WaitSelect)
end

function Rouge2_MapPieceChoiceView:initData()
	self.pieceMo = self.viewParam
	self.talkId = self.pieceMo.talkId
	self.talkCo = lua_rouge2_piece_talk.configDict[self.talkId]
	self.preSelectChoiceId = 0
end

function Rouge2_MapPieceChoiceView:onOpen()
	Rouge2_MapPieceChoiceView.super.onOpen(self)
	self:initData()
	self:refreshUI()
	self:refreshDesc()
end

function Rouge2_MapPieceChoiceView:refreshUI()
	self._txtName.text = self.talkCo.title
end

function Rouge2_MapPieceChoiceView:refreshDesc()
	Rouge2_MapDialogueHelper.initPieceDialogue(self._dialogueListComp, self.pieceMo, self.enterDialogueDone, self)
end

function Rouge2_MapPieceChoiceView:enterDialogueDone()
	gohelper.setActive(self.goRight, true)
	gohelper.setActive(self.goLeft, true)
	self:changeState(Rouge2_MapEnum.ChoiceViewState.WaitSelect)
	self:playChoiceShowAnim()
	self:refreshChoice()
end

function Rouge2_MapPieceChoiceView:noAnimRefreshRight()
	self:refreshChoice()
end

function Rouge2_MapPieceChoiceView:refreshChoice()
	local choiceIdList = self.pieceMo:getCanselectIds()

	Rouge2_MapHelper.loadItemWithCustomUpdateFunc(self.goChoiceItem, Rouge2_MapPieceChoiceItem, choiceIdList, self.choiceItemList, self.updateItem, self)
end

function Rouge2_MapPieceChoiceView:updateItem(item, index, choiceId)
	item:update(choiceId, self.pieceMo, index)
end

function Rouge2_MapPieceChoiceView:onDestroyView()
	Rouge2_MapPieceChoiceView.super.onDestroyView(self)
end

return Rouge2_MapPieceChoiceView
