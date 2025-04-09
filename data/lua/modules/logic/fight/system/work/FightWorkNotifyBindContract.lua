module("modules.logic.fight.system.work.FightWorkNotifyBindContract", package.seeall)

slot0 = class("FightWorkNotifyBindContract", FightEffectBase)

function slot0.onStart(slot0)
	FightModel.instance:setNotifyContractInfo(slot0.actEffectData.targetId, FightStrUtil.instance:getSplitCache(slot0.actEffectData.reserveStr, "#"))
	slot0:onDone(true)
end

return slot0
