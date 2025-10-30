﻿-- chunkname: @modules/logic/activity/view/ActivityStarLightSignItem_1_3.lua

module("modules.logic.activity.view.ActivityStarLightSignItem_1_3", package.seeall)

local ActivityStarLightSignItem_1_3 = class("ActivityStarLightSignItem_1_3", ListScrollCellExtend)

function ActivityStarLightSignItem_1_3:onInitView()
	self._goNormalBG = gohelper.findChild(self.viewGO, "Root/#go_NormalBG")
	self._goSelectedBG = gohelper.findChild(self.viewGO, "Root/#go_SelectedBG")
	self._txtDay = gohelper.findChildText(self.viewGO, "Root/#txt_Day")
	self._txtDayEn = gohelper.findChildText(self.viewGO, "Root/#txt_DayEn")
	self._goTomorrowTag = gohelper.findChild(self.viewGO, "Root/#go_TomorrowTag")
	self._goitem1 = gohelper.findChild(self.viewGO, "Root/Item/#go_item1")
	self._goitem2 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2")
	self._goIcon1 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2/#go_Icon1")
	self._goIcon2 = gohelper.findChild(self.viewGO, "Root/Item/#go_item2/#go_Icon2")
	self._txtName = gohelper.findChildText(self.viewGO, "Root/#txt_Name")
	self._goFinishedBG = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG")
	self._goTick1 = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG/#go_Tick1")
	self._goTick2 = gohelper.findChild(self.viewGO, "Root/#go_FinishedBG/#go_Tick2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityStarLightSignItem_1_3:addEvents()
	return
end

function ActivityStarLightSignItem_1_3:removeEvents()
	return
end

local sf = string.format
local splitToNumber = string.splitToNumber
local split = string.split

function ActivityStarLightSignItem_1_3:_editableInitView()
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._itemClick = gohelper.getClickWithAudio(self._goSelectedBG)
	self._itemClick2 = gohelper.getClickWithAudio(self._goNormalBG)
	self._itemList = {}
	self._item = IconMgr.instance:getCommonPropItemIcon(self._goitem1)
end

function ActivityStarLightSignItem_1_3:_editableAddEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
	self._itemClick2:AddClickListener(self._onItemClick, self)
end

function ActivityStarLightSignItem_1_3:_editableRemoveEvents()
	self._itemClick:RemoveClickListener()
	self._itemClick2:RemoveClickListener()
end

function ActivityStarLightSignItem_1_3:onUpdateMO(mo)
	self._mo = mo

	if not self._openAnim then
		self:_playOpen()
	else
		self:_playIdle()
	end

	self:_refreshItem()
end

function ActivityStarLightSignItem_1_3:onSelect(isSelect)
	return
end

function ActivityStarLightSignItem_1_3:_refreshRewardItem(item, itemCo)
	local actId = self._mo.data[1]
	local index = self._index

	item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	item:setCountFontSize(46)
	item:setHideLvAndBreakFlag(true)
	item:hideEquipLvAndBreak(true)
	item:customOnClickCallback(function()
		local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

		if couldGet then
			Activity101Rpc.instance:sendGet101BonusRequest(actId, index)

			return
		end

		MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
	end)
end

function ActivityStarLightSignItem_1_3:_refreshItem()
	local actId = self._mo.data[1]
	local index = self._index
	local rewardGet = ActivityType101Model.instance:isType101RewardGet(actId, index)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)
	local totalday = ActivityType101Model.instance:getType101LoginCount(actId)
	local co = ActivityConfig.instance:getNorSignActivityCo(actId, index)
	local rewards = split(co.bonus, "|")
	local rewardCount = #rewards
	local isShowOneReward = rewardCount == 1

	gohelper.setActive(self._goitem1, isShowOneReward)
	gohelper.setActive(self._goTick1, isShowOneReward)
	gohelper.setActive(self._goitem2, not isShowOneReward)
	gohelper.setActive(self._goTick2, not isShowOneReward)

	self._txtName.text = ""

	for i = 1, rewardCount do
		local itemCo = splitToNumber(rewards[i], "#")
		local item = self._itemList[i]

		if not item then
			item = IconMgr.instance:getCommonPropItemIcon(self["_goIcon" .. i])

			table.insert(self._itemList, item)
		end

		self:_refreshRewardItem(item, itemCo)

		if i == 1 then
			self:_refreshRewardItem(self._item, itemCo)

			if isShowOneReward then
				local itemConfig = ItemModel.instance:getItemConfig(itemCo[1], itemCo[2])

				self._txtName.text = itemConfig.name
			end
		end
	end

	self._txtDay.text = index < 10 and "0" .. index or index
	self._txtDayEn.text = sf("DAY\n%s", GameUtil.getEnglishNumber(index))

	gohelper.setActive(self._goSelectedBG, couldGet)
	gohelper.setActive(self._goTomorrowTag, index ~= 10 and index == totalday + 1)
	gohelper.setActive(self._goFinishedBG, rewardGet)
end

function ActivityStarLightSignItem_1_3:onDestroyView()
	self._openAnim = nil

	TaskDispatcher.cancelTask(self._playOpenInner, self)
end

function ActivityStarLightSignItem_1_3:_onItemClick()
	local actId = self._mo.data[1]
	local index = self._index

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)
	local totalday = ActivityType101Model.instance:getType101LoginCount(actId)

	if couldGet then
		Activity101Rpc.instance:sendGet101BonusRequest(actId, index)
	end

	if totalday < index then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

function ActivityStarLightSignItem_1_3:_playOpenInner()
	self:_setActive(true)
	self._anim:Play(UIAnimationName.Open)
end

function ActivityStarLightSignItem_1_3:_playOpen()
	if self._openAnim then
		return
	end

	self._openAnim = true

	self:_setActive(false)
	TaskDispatcher.runDelay(self._playOpenInner, self, self._index * 0.03)
end

function ActivityStarLightSignItem_1_3:_playIdle()
	if self._openAnim then
		return
	end

	self._anim:Play(UIAnimationName.Idle, 0, 1)
end

function ActivityStarLightSignItem_1_3:_setActive(bool)
	gohelper.setActive(self.viewGO, bool)
end

return ActivityStarLightSignItem_1_3
