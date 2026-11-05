-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayNpcGuessView.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayNpcGuessView", package.seeall)

local GuessGameNewPlayNpcGuessView = class("GuessGameNewPlayNpcGuessView", BaseView)

function GuessGameNewPlayNpcGuessView:onInitView()
	self._btncontinue = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_continue")
	self._gogifts = gohelper.findChild(self.viewGO, "root/#go_gifts")
	self._gotipgiftname = gohelper.findChild(self.viewGO, "root/#go_tipgiftname")
	self._txttipgiftname = gohelper.findChildText(self.viewGO, "root/#go_tipgiftname/#txt_tipgiftname")
	self._gotipwaiting = gohelper.findChild(self.viewGO, "root/#go_tipwaiting")
	self._txttipwaiting = gohelper.findChildText(self.viewGO, "root/#go_tipwaiting/#txt_tipwaiting")
	self._gotipannounce = gohelper.findChild(self.viewGO, "root/#go_tipannounce")
	self._txttipannounce = gohelper.findChildText(self.viewGO, "root/#go_tipannounce/#txt_tipannounce")
	self._imageannoucegift = gohelper.findChildImage(self.viewGO, "root/#go_tipannounce/#txt_tipannounce/#image_announcegift")
	self._gotipguess = gohelper.findChild(self.viewGO, "root/#go_tipguess")
	self._txttipguess = gohelper.findChildText(self.viewGO, "root/#go_tipguess/#txt_tipguess")
	self._gosuccess = gohelper.findChild(self.viewGO, "root/#go_success")
	self._txtsuccess = gohelper.findChildText(self.viewGO, "root/#go_success/#txt_success")
	self._gofail = gohelper.findChild(self.viewGO, "root/#go_fail")
	self._txtfail = gohelper.findChildText(self.viewGO, "root/#go_fail/txt_fail")
	self._goroles = gohelper.findChild(self.viewGO, "#go_roles")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameNewPlayNpcGuessView:addEvents()
	self._btncontinue:AddClickListener(self._btncontinueOnClick, self)
end

function GuessGameNewPlayNpcGuessView:removeEvents()
	self._btncontinue:RemoveClickListener()
end

function GuessGameNewPlayNpcGuessView:_btncontinueOnClick()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoleGuessFinished)
	self:closeThis()
end

function GuessGameNewPlayNpcGuessView:_editableInitView()
	self._actId = VersionActivity4_1Enum.ActivityId.GuessGameNew
end

function GuessGameNewPlayNpcGuessView:onOpen()
	self:_initData()
	self:_initUI()
	self:_startRound()
end

function GuessGameNewPlayNpcGuessView:_initData()
	self._selectGiftIndexs = {}
	self._selectItems = self:getUserDataTb_()
	self._targetGiftId = GuessGameNewModel.instance:getTargetGiftId()

	local roleId = GuessGameNewModel.instance:getCurPlayRole()

	self._roleMo = GuessGameNewModel.instance:getRoleData(roleId)
	self._selectGiftIndexs = self._roleMo.selectGifts
end

function GuessGameNewPlayNpcGuessView:_initUI()
	gohelper.setActive(self._btncontinue.gameObject, false)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._gofail, false)
	gohelper.setActive(self._gotipguess, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._gotipwaiting, false)
end

local waitSelectingTime = 0.5
local waitGuessingTime = 2
local showUnlockGiftTime = 0.5
local showResultTime = 0.4
local showGiftResultTime = 0.5

function GuessGameNewPlayNpcGuessView:_startRound()
	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._showSelectCards, self))
	self._flow:addWork(TimerWork.New(waitSelectingTime))
	self._flow:addWork(FunctionWork.New(self._enterNpcGuess, self))
	self._flow:addWork(TimerWork.New(waitGuessingTime))
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

function GuessGameNewPlayNpcGuessView:_showSelectCards()
	gohelper.setActive(self._gotipguess, false)
	gohelper.setActive(self._gotipgiftname, true)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._gotipwaiting, false)
