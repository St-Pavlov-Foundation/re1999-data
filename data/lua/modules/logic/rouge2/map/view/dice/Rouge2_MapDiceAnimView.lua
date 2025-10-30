﻿-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapDiceAnimView.lua

module("modules.logic.rouge2.map.view.dice.Rouge2_MapDiceAnimView", package.seeall)

local Rouge2_MapDiceAnimView = class("Rouge2_MapDiceAnimView", BaseView)
local dicePosRangeX = 50
local dicePosRangeY = 50
local FixValueMoveDuration = 0.4
local WaitSec2MoveOtherValue = 0.06
local FixValueFadeOutWaitTime = 0.1
local FixValueFadeOutDuration = 0.15
local MiddleValueFadeInDuration = 0.3
local DiceAnimDuration = 2
local WaitSeconds2Close = 2

Rouge2_MapDiceAnimView.DiceType = {
	Twenty = 20,
	Six = 6
}
Rouge2_MapDiceAnimView.DiceType2Cls = {
	[Rouge2_MapDiceAnimView.DiceType.Six] = Rouge2_MapSixDiceItem,
	[Rouge2_MapDiceAnimView.DiceType.Twenty] = Rouge2_MapTwentyDiceItem
}
Rouge2_MapDiceAnimView.CheckResult2InfoAnim = {
	[Rouge2_MapEnum.AttrCheckResult.None] = "idle",
	[Rouge2_MapEnum.AttrCheckResult.Succeed] = "succeed",
	[Rouge2_MapEnum.AttrCheckResult.Failure] = "failure",
	[Rouge2_MapEnum.AttrCheckResult.BigSucceed] = "bigsucceed"
}

function Rouge2_MapDiceAnimView:onInitView()
	self._goInfo = gohelper.findChild(self.viewGO, "root/#go_Info")
	self._imageRateAttribute = gohelper.findChildImage(self.viewGO, "root/#go_Info/Rate/#image_Attribute")
	self._txtRate = gohelper.findChildText(self.viewGO, "root/#go_Info/Rate/#txt_Rate")
	self._txtFixAttributeName = gohelper.findChildText(self.viewGO, "root/#go_Info/Value/#txt_AttributeName")
	self._imageFixAttribute = gohelper.findChildImage(self.viewGO, "root/#go_Info/Value/#image_Attribute")
	self._txtFixValue = gohelper.findChildText(self.viewGO, "root/#go_Info/Value/#txt_FixValue")
	self._txtTips = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_Tips")
	self._txtTarget = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_Target")
	self._txtMiddle = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_Middle")
	self._goDice = gohelper.findChild(self.viewGO, "root/#go_Dice")
	self._goSixItem = gohelper.findChild(self.viewGO, "root/#go_Dice/#go_SixItem")
	self._goTwentyItem = gohelper.findChild(self.viewGO, "root/#go_Dice/#go_TwentyItem")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Click", AudioEnum.Rouge2.StartDice)
	self._btnJump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Jump")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._goResult = gohelper.findChild(self.viewGO, "root/#go_Result")
	self._goFailure = gohelper.findChild(self.viewGO, "root/#go_Result/#go_Failure")
	self._goSucceed = gohelper.findChild(self.viewGO, "root/#go_Result/#go_Succeed")
	self._goBigSucceed = gohelper.findChild(self.viewGO, "root/#go_Result/#go_BigSucceed")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapDiceAnimView:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnJump:AddClickListener(self._btnJumpOnClick, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.OnJumpFinishDice, self._onJumpFinishDice, self)
end

function Rouge2_MapDiceAnimView:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnJump:RemoveClickListener()
end

function Rouge2_MapDiceAnimView:_btnClickOnClick()
	gohelper.setActive(self._btnClick.gameObject, false)
	gohelper.setActive(self._btnJump.gameObject, true)
	self:dice()
end

function Rouge2_MapDiceAnimView:_btnJumpOnClick()
	gohelper.setActive(self._btnClick.gameObject, false)
	gohelper.setActive(self._btnJump.gameObject, false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnJumpFinishDice)
end

function Rouge2_MapDiceAnimView:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._infoAnimWorkParam = self:getUserDataTb_()
	self._infoAnimWorkParam.go = self._goInfo
	self._mainView = self.viewContainer._views[1]
	self._diceType2ItemTab = self:getUserDataTb_()

	self:initDicePrefabTab()
	self:initPosList()
end

