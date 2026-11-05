-- chunkname: @modules/logic/fight/system/work/FightWorkClueMaxAdd392.lua

module("modules.logic.fight.system.work.FightWorkClueMaxAdd392", package.seeall)

local FightWorkClueMaxAdd392 = class("FightWorkClueMaxAdd392", FightEffectBase)

function FightWorkClueMaxAdd392:onStart()
	local entityId = self.actEffectData.targetId

	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, entityId, self.actEffectData.effectNum)

	return self:onDone(true)
end

return FightWorkClueMaxAdd392
