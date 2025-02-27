module("modules.logic.weekwalk_2.view.WeekWalk_2HeartViewContainer", package.seeall)

slot0 = class("WeekWalk_2HeartViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._heartView = WeekWalk_2HeartView.New()

	table.insert(slot1, slot0._heartView)
	table.insert(slot1, WeekWalk_2Ending.New())
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.WeekWalk)

		slot0._navigateButtonView:setOverrideClose(slot0._overrideClose, slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0._overrideClose(slot0)
	module_views_preloader.WeekWalk_2HeartLayerViewPreload(function ()
		uv0._heartView._viewAnim:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(uv0._doClose, uv0, 0.133)
	end)
end

function slot0._doClose(slot0)
	if not ViewMgr.instance:isOpen(ViewName.WeekWalk_2HeartLayerView) then
		WeekWalk_2Controller.instance:openWeekWalk_2HeartLayerView({
			mapId = WeekWalk_2Model.instance:getCurMapId()
		})
	end

	slot0:closeThis()
end

function slot0.onContainerDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._doClose, slot0)
end

return slot0
