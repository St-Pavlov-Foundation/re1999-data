-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayView.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayView", package.seeall)

local GuessGameNewPlayView = class("GuessGameNewPlayView", BaseView)

function GuessGameNewPlayView:onInitView()
	self._gorole = gohelper.findChild(self.viewGO, "#go_role")
	self._gocards = gohelper.findChild(self.viewGO, "#go_cards")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_bottom")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#btn_start")
	self._godistributetips = gohelper.findChild(self.viewGO, "#go_bottom/#go_distributetips")
	self._godistributing = gohelper.findChild(self.viewGO, "#go_bottom/#go_distributetips/#go_distributing")
	self._godistributefinish = gohelper.findChild(self.viewGO, "#go_bottom/#go_distributetips/#go_distributefinish")
	self._gostarttips = gohelper.findChild(self.viewGO, "#go_startTips")
	self._gotipannounce = gohelper.findChild(self.viewGO, "#go_tipannounce")
	self._imageannoucegift = gohelper.findChildImage(self.viewGO, "#go_tipannounce/#txt_tipannounce/#image_announcegift")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameNewPlayView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function GuessGameNewPlayView:removeEvents()
	self._btnstart:RemoveClickListener()
end

function GuessGameNewPlayView:_btnstartOnClick()
	gohelper.setActive(self._gostarttips, false)
	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_start_game)
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoundDistributeCardClick)
end

function GuessGameNewPlayView:_onShowGuessAnnounceTips()
	gohelper.setActive(self._gotipannounce, true)

	local targetGiftId = GuessGameNewModel.instance:getTargetGiftId()
	local giftCo = GuessGameNewConfig.instance:getBoxGiftCo(targetGiftId)

	UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imageannoucegift, giftCo.icon)
end

function GuessGameNewPlayView:_onRoleSelectCardFinished()
	gohelper.setActive(self._gotipannounce, false)
end

function GuessGameNewPlayView:_addSelfEvents()
	local controller = GuessGameNewController.instance

	self._selfEvents = {
		[GuessGameNewEvent.OnShowGuessAnnounceTips] = self._onShowGuessAnnounceTips,
		[GuessGameNewEvent.OnRoleSelectCardFinished] = self._onRoleSelectCardFinished
	}

	for event, handler in pairs(self._selfEvents) do
		self:addEventCb(controller, event, handler, self)
	end
end

function GuessGameNewPlayView:_removeSelfEvents()
	local controller = GuessGameNewController.instance

	for event, handler in pairs(self._selfEvents) do
		self:removeEventCb(controller, event, handler, self)
	end
end

function GuessGameNewPlayView:_editableInitView()
	self:_initView()
	self:_addSelfEvents()
end

function GuessGameNewPlayView:_initView()
	self._actId = VersionActivity4_1Enum.ActivityId.GuessGameNew
	self._posBoxItems = self:getUserDataTb_()

	GuessGameNewModel.instance:initGameData()

	self._cardAnim = self._gocards:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gorighttop, false)
	gohelper.setActive(self._gotipannounce, false)
end

function GuessGameNewPlayView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_enter_game)
	self:_startGame()
end

function GuessGameNewPlayView:_startGame()
	if self._flow then
		self._flow:stop()

		self._flow = nil
	end

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._startRound, self))
	self._flow:addWork(WaitEventWork.New("GuessGameNewController;GuessGameNewEvent;OnGameGuessFinished"))
	self._flow:addWork(FunctionWork.New(self._showResult, self))
	self._flow:addWork(WaitEventWork.New("GuessGameNewController;GuessGameNewEvent;OnGameFinished"))
	self._flow:addWork(FunctionWork.New(self._gameFinished, self))
	self._flow:start()
end

function GuessGameNewPlayView:_showResult()
	local score = GuessGameNewModel.instance:getGameScore()
	local isFirstShow = GuessGameNewModel.instance:isFirstShow(self._actId)

	Activity234Rpc.instance:sendAct234FinishGameRequest(self._actId, score, "")
	GuessGameNewController.instance:openGuessGameNewPlayResultView(isFirstShow)
end

function GuessGameNewPlayView:_gameFinished()
	return
end

local distributeStage12InterverTime = 1
local distributeStage23InterverTime = 0.65
local distributeStage3FinishInterverTime = 0.15
local waitRoundStartTime = 1
local roundTipsShowTime = 1.5

