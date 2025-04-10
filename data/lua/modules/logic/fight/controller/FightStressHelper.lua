module("modules.logic.fight.controller.FightStressHelper", package.seeall)

slot0 = _M

function slot0.getStressUiType(slot0)
	if FightDataHelper.fieldMgr.customData and FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183] and slot1.stressIdentity[slot0] then
		table.sort(slot2, uv0.sortIdentity)

		return uv0.getIdentityUiType(slot2[1])
	end

	slot2 = nil

	if not FightDataHelper.entityMgr:getById(slot0) then
		return FightNameUIStressMgr.UiType.Normal
	end

	return uv0.getIdentityUiType((slot3.side ~= FightEnum.EntitySide.MySide or FightNameUIStressMgr.HeroDefaultIdentityId) and tonumber(slot5 and slot5.identity or FightNameUIStressMgr.HeroDefaultIdentityId))
end

function slot0.sortIdentity(slot0, slot1)
	return slot0 < slot1
end

function slot0.getIdentityUiType(slot0)
	if not lua_stress_identity.configDict[slot0] then
		logError(string.format("身份类型表，identityId : %s, 不存在", slot0))

		return FightNameUIStressMgr.UiType.Normal
	end

	return slot1.uiType
end

return slot0
