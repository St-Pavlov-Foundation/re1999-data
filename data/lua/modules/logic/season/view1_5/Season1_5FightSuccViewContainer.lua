module("modules.logic.season.view1_5.Season1_5FightSuccViewContainer", package.seeall)

slot0 = class("Season1_5FightSuccViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_5FightSuccView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
