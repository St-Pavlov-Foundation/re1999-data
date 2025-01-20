module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessGameViewContainer", package.seeall)

slot0 = class("AutoChessGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.view = AutoChessGameView.New()

	table.insert(slot1, slot0.view)
	table.insert(slot1, AutoChessGameScene.New())
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

		slot0.navigateView:setOverrideClose(slot0.clickClose, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0.clickClose(slot0)
	if slot0.view.isFight then
		return
	end

	AutoChessController.instance:exitGame()
end

return slot0
