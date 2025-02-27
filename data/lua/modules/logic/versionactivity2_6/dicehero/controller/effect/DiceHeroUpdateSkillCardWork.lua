module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroUpdateSkillCardWork", package.seeall)

slot0 = class("DiceHeroUpdateSkillCardWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	for slot5, slot6 in pairs(DiceHeroHelper.instance._cardDict) do
		slot6:playRefreshAnim()
	end

	TaskDispatcher.runDelay(slot0._delayRefreshCard, slot0, 0.167)
end

function slot0._delayRefreshCard(slot0)
	for slot5, slot6 in ipairs(slot0._effectMo.skillCards) do
		if DiceHeroFightModel.instance:getGameData():getCardMoBySkillId(slot6.skillId) then
			slot7:init(slot6)
		end
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayRefreshCard, slot0)
end

return slot0