end

function GuessGameNewPlayNpcGuessView:_enterNpcGuess()
	gohelper.setActive(self._btncontinue.gameObject, false)
	gohelper.setActive(self._gotipgiftname, true)
	gohelper.setActive(self._gotipannounce, true)
	gohelper.setActive(self._gotipguess, false)
	gohelper.setActive(self._gotipwaiting, true)
	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_card_content)

	local curRoleType = GuessGameNewModel.instance:getCurPlayRole()
	local nextRoleType = GuessGameNewModel.instance:getNextPlayRole()
	local curRoleMo = GuessGameNewModel.instance:getRoleData(curRoleType)
	local nextRoleMo = GuessGameNewModel.instance:getRoleData(nextRoleType)
	local curRoleName = curRoleType == GuessGameNewEnum.RoleType.Player and PlayerModel.instance:getPlayerName() or curRoleMo.npcConfig.name
	local nextRoleName = nextRoleType == GuessGameNewEnum.RoleType.Player and PlayerModel.instance:getPlayerName() or nextRoleMo.npcConfig.name

	self._txttipwaiting.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a1_trad_guess_wait"), {
		nextRoleName
	})
	self._txttipannounce.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a1_trad_announce_gift"), {
		curRoleName
	})

	local giftCo = GuessGameNewConfig.instance:getBoxGiftCo(self._targetGiftId)

	UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imageannoucegift, giftCo.icon)

	local selectIndexs = curRoleMo.selectGifts

	for i = 1, #selectIndexs do
		if not self._selectItems[i] then
			self._selectItems[i] = GuessGameNewPlayGiftItem.New()

			local go = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._gogifts)

			self._selectItems[i]:init(go, i)
		end

		local giftId = curRoleMo.gifts[selectIndexs[i]]

		self._selectItems[i]:refresh(giftId)
		self._selectItems[i]:playAnim("unopen_in")
	end
end

function GuessGameNewPlayNpcGuessView:_getTemperName(temperType)
	local TemperType = GuessGameNewEnum.TemperType

	if temperType == TemperType.Cautious then
		return "cautious"
	elseif temperType == TemperType.Radical then
		return "radical"
	end

	return "logical"
end

