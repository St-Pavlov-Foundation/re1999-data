module("modules.logic.gm.view.GMFightNuoDiKaXianJieAnNiuContainer", package.seeall)

slot0 = class("GMFightNuoDiKaXianJieAnNiuContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, GMFightNuoDiKaXianJieAnNiu.New())

	return slot1
end

return slot0
