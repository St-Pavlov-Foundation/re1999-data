-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayPlayerGuessView.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayPlayerGuessView", package.seeall)

local GuessGameNewPlayPlayerGuessView = class("GuessGameNewPlayPlayerGuessView", BaseView)

function GuessGameNewPlayPlayerGuessView:onInitView()
	self._btncontinue = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_continue")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_cancel")
	self._gobtns = gohelper.findChild(self.viewGO, "root/#go_btns")
	self._btntrust = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_trust")
	self._btndoubt = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_doubt")
	self._btnsearch = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_search")
	self._txtsearchtimes = gohelper.findChildText(self.viewGO, "root/#go_btns/#btn_search/#txt_searchtimes")
	self._btnsearchGrey = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#go_searchGrey")
	self._gogifts = gohelper.findChild(self.viewGO, "root/#go_gifts")
	self._gotipsubmit = gohelper.findChild(self.viewGO, "root/#go_tipsubmit")
	self._txttipsubmit = gohelper.findChildText(self.viewGO, "root/#go_tipsubmit/#txt_tipsubmit")
	self._gotipgiftselect = gohelper.findChild(self.viewGO, "root/#go_tipgiftselect")
	self._txttipgiftselect = gohelper.findChildText(self.viewGO, "root/#go_tipgiftselect/#txt_tipgiftselect")
	self._gotipgiftunlock = gohelper.findChild(self.viewGO, "root/#go_tipgiftunlock")
	self._txttipgiftunlock = gohelper.findChildText(self.viewGO, "root/#go_tipgiftunlock/#txt_tipgiftunlock")
	self._gotipgiftname = gohelper.findChild(self.viewGO, "root/#go_tipgiftname")
	self._txttipgiftname = gohelper.findChildText(self.viewGO, "root/#go_tipgiftname/#txt_tipgiftname")
	self._gosuccess = gohelper.findChild(self.viewGO, "root/#go_success")
	self._txtsuccess = gohelper.findChildText(self.viewGO, "root/#go_success/txt_success")
	self._gofail = gohelper.findChild(self.viewGO, "root/#go_fail")
	self._txtfail = gohelper.findChildText(self.viewGO, "root/#go_fail/txt_fail")
	self._gotipannounce = gohelper.findChild(self.viewGO, "root/#go_tipannounce")
	self._txttipannounce = gohelper.findChildText(self.viewGO, "root/#go_tipannounce/#txt_tipannounce")
	self._imageannoucegift = gohelper.findChildImage(self.viewGO, "root/#go_tipannounce/#txt_tipannounce/#image_gift")
	self._goroles = gohelper.findChild(self.viewGO, "#go_roles")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameNewPlayPlayerGuessView:addEvents()
	self._btncontinue:AddClickListener(self._btncontinueOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btntrust:AddClickListener(self._btntrustOnClick, self)
	self._btndoubt:AddClickListener(self._btndoubtOnClick, self)
	self._btnsearch:AddClickListener(self._btnsearchOnClick, self)
	self._btnsearchGrey:AddClickListener(self._btnsearchGreyOnClick, self)
end

function GuessGameNewPlayPlayerGuessView:removeEvents()
	self._btncontinue:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btntrust:RemoveClickListener()
	self._btndoubt:RemoveClickListener()
	self._btnsearch:RemoveClickListener()
	self._btnsearchGrey:RemoveClickListener()
end

function GuessGameNewPlayPlayerGuessView:_btncontinueOnClick()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoleGuessFinished)
	self:closeThis()
end

function GuessGameNewPlayPlayerGuessView:_btncancelOnClick()
	self:_cancelSearch()
end

function GuessGameNewPlayPlayerGuessView:_btntrustOnClick()
	self._guessType = GuessGameNewEnum.ChooseType.Trust

	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnGuessBtnClick)
end

function GuessGameNewPlayPlayerGuessView:_btndoubtOnClick()
	self._guessType = GuessGameNewEnum.ChooseType.Doubt

	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnGuessBtnClick)
