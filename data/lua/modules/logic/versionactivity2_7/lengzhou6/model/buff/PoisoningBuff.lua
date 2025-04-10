module("modules.logic.versionactivity2_7.lengzhou6.model.buff.PoisoningBuff", package.seeall)

slot0 = class("PoisoningBuff", BuffBase)

function slot0.execute(slot0)
	if uv0.super.execute(slot0) and slot0._triggerPoint == LengZhou6GameModel.instance:getCurGameStep() and LengZhou6GameModel.instance:getEnemy() then
		slot2:changeHp(-slot0._layerCount * 1)

		if isDebugBuild then
			logNormal("中毒伤害：" .. slot0._layerCount * 1)
		end

		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ShowEnemyEffect, LengZhou6Enum.BuffEffect.poison)
	end
end

return slot0
