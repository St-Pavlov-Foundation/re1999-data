module("modules.logic.fight.entity.comp.skill.FightTLEventChangeScene", package.seeall)

slot0 = class("FightTLEventChangeScene", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	if not string.nilorempty(slot3[1]) then
		GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevelNoEffect(tonumber(slot3[1]))
	end
end

function slot0.onTrackEnd(slot0)
end

return slot0
