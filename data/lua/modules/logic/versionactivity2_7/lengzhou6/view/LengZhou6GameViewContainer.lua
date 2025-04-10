module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameViewContainer", package.seeall)

slot0 = class("LengZhou6GameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LengZhou6GameView.New(),
		TabViewGroup.New(1, "#go_btns"),
		LengZhou6EliminateView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			false,
			slot0:_getHelpId() ~= nil
		}, slot2)

		slot0.navigationView:setOverrideClose(slot0._overrideClose, slot0)

		return {
			slot0.navigationView
		}
	end
end

function slot0._overrideClose(slot0)
	if LengZhou6Model.instance:getEpisodeInfoMo(LengZhou6Model.instance:getCurEpisodeId()) then
		LengZhou6StatHelper.instance:setGameResult(slot2:isEndlessEpisode() and LengZhou6Enum.GameResult.infiniteCancel or LengZhou6Enum.GameResult.normalCancel)
	end

	LengZhou6GameController.instance:levelGame(true)
	LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.OnClickCloseGameView)
	LengZhou6StatHelper.instance:sendGameExit()
end

function slot0.refreshHelpId(slot0)
	if slot0:_getHelpId() ~= nil and slot0.navigationView ~= nil then
		slot0.navigationView:setHelpId(slot1)
	end
end

function slot0._getHelpId(slot0)
	return 2500200
end

function slot0.onContainerInit(slot0)
	slot0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0.refreshHelpId, slot0)
end

return slot0
