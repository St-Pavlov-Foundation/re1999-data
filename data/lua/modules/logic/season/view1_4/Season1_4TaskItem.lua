﻿-- chunkname: @modules/logic/season/view1_4/Season1_4TaskItem.lua

module("modules.logic.season.view1_4.Season1_4TaskItem", package.seeall)

local Season1_4TaskItem = class("Season1_4TaskItem", UserDataDispose)

Season1_4TaskItem.BlockKey = "Season1_4TaskItemAni"

function Season1_4TaskItem:ctor(go, parentScrollGO)
	self:__onInit()

	self._viewGO = go
	self._simageBg = gohelper.findChildSingleImage(go, "#simage_bg")
	self._goNormal = gohelper.findChild(go, "#goNormal")
	self._goTotal = gohelper.findChild(go, "#goTotal")
	self._ani = go:GetComponent(typeof(UnityEngine.Animator))

	self:initNormal(parentScrollGO)
	self:initTotal()

	if self._editableInitView then
		self:_editableInitView()
	end

	self:addEventListeners()
end

function Season1_4TaskItem:addEventListeners()
	self._btnGoto:AddClickListener(self.onClickGoto, self)
	self._btnReceive:AddClickListener(self.onClickReceive, self)
	self._btnGetTotal:AddClickListener(self.onClickGetTotal, self)
end

function Season1_4TaskItem:removeEventListeners()
	self._btnGoto:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
	self._btnGetTotal:RemoveClickListener()
end

