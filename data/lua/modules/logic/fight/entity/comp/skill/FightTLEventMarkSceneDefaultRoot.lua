module("modules.logic.fight.entity.comp.skill.FightTLEventMarkSceneDefaultRoot", package.seeall)

slot0 = class("FightTLEventMarkSceneDefaultRoot", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	uv0.sceneId = GameSceneMgr.instance:getCurSceneId()
	uv0.levelId = GameSceneMgr.instance:getCurLevelId()
	uv0.rootName = slot3[1]
end

function slot0.onTrackEnd(slot0)
end

function slot0.onDestructor(slot0)
end

return slot0
