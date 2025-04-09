module("modules.logic.fight.system.work.FightWorkMagicCircleUpgrade340", package.seeall)

slot0 = class("FightWorkMagicCircleUpgrade340", FightEffectBase)

function slot0.onStart(slot0)
	if FightModel.instance:getMagicCircleInfo() then
		slot1:refreshData(slot0.actEffectData.magicCircle)
		FightController.instance:dispatchEvent(FightEvent.UpgradeMagicCircile, slot1)
	end

	slot0:onDone(true)
end

return slot0
