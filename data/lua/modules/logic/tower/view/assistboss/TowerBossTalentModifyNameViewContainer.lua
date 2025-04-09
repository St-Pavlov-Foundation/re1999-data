module("modules.logic.tower.view.assistboss.TowerBossTalentModifyNameViewContainer", package.seeall)

slot0 = class("TowerBossTalentModifyNameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerBossTalentModifyNameView.New())

	return slot1
end

return slot0
