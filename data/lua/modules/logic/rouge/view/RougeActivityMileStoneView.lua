-- chunkname: @modules/logic/rouge/view/RougeActivityMileStoneView.lua

module("modules.logic.rouge.view.RougeActivityMileStoneView", package.seeall)

local RougeActivityMileStoneView = class("RougeActivityMileStoneView", BaseView)
local StagePointWidth = 30
local StartSpace = 95
local StageSpace = 240

function RougeActivityMileStoneView:onInitView()
	self.btnStoneCanget = gohelper.findChildButtonWithAudio(self.viewGO, "root/bonusNode/milestone/go_canget")
	self.txtStoneProgress = gohelper.findChildTextMesh(self.viewGO, "root/bonusNode/milestone/progress/txtprogress")
	self.itemGO = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem")

	gohelper.setActive(self.itemGO, false)

	self.goLine = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content/#go_normalline")
	self.trsLine = self.goLine.transform
	self.goContent = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content")
	self.contentTransform = self.goContent.transform
	self.goScroll = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward")
	self.scroll = gohelper.findChildScrollRect(self.viewGO, "root/bonusNode/#scroll_reward")
	self.scrollRect = gohelper.findChildComponent(self.viewGO, "root/bonusNode/#scroll_reward", typeof(ZProj.LimitedScrollRect))
	self.scrollWidth = recthelper.getWidth(self.goScroll.transform)
	self.goBubble = gohelper.findChild(self.viewGO, "root/bonusNode/bubble")
	self.btnSpBonus = gohelper.findChildButtonWithAudio(self.viewGO, "root/bonusNode/bubble/btn")
	self.goreward = gohelper.findChild(self.viewGO, "root/bonusNode/bubble/goreward")

	gohelper.setActive(self.goBubble, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeActivityMileStoneView:addEvents()
	self.scroll:AddOnValueChanged(self.onValueChanged, self)
	self:addClickCb(self.btnSpBonus, self.onClickBtnSpBonus, self)
	self:addEventCb(Activity186Controller.instance, Activity186Event.GetDailyCollection, self.onGetDailyCollection, self)
	self:addEventCb(Activity186Controller.instance, Activity186Event.GetMilestoneReward, self.onGetMilestoneReward, self)
	self:addEventCb(Activity186Controller.instance, Activity186Event.FinishAllTask, self.onUpdateInfo, self)
	self:addEventCb(Activity186Controller.instance, Activity186Event.UpdateInfo, self.onUpdateInfo, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrencyChange, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseView, self)
end

function RougeActivityMileStoneView:removeEvents()
	self.scroll:RemoveOnValueChanged()
	self:addClickCb(self.btnSpBonus, self.onClickBtnSpBonus, self)
	self:removeEventCb(Activity186Controller.instance, Activity186Event.GetDailyCollection, self.onGetDailyCollection, self)
	self:removeEventCb(Activity186Controller.instance, Activity186Event.GetMilestoneReward, self.onGetMilestoneReward, self)
	self:removeEventCb(Activity186Controller.instance, Activity186Event.UpdateInfo, self.onUpdateInfo, self)
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrencyChange, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseView, self)
end

function RougeActivityMileStoneView:_editableInitView()
	self.scrollBonusCanvasGroup = self.goScroll:GetComponent(gohelper.Type_CanvasGroup)
end

function RougeActivityMileStoneView:onValueChanged()
	self:refreshSpBonusReward()
end

function RougeActivityMileStoneView:onClickBtnSpBonus()
	self:_moveToIndex(self._spBonusIndex)
end

function RougeActivityMileStoneView:onCloseView(viewName)
	if viewName == ViewName.CommonPropView and self._waitRefresh then
		self:refreshView()
	end
end

function RougeActivityMileStoneView:onCurrencyChange(changeIds)
	if not changeIds then
		return
	end

	local currencyId = Activity186Config.instance:getConstNum(self.actId, Activity186Enum.ConstId.CurrencyId)

	if changeIds[currencyId] then
		self._waitRefresh = true
	end
end

function RougeActivityMileStoneView:onGetMilestoneReward()
	self:refreshList()
end

function RougeActivityMileStoneView:onUpdateInfo()
	self:refreshView()
end

function RougeActivityMileStoneView:onGetDailyCollection()
	self:refreshStone()
end

function RougeActivityMileStoneView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function RougeActivityMileStoneView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function RougeActivityMileStoneView:refreshParam()
	self.actId = self.viewParam and self.viewParam.actId
	self.actMo = Activity186Model.instance:getById(self.actId)

	RougeActivityMileStoneListModel.instance:init(self.actMo)
end

function RougeActivityMileStoneView:refreshView()
	self._waitRefresh = false

	self:refreshList()
	self:refreshStone()
end

function RougeActivityMileStoneView:refreshStone()
	local maxMileStoneValue = RougeActivityMileStoneListModel.instance:getMaxMileStoneValue()
	local currencyId = Activity186Config.instance:getConstNum(self.actId, Activity186Enum.ConstId.CurrencyId)
	local currencyMo = CurrencyModel.instance:getCurrency(currencyId)
	local curMilestoneValue = currencyMo and currencyMo.quantity or 0

	self.txtStoneProgress.text = string.format("%s/%s", curMilestoneValue, maxMileStoneValue)
end

