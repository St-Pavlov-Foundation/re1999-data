module("modules.logic.versionactivity2_5.challenge.view.enter.Act183MainViewContainer", package.seeall)

slot0 = class("Act183MainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act183MainView.New())
	table.insert(slot1, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(slot1, TabViewGroup.New(2, "root/left/#go_store"))

	slot2 = HelpShowView.New()

	slot2:setHelpId(HelpEnum.HelpId.Act183EnterMain)
	table.insert(slot1, slot2)

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Act183EnterMain)

		return {
			slot0.navigateView
		}
	elseif slot1 == 2 then
		return {
			Act183StoreEntry.New()
		}
	end
end

return slot0
