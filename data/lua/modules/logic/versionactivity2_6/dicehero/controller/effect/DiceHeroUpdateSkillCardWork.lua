module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroUpdateSkillCardWork", package.seeall)

slot0 = class("DiceHeroUpdateSkillCardWork", DiceHeroBaseEffectWork)

function slot0.onStart(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._effectMo.skillCards) do
		if DiceHeroFightModel.instance:getGameData():getCardMoBySkillId(slot7.skillId) then
			slot8:init(slot7)
		end
	end

	slot0:onDone(true)
end

return slot0