end

function GuessGameNewPlayPlayerGuessView:_btnsearchOnClick()
	self._guessType = GuessGameNewEnum.ChooseType.Search

	Activity234Rpc.instance:sendAct234ExploreRequest(self._actId)
	self:_startSearch()
end

function GuessGameNewPlayPlayerGuessView:_btnsearchGreyOnClick()
	GameFacade.showToast(ToastEnum.V3a7SearchTimeLimit)
end

local waitAutoSearchTime = 0.2
local selectGiftAndFinishTime = 1

function GuessGameNewPlayPlayerGuessView:_startSearch()
	self._searchFlow = FlowSequence.New()

	self._searchFlow:addWork(FunctionWork.New(self._initSearchGift, self))
	self._searchFlow:addWork(TimerWork.New(waitAutoSearchTime))
	self._searchFlow:addWork(FunctionWork.New(self._showSearchGift, self))
	self._searchFlow:addWork(TimerWork.New(selectGiftAndFinishTime))
	self._searchFlow:addWork(FunctionWork.New(self._searchFinished, self))
	self._searchFlow:start()
end

function GuessGameNewPlayPlayerGuessView:_initSearchGift()
	gohelper.setActive(self._gobtns, false)
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, false)

	for _, item in pairs(self._selectItems) do
		item:enableClick(false)
	end
end

function GuessGameNewPlayPlayerGuessView:_showSearchGift()
	gohelper.setActive(self._gobtns, false)
	gohelper.setActive(self._gotipsubmit, true)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, false)

	local couldSelectIndexs = {}

	for index, _ in pairs(self._selectGiftIndexs) do
		if not LuaUtil.tableContains(self._unlockIndexs, self._selectGiftIndexs[index]) then
			table.insert(couldSelectIndexs, self._selectGiftIndexs[index])
		end
	end

	local searchIndex = #couldSelectIndexs > 0 and couldSelectIndexs[math.random(1, #couldSelectIndexs)] or 1
	local selectIndex = GuessGameNewUtil.findIndexsInTab(self._selectGiftIndexs, searchIndex)

	table.insert(self._unlockIndexs, self._selectGiftIndexs[selectIndex])

	local targetItem = self._selectItems[selectIndex]
	local giftId = targetItem and targetItem:getGiftId() or 1

	if targetItem then
		targetItem:playAnim("open_in")
		AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_announce)
	end

	GuessGameNewModel.instance:setUnlockGifts({
		giftId
	})
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRefreshTaskTipUnlockChanged)

	local giftCo = GuessGameNewConfig.instance:getBoxGiftCo(giftId)

	self._txttipsubmit.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("guessgame_giftname_tip"), giftCo.name)
end

function GuessGameNewPlayPlayerGuessView:_searchFinished()
	self._guessType = GuessGameNewEnum.ChooseType.None

	GuessGameNewModel.instance:reduceSearchCount()

	if self._searchFlow then
		self._searchFlow:stop()

		self._searchFlow = nil
	end

	gohelper.setActive(self._gobtns, true)
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, true)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipannounce, true)
	self:_refreshSearch()
end

function GuessGameNewPlayPlayerGuessView:_cancelSearch()
	self._guessType = GuessGameNewEnum.ChooseType.None

	self:_enterGuess()
end

function GuessGameNewPlayPlayerGuessView:_editableInitView()
	self._actId = VersionActivity4_1Enum.ActivityId.GuessGameNew
end

function GuessGameNewPlayPlayerGuessView:onOpen()
	self:_initData()
	self:_initUI()
	self:_startRound()
end

function GuessGameNewPlayPlayerGuessView:_initData()
	self._curRoleType = GuessGameNewModel.instance:getCurPlayRole()
	self._selectItems = self:getUserDataTb_()
	self._targetGiftId = GuessGameNewModel.instance:getTargetGiftId()

	local roleId = GuessGameNewModel.instance:getCurPlayRole()

	self._roleMo = GuessGameNewModel.instance:getRoleData(roleId)
	self._selectGiftIndexs = self._roleMo.selectGifts
	self._unlockIndexs = {}
