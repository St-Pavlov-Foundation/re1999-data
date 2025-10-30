﻿-- chunkname: @modules/logic/pcInput/activityAdapter/CommonActivityAdapter.lua

module("modules.logic.pcInput.activityAdapter.CommonActivityAdapter", package.seeall)

local CommonActivityAdapter = class("CommonActivityAdapter", BaseActivityAdapter)

CommonActivityAdapter.keytoFunction = {
	Esc = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyCommonCancel)
	end,
	Return = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyCommonConfirm)
	end
}

function CommonActivityAdapter:ctor()
	self.keytoFunction = CommonActivityAdapter.keytoFunction

	self:registerFunction()
end

function CommonActivityAdapter:registerFunction()
	for k, _ in pairs(self.keytoFunction) do
		PCInputController.instance:registerKey(k, ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function CommonActivityAdapter:unRegisterFunction()
	return
end

function CommonActivityAdapter:OnkeyUp(keyName)
	local func = self.keytoFunction[keyName]

	if func then
		func()
	end
end

function CommonActivityAdapter:OnkeyDown(keyName)
	local func = self.keytoFunction[keyName]

	if func then
		func()
	end
end

function CommonActivityAdapter:destroy()
	self:unRegisterFunction()
end

return CommonActivityAdapter
