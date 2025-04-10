module("modules.logic.versionactivity2_7.act191.view.Act191HeroGroupViewContainer", package.seeall)

slot0 = class("Act191HeroGroupViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.groupView = Act191HeroGroupView.New()

	table.insert(slot1, slot0.groupView)

	slot0.groupListView = Act191HeroGroupListView.New()

	table.insert(slot1, slot0.groupListView)
	table.insert(slot1, CheckActivityEndView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, slot0._closeCallback, nil, , slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0._closeCallback(slot0)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(true)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			Activity191Controller.instance:openMainView()
		end, nil, VersionActivity2_7Enum.ActivityId.Act191, true)
	end)
end

function slot0.playOpenTransition(slot0)
	slot0.groupView.anim:Play("open", 0, 0)
	slot0.groupListView.animSwitch:Play("open", 0, 0)
	TaskDispatcher.runDelay(slot0.onPlayOpenTransitionFinish, slot0, 0.33)
end

function slot0.playCloseTransition(slot0)
	slot0.groupView.anim:Play("close", 0, 0)
	slot0.groupListView.animSwitch:Play("close", 0, 0)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 0.16)
end

function slot0.onContainerDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.onPlayOpenTransitionFinish, slot0)
	TaskDispatcher.cancelTask(slot0.onPlayCloseTransitionFinish, slot0)
end

return slot0
