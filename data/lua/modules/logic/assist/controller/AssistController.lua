-- chunkname: @modules/logic/assist/controller/AssistController.lua

module("modules.logic.assist.controller.AssistController", package.seeall)

local AssistController = class("AssistController", BaseController)

function AssistController:addConstEvents()
	self:addEventCb(LoginController.instance, LoginEvent.OnLoginEnterMainScene, self.onLoginFinish, self)
	self:addEventCb(OpenController.instance, OpenEvent.NewFuncUnlock, self.onNewFuncUnlock, self)
end

function AssistController:onLoginFinish()
	PlayerRpc.instance:sendMainSceneLoadCompleteRequest()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		RoleBadgeRpc.instance:sendRoleBadgeGetInfoRequest()
	end
end

function AssistController:onNewFuncUnlock(ids)
	if tabletool.indexOf(ids, OpenEnum.UnlockFunc.Friend) then
		RoleBadgeRpc.instance:sendRoleBadgeGetInfoRequest()
	end
end

AssistController.instance = AssistController.New()

return AssistController
