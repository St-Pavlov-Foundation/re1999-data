-- chunkname: @modules/logic/main/controller/work/LinkGiftPanelPatWork.lua

module("modules.logic.main.controller.work.LinkGiftPanelPatWork", package.seeall)

local LinkGiftPanelPatWork = class("LinkGiftPanelPatWork", ActivityRoleSignWorkBase)

function LinkGiftPanelPatWork:onGetViewNames()
	local viewName = PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)

	if not string.nilorempty(viewName) then
		return {
			viewName
		}
	end

	viewName = GameBranchMgr.instance:Vxax_ViewName("LinkGift_PanelView", ViewName.LinkGift_PanelView)

	return {
		viewName
	}
end

function LinkGiftPanelPatWork:onGetActIds()
	return {
		(ActivityType101Config.instance:getLinkGiftActId())
	}
end

function LinkGiftPanelPatWork:onWork(refWorkContext)
	local actId = self._actId

	refWorkContext.bAutoWorkNext = false

	if not ActivityType101Model.instance:isOpen(actId) then
		self:onDone(true)

		return
	end

	if self:_bAllSoldOut(actId) then
		self:onDone(true)

		return
	end

	refWorkContext.bAutoWorkNext = true

	LinkGiftPanelPatWork.super.onWork(self, refWorkContext)
end

function LinkGiftPanelPatWork:_bAllSoldOut(actId)
	local activityCo = self:getActivityCo(actId)

	if not activityCo then
		return false
	end

	local lua_store_charge_goods_ids = string.splitToNumber(activityCo.param, "#")

	return StoreModel.instance:isAllSoldOut(lua_store_charge_goods_ids)
end

return LinkGiftPanelPatWork
