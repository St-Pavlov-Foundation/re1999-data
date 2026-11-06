-- chunkname: @modules/logic/gm/view/GM_ActivityWarmUpH5FullViewContainer.lua

module("modules.logic.gm.view.GM_ActivityWarmUpH5FullViewContainer", package.seeall)

local GM_ActivityWarmUpH5FullViewContainer = class("GM_ActivityWarmUpH5FullViewContainer", BaseViewContainer)

function GM_ActivityWarmUpH5FullViewContainer:buildViews()
	return {
		GM_ActivityWarmUpH5FullView.New()
	}
end

function GM_ActivityWarmUpH5FullViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_ActivityWarmUpH5FullViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.ActivityWarmUpH5FullView_OnUseTestEnv, viewObj._gm_onUseTestEnv, viewObj)
	GMController.instance:registerCallback(GMEvent.ActivityWarmUpH5FullView_OnClickDeleteLocalFile, viewObj._gm_onClickDeleteLocalFile, viewObj)
	GMController.instance:registerCallback(GMEvent.ActivityWarmUpH5FullView_OnClickDeletePlayerPrefsKey, viewObj._gm_onClickDeletePlayerPrefsKey, viewObj)
end

function GM_ActivityWarmUpH5FullViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.ActivityWarmUpH5FullView_OnUseTestEnv, viewObj._gm_onUseTestEnv, viewObj)
	GMController.instance:unregisterCallback(GMEvent.ActivityWarmUpH5FullView_OnClickDeleteLocalFile, viewObj._gm_onClickDeleteLocalFile, viewObj)
	GMController.instance:unregisterCallback(GMEvent.ActivityWarmUpH5FullView_OnClickDeletePlayerPrefsKey, viewObj._gm_onClickDeletePlayerPrefsKey, viewObj)
end

return GM_ActivityWarmUpH5FullViewContainer
