module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandGameViewContainer", package.seeall)

slot0 = class("CooperGarlandGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CooperGarlandGameView.New())
	table.insert(slot1, CooperGarlandGameScene.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setOverrideClose(slot0.overrideClose, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0.overrideClose(slot0)
	if CooperGarlandGameModel.instance:getIsRemoveMode() then
		CooperGarlandController.instance:changeRemoveMode()
	else
		CooperGarlandController.instance:setStopGame(true)
		GameFacade.showMessageBox(MessageBoxIdDefine.CooperGarlandExitGame, MsgBoxEnum.BoxType.Yes_No, slot0._confirmExit, slot0._closeMessBox, nil, slot0, slot0)
	end
end

function slot0._confirmExit(slot0)
	CooperGarlandStatHelper.instance:sendGameExit(ViewName.CooperGarlandGameView)
	slot0.navigateView:_reallyClose()
	CooperGarlandController.instance:exitGame()
end

function slot0._closeMessBox(slot0)
	CooperGarlandController.instance:setStopGame(false)
end

return slot0