function GuessGameNewPlayNpcGuessView:_getGuessType()
	local ConstId = GuessGameNewEnum.ConstId
	local TemperType = GuessGameNewEnum.TemperType
	local ChooseType = GuessGameNewEnum.ChooseType
	local model = GuessGameNewModel.instance
	local config = GuessGameNewConfig.instance
	local curRoleType = model:getCurPlayRole()
	local guessRoleType = model:getNextPlayRole()
	local curRoleMo = model:getRoleData(curRoleType)
	local guessRoleMo = model:getRoleData(guessRoleType)

	if not curRoleMo or not guessRoleMo then
		return math.random(1, 2)
	end

	local temperType = model:getRoleTemperType(guessRoleType)
	local playCount = curRoleMo.selectGifts and #curRoleMo.selectGifts or 0

	if playCount <= 0 then
		return ChooseType.Doubt
	end

	local roleName = guessRoleType == GuessGameNewEnum.RoleType.Player and PlayerModel.instance:getPlayerName() or guessRoleMo.npcConfig.name
	local unlockGifts = model:getUnlockGifts() or {}
	local wildCardId = model:getWildCardId()
	local totalRealCount = 0

	for _, giftId in ipairs(model:getInitTableCards() or {}) do
		if giftId == self._targetGiftId or giftId == wildCardId then
			totalRealCount = totalRealCount + 1
		end
	end

	local revealedRealCount = (unlockGifts[self._targetGiftId] or 0) + (unlockGifts[wildCardId] or 0)
	local ownRealCount = 0

	for index, giftId in ipairs(guessRoleMo.gifts) do
		if not guessRoleMo:isGiftIndexRevealed(index) and (giftId == self._targetGiftId or giftId == wildCardId) then
			ownRealCount = ownRealCount + 1
		end
	end

	local maxHoldRealCount = totalRealCount - revealedRealCount - ownRealCount

	if totalRealCount > 0 and maxHoldRealCount < playCount then
		logNormal(string.format("%s %s, totalRealCount %s - revealedRealCount %s - ownRealCount %s = %s < playCount %s, doubt", roleName, self:_getTemperName(temperType), totalRealCount, revealedRealCount, ownRealCount, maxHoldRealCount, playCount))

		return ChooseType.Doubt
	end

	if temperType == TemperType.Cautious then
		local trustProbability = self:_getTrustProbabilityByCount(temperType, playCount)

		if curRoleMo.lastPlayIsReal == true then
			trustProbability = trustProbability + config:getConstNumberValue(ConstId.CautiousLastRealTrustAdd)

			logNormal(roleName .. " cautious, last play is real, trustProbability add " .. config:getConstNumberValue(ConstId.CautiousLastRealTrustAdd))
		elseif curRoleMo.lastPlayIsReal == false then
			trustProbability = trustProbability - config:getConstNumberValue(ConstId.CautiousLastFakeTrustReduce)

			logNormal(roleName .. " cautious, last play is fake, trustProbability reduce " .. config:getConstNumberValue(ConstId.CautiousLastFakeTrustReduce))
		end

		trustProbability = math.max(0, math.min(trustProbability, 100))

		local chooseType = trustProbability >= math.random(1, 100) and ChooseType.Trust or ChooseType.Doubt

		logNormal(roleName .. " cautious, result trustProbability: " .. trustProbability .. "%, chooseType: " .. chooseType)

		return chooseType
	elseif temperType == TemperType.Radical then
		local trustProbability = self:_getTrustProbabilityByCount(temperType, playCount)

		if curRoleMo.lastPlayIsReal == true then
			trustProbability = trustProbability + config:getConstNumberValue(ConstId.AggressiveLastRealTrustAdd)

			logNormal(roleName .. " radical, last play is real, trustProbability add: " .. config:getConstNumberValue(ConstId.AggressiveLastRealTrustAdd))
		elseif curRoleMo.lastPlayIsReal == false then
			trustProbability = trustProbability - config:getConstNumberValue(ConstId.AggressiveLastFakeTrustReduce)

			logNormal(roleName .. " radical, last play is fake, trustProbability reduce: " .. config:getConstNumberValue(ConstId.AggressiveLastFakeTrustReduce))
		end

		trustProbability = math.max(0, math.min(trustProbability, 100))

		local chooseType = trustProbability >= math.random(1, 100) and ChooseType.Trust or ChooseType.Doubt

		logNormal(roleName .. " radical, result trustProbability: " .. trustProbability .. "%, chooseType: " .. chooseType)

		return chooseType
	else
		local trustProbability = self:_getTrustProbabilityByCount(temperType, playCount)
		local fakePlayTimes = curRoleMo.fakePlayTimes or 0
		local realPlayTimes = curRoleMo.realPlayTimes or 0
		local netValue = realPlayTimes - fakePlayTimes + 2
		local timesLog = ", realPlayTimes: " .. realPlayTimes .. ", fakePlayTimes: " .. fakePlayTimes

		if netValue <= 0 then
			logNormal(roleName .. " logical, netValue <= 0" .. timesLog .. ", trustProbability reduce " .. config:getConstNumberValue(ConstId.LogicalTrustReduceLe0))

			trustProbability = trustProbability - config:getConstNumberValue(ConstId.LogicalTrustReduceLe0)
		elseif netValue == 1 then
			logNormal(roleName .. " logical, netValue == 1" .. timesLog .. ", trustProbability reduce " .. config:getConstNumberValue(ConstId.LogicalTrustReduceEq1))

			trustProbability = trustProbability - config:getConstNumberValue(ConstId.LogicalTrustReduceEq1)
		elseif netValue == 3 then
			logNormal(roleName .. " logical, netValue == 3" .. timesLog .. ", trustProbability add " .. config:getConstNumberValue(ConstId.LogicalTrustAddEq3))

			trustProbability = trustProbability + config:getConstNumberValue(ConstId.LogicalTrustAddEq3)
		elseif netValue >= 4 then
			logNormal(roleName .. " logical, netValue >= 4" .. timesLog .. ", trustProbability add " .. config:getConstNumberValue(ConstId.LogicalTrustAddGe4))

			trustProbability = trustProbability + config:getConstNumberValue(ConstId.LogicalTrustAddGe4)
		end

		trustProbability = math.max(0, math.min(trustProbability, 100))

		local chooseType = trustProbability >= math.random(1, 100) and ChooseType.Trust or ChooseType.Doubt

		logNormal(roleName .. " logical, result trustProbability: " .. trustProbability .. "%, chooseType: " .. chooseType)

		return chooseType
	end

	return math.random(1, 2)
