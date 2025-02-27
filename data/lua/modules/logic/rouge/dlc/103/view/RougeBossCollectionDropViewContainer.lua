module("modules.logic.rouge.dlc.103.view.RougeBossCollectionDropViewContainer", package.seeall)

slot0 = class("RougeBossCollectionDropViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeBossCollectionDropView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, TabViewGroup.New(2, "layout/#go_rougemapdetailcontainer"))

	slot2 = HelpShowView.New()

	slot2:setHelpId(HelpEnum.HelpId.RougeBossCollectionDropHelp)
	table.insert(slot1, slot2)

	return slot1
end

function slot0.playCloseTransition(slot0)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, RougeMapEnum.CollectionChangeAnimDuration)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				false,
				false,
				true
			}, HelpEnum.HelpId.RougeBossCollectionDropHelp)
		}
	elseif slot1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return slot0
