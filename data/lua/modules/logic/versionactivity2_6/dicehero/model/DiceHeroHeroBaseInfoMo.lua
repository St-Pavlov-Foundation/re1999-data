module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroHeroBaseInfoMo", package.seeall)

slot0 = pureTable("DiceHeroHeroBaseInfoMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.hp = tonumber(slot1.hp) or 0
	slot0.shield = tonumber(slot1.shield) or 0
	slot0.power = tonumber(slot1.power) or 0
	slot0.maxHp = tonumber(slot1.maxHp) or 0
	slot0.maxShield = tonumber(slot1.maxShield) or 0
	slot0.maxPower = tonumber(slot1.maxPower) or 0
	slot0.relicIds = slot1.relicIds

	if slot0.id ~= 0 then
		slot0.co = lua_dice_character.configDict[slot0.id]
	end
end

return slot0
