module("modules.logic.fight.entity.comp.skill.FightTLEventDisableSpineRotate", package.seeall)

slot0 = class("FightTLEventDisableSpineRotate", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	slot0:_disable()
end

function slot0.onTrackEnd(slot0)
	slot0:_enable()
end

function slot0._enable(slot0)
	slot0:_do(true)
end

function slot0._disable(slot0)
	slot0:_do(false)
end

function slot0._do(slot0, slot1)
	GameSceneMgr.instance:getCurScene().entityMgr.enableSpineRotate = slot1
end

return slot0
