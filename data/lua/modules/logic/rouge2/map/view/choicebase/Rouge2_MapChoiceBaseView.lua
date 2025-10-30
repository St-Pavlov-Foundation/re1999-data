﻿-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MapChoiceBaseView.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MapChoiceBaseView", package.seeall)

local Rouge2_MapChoiceBaseView = class("Rouge2_MapChoiceBaseView", BaseView)

function Rouge2_MapChoiceBaseView:onInitView()
	self._goBG = gohelper.findChild(self.viewGO, "#go_BG")
	self._txtName = gohelper.findChildText(self.viewGO, "Title/#txt_Name")
	self._goDialogueList = gohelper.findChild(self.viewGO, "Right/#go_DialogueList")
	self._scrollDialgoue = gohelper.findChild(self.viewGO, "Right/#go_DialogueList/#scroll_Dialogue")
	self._scrollChoiceList = gohelper.findChild(self.viewGO, "Right/#scroll_choiceList")
	self._gochoicecontainer = gohelper.findChild(self.viewGO, "Right/#scroll_choiceList/Viewport/#go_choicecontainer")
	self._godialogueblock = gohelper.findChild(self.viewGO, "#go_dialogueblock")
	self._goAttribute = gohelper.findChild(self.viewGO, "Left/#go_Attribute")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapChoiceBaseView:addEvents()
	self.scrollClick = gohelper.getClickWithDefaultAudio(self._scrollDialgoue.gameObject)

	self.scrollClick:AddClickListener(self.onClickDialogueBlock, self)

	self.dialogueBlockClick = gohelper.getClickWithDefaultAudio(self._godialogueblock)

	self.dialogueBlockClick:AddClickListener(self.onClickDialogueBlock, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onChoiceDialogueDone, self.onChoiceDialogueDone, self)
end

function Rouge2_MapChoiceBaseView:removeEvents()
	self.scrollClick:RemoveClickListener()
	self.dialogueBlockClick:RemoveClickListener()
end

function Rouge2_MapChoiceBaseView:_editableInitView()
	gohelper.setActive(self._goBG, false)
	Rouge2_AttributeToolBar.Load(self._goAttribute, Rouge2_Enum.AttributeToolType.Default)

	self.goRight = gohelper.findChild(self.viewGO, "Right")
	self.choiceItemList = {}

	self:initChoiceTemplate()
	self:initDialogueList()

	self.animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self.rightAnimator = gohelper.onceAddComponent(self.goRight, gohelper.Type_Animator)
end

function Rouge2_MapChoiceBaseView:initDialogueList()
	self._dialogueListComp = Rouge2_MapDialogueListComp.Get(self._goDialogueList, self.viewName)
end

function Rouge2_MapChoiceBaseView:initChoiceTemplate()
	self.goChoiceItem = self.viewContainer:getResInst(Rouge2_Enum.ResPath.MapChoiceItem, self._gochoicecontainer)

	gohelper.setActive(self.goChoiceItem, false)
end

function Rouge2_MapChoiceBaseView:onChangeMapInfo()
	self:closeThis()
end

function Rouge2_MapChoiceBaseView:onClickDialogueBlock()
	self:_initStateHandle()

	local handle = self._stateHandleDict[self.state]

	if handle then
		handle(self)
	end
end

function Rouge2_MapChoiceBaseView:_initStateHandle()
	if self._stateHandleDict then
		return
	end

	self._stateHandleDict = {
		[Rouge2_MapEnum.ChoiceViewState.PlayingDialogue] = self.onClickBlockOnPlayingState,
		[Rouge2_MapEnum.ChoiceViewState.Finish] = self.onClickBlockOnFinishState
	}
end

function Rouge2_MapChoiceBaseView:onClickBlockOnFinishState()
	return
end

function Rouge2_MapChoiceBaseView:onClickBlockOnPlayingState()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.quickSetDialogueDone)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSwitchNextChoiceDialogue)
end

function Rouge2_MapChoiceBaseView:changeState(state)
	if self.state == state then
		return
	end

	self.state = state

	local isBlock = self.state ~= Rouge2_MapEnum.ChoiceViewState.WaitSelect and self.state ~= Rouge2_MapEnum.ChoiceViewState.DialogueDone

	gohelper.setActive(self._godialogueblock, isBlock)
	gohelper.setActive(self._gochoicecontainer, self.state == Rouge2_MapEnum.ChoiceViewState.WaitSelect)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onChangeChoiceViewState, self.state)
end

function Rouge2_MapChoiceBaseView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewOpen)
	self:changeState(Rouge2_MapEnum.ChoiceViewState.PlayingDialogue)
end

function Rouge2_MapChoiceBaseView:startPlayDialogue(playInfoList, callback, callbackObj)
	if self.closeed then
		logError("start dialogue after close view !!!")

		return
	end

	self:changeState(Rouge2_MapEnum.ChoiceViewState.PlayingDialogue)
	self._dialogueListComp:startPlayDialogue(playInfoList, callback, callbackObj)
end

function Rouge2_MapChoiceBaseView:onChoiceDialogueDone()
	self:changeState(Rouge2_MapEnum.ChoiceViewState.DialogueDone)
end

function Rouge2_MapChoiceBaseView:playChoiceShowAnim()
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	self.rightAnimator:Play("tochoice", 0, 0)

	self.showChoice = true
end

function Rouge2_MapChoiceBaseView:playChoiceHideAnim()
	self.rightAnimator:Play("todialogue", 0, 0)

	self.showChoice = false
end

function Rouge2_MapChoiceBaseView:onClose()
	self.closeed = true
end

function Rouge2_MapChoiceBaseView:onDestroyView()
	Rouge2_MapHelper.destroyItemList(self.choiceItemList)
end

return Rouge2_MapChoiceBaseView