function Rouge2_MapDiceAnimView:initDicePrefabTab()
	self._diceType2Prefab = self:getUserDataTb_()
	self._diceType2Prefab[Rouge2_MapDiceAnimView.DiceType.Six] = self._goSixItem
	self._diceType2Prefab[Rouge2_MapDiceAnimView.DiceType.Twenty] = self._goTwentyItem

	for _, goDicePrefab in pairs(self._diceType2Prefab) do
		gohelper.setActive(goDicePrefab, false)
	end
end

function Rouge2_MapDiceAnimView:initPosList()
	self._goPosList = self:getUserDataTb_()

	for i = 1, math.huge do
		local gopos = gohelper.findChild(self.viewGO, "root/#go_Dice/#go_poslist/#go_pos" .. i)

		if gohelper.isNil(gopos) then
			return
		end

		table.insert(self._goPosList, gopos)
	end
end

function Rouge2_MapDiceAnimView:onOpen()
	self:initViewParams()
	self:initDiceList()
end

function Rouge2_MapDiceAnimView:initViewParams()
	self._checkCo = self.viewParam and self.viewParam.checkCo
	self._checkResInfo = self.viewParam and self.viewParam.checkResInfo
	self._checkId = self._checkResInfo and self._checkResInfo.checkId
	self._checkDiceRes = self._checkResInfo and GameUtil.splitString2(self._checkResInfo.checkDiceRes, true)
	self._checkRes = self._checkResInfo and self._checkResInfo.checkRes
end

function Rouge2_MapDiceAnimView:getOrCreateDiceItem(diceType, index)
	local diceList = self._diceType2ItemTab[diceType]
	local diceItem = diceList and diceList[index]

	if not diceItem then
		diceList = diceList or {}
		self._diceType2ItemTab[diceType] = diceList

		local cls = Rouge2_MapDiceAnimView.DiceType2Cls[diceType]
		local goTemplate = self._diceType2Prefab[diceType]
		local goDiceItem = gohelper.cloneInPlace(goTemplate, index)

		diceItem = MonoHelper.addNoUpdateLuaComOnceToGo(goDiceItem, cls, self)

		table.insert(diceList, diceItem)
	end

	return diceItem
end

function Rouge2_MapDiceAnimView:initDiceList()
	for _, goPos in pairs(self._goPosList) do
		gohelper.setActive(goPos, false)
	end

	local useMap = {}
	local diceType2Num = {}

	self._totalDicePoint = 0

	for i, diceInfo in ipairs(self._checkDiceRes or {}) do
		local diceId = diceInfo[1]
		local dicePoint = diceInfo[2] or 0
		local diceCo = lua_rouge2_dice.configDict[diceId]
		local diceType = diceCo.sides
		local index = diceType2Num[diceType] or 0

		index = index + 1
		diceType2Num[diceType] = index

		local diceItem = self:getOrCreateDiceItem(diceType, index)
		local goParent = self._goPosList and self._goPosList[i]

		gohelper.addChild(goParent, diceItem.go)
		gohelper.setActive(goParent, true)
		recthelper.setAnchor(diceItem.go.transform, 0, 0)
		diceItem:initInfo(diceInfo)

		useMap[diceItem] = true
		self._totalDicePoint = self._totalDicePoint + dicePoint
	end

	for _, diceItemList in pairs(self._diceType2ItemTab) do
		for _, diceItem in pairs(diceItemList) do
			if not useMap[diceItem] then
				diceItem:setUse(false)
			end
		end
	end

	self._txtMiddle.text = self._totalDicePoint

	gohelper.setActive(self._txtMiddle.gameObject, false)
end

function Rouge2_MapDiceAnimView:dice(diceAnimDuration)
	for _, diceItemList in pairs(self._diceType2ItemTab) do
		for _, diceItem in pairs(diceItemList) do
			diceItem:dice()
		end
	end

	self:playDiceResultFlow(diceAnimDuration)
end

function Rouge2_MapDiceAnimView:playDiceResultFlow(diceAnimDuration)
	self:destroyFlow()

	self._flow = FlowSequence.New()

	self._flow:addWork(WorkWaitSeconds.New(diceAnimDuration or DiceAnimDuration))
	self._flow:addWork(FunctionWork.New(self._showMiddleValue, self))
	self._flow:addWork(TweenWork.New({
		from = 0,
		type = "DOFadeCanvasGroup",
		to = 1,
		t = MiddleValueFadeInDuration,
		go = self._txtMiddle.gameObject
	}))
	self._flow:addWork(self:buildFixValueMoveFlow())

	local infoAnimName = Rouge2_MapDiceAnimView.CheckResult2InfoAnim[self._checkRes]

	if not string.nilorempty(infoAnimName) then
		self._infoAnimWorkParam.animName = infoAnimName

		self._flow:addWork(FunctionWork.New(AudioMgr.trigger, AudioMgr.instance, AudioEnum.Rouge2.DiceValue))
		self._flow:addWork(AnimatorWork.New(self._infoAnimWorkParam))
	end

	self._flow:registerDoneListener(self.playFinishAnim, self)
	self._flow:start()