function RougeActivityMileStoneView:refreshList()
	RougeActivityMileStoneListModel.instance:refresh()
	TaskDispatcher.cancelTask(self.refreshLine, self)
	TaskDispatcher.runDelay(self.refreshLine, self, 0.01)
end

function RougeActivityMileStoneView:refreshLine()
	local index = RougeActivityMileStoneListModel.instance:caleProgressIndex()
	local indexValue = math.floor(index)
	local width = self:getItemPosX(indexValue) - 15
	local percent = index - indexValue

	if percent > 0 then
		local nextWidth = self:getItemWidth(indexValue + 1)

		if indexValue > 0 then
			width = width + (nextWidth + StagePointWidth) * percent
		else
			width = 72 * percent
		end
	end

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	if self._lineWidth and self._lineWidth ~= width then
		self._lineWidth = width
		self._moveTweenId = ZProj.TweenHelper.DOWidth(self.trsLine, width, 1, nil, nil, nil, EaseType.OutCubic)
	else
		self._lineWidth = width

		recthelper.setWidth(self.trsLine, width)
	end

	if not self.isOpen then
		self.isOpen = true

		self:moveToDefaultPos()
	end

	self:onValueChanged()
end

function RougeActivityMileStoneView:caleProgressIndex(list)
	local index = 0
	local currencyId = Activity186Config.instance:getConstNum(self.actId, Activity186Enum.ConstId.CurrencyId)
	local hasCurrencyNum = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)
	local lastCoinNum = 0

	for i, v in ipairs(list) do
		local coinNum = v.coinNum

		if hasCurrencyNum < coinNum then
			index = i + (hasCurrencyNum - lastCoinNum) / (coinNum - lastCoinNum) - 1

			return index
		end

		lastCoinNum = coinNum
	end

	local listLen = #list

	lastCoinNum = list[listLen - 1] and list[listLen - 1].coinNum or 0

	local loopConfig = list[listLen]
	local progress = self.actMo.getMilestoneProgress
	local loopNum = loopConfig.loopBonusIntervalNum or 1
	local coinNum = loopConfig.coinNum

	if progress < coinNum then
		index = listLen
	else
		local canGetTimesValue = (hasCurrencyNum - coinNum) / loopNum
		local canGetTimes = math.floor(canGetTimesValue)
		local getTimes = math.floor((progress - coinNum) / loopNum)

		if getTimes < canGetTimes then
			index = listLen
		else
			index = listLen - 1 + canGetTimesValue - canGetTimes
		end
	end

	return index
end

function RougeActivityMileStoneView:refreshSpBonusReward()
	local index = self:getSpBonusIndex()

	if self._spBonusIndex == index then
		return
	end

	self._spBonusIndex = index

	gohelper.setActive(self.goBubble, index ~= nil)

	if index ~= nil then
		local list = Activity186Config.instance:getMileStoneList(self.actId)
		local config = list[index]

		if config then
			local rewards = GameUtil.splitString2(config.bonus, true)
			local itemCo = rewards[1]

			if not self.itemIcon then
				self.itemIcon = IconMgr.instance:getCommonPropItemIcon(self.goreward)
			end

			self.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3])
			self.itemIcon:isShowQuality(false)
			self.itemIcon:isShowEquipAndItemCount(false)
			self.itemIcon:setCanShowDeadLine(false)
		end
	end
end

function RougeActivityMileStoneView:getSpBonusIndex()
	local contentX = recthelper.getAnchorX(self.contentTransform)
	local maxAnchorX = -(contentX - self.scrollWidth)
	local minAnchorX = -contentX
	local list = RougeActivityMileStoneListModel.instance:getList()

	for i, mo in ipairs(list) do
		if mo.isSpBonus then
			local itemPosX = self:getItemPosX(i)
			local status = self.actMo:getMilestoneRewardStatus(mo.rewardId)

			if minAnchorX <= itemPosX and itemPosX <= maxAnchorX and status == Activity186Enum.RewardStatus.Canget then
				return
			end

			if maxAnchorX < itemPosX and status ~= Activity186Enum.RewardStatus.Hasget then
				return i
			end
		end
	end
end

function RougeActivityMileStoneView:getItemPosX(index)
	if index <= 0 then
		return 0
	end

	local col = index - 1
	local posX = col * StageSpace + StartSpace

	return posX
end

function RougeActivityMileStoneView:getItemWidth(index)
	if not index then
		return 0
	end

	local list = RougeActivityMileStoneListModel.instance:getList()

	if list[index] then
		return StageSpace - StagePointWidth
	end

	return 0
end

function RougeActivityMileStoneView:moveToDefaultPos()
	local list = Activity186Config.instance:getMileStoneList(self.actId)
	local index = 1

	for i, config in ipairs(list) do
		local status = self.actMo:getMilestoneRewardStatus(config.rewardId)

		if status ~= Activity186Enum.RewardStatus.Hasget then
			index = i

			break
		end
	end

	self:_moveToIndex(index)
end

function RougeActivityMileStoneView:_moveToIndex(index)
	if not index then
		return
	end

	self.viewContainer.mileStoneScrollView:moveToByIndex(index)
	self:onValueChanged()
end

function RougeActivityMileStoneView:onClose()
	return
end

function RougeActivityMileStoneView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshLine, self)

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end
end

return RougeActivityMileStoneView