function Season1_4TaskItem:initNormal(parentScrollGO)
	self._txtCurCount = gohelper.findChildTextMesh(self._goNormal, "#txt_curcount")
	self._txtMaxCount = gohelper.findChildTextMesh(self._goNormal, "#txt_curcount/#txt_maxcount")
	self._txtDesc = gohelper.findChildTextMesh(self._goNormal, "#txt_desc")
	self._scrollreward = gohelper.findChild(self._goNormal, "#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._gocontent = gohelper.findChild(self._goNormal, "#scroll_rewards/Viewport/Content")
	self._scrollreward.parentGameObject = parentScrollGO
	self._goRewardTemplate = gohelper.findChild(self._gocontent, "#go_rewarditem")

	gohelper.setActive(self._goRewardTemplate, false)

	self._goMask = gohelper.findChild(self._goNormal, "#go_blackmask")
	self._goFinish = gohelper.findChild(self._goNormal, "#go_finish")
	self._goGoto = gohelper.findChild(self._goNormal, "#btn_goto")
	self._btnGoto = gohelper.findChildButtonWithAudio(self._goNormal, "#btn_goto")
	self._goReceive = gohelper.findChild(self._goNormal, "#btn_receive")
	self._btnReceive = gohelper.findChildButtonWithAudio(self._goNormal, "#btn_receive")
	self._goUnfinish = gohelper.findChild(self._goNormal, "#go_unfinish")
	self._goType1 = gohelper.findChild(self._goGoto, "#go_gotype1")
	self._goType3 = gohelper.findChild(self._goGoto, "#go_gotype3")
end

function Season1_4TaskItem:initTotal()
	self._btnGetTotal = gohelper.findChildButtonWithAudio(self._goTotal, "#btn_getall")
end

function Season1_4TaskItem:onUpdateMO(data, open)
	if data then
		gohelper.setActive(self._viewGO, true)

		if data.isTotalGet then
			gohelper.setActive(self._goNormal, false)
			gohelper.setActive(self._goTotal, true)
			self._simageBg:LoadImage(ResUrl.getSeasonIcon("tap2.png"))
		else
			gohelper.setActive(self._goNormal, true)
			gohelper.setActive(self._goTotal, false)
			self:refreshNormal(data)
		end

		if open then
			self._ani:Play(UIAnimationName.Open)
		else
			self._ani:Play(UIAnimationName.Idle)
		end
	else
		gohelper.setActive(self._viewGO, false)
	end
end

function Season1_4TaskItem:hide()
	gohelper.setActive(self._viewGO, false)
end

function Season1_4TaskItem:refreshNormal(data)
	self.taskId = data.id
	self.jumpId = data.config.jumpId

	gohelper.setActive(self._viewGO, true)
	self:refreshReward(data)
	self:refreshDesc(data)
	self:refreshProgress(data)
	self:refreshState(data)
end

function Season1_4TaskItem:refreshReward(data)
	local config = data.config
	local rewardStrList = string.split(config.bonus, "|")
	local dataList = {}

	for i, v in ipairs(rewardStrList) do
		if not string.nilorempty(v) then
			local itemCo = string.splitToNumber(v, "#")
			local co = {
				isIcon = true,
				materilType = itemCo[1],
				materilId = itemCo[2],
				quantity = itemCo[3]
			}

			table.insert(dataList, co)
		end
	end

	if config.activity104EquipBonus > 0 then
		table.insert(dataList, {
			equipId = config.activity104EquipBonus
		})
	end

	if not self._rewardItems then
		self._rewardItems = {}
	end

	for i = 1, math.max(#self._rewardItems, #dataList) do
		local co = dataList[i]
		local item = self._rewardItems[i] or self:createRewardItem(i)

		self:refreshRewardItem(item, co)
	end
end

function Season1_4TaskItem:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.clone(self._goRewardTemplate, self._gocontent, "reward_" .. tostring(index))

	item.go = itemGo
	item.itemParent = gohelper.findChild(itemGo, "go_prop")
	item.cardParent = gohelper.findChild(itemGo, "go_card")
	self._rewardItems[index] = item

	return item
end

function Season1_4TaskItem:refreshRewardItem(item, data)
	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	if data.equipId then
		gohelper.setActive(item.cardParent, true)
		gohelper.setActive(item.itemParent, false)

		if not item.equipIcon then
			item.equipIcon = Season1_4CelebrityCardItem.New()

			item.equipIcon:init(item.cardParent, data.equipId)
		end

		item.equipIcon:reset(data.equipId)

		return
	end

	gohelper.setActive(item.cardParent, false)
	gohelper.setActive(item.itemParent, true)

	if not item.itemIcon then
		item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.itemParent)
	end

	item.itemIcon:onUpdateMO(data)
	item.itemIcon:isShowCount(true)
	item.itemIcon:setCountFontSize(40)
	item.itemIcon:showStackableNum2()
	item.itemIcon:setHideLvAndBreakFlag(true)
	item.itemIcon:hideEquipLvAndBreak(true)
end

function Season1_4TaskItem:destroyRewardItem(item)
	if item.itemIcon then
		item.itemIcon:onDestroy()

		item.itemIcon = nil
	end

	if item.equipIcon then
		item.equipIcon:destroy()

		item.equipIcon = nil
	end
end

function Season1_4TaskItem:refreshDesc(data)
	local config = data.config
	local bgStr = string.format("tap%s.png", config.bgType == 1 and 3 or 1)

	self._simageBg:LoadImage(ResUrl.getSeasonIcon(bgStr))

	self._txtDesc.text = config.desc
end

function Season1_4TaskItem:refreshProgress(data)
	local progress = data.progress
	local maxProgress = data.config.maxProgress

	self._txtCurCount.text = progress
	self._txtMaxCount.text = maxProgress
end

function Season1_4TaskItem:refreshState(data)
	if data.finishCount >= data.config.maxFinishCount then
		gohelper.setActive(self._goMask, true)
		gohelper.setActive(self._goFinish, true)
		gohelper.setActive(self._goGoto, false)
		gohelper.setActive(self._goReceive, false)
	elseif data.hasFinished then
		gohelper.setActive(self._goMask, false)
		gohelper.setActive(self._goFinish, false)
		gohelper.setActive(self._goGoto, false)
		gohelper.setActive(self._goReceive, true)
	else
		gohelper.setActive(self._goMask, false)
		gohelper.setActive(self._goFinish, false)
		gohelper.setActive(self._goReceive, false)

		if self.jumpId and self.jumpId > 0 then
			local config = data.config

			gohelper.setActive(self._goGoto, true)
			gohelper.setActive(self._goUnfinish, false)
			gohelper.setActive(self._goType1, data.config.bgType ~= 1)
			gohelper.setActive(self._goType3, data.config.bgType == 1)
		else
			gohelper.setActive(self._goGoto, false)
			gohelper.setActive(self._goUnfinish, true)
		end
	end
end

function Season1_4TaskItem:onClickGoto()
	if not self.jumpId then
		return
	end

	if GameFacade.jump(self.jumpId) then
		local actId = Activity104Model.instance:getCurSeasonId()
		local realView = SeasonViewHelper.getViewName(actId, Activity104Enum.ViewName.TaskView)

		ViewMgr.instance:closeView(realView)
	end
end

function Season1_4TaskItem:onClickReceive()
	if not self.taskId then
		return
	end

	gohelper.setActive(self._goMask, true)
	self._ani:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(Season1_4TaskItem.BlockKey)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, 0.76)
end

function Season1_4TaskItem:onClickGetTotal()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Season)
end

function Season1_4TaskItem:_onPlayActAniFinished()
	UIBlockMgr.instance:endBlock(Season1_4TaskItem.BlockKey)
	TaskRpc.instance:sendFinishTaskRequest(self.taskId)
	self:hide()
end

function Season1_4TaskItem:destroy()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)
	self:removeEventListeners()

	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			self:destroyRewardItem(item)
		end

		self._rewardItems = nil
	end

	self:__onDispose()
end

return Season1_4TaskItem
