﻿module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotRoomViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_CachotRoomView.New(),
		V1a6_CachotPlayCtrlView.New(),
		V1a6_CachotHeartView.New("top/#go_heart"),
		V1a6_CachotRoomTopLeftView.New(),
		V1a6_CachotRoomTopRightView.New(),
		V1a6_CachotCurrencyView.New("top"),
		V1a6_CachotRoomTipsView.New(),
		V1a6_CachotRoomEventTipsView.New(),
		V1a6_CachotRoomGuide.New(),
		V1a6_CachotGuideDragTip.New()
	}
end

return var_0_0