end

function GuessGameNewPlayPlayerGuessView:_initUI()
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, false)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._gofail, false)
end

local waitSelectingTime = 1.5
local autoSelectGiftTime = 0
local showUnlockGiftTime = 1
local showResultTime = 0.4
local showGiftResultTime = 1

function GuessGameNewPlayPlayerGuessView:_startRound()
	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._showSelecting, self))
	self._flow:addWork(TimerWork.New(waitSelectingTime))
	self._flow:addWork(FunctionWork.New(self._startAutoSelectGift, self))
	self._flow:addWork(TimerWork.New(autoSelectGiftTime))
	self._flow:addWork(FunctionWork.New(self._enterGuess, self))
	self._flow:addWork(WaitEventWork.New("GuessGameNewController;GuessGameNewEvent;OnGuessBtnClick"))
	self._flow:addWork(FunctionWork.New(self._showUnlockGift, self))
	self._flow:addWork(TimerWork.New(showUnlockGiftTime))
	self._flow:addWork(FunctionWork.New(self._flipGiftCard, self))
	self._flow:addWork(TimerWork.New(showResultTime))
	self._flow:addWork(FunctionWork.New(self._showGiftResult, self))
	self._flow:addWork(TimerWork.New(showGiftResultTime))
	self._flow:addWork(FunctionWork.New(self._showGuessReduceHp, self))
	self._flow:addWork(WaitEventWork.New("GuessGameNewController;GuessGameNewEvent;OnRoleGuessResultShowFinished"))
	self._flow:addWork(FunctionWork.New(self._guessFinished, self))
	self._flow:start()
end

function GuessGameNewPlayPlayerGuessView:_showSelecting()
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._gobtns, false)
end

function GuessGameNewPlayPlayerGuessView:_startAutoSelectGift()
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._gobtns, false)
end

function GuessGameNewPlayPlayerGuessView:_enterGuess()
	gohelper.setActive(self._gobtns, true)
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, true)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipannounce, true)

	local giftCo = GuessGameNewConfig.instance:getBoxGiftCo(self._targetGiftId)
	local tag = {
		self._roleMo.npcConfig.name,
		#self._selectGiftIndexs,
		giftCo.name
	}

	self._txttipannounce.text = GameUtil.getSubPlaceholderLuaLang(luaLang("guessgame_npcannouncegift_tip"), tag)

	UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imageannoucegift, giftCo.icon)
	self:_setSelectItems()
	self:_refreshSearch()
end

function GuessGameNewPlayPlayerGuessView:_setSelectItems()
	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_card_content)

	local distributes = GuessGameNewModel.instance:getRoleGifts(self._roleMo.roleType)

	for i = 1, #self._selectGiftIndexs do
		if not self._selectItems[i] then
			self._selectItems[i] = GuessGameNewPlayGiftItem.New()

			local go = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._gogifts)

			self._selectItems[i]:init(go, i)
		end

		local giftId = distributes[self._selectGiftIndexs[i]]

		self._selectItems[i]:refresh(giftId)
		self._selectItems[i]:playAnim("unopen_in")
	end
end

function GuessGameNewPlayPlayerGuessView:_showUnlockGift()
	gohelper.setActive(self._gobtns, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)

	if self._selectItems then
		for index, item in pairs(self._selectItems) do
			local unlockIndex = self._selectGiftIndexs[index]
			local isUnlock = LuaUtil.tableContains(self._unlockIndexs, unlockIndex)

			if not isUnlock then
				item:showOpen(false)
			end
		end
	end
end

