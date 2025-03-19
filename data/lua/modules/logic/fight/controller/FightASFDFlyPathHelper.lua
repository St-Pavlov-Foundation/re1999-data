module("modules.logic.fight.controller.FightASFDFlyPathHelper", package.seeall)

slot0 = _M

function slot0.getMissileMover(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	return uv0.flyPathHandle[slot1.flyPath] or uv0.defaultFlyMover(slot1.flyPath, slot0, slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0.defaultFlyMover(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	MonoHelper.addLuaComOnceToGo(slot3.containerGO, UnitMoverHandler)
	MonoHelper.addLuaComOnceToGo(slot3.containerGO, UnitMoverBezier3):registerCallback(UnitMoveEvent.Arrive, slot6, slot7)
	FightASFDHelper.changeRandomArea()

	slot10 = FightASFDHelper.getStartPos(slot1:getMO() and slot9.side or FightEnum.EntitySide.MySide, slot2.sceneEmitterId)
	slot11 = FightASFDHelper.getEndPos(slot4)
	slot13 = FightASFDHelper.getRandomPos(slot10, slot11, slot2)

	slot3:setWorldPos(slot10.x, slot10.y, slot10.z)

	slot16 = FightASFDConfig.instance:getFlyPathCo(slot0)

	slot8:setEaseType(slot16.lineType)
	slot8:simpleMove(slot10, slot13, slot13, slot11, FightASFDConfig.instance:getFlyDuration(slot16.flyDuration, slot5.emitterAttackNum) / FightModel.instance:getSpeed())

	return slot8
end

function slot0.straightLineFlyMover(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	MonoHelper.addLuaComOnceToGo(slot3.containerGO, UnitMoverHandler)
	MonoHelper.addLuaComOnceToGo(slot3.containerGO, UnitMoverEase):registerCallback(UnitMoveEvent.Arrive, slot6, slot7)

	slot10 = FightASFDHelper.getStartPos(slot1:getMO() and slot9.side or FightEnum.EntitySide.MySide, slot2.sceneEmitterId)
	slot11 = FightASFDHelper.getEndPos(slot4, ModuleEnum.SpineHangPoint.mountbody)

	slot3:setWorldPos(slot10.x, slot10.y, slot10.z)
	transformhelper.setLocalRotation(slot3.containerGO.transform, 0, 0, FightASFDHelper.getZRotation(slot10.x, slot10.y, slot11.x, slot11.y))

	slot13 = FightASFDConfig.instance:getFlyPathCo(slot0)

	slot8:setEaseType(slot13.lineType)
	slot8:simpleMove(slot10.x, slot10.y, slot10.z, slot11.x, slot11.y, slot11.z, FightASFDConfig.instance:getFlyDuration(slot13.flyDuration, slot5.emitterAttackNum) / FightModel.instance:getSpeed())

	return slot8
end

slot0.flyPathHandle = {
	[FightEnum.ASFDFlyPath.Default] = slot0.defaultFlyMover,
	[FightEnum.ASFDFlyPath.StraightLine] = slot0.straightLineFlyMover
}

return slot0
