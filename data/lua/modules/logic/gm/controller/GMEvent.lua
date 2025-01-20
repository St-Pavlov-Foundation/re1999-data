module("modules.logic.gm.controller.GMEvent", package.seeall)

slot1 = 1

function slot2(slot0)
	assert(uv0[slot0] == nil, "[GMEvent] error redefined GMEvent." .. slot0)

	uv0[slot0] = uv1
	uv1 = uv1 + 1
end

slot2("RecommendStore_ShowAllBannerUpdate")
slot2("RecommendStore_ShowAllTabIdUpdate")
slot2("RecommendStore_StopBannerLoopAnimUpdate")
slot2("GMLog_Trigger")
slot2("GMLog_UpdateCount")
slot2("GMLogView_Select")

return _M