function GuessGameNewPlayView:_startRound()
	if self._roundflow then
		self._roundflow:stop()

		self._roundflow = nil
	end

	self._roundflow = FlowSequence.New()

	self._roundflow:addWork(FunctionWork.New(self._initGiftDistribution, self))
	self._roundflow:addWork(WaitEventWork.New("GuessGameNewController;GuessGameNewEvent;OnRoundDistributeCardClick"))
	self._roundflow:addWork(FunctionWork.New(self._distributeGiftStage1, self, true))
	self._roundflow:addWork(TimerWork.New(distributeStage12InterverTime))
	self._roundflow:addWork(FunctionWork.New(self._distributeGiftStage2, self))
	self._roundflow:addWork(TimerWork.New(distributeStage23InterverTime))
	self._roundflow:addWork(FunctionWork.New(self._distributeGiftStage3, self))
	self._roundflow:addWork(TimerWork.New(distributeStage3FinishInterverTime))
	self._roundflow:addWork(FunctionWork.New(self._distributeGiftStageFinished, self))
	self._roundflow:addWork(TimerWork.New(waitRoundStartTime))
	self._roundflow:addWork(FunctionWork.New(self._showRoundTargetTipsView, self))
	self._roundflow:addWork(TimerWork.New(roundTipsShowTime))
	self._roundflow:addWork(FunctionWork.New(self._enterRoundGuess, self))
	self._roundflow:addWork(WaitEventWork.New("GuessGameNewController;GuessGameNewEvent;OnRoundGuessFinished"))
	self._roundflow:addWork(FunctionWork.New(self._checkEnterNextRound, self))
	self._roundflow:start()
end

function GuessGameNewPlayView:_initGiftDistribution()
	GuessGameNewModel.instance:initRoundData()
	self:_initTableGifts()

	local round = GuessGameNewModel.instance:getCurRound()

	if round == 1 then
		self:_showStartBtn()
	else
		TaskDispatcher.runDelay(self._autoStart, self, 0.5)
	end
end

function GuessGameNewPlayView:_autoStart()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoundDistributeCardClick)
end

function GuessGameNewPlayView:_initTableGifts()
	gohelper.setActive(self._gorighttop, false)
	self._cardAnim:Play("cards_in", 0, 0)

	local cards = GuessGameNewModel.instance:getInitTableCards()

	for i = 1, #cards do
		if not self._posBoxItems[i] then
			self._posBoxItems[i] = GuessGameNewPlayGiftItem.New()

			local line = i % GuessGameNewEnum.lineCardCount == 0 and math.floor(i / GuessGameNewEnum.lineCardCount) or math.floor(i / GuessGameNewEnum.lineCardCount) + 1
			local row = i % GuessGameNewEnum.lineCardCount == 0 and GuessGameNewEnum.lineCardCount or i % GuessGameNewEnum.lineCardCount
			local subPath = string.format("%s/%s_%s", line, line, row)
			local rootGo = gohelper.findChild(self._gocards, subPath)
			local go = self:getResInst(self.viewContainer._viewSetting.otherRes[1], rootGo)

			self._posBoxItems[i]:init(go, i)
		end

		self._posBoxItems[i]:refresh(cards[i])
		self._posBoxItems[i]:playAnim("open_idle")
	end

	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnTaskTipReset)
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoundStart)
end

function GuessGameNewPlayView:_distributeGiftStage1()
	self._cardAnim:Play("cards_start", 0, 0)
	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_deal)
	self:_showDistributing()
	self:_lockTableGifts()
end

function GuessGameNewPlayView:_distributeGiftStage2()
	self:_showDistributing()
end

function GuessGameNewPlayView:_distributeGiftStage3()
	self:_showDistributing()
	self._cardAnim:Play("cards_end", 0, 0)
end

function GuessGameNewPlayView:_distributeGiftStageFinished()
	gohelper.setActive(self._gobottom, true)
	gohelper.setActive(self._btnstart.gameObject, false)
	gohelper.setActive(self._godistributetips, true)
	gohelper.setActive(self._gorighttop, true)
	gohelper.setActive(self._godistributing, false)
	gohelper.setActive(self._godistributefinish, true)
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoundDistributeCardFinished)
end

function GuessGameNewPlayView:_showRoundTargetTipsView()
	gohelper.setActive(self._gobottom, false)

	self._roundInitRole = GuessGameNewModel.instance:getCurPlayRole()

	GuessGameNewController.instance:openGuessGameNewPlayRoundTipsView()
