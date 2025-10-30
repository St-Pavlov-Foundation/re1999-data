﻿-- chunkname: @modules/logic/versionactivity2_8/molideer/view/MoLiDeErTaskItem.lua

module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErTaskItem", package.seeall)

local MoLiDeErTaskItem = class("MoLiDeErTaskItem", ListScrollCellExtend)

function MoLiDeErTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._gonojump = gohelper.findChild(self.viewGO, "#go_normal/#go_nojump")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function MoLiDeErTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function MoLiDeErTaskItem:_btnnotfinishbgOnClick()
	if self._act194TaskMO.config.jumpId > 0 then
		GameFacade.jump(self._act194TaskMO.config.jumpId)
	end
end

function MoLiDeErTaskItem:_btnfinishbgOnClick()
	self:_onOneClickClaimReward(self._act194TaskMO.activityId)
	UIBlockHelper.instance:startBlock("MoLiDeErTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(self._delayFinish, self, 0.5)
end

function MoLiDeErTaskItem:_btngetallOnClick()
	LiangYueController.instance:dispatchEvent(MoLiDeErEvent.OneClickClaimReward, self._act194TaskMO.activityId, true)
	UIBlockHelper.instance:startBlock("MoLiDeErTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(self._delayFinishAll, self, 0.5)
end

function MoLiDeErTaskItem:_delayFinish()
	TaskRpc.instance:sendFinishTaskRequest(self._act194TaskMO.config.id)
end

function MoLiDeErTaskItem:_delayFinishAll()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity194)
end

function MoLiDeErTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewTrs = self.viewGO.transform
	self._scrollRewards = gohelper.findChildComponent(self.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function MoLiDeErTaskItem:_editableAddEvents()
	LiangYueController.instance:registerCallback(MoLiDeErEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function MoLiDeErTaskItem:_editableRemoveEvents()
	LiangYueController.instance:unregisterCallback(MoLiDeErEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function MoLiDeErTaskItem:_onOneClickClaimReward(actId, isAll)
	if self._act194TaskMO and self._act194TaskMO.activityId == actId and (self._act194TaskMO:alreadyGotReward() or self._act194TaskMO.id == -99999 and isAll) then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function MoLiDeErTaskItem:getAnimator()
	return self._animator
end

function MoLiDeErTaskItem:onUpdateMO(mo)
	self._act194TaskMO = mo

	local rankDiff = MoLiDeErTaskListModel.instance:getRankDiff(mo)

	self._scrollRewards.parentGameObject = self._view._csListScroll.gameObject

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function MoLiDeErTaskItem:_moveByRankDiff(rankDiff)
	if rankDiff and rankDiff ~= 0 then
		if self._rankDiffMoveId then
			ZProj.TweenHelper.KillById(self._rankDiffMoveId)

			self._rankDiffMoveId = nil
		end

		local posx, posy, posz = transformhelper.getLocalPos(self.viewTrs)

		transformhelper.setLocalPosXY(self.viewTrs, posx, 165 * rankDiff)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, 0.15)
	end
end

function MoLiDeErTaskItem:onSelect(isSelect)
	return
end

function MoLiDeErTaskItem:_refreshUI()
	local atMO = self._act194TaskMO

	if not atMO then
		return
	end

	local isNormal = atMO.id ~= -99999

	gohelper.setActive(self._gogetall, not isNormal)
	gohelper.setActive(self._gonormal, isNormal)

	if isNormal then
		if self._playFinishAnin then
			self._playFinishAnin = false

			self._animator:Play("idle", 0, 1)
		end

		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg, false)
		gohelper.setActive(self._btnfinishbg, false)
		gohelper.setActive(self._gonojump, false)

		if atMO:isFinished() then
			gohelper.setActive(self._goallfinish, true)
		elseif atMO:alreadyGotReward() then
			gohelper.setActive(self._btnfinishbg, true)
		elseif atMO.config.jumpId > 0 then
			gohelper.setActive(self._btnnotfinishbg, true)
		else
			gohelper.setActive(self._gonojump, true)
		end

		local offestPro = atMO.config and atMO.config.offestProgress or 0

		self._txtnum.text = math.max(atMO:getFinishProgress() + offestPro, 0)
		self._txttotal.text = math.max(atMO:getMaxProgress() + offestPro, 0)
		self._txttaskdes.text = atMO.config and atMO.config.desc or ""

		local list = DungeonConfig.instance:getRewardItems(tonumber(atMO.config.bonus))
		local item_list = {}

		for k, v in ipairs(list) do
			item_list[k] = {
				isIcon = true,
				materilType = v[1],
				materilId = v[2],
				quantity = v[3]
			}
		end

		self.item_list = item_list

		IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self._gorewards)

		self._scrollRewards.horizontalNormalizedPosition = 0
	end
end

function MoLiDeErTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function MoLiDeErTaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end
end

return MoLiDeErTaskItem
