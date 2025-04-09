module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6LevelViewContainer", package.seeall)

slot0 = class("LengZhou6LevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LengZhou6LevelView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigationView:setOverrideClose(slot0._overrideClose, slot0)

		return {
			slot0.navigationView
		}
	end
end

return slot0