end

function GuessGameNewPlayView:_checkEnterNextRound()
	local nextNpc = GuessGameNewModel.instance:getNextPlayRole()

	if not nextNpc or nextNpc == 0 then
		GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnGameGuessFinished)
	else
		GuessGameNewModel.instance:setCurPlayRole(nextNpc)
		GuessGameNewModel.instance:increaseCurRound()
		self:_startRound()
	end
end

function GuessGameNewPlayView:_showRoleTips()
	GuessGameNewController.instance:openGuessGameNewPlayRoleTipsView()
end

function GuessGameNewPlayView:_showStartBtn()
	gohelper.setActive(self._gobottom, true)
	gohelper.setActive(self._btnstart.gameObject, true)
	gohelper.setActive(self._godistributetips, false)
	gohelper.setActive(self._gostarttips, true)
end

function GuessGameNewPlayView:_showDistributing()
	gohelper.setActive(self._gobottom, true)
	gohelper.setActive(self._btnstart.gameObject, false)
	gohelper.setActive(self._godistributetips, true)
	gohelper.setActive(self._godistributing, true)
	gohelper.setActive(self._godistributefinish, false)
end

function GuessGameNewPlayView:_lockTableGifts()
	if self._posBoxItems then
		for _, item in pairs(self._posBoxItems) do
			item:playAnim("flip_unopen")
		end
	end
end

local roleDiscardTipsShowTime = 2

function GuessGameNewPlayView:_enterRoundGuess()
	if self._guessFlow then
		self._guessFlow:stop()

		self._guessFlow = nil
	end

	self._guessFlow = FlowSequence.New()

	self._guessFlow:addWork(FunctionWork.New(self._showRoleDiscardTips, self))
	self._guessFlow:addWork(TimerWork.New(roleDiscardTipsShowTime))
	self._guessFlow:addWork(FunctionWork.New(self._roleSelectGifts, self))
	self._guessFlow:addWork(WaitEventWork.New("GuessGameNewController;GuessGameNewEvent;OnRoleSelectCardFinished"))
	self._guessFlow:addWork(FunctionWork.New(self._roleGuessGifts, self))
	self._guessFlow:addWork(WaitEventWork.New("GuessGameNewController;GuessGameNewEvent;OnRoleGuessFinished"))
	self._guessFlow:addWork(FunctionWork.New(self._roleGuessEnd, self))
	self._guessFlow:start()
end

function GuessGameNewPlayView:_showRoleDiscardTips()
	local curRole = GuessGameNewModel.instance:getCurPlayRole()

	GuessGameNewController.instance:openGuessGameNewPlayRoleTipsView(curRole)
end

function GuessGameNewPlayView:_roleSelectGifts()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoleSelectCardStart)
end

function GuessGameNewPlayView:_roleGuessGifts()
	local guessRole = GuessGameNewModel.instance:getNextPlayRole()

	if guessRole == GuessGameNewEnum.RoleType.Player then
		GuessGameNewController.instance:openGuessGameNewPlayPlayerGuessView()
	else
		GuessGameNewController.instance:openGuessGameNewPlayNpcGuessView()
	end
end

function GuessGameNewPlayView:_roleGuessResultShow()
	return
end

function GuessGameNewPlayView:_roleGuessEnd()
	local nextRole = GuessGameNewModel.instance:getNextPlayRole()

	if not nextRole or nextRole == 0 then
		GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnGameGuessFinished)
	else
		GuessGameNewModel.instance:setCurPlayRole(nextRole)

		if nextRole == self._roundInitRole then
			self:_onRoundGuessFinished()
		else
			self:_enterRoundGuess()
		end
	end
end

function GuessGameNewPlayView:_onRoundGuessFinished()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoundGuessFinished)
	self:_startRound()
end

function GuessGameNewPlayView:onClose()
	return
end

function GuessGameNewPlayView:onDestroyView()
	TaskDispatcher.cancelTask(self._autoStart, self, 0.5)

	if self._posBoxItems then
		for _, item in pairs(self._posBoxItems) do
			item:destroy()
		end

		self._posBoxItems = nil
	end

	if self._flow then
		self._flow:stop()

		self._flow = nil
	end

	if self._roundflow then
		self._roundflow:stop()

		self._roundflow = nil
	end

	if self._guessFlow then
		self._guessFlow:stop()

		self._guessFlow = nil
	end

	self:_removeSelfEvents()
end

return GuessGameNewPlayView
