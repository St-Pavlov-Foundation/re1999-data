-- chunkname: @modules/logic/survival/controller/work/SurvivalMessagePushWork.lua

module("modules.logic.survival.controller.work.SurvivalMessagePushWork", package.seeall)

local SurvivalMessagePushWork = class("SurvivalMessagePushWork", BaseWork)

function SurvivalMessagePushWork:ctor()
	self.messages = self._msg.messages
	self.unitId = self._msg.unitId
end

function SurvivalMessagePushWork:onStart()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onViewClose, self)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalLeaveMsgView, {
		message = self.message
	})
end

function SurvivalMessagePushWork:onViewClose(viewName)
	if viewName == ViewName.SurvivalLeaveMsgView then
		self:onDone(true)
	end
end

function SurvivalMessagePushWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onViewClose, self)
end

return SurvivalMessagePushWork
