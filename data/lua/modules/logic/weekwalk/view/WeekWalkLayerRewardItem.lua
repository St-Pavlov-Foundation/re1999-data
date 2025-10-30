﻿-- chunkname: @modules/logic/weekwalk/view/WeekWalkLayerRewardItem.lua

module("modules.logic.weekwalk.view.WeekWalkLayerRewardItem", package.seeall)

local WeekWalkLayerRewardItem = class("WeekWalkLayerRewardItem", ListScrollCellExtend)

function WeekWalkLayerRewardItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_bg")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_normal/#txt_index")
	self._scrollrewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._rewardscontent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._gonotget = gohelper.findChild(self.viewGO, "#go_normal/#go_notget")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	self._goblackmask = gohelper.findChild(self.viewGO, "#go_normal/#go_blackmask")
	self._goget = gohelper.findChild(self.viewGO, "#go_normal/#go_get")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_normal/info/#txt_desc")
	self._imagestar = gohelper.findChildImage(self.viewGO, "#go_normal/info/progress/#image_star")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btncollectall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/go_getall/#btn_collectall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkLayerRewardItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btncollectall:AddClickListener(self._btncollectallOnClick, self)
end

function WeekWalkLayerRewardItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btncollectall:RemoveClickListener()
end

function WeekWalkLayerRewardItem:_btncollectallOnClick()
	if self._isDeepTask then
		self:_getAllTaskReward()

		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, self)

	local list = WeekWalkTaskListModel.instance:getCanGetList()

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk, self._mo.minTypeId, list)
end

function WeekWalkLayerRewardItem:_btnnotfinishbgOnClick()
	return
end

function WeekWalkLayerRewardItem:_btnfinishbgOnClick()
	if self._isDeepTask then
		self:_getAllTaskReward()

		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, self)
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
end

function WeekWalkLayerRewardItem:_getAllTaskReward()
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, self)

	local _, _, list = WeekWalkTaskListModel.instance:getAllDeepTaskInfo()

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk, self._mo.minTypeId, list)
end

function WeekWalkLayerRewardItem:playOutAnim()
	gohelper.setActive(self._goblackmask, true)
	self._animator:Play("out", 0, 0)
end

function WeekWalkLayerRewardItem:_editableInitView()
	gohelper.setActive(self._imagestar.gameObject, false)

	self._rewardItems = self:getUserDataTb_()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function WeekWalkLayerRewardItem:getAnimator()
	return self._animator
end

function WeekWalkLayerRewardItem:_editableAddEvents()
	self._simagegetallbg:LoadImage(ResUrl.getWeekWalkBg("btn_yijiandi.png"))
	gohelper.addUIClickAudio(self._btnnotfinishbg.gameObject, AudioEnum.UI.play_ui_activity_jump)
	gohelper.addUIClickAudio(self._btnfinishbg.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
	gohelper.addUIClickAudio(self._btncollectall.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
end

function WeekWalkLayerRewardItem:_editableRemoveEvents()
	return
end

function WeekWalkLayerRewardItem:onUpdateMO(mo)
	if mo.isDirtyData then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self._mo = mo

	gohelper.setActive(self._gonormal, not mo.isGetAll)
	gohelper.setActive(self._gogetall, mo.isGetAll)

	local mapId = WeekWalkTaskListModel.instance:getLayerTaskMapId()

	self._isDeepTask = not WeekWalkModel.isShallowMap(mapId)

	if mo.isGetAll then
		return
	end

	self._config = lua_task_weekwalk.configDict[mo.id]
	self._txtindex.text = "0" .. WeekWalkTaskListModel.instance:getSortIndex(mo)

	self:_addRewards()
	self:_updateStatus()
	gohelper.setActive(self._txtdesc.gameObject, self._isDeepTask)

	if self._isDeepTask then
		self._txtdesc.text = self._config.desc
	end

	self:_initStars()
	self:_updateStars()

	self._scrollrewards.parentGameObject = self._view._csListScroll.gameObject
end

function WeekWalkLayerRewardItem:_initStars()
	if not self._starList then
		self._starList = self:getUserDataTb_()
	end

	local go = self._imagestar.gameObject
	local showStarCount = self._isDeepTask and 1 or self._config.maxProgress

	for i = #self._starList, showStarCount do
		local child = gohelper.cloneInPlace(go)

		gohelper.setActive(child, true)
		table.insert(self._starList, child:GetComponent(gohelper.Type_Image))
	end
end

function WeekWalkLayerRewardItem:_updateStars()
	if not self._starList then
		return
	end

	local showStarCount = self._isDeepTask and 1 or self._config.maxProgress

	for i, v in ipairs(self._starList) do
		gohelper.setActive(v.gameObject, i <= showStarCount)
		UISpriteSetMgr.instance:setWeekWalkSprite(v, (i <= self._taskMo.progress or self._isDeepTask) and "star_highlight4" or "star_null4")
	end
end

function WeekWalkLayerRewardItem:_updateStatus()
	self._taskMo = WeekWalkTaskListModel.instance:getTaskMo(self._mo.id)

	local isGet = self._taskMo.finishCount >= self._config.maxFinishCount

	gohelper.setActive(self._gonotget, not isGet)
	gohelper.setActive(self._goget, isGet)
	gohelper.setActive(self._goblackmask, isGet)

	if not isGet then
		local isFinish = self._taskMo.hasFinished

		gohelper.setActive(self._btnnotfinishbg.gameObject, not isFinish)
		gohelper.setActive(self._btnfinishbg.gameObject, isFinish)
	end

	local itemBgName = not isGet and self._taskMo.hasFinished and "img_bg_claim_hl.png" or "img_bg_claim_nor.png"

	self._simagebg:LoadImage(ResUrl.getWeekWalkBg(itemBgName))
end

function WeekWalkLayerRewardItem:_addRewards()
	self._scrollrewards.horizontalNormalizedPosition = 0

	local rewards = string.split(self._mo.bonus, "|")

	for i = 1, #rewards do
		local item = self:_getItem(i)
		local itemCo = string.splitToNumber(rewards[i], "#")

		gohelper.setActive(item.parentGo, true)
		item.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		item.itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:setCountFontSize(40)
		item.itemIcon:showStackableNum2()
		item.itemIcon:setHideLvAndBreakFlag(true)
		item.itemIcon:hideEquipLvAndBreak(true)
	end

	for i = #rewards + 1, #self._rewardItems do
		local item = self._rewardItems[i]

		if item then
			gohelper.setActive(item.parentGo, false)
		end
	end

	local itemwidth = recthelper.getWidth(self._gorewarditem.transform)
	local space = -13
	local contentwidth = (itemwidth + space) * #rewards

	recthelper.setWidth(self._rewardscontent.transform, contentwidth)
end

function WeekWalkLayerRewardItem:_getItem(index)
	local item = self._rewardItems[index]

	if item then
		return item
	end

	item = self:getUserDataTb_()
	item.parentGo = gohelper.clone(self._gorewarditem, self._rewardscontent)
	item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.parentGo)
	self._rewardItems[index] = item

	return item
end

function WeekWalkLayerRewardItem:onSelect(isSelect)
	return
end

function WeekWalkLayerRewardItem:onDestroyView()
	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()
	end

	self._rewardItems = nil

	self._simagebg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()
end

return WeekWalkLayerRewardItem
