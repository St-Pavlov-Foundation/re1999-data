module("modules.logic.explore.map.unit.ExploreBonusSceneUnit", package.seeall)

slot0 = class("ExploreBonusSceneUnit", ExploreBaseMoveUnit)

function slot0.needInteractAnim(slot0)
	return true
end

function slot0.canTrigger(slot0)
	if slot0.mo:isInteractActiveState() then
		return false
	end

	return uv0.super.canTrigger(slot0)
end

return slot0
