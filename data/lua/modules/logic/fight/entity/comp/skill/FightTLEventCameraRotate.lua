module("modules.logic.fight.entity.comp.skill.FightTLEventCameraRotate", package.seeall)

slot0 = class("FightTLEventCameraRotate", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		slot7 = GameSceneMgr.instance:getCurScene().camera

		slot7:setEaseTime(slot3[3] == "1" and 0 or slot2)
		slot7:setRotate(tonumber(slot3[1]) or 0, tonumber(slot3[2]) or 0)
	end
end

return slot0
