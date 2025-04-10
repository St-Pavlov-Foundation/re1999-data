module("modules.logic.fight.system.work.LY.FightWorkRedOrBlueCountExSkill", package.seeall)

slot0 = class("FightWorkRedOrBlueCountExSkill", FightEffectBase)

function slot0.onStart(slot0)
	if not FightStrUtil.instance:getSplitToNumberCache(slot0.actEffectData.reserveStr, "#") then
		return slot0:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.LY_TriggerCountSkill, slot1[1], slot1[2], tonumber(slot0.actEffectData.reserveId))

	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
