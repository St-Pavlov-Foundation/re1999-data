module("modules.logic.tower.view.assistboss.TowerBossTeachViewContainer", package.seeall)

slot0 = class("TowerBossTeachViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerBossTeachView.New())

	return slot1
end

return slot0
