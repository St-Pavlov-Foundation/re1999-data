-- chunkname: @modules/logic/fight/system/work/FightWorkDevicePowerChange374.lua

module("modules.logic.fight.system.work.FightWorkDevicePowerChange374", package.seeall)

local FightWorkDevicePowerChange374 = class("FightWorkDevicePowerChange374", FightEffectBase)

function FightWorkDevicePowerChange374:onStart()
	local changeFrom = self.actEffectData.effectNum

	FightController.instance:dispatchEvent(FightEvent.OnDevice_PowerChange, self.actEffectData.reserveStr, changeFrom)

	return self:onDone(true)
end

return FightWorkDevicePowerChange374
