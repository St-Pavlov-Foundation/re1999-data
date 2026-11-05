-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayRolesView.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayRolesView", package.seeall)

local GuessGameNewPlayRolesView = class("GuessGameNewPlayRolesView", BaseView)

function GuessGameNewPlayRolesView:onInitView()
	self._gorole1 = gohelper.findChild(self.viewGO, "#go_role1")
	self._gorole2 = gohelper.findChild(self.viewGO, "#go_role2")
	self._gorole3 = gohelper.findChild(self.viewGO, "#go_role3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameNewPlayRolesView:addEvents()
	return
end

function GuessGameNewPlayRolesView:removeEvents()
	return
end

function GuessGameNewPlayRolesView:_editableInitView()
	self._roleItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function GuessGameNewPlayRolesView:onUpdateParam()
	return
end

function GuessGameNewPlayRolesView:onOpen()
	self:_initRoles()
end

function GuessGameNewPlayRolesView:_initRoles()
	local otherRes = self.viewContainer._viewSetting.otherRes

	for _, roleMo in ipairs(GuessGameNewModel.instance:getRoleDatas()) do
		local roleType = roleMo.roleType
		local roleItem = self._roleItems[roleType]

		if not roleItem then
			local isPlayer = roleType == GuessGameNewEnum.RoleType.Player
			local ItemClass = isPlayer and GuessGameNewPlayPlayerItem or GuessGameNewPlayNpcItem
			local parent = self["_gorole" .. roleType]

			roleItem = ItemClass.New()

			roleItem:init(self:getResInst(otherRes[isPlayer and 2 or 3], parent), self:getResInst(otherRes[1], parent))

			self._roleItems[roleType] = roleItem
		end

		roleItem:refresh(roleType)
	end
end

function GuessGameNewPlayRolesView:_addSelfEvents()
	local controller = GuessGameNewController.instance

	self._selfEvents = {
		[GuessGameNewEvent.OnRoleGuessFinished] = self._onRoleGuessFinished,
		[GuessGameNewEvent.OnReduceRoleHp] = self._onReduceRoleHp,
		[GuessGameNewEvent.OnRoundDistributeCardFinished] = self._onDistributeGiftsFinished,
		[GuessGameNewEvent.OnRoleSelectCardStart] = self._onRoleStartSelectGifts,
		[GuessGameNewEvent.OnRoleSelectCardFinished] = self._onRoleSelectGiftFinished,
		[GuessGameNewEvent.OnRoundStart] = self._onRoundStarted
	}

	for event, handler in pairs(self._selfEvents) do
		self:addEventCb(controller, event, handler, self)
	end
end

function GuessGameNewPlayRolesView:_removeSelfEvents()
	local controller = GuessGameNewController.instance

	for event, handler in pairs(self._selfEvents) do
		self:removeEventCb(controller, event, handler, self)
	end
end

function GuessGameNewPlayRolesView:_onRoleSelectGiftFinished()
	for _, roleItem in pairs(self._roleItems) do
		roleItem:hideSelectGifts()

		if roleItem:getRoleType() ~= GuessGameNewEnum.RoleType.Player then
			roleItem:showRoleSelect(false)
		else
			roleItem:clearRoleCardSelectCallback()
		end
	end
end

function GuessGameNewPlayRolesView:_onRoleGuessFinished()
	for _, roleItem in pairs(self._roleItems or {}) do
		roleItem:showRoleSelect(false)
	end
end

function GuessGameNewPlayRolesView:_onReduceRoleHp(roleType)
	for _, roleItem in pairs(self._roleItems or {}) do
		roleItem:refreshHp()

		if roleItem:getRoleType() == roleType then
			roleItem:showRoleReduceHp()
		end
	end
end

function GuessGameNewPlayRolesView:_onDistributeGiftsFinished()
	for _, roleItem in pairs(self._roleItems or {}) do
		roleItem:showGifts(true)
	end
end

local MinPlayCount = 2

function GuessGameNewPlayRolesView:_getRandomSelectGifts(roleType)
	local model = GuessGameNewModel.instance
	local gifts = model:getRoleGifts(roleType)

	if not gifts or #gifts <= 0 then
		return {}
	end

	local ConstId = GuessGameNewEnum.ConstId
	local TemperType = GuessGameNewEnum.TemperType
	local config = GuessGameNewConfig.instance
	local targetGiftId = model:getTargetGiftId()
	local realIndexs, fakeIndexs = {}, {}

	for index, giftId in ipairs(gifts) do
		local giftCo = config:getBoxGiftCo(giftId)
		local isReal = giftId == targetGiftId or giftCo and giftCo.type == GuessGameNewEnum.GiftType.Wild

		table.insert(isReal and realIndexs or fakeIndexs, index)
	end

	local realCount = #realIndexs
	local giftCount = gifts and #gifts or 0
	local roleMo = model:getRoleData(roleType)
	local temperType = model:getRoleTemperType(roleType)
	local roleName = roleType == GuessGameNewEnum.RoleType.Player and PlayerModel.instance:getPlayerName() or roleMo.npcConfig.name

	if temperType == TemperType.Cautious then
		local doubtParams = string.splitToNumber(config:getConstValue(ConstId.CautiousDoubtStreakPreferReal), ",")
		local needStreak = doubtParams and doubtParams[1] or 0

		if needStreak > 0 and needStreak <= (roleMo.doubtedStreak or 0) and realCount >= MinPlayCount then
			local count = self:_randomPlayCount(ConstId.CautiousPlayCountWeightGte2, realCount)
			local selectIndexs = self:_buildSelectIndexs(realIndexs, {}, count, 0)

			logNormal(roleName .. " cautious, continus doubted first set real, selectIndexs: " .. table.concat(selectIndexs, ","))

			return selectIndexs
		end

		if realCount < 2 then
			local weightId = self:_getPlayCountWeightId(temperType, false)
			local count = self:_randomPlayCount(weightId, giftCount)
			local realTakeCount = math.min(realCount, count)
			local selectIndexs = self:_buildSelectIndexs(realIndexs, fakeIndexs, realTakeCount, count - realTakeCount)

			logNormal(roleName .. " cautious, realCount < 2, selectIndexs: " .. table.concat(selectIndexs, ","))

			return selectIndexs
		else
			local playRealProbability = self:_getPlayRealProbability(temperType, roleType)
			local isPlayReal = playRealProbability >= math.random(1, 100)
			local maxFakeCount = self:_getMaxFakeCount(temperType)
			local weightId = self:_getPlayCountWeightId(temperType, true)
			local maxPlayCount = isPlayReal and realCount or math.min(realCount + maxFakeCount, giftCount)
			local count = self:_randomPlayCount(weightId, maxPlayCount)

			if isPlayReal then
				local selectIndexs = self:_buildSelectIndexs(realIndexs, {}, count, 0)

				logNormal(roleName .. " cautious, realCount >= 2, set real card, selectIndexs: " .. table.concat(selectIndexs, ","))

				return selectIndexs
			end

			local fakeTakeCount = math.min(maxFakeCount, count)
			local selectIndexs = self:_buildSelectIndexs(realIndexs, fakeIndexs, count - fakeTakeCount, fakeTakeCount)

			logNormal(roleName .. " cautious, realCount >= 2, set fake card, selectIndexs: " .. table.concat(selectIndexs, ","))

			return selectIndexs
		end
	elseif temperType == TemperType.Radical then
		if realCount < 2 then
			local weightId = self:_getPlayCountWeightId(temperType, false)
			local count = self:_randomPlayCount(weightId, giftCount)
			local realTakeCount = math.min(realCount, count)
			local selectIndexs = self:_buildSelectIndexs(realIndexs, fakeIndexs, realTakeCount, count - realTakeCount)

			logNormal(roleName .. " radical, realCount < 2, selectIndexs: " .. table.concat(selectIndexs, ","))

			return selectIndexs
		else
			local playRealProbability = self:_getPlayRealProbability(temperType, roleType)
			local isPlayReal = playRealProbability >= math.random(1, 100)
			local maxFakeCount = self:_getMaxFakeCount(temperType)
			local weightId = self:_getPlayCountWeightId(temperType, true)
			local maxPlayCount = isPlayReal and realCount or math.min(realCount + maxFakeCount, giftCount)
			local count = self:_randomPlayCount(weightId, maxPlayCount)

			if isPlayReal then
				local selectIndexs = self:_buildSelectIndexs(realIndexs, {}, count, 0)

				logNormal(roleName .. " radical, realCount >= 2, set real card, selectIndexs: " .. table.concat(selectIndexs, ","))

				return selectIndexs
			end

			local fakeTakeCount = math.min(maxFakeCount, count)
			local selectIndexs = self:_buildSelectIndexs(realIndexs, fakeIndexs, count - fakeTakeCount, fakeTakeCount)

			logNormal(roleName .. " radical, realCount >= 2, set fake card, selectIndexs: " .. table.concat(selectIndexs, ","))

			return selectIndexs
		end
	elseif realCount < 2 then
		local weightId = self:_getPlayCountWeightId(temperType, false)
		local count = self:_randomPlayCount(weightId, giftCount)
		local realTakeCount = math.min(realCount, count)
		local selectIndexs = self:_buildSelectIndexs(realIndexs, fakeIndexs, realTakeCount, count - realTakeCount)

		logNormal(roleName .. " logical, realcount < 2, real Priority, selectIndexs: " .. table.concat(selectIndexs, ","))

		return selectIndexs
	else
		local playRealProbability = self:_getPlayRealProbability(temperType, roleType)
		local isPlayReal = playRealProbability >= math.random(1, 100)
		local maxFakeCount = self:_getMaxFakeCount(temperType)
		local weightId = self:_getPlayCountWeightId(temperType, true)
		local maxPlayCount = isPlayReal and realCount or math.min(realCount + maxFakeCount, giftCount)
		local count = self:_randomPlayCount(weightId, maxPlayCount)

		if isPlayReal then
			local selectIndexs = self:_buildSelectIndexs(realIndexs, {}, count, 0)

			logNormal(roleName .. " logical, realCount >= 2, set real card, selectIndexs: " .. table.concat(selectIndexs, ","))

			return selectIndexs
		end

		local fakeTakeCount = math.min(maxFakeCount, count)
		local selectIndexs = self:_buildSelectIndexs(realIndexs, fakeIndexs, count - fakeTakeCount, fakeTakeCount)

		logNormal(roleName .. " logical, realCount >= 2, set fake card, selectIndexs: " .. table.concat(selectIndexs, ","))

		return selectIndexs
	end
end

function GuessGameNewPlayRolesView:_getPlayCountWeightId(temperType, gte2)
	local ConstId = GuessGameNewEnum.ConstId
	local TemperType = GuessGameNewEnum.TemperType

	if temperType == TemperType.Cautious then
		return gte2 and ConstId.CautiousPlayCountWeightGte2 or ConstId.CautiousPlayCountWeightLt2
	elseif temperType == TemperType.Logical then
		return gte2 and ConstId.LogicalPlayCountWeightGte2 or ConstId.LogicalPlayCountWeightLt2
	end

	return gte2 and ConstId.AggressivePlayCountWeightGte2 or ConstId.AggressivePlayCountWeightLt2
end

function GuessGameNewPlayRolesView:_getMaxFakeCount(temperType)
	local ConstId = GuessGameNewEnum.ConstId

	if temperType == GuessGameNewEnum.TemperType.Cautious then
		local maxFakeCount = GuessGameNewConfig.instance:getConstNumberValue(ConstId.CautiousMaxFakeCount)

		return maxFakeCount > 0 and maxFakeCount or 1
	elseif temperType == GuessGameNewEnum.TemperType.Logical then
		return GuessGameNewConfig.instance:getConstNumberValue(ConstId.LogicalMaxFakeCount)
	end

	return GuessGameNewConfig.instance:getConstNumberValue(ConstId.AggressiveMaxFakeCount)
end

function GuessGameNewPlayRolesView:_getPlayRealProbability(temperType, roleType)
	local ConstId = GuessGameNewEnum.ConstId
	local config = GuessGameNewConfig.instance

	if temperType == GuessGameNewEnum.TemperType.Logical then
		local model = GuessGameNewModel.instance
		local netTrust = model:getTargetBelieveTimes() - model:getTargetDoubtTimes() + 2
		local index = math.max(1, math.min(netTrust + 1, 5))
		local probabilities = string.splitToNumber(config:getConstValue(ConstId.LogicalAllRealCardProbability), ",") or {}

		return probabilities[index] or 50
	end

	local probability = config:getConstNumberValue(ConstId.AggressiveAllRealCardProbability)

	if temperType == GuessGameNewEnum.TemperType.Cautious then
		probability = config:getConstNumberValue(ConstId.CautiousAllRealCardProbability)

		local truthParams = string.splitToNumber(config:getConstValue(ConstId.CautiousTruthStreakNoFakeReduce), ",")
		local needStreak = truthParams and truthParams[1] or 0
		local reduce = truthParams and truthParams[2] or 0
		local roleMo = GuessGameNewModel.instance:getRoleData(roleType)

		if needStreak > 0 and reduce > 0 and needStreak <= (roleMo.truthStreak or 0) then
			probability = probability - reduce
		end
	end

	return probability
end

function GuessGameNewPlayRolesView:_randomPlayCount(weightConstId, maxCount)
	maxCount = math.floor(maxCount or 0)

	local weightStr = GuessGameNewConfig.instance:getConstValue(weightConstId)
	local countWeights = GameUtil.splitString2(weightStr, true, "|", "#") or {}
	local weightByCount, countList, total = {}, {}, 0

	for _, params in ipairs(countWeights) do
		local count, weight = params[1], params[2]

		if count and weight and count >= MinPlayCount and weight > 0 then
			count = math.max(math.min(count, maxCount), MinPlayCount)

			if not weightByCount[count] then
				weightByCount[count] = 0

				table.insert(countList, count)
			end

			weightByCount[count] = weightByCount[count] + weight
			total = total + weight
		end
	end

	if total <= 0 then
		logError(string.format("GuessGameNewPlayRolesView:_randomPlayCount invalid weight config, constId:%s value:%s", tostring(weightConstId), tostring(weightStr)))

		return MinPlayCount
	end

	local random = math.random(1, total)
	local acc = 0

	for _, count in ipairs(countList) do
		acc = acc + weightByCount[count]

		if random <= acc then
			return count
		end
	end

	return countList[#countList]
end

function GuessGameNewPlayRolesView:_buildSelectIndexs(realIndexs, fakeIndexs, realTakeCount, fakeTakeCount)
	local realPool = realTakeCount > 0 and #realIndexs > 0 and GameUtil.randomTable(realIndexs) or {}
	local fakePool = fakeTakeCount > 0 and #fakeIndexs > 0 and GameUtil.randomTable(fakeIndexs) or {}
	local selectIndexs = {}

	for i = 1, math.min(realTakeCount, #realPool) do
		table.insert(selectIndexs, realPool[i])
	end

	for i = 1, math.min(fakeTakeCount, #fakePool) do
		table.insert(selectIndexs, fakePool[i])
	end

	table.sort(selectIndexs)

	return selectIndexs
end

local showSelectTime = 1

function GuessGameNewPlayRolesView:_onRoleStartSelectGifts()
	local roleType = GuessGameNewModel.instance:getCurPlayRole()

	if roleType ~= GuessGameNewEnum.RoleType.Player then
		local selectIndexs = self:_getRandomSelectGifts(roleType)

		GuessGameNewModel.instance:setRoleGiftsSelect(roleType, selectIndexs)

		for index, roleItem in pairs(self._roleItems) do
			local showSelect = index == roleType

			roleItem:showRoleSelect(showSelect)
		end

		TaskDispatcher.runDelay(self._onShowNpcSelectFinished, self, showSelectTime)

		return
	end

	self._selectIndexs = {}

	self._roleItems[GuessGameNewEnum.RoleType.Player]:setRoleCardSelectCallback(self._onGiftSelected, self)
end

function GuessGameNewPlayRolesView:_onGiftSelected(giftIndex)
	if not self._selectIndexs then
		self._selectIndexs = {}
	end

	if LuaUtil.tableContains(self._selectIndexs, giftIndex) then
		for i = #self._selectIndexs, 1, -1 do
			if self._selectIndexs[i] == giftIndex then
				table.remove(self._selectIndexs, i)

				break
			end
		end
	else
		if #self._selectIndexs >= 5 then
			GameFacade.showToast(ToastEnum.GuessGameNewMaxSelectCardCount)

			return
		end

		table.insert(self._selectIndexs, giftIndex)
	end

	GuessGameNewModel.instance:setRoleGiftsSelect(GuessGameNewEnum.RoleType.Player, self._selectIndexs)

	local roleItem = self._roleItems[GuessGameNewEnum.RoleType.Player]

	roleItem:refresh()
	roleItem:showRoleSelect(true)
end

function GuessGameNewPlayRolesView:_onRoundStarted()
	self:_hideGifts()

	for _, roleItem in pairs(self._roleItems or {}) do
		roleItem:refreshGiftsSelect(false)
	end
end

function GuessGameNewPlayRolesView:_hideGifts()
	for _, roleItem in pairs(self._roleItems or {}) do
		roleItem:showGifts(false)
	end
end

function GuessGameNewPlayRolesView:_onShowNpcSelectFinished()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoleSelectCardFinished)
end

function GuessGameNewPlayRolesView:onClose()
	return
end

function GuessGameNewPlayRolesView:onDestroyView()
	TaskDispatcher.cancelTask(self._onShowNpcSelectFinished, self)

	if self._roleItems then
		for _, v in pairs(self._roleItems) do
			v:destroy()
		end

		self._roleItems = nil
	end

	self:_removeSelfEvents()
end

return GuessGameNewPlayRolesView
