module("modules.logic.fight.entity.comp.skill.FightTLEventCameraShake", package.seeall)

slot0 = class("FightTLEventCameraShake", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		GameSceneMgr.instance:getCurScene().camera:shake(slot2, tonumber(slot3[1]) or 0, tonumber(slot3[3]) or 0, tonumber(slot3[2]) or 0)
	end
end

return slot0