function GuessGameNewPlayPlayerGuessView:_flipGiftCard()
	gohelper.setActive(self._gobtns, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._gotipgiftunlock, true)

	local curRoleType = GuessGameNewModel.instance:getCurPlayRole()
	local nextRoleType = GuessGameNewModel.instance:getNextPlayRole()
	local curRoleMo = GuessGameNewModel.instance:getRoleData(curRoleType)
	local nextRoleMo = GuessGameNewModel.instance:getRoleData(nextRoleType)
	local nextRoleName = nextRoleType == GuessGameNewEnum.RoleType.Player and PlayerModel.instance:getPlayerName() or nextRoleMo.npcConfig.name
	local curRoleName = curRoleType == GuessGameNewEnum.RoleType.Player and PlayerModel.instance:getPlayerName() or curRoleMo.npcConfig.name
	local playerGuessSuccess = self:_isPlayerGuessSuccess()
	local guessStr = self._guessType == GuessGameNewEnum.ChooseType.Trust and luaLang("v4a1_trad_guess_trust") or luaLang("v4a1_trad_guess_doubt")

	if not playerGuessSuccess then
		curRoleMo:setBluffSuccessTime(1)
		nextRoleMo:setGuessFailTime(1)

		local tag = {
			nextRoleName,
			guessStr,
			curRoleName
		}

		self._txttipgiftunlock.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a1_trad_guess_fail"), tag)
	else
		curRoleMo:setBluffFailTime(1)
		nextRoleMo:setGuessSuccessTime(1)

		local tag = {
			nextRoleName,
			guessStr,
			curRoleName
		}

		self._txttipgiftunlock.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a1_trad_guess_success"), tag)
	end

	if self._selectItems then
		AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_turnover)

		for index, item in pairs(self._selectItems) do
			local unlockIndex = self._selectGiftIndexs[index]
			local isUnlock = LuaUtil.tableContains(self._unlockIndexs, unlockIndex)

			if not isUnlock then
				item:playAnim("flip_open")
			end
		end
	end

	local distributes = GuessGameNewModel.instance:getRoleGifts(curRoleType)
	local gifts = {}

	for _, index in pairs(self._selectGiftIndexs) do
		local isUnlock = LuaUtil.tableContains(self._unlockIndexs, index)

		if not isUnlock then
			local giftId = distributes[index]

			table.insert(gifts, giftId)
		end
	end

	GuessGameNewModel.instance:recordRoleRevealedGiftIndexs(curRoleType, self._selectGiftIndexs)
	GuessGameNewModel.instance:setUnlockGifts(gifts)
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRefreshTaskTipUnlockChanged)
end

function GuessGameNewPlayPlayerGuessView:_isPlayerGuessSuccess()
	if not self._selectItems then
		return false
	end

	local wildCardId = GuessGameNewModel.instance:getWildCardId()

	if self._guessType == GuessGameNewEnum.ChooseType.Trust then
		for _, item in pairs(self._selectItems) do
			local giftId = item:getGiftId()

			if giftId ~= self._targetGiftId and giftId ~= wildCardId then
				return false
			end
		end

		return true
	end

	for _, item in pairs(self._selectItems) do
		local giftId = item:getGiftId()

		if giftId ~= self._targetGiftId and giftId ~= wildCardId then
			return true
		end
	end

	return false
end