end

function GuessGameNewPlayNpcGuessView:_getTrustProbabilityByCount(temperType, playCount)
	local ConstId = GuessGameNewEnum.ConstId
	local constId

	if temperType == GuessGameNewEnum.TemperType.Cautious then
		constId = ConstId.CautiousTrustProbability
	elseif temperType == GuessGameNewEnum.TemperType.Logical then
		constId = ConstId.LogicalTrustProbability
	else
		constId = ConstId.AggressiveTrustProbability
	end

	local tabs = GameUtil.splitString2(GuessGameNewConfig.instance:getConstValue(constId), true)

	if not tabs or #tabs <= 0 then
		return 50
	end

	for _, tab in ipairs(tabs) do
		if tab[1] == playCount then
			return tab[2]
		end
	end

	return tabs[#tabs][2]
end

function GuessGameNewPlayNpcGuessView:_showUnlockGift()
	gohelper.setActive(self._gotipwaiting, false)
	gohelper.setActive(self._gotipguess, false)
	gohelper.setActive(self._gotipgiftname, true)
	gohelper.setActive(self._gotipannounce, false)

	self._guessType = self:_getGuessType()

	if self._selectItems then
		for _, item in pairs(self._selectItems) do
			item:showOpen(false)
		end
	end
end

function GuessGameNewPlayNpcGuessView:_flipGiftCard()
	gohelper.setActive(self._gotipwaiting, false)
	gohelper.setActive(self._gotipguess, true)
	gohelper.setActive(self._gotipgiftname, true)
	gohelper.setActive(self._gotipannounce, false)

	local guessSuccess = self:_isGuessSuccess()
	local curRoleType = GuessGameNewModel.instance:getCurPlayRole()
	local nextRoleType = GuessGameNewModel.instance:getNextPlayRole()
	local curRoleMo = GuessGameNewModel.instance:getRoleData(curRoleType)
	local nextRoleMo = GuessGameNewModel.instance:getRoleData(nextRoleType)
	local nextRoleName = nextRoleType == GuessGameNewEnum.RoleType.Player and PlayerModel.instance:getPlayerName() or nextRoleMo.npcConfig.name
	local curRoleName = curRoleType == GuessGameNewEnum.RoleType.Player and PlayerModel.instance:getPlayerName() or curRoleMo.npcConfig.name
	local guessStr = self._guessType == GuessGameNewEnum.ChooseType.Trust and luaLang("v4a1_trad_guess_trust") or luaLang("v4a1_trad_guess_doubt")

	if not guessSuccess then
		curRoleMo:setBluffSuccessTime(1)
		nextRoleMo:setGuessFailTime(1)

		local tag = {
			nextRoleName,
			guessStr,
			curRoleName
		}

		self._txttipguess.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a1_trad_guess_fail"), tag)
	else
		curRoleMo:setBluffFailTime(1)
		nextRoleMo:setGuessSuccessTime(1)

		local tag = {
			nextRoleName,
			guessStr,
			curRoleName
		}

		self._txttipguess.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a1_trad_guess_success"), tag)
	end

	if self._selectItems then
		AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_wenming_cards_flipping)

		for _, item in pairs(self._selectItems) do
			item:playAnim("flip_open")
		end
	end

	local distributes = GuessGameNewModel.instance:getRoleGifts(curRoleType)
	local gifts = {}

	for _, index in pairs(self._selectGiftIndexs) do
		table.insert(gifts, distributes[index])
	end

	GuessGameNewModel.instance:recordRoleRevealedGiftIndexs(curRoleType, self._selectGiftIndexs)
	GuessGameNewModel.instance:setUnlockGifts(gifts)
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRefreshTaskTipUnlockChanged)
end