end

function Rouge2_MapDiceAnimView:buildFixValueMoveFlow()
	local moveFlow = FlowParallel.New()
	local fixItemList = self._mainView:getFixItemList()

	if fixItemList then
		for i, fixItem in ipairs(fixItemList) do
			local fixValue = fixItem.fixValue or 0

			if fixValue ~= 0 then
				local oneFixFlow = self:buildOneFixValueMoveFlow(i, fixItem)

				moveFlow:addWork(oneFixFlow)
			end
		end
	end

	return moveFlow
end

function Rouge2_MapDiceAnimView:buildOneFixValueMoveFlow(index, fixItem)
	local moveFlow = FlowSequence.New()
	local targetPosX, targetPosY = recthelper.rectToRelativeAnchorPos2(self._txtMiddle.transform.position, fixItem.go.transform)
	local params = {
		type = "DOAnchorPos",
		ease = "easeOutQuint",
		tr = fixItem.txtFixValue.transform,
		tox = targetPosX,
		toy = targetPosY,
		t = FixValueMoveDuration
	}
	local waitSec = (index - 1) * WaitSec2MoveOtherValue

	moveFlow:addWork(WorkWaitSeconds.New(waitSec))

	local parallel = FlowParallel.New()
	local moveWork = TweenWork.New(params)

	parallel:addWork(moveWork)
	parallel:addWork(FunctionWork.New(self._showFlyEffect, self, fixItem))

	local fadeFlow = FlowSequence.New()

	fadeFlow:addWork(WorkWaitSeconds.New(FixValueFadeOutWaitTime))
	fadeFlow:addWork(TweenWork.New({
		from = 1,
		type = "DOFadeCanvasGroup",
		to = 0,
		t = FixValueFadeOutDuration,
		go = fixItem.txtFixValue.gameObject
	}))
	parallel:addWork(fadeFlow)
	moveFlow:addWork(parallel)
	moveFlow:addWork(FunctionWork.New(self._updateFixValue, self, fixItem))

	return moveFlow
end

function Rouge2_MapDiceAnimView:_showFlyEffect(fixItem)
	gohelper.setActive(fixItem.goFlyEffect, true)
end

function Rouge2_MapDiceAnimView:_showMiddleValue()
	gohelper.setActive(self._txtMiddle.gameObject, true)
end

function Rouge2_MapDiceAnimView:_updateFixValue(fixItem)
	AudioMgr.instance:trigger(AudioEnum.Rouge2.AddFixValue)
	gohelper.setActive(fixItem.goFlyEffect, false)

	local goFixValue = fixItem.txtFixValue.gameObject

	gohelper.setActive(goFixValue, false)

	local fixValue = fixItem.fixValue or 0

	self._totalDicePoint = self._totalDicePoint + fixValue
	self._txtMiddle.text = self._totalDicePoint

	gohelper.setActive(self._txtMiddle.gameObject, true)
end

function Rouge2_MapDiceAnimView:playFinishAnim()
	gohelper.setActive(self._btnJump.gameObject, false)
	gohelper.setActive(self._btnClose.gameObject, true)
	self._animator:Play("result", 0, 0)
	gohelper.setActive(self._goResult, true)
	gohelper.setActive(self._goFailure, self._checkRes == Rouge2_MapEnum.AttrCheckResult.Failure)
	gohelper.setActive(self._goSucceed, self._checkRes == Rouge2_MapEnum.AttrCheckResult.Succeed)
	gohelper.setActive(self._goBigSucceed, self._checkRes == Rouge2_MapEnum.AttrCheckResult.BigSucceed)

	if self._checkRes == Rouge2_MapEnum.AttrCheckResult.Failure then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.DiceFail)
	else
		AudioMgr.instance:trigger(AudioEnum.Rouge2.DiceSucc)
	end

	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.runDelay(self.closeThis, self, WaitSeconds2Close)
end

function Rouge2_MapDiceAnimView:_onJumpFinishDice()
	self:playDiceResultFlow(0)
end

function Rouge2_MapDiceAnimView:destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function Rouge2_MapDiceAnimView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
	self:destroyFlow()
end

return Rouge2_MapDiceAnimView
