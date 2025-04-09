module("modules.logic.gm.view.GMFightNuoDiKaXianJieCeShiContainer", package.seeall)

slot0 = class("GMFightNuoDiKaXianJieCeShiContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, GMFightNuoDiKaXianJieCeShi.New())

	return slot1
end

return slot0
