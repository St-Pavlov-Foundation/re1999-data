-- chunkname: @modules/logic/udimo/controller/ExitUdimoSceneHelper.lua

module("modules.logic.udimo.controller.ExitUdimoSceneHelper", package.seeall)

local ExitUdimoSceneHelper = _M

function ExitUdimoSceneHelper._resumeMailView()
	MailController.instance:open()
end

function ExitUdimoSceneHelper._resumeTaskView()
	TaskController.instance:enterTaskViewCheckUnlock()
end

function ExitUdimoSceneHelper._resumeBackpackView()
	ItemRpc.instance:sendGetPowerMakerInfoRequest(false, false, ExitUdimoSceneHelper._afterGetPowerMakerInfo)
end

function ExitUdimoSceneHelper._afterGetPowerMakerInfo()
	BackpackController.instance:enterItemBackpack()
end

function ExitUdimoSceneHelper._resumeStoreView()
	local isCanOpen = StoreController.instance:checkAndOpenStoreView()

	if not isCanOpen then
		GameLoadingState:clearWaitView()
	end
end

function ExitUdimoSceneHelper._resumeMainThumbnailView()
	MainController.instance:openMainThumbnailView()
end

function ExitUdimoSceneHelper._resumeDungeonView()
	DungeonController.instance:enterDungeonView(true)
end

function ExitUdimoSceneHelper._resumeSignInView()
	ExitUdimoSceneHelper._resumeMainThumbnailView()
	SignInController.instance:openSignInDetailView({
		isBirthday = false
	})
end

function ExitUdimoSceneHelper._resumeSettingsView()
	ExitUdimoSceneHelper._resumeMainThumbnailView()
	SettingsController.instance:openView()
end

function ExitUdimoSceneHelper._resumeNoticeView()
	if VersionValidator.instance:isInReviewing() then
		GameLoadingState:clearWaitView()

		return
	end

	ExitUdimoSceneHelper._resumeMainThumbnailView()
	NoticeController.instance:openNoticeView()
end

function ExitUdimoSceneHelper._resumePlayerView()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	PlayerController.instance:openPlayerView(playerInfo, true)
end

function ExitUdimoSceneHelper._resumeCharacterBackpackView()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Role) then
		CharacterController.instance:enterCharacterBackpack()
	else
		GameLoadingState:clearWaitView()
	end
end

function ExitUdimoSceneHelper._resumeBpView()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		BpController.instance:openBattlePassView()
	else
		GameLoadingState:clearWaitView()
	end
end

function ExitUdimoSceneHelper._resumePowerView()
	CurrencyController.instance:openPowerView()
end

ExitUdimoSceneHelper.ResumeViewHandlerFuncDict = {
	[ViewName.MailView] = ExitUdimoSceneHelper._resumeMailView,
	[ViewName.TaskView] = ExitUdimoSceneHelper._resumeTaskView,
	[ViewName.BackpackView] = ExitUdimoSceneHelper._resumeBackpackView,
	[ViewName.StoreView] = ExitUdimoSceneHelper._resumeStoreView,
	[ViewName.MainThumbnailView] = ExitUdimoSceneHelper._resumeMainThumbnailView,
	[ViewName.DungeonView] = ExitUdimoSceneHelper._resumeDungeonView,
	[ViewName.SignInView] = ExitUdimoSceneHelper._resumeSignInView,
	[ViewName.SettingsView] = ExitUdimoSceneHelper._resumeSettingsView,
	[ViewName.NoticeView] = ExitUdimoSceneHelper._resumeNoticeView,
	[ViewName.PlayerView] = ExitUdimoSceneHelper._resumePlayerView,
	[ViewName.CharacterBackpackView] = ExitUdimoSceneHelper._resumeCharacterBackpackView,
	[ViewName.BpView] = ExitUdimoSceneHelper._resumeBpView,
	[ViewName.PowerView] = ExitUdimoSceneHelper._resumePowerView
}

function ExitUdimoSceneHelper.resumeViewOnExitScene()
	local viewName = UdimoModel.instance:getResumeViewName()

	if string.nilorempty(viewName) then
		return
	end

	local resumeFunc = ExitUdimoSceneHelper.ResumeViewHandlerFuncDict[viewName]

	if not resumeFunc then
		return
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, viewName)
	SceneHelper.instance:waitSceneDone(SceneType.Main, resumeFunc)
end

return ExitUdimoSceneHelper
