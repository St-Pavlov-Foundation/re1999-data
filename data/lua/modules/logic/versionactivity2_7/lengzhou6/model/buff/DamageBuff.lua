module("modules.logic.versionactivity2_7.lengzhou6.model.buff.DamageBuff", package.seeall)

slot0 = class("DamageBuff", BuffBase)

function slot0.execute(slot0)
	if uv0.super.execute(slot0) and slot0._triggerPoint == LengZhou6GameModel.instance:getCurGameStep() and LengZhou6GameModel.instance:getPlayer() and slot2:getDamageComp() then
		slot3:setExDamage(slot0._layerCount * 1)
	end
end

return slot0
