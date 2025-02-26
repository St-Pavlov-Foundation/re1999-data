module("modules.logic.rouge.dlc.103.view.RougeBossCollectionDropViewContainer", package.seeall)

slot0 = class("RougeBossCollectionDropViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeBossCollectionDropView.New())
	table.insert(slot1, TabViewGroup.New(2, "layout/#go_rougemapdetailcontainer"))

	return slot1
end

function slot0.playCloseTransition(slot0)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, RougeMapEnum.CollectionChangeAnimDuration)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return slot0