function GuessGameNewPlayPlayerGuessView:_showGiftResult()
	if self._selectItems then
		local wildCardId = GuessGameNewModel.instance:getWildCardId()

		for _, item in pairs(self._selectItems) do
			local giftId = item:getGiftId()

			if giftId ~= self._targetGiftId and giftId ~= wildCardId then
				item:showResult(true, false)
				item:playAnim("result_lose")
			else
				item:showResult(true, true)
				item:playAnim("result_add")
			end
		end
	end

	local curRoleType = GuessGameNewModel.instance:getCurPlayRole()
	local curRoleMo = GuessGameNewModel.instance:getRoleData(curRoleType)
	local nextRoleType = GuessGameNewModel.instance:getNextPlayRole()
	local nextRoleMo = GuessGameNewModel.instance:getRoleData(nextRoleType)
	local nextRoleName = nextRoleType == GuessGameNewEnum.RoleType.Player and PlayerModel.instance:getPlayerName() or nextRoleMo.npcConfig.name
	local playerGuessSuccess = self:_isPlayerGuessSuccess()
	local waitShowTime = 2.2
	local npcConfig = curRoleMo.npcConfig

	gohelper.setActive(self._gosuccess, playerGuessSuccess)
	gohelper.setActive(self._gofail, not playerGuessSuccess)

	if playerGuessSuccess then
		AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_win)

		local txts = string.split(npcConfig.rightdia or "", "#")

		if txts and txts[2] then
			waitShowTime = tonumber(txts[2]) + 0.2 or 2.2
		end

		self._txtsuccess.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a1_trad_guessresult_success2"), {
			nextRoleName
		})
	else
		AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_lose)

		local txts = string.split(npcConfig.wrongdia or "", "#")

		if txts and txts[2] then
			waitShowTime = tonumber(txts[2]) + 0.2 or 2.2
		end

		self._txtfail.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a1_trad_guessresult_fail2"), {
			nextRoleName
		})
	end

	waitShowTime = waitShowTime + showGiftResultTime

	local reduceHpRole = playerGuessSuccess and curRoleType or nextRoleType

	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnShowRoleResultBubble, reduceHpRole)
	TaskDispatcher.runDelay(self._onGuessResultShowFinished, self, waitShowTime)
end

function GuessGameNewPlayPlayerGuessView:_onGuessResultShowFinished()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoleGuessResultShowFinished)
end

function GuessGameNewPlayPlayerGuessView:_showGuessReduceHp()
	gohelper.setActive(self._btncontinue.gameObject, true)

	local curRoleType = GuessGameNewModel.instance:getCurPlayRole()
	local nextRoleType = GuessGameNewModel.instance:getNextPlayRole()
	local playerGuessSuccess = self:_isPlayerGuessSuccess()

	if self._guessType == GuessGameNewEnum.ChooseType.Trust or self._guessType == GuessGameNewEnum.ChooseType.Doubt then
		GuessGameNewModel.instance:recordRolePlay(curRoleType, self._selectGiftIndexs)
		GuessGameNewModel.instance:recordRoleGuessResult(curRoleType, self._guessType)
	end

	local winAddScore = GuessGameNewConfig.instance:getConstNumberValue(GuessGameNewEnum.ConstId.WinAddScore)
	local loseReduceScore = GuessGameNewConfig.instance:getConstNumberValue(GuessGameNewEnum.ConstId.LoseReduceScore)
	local score = playerGuessSuccess and winAddScore or -loseReduceScore

	GuessGameNewModel.instance:addGameScore(score)

	local reduceHpRole = playerGuessSuccess and curRoleType or nextRoleType

	GuessGameNewModel.instance:reduceRoleHp(reduceHpRole)
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnReduceRoleHp, reduceHpRole)
end

function GuessGameNewPlayPlayerGuessView:_guessFinished()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoleGuessFinished)
	self:closeThis()
end

function GuessGameNewPlayPlayerGuessView:_refreshSearch()
	local count = GuessGameNewModel.instance:getSearchCount()

	gohelper.setActive(self._btnsearch.gameObject, count > 0)
	gohelper.setActive(self._btnsearchGrey.gameObject, count <= 0)

	self._txtsearchtimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("guessgame_searchcount_tip"), count)
end

function GuessGameNewPlayPlayerGuessView:onClose()
	return
end

function GuessGameNewPlayPlayerGuessView:onDestroyView()
	TaskDispatcher.cancelTask(self._onGuessResultShowFinished, self)

	if self._selectItems then
		for _, item in pairs(self._selectItems) do
			item:destroy()
		end

		self._selectItems = nil
	end

	if self._searchFlow then
		self._searchFlow:stop()

		self._searchFlow = nil
	end

	if self._flow then
		self._flow:stop()

		self._flow = nil
	end
end

return GuessGameNewPlayPlayerGuessView