function GuessGameNewPlayNpcGuessView:_isGuessSuccess()
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

local waitAutoFinishTime = 5

function GuessGameNewPlayNpcGuessView:_showGiftResult()
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

	local guessSuccess = self:_isGuessSuccess()

	gohelper.setActive(self._gosuccess, not guessSuccess)
	gohelper.setActive(self._gofail, guessSuccess)

	local curRoleType = GuessGameNewModel.instance:getCurPlayRole()
	local nextRoleType = GuessGameNewModel.instance:getNextPlayRole()
	local curRoleMo = GuessGameNewModel.instance:getRoleData(curRoleType)
	local curRoleName = curRoleType == GuessGameNewEnum.RoleType.Player and PlayerModel.instance:getPlayerName() or curRoleMo.npcConfig.name

	if guessSuccess then
		AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_win)

		self._txtfail.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a1_trad_guessresult_success"), {
			curRoleName
		})
	else
		AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_lose)

		self._txtsuccess.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a1_trad_guessresult_fail"), {
			curRoleName
		})
	end

	local reduceRole = guessSuccess and curRoleType or nextRoleType

	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnShowRoleResultBubble, reduceRole)
	TaskDispatcher.runDelay(self._onGuessResultShowFinished, self, waitAutoFinishTime + showGiftResultTime)
end

function GuessGameNewPlayNpcGuessView:_onGuessResultShowFinished()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoleGuessResultShowFinished)
end

function GuessGameNewPlayNpcGuessView:_showGuessReduceHp()
	gohelper.setActive(self._btncontinue.gameObject, true)

	local guessSuccess = self:_isGuessSuccess()
	local curRoleType = GuessGameNewModel.instance:getCurPlayRole()

	if self._guessType == GuessGameNewEnum.ChooseType.Trust or self._guessType == GuessGameNewEnum.ChooseType.Doubt then
		GuessGameNewModel.instance:recordRolePlay(curRoleType, self._selectGiftIndexs)
		GuessGameNewModel.instance:recordRoleGuessResult(curRoleType, self._guessType)
	end

	if curRoleType == GuessGameNewEnum.RoleType.Player then
		local winAddScore = GuessGameNewConfig.instance:getConstNumberValue(GuessGameNewEnum.ConstId.WinAddScore)
		local loseReduceScore = GuessGameNewConfig.instance:getConstNumberValue(GuessGameNewEnum.ConstId.LoseReduceScore)
		local score = guessSuccess and -loseReduceScore or winAddScore

		GuessGameNewModel.instance:addGameScore(score)
	end

	local nextRoleType = GuessGameNewModel.instance:getNextPlayRole()
	local reduceRole = guessSuccess and curRoleType or nextRoleType

	GuessGameNewModel.instance:reduceRoleHp(reduceRole)
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnReduceRoleHp, reduceRole)
end

function GuessGameNewPlayNpcGuessView:_guessFinished()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoleGuessFinished)
	self:closeThis()
end

function GuessGameNewPlayNpcGuessView:onClose()
	return
end

function GuessGameNewPlayNpcGuessView:onDestroyView()
	TaskDispatcher.cancelTask(self._onGuessResultShowFinished, self)

	if self._selectItems then
		for _, item in pairs(self._selectItems) do
			item:destroy()
		end

		self._selectItems = nil
	end

	if self._flow then
		self._flow:stop()

		self._flow = nil
	end
end

return GuessGameNewPlayNpcGuessView
