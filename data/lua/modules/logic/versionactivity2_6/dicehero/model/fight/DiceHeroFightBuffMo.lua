module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightBuffMo", package.seeall)

slot0 = pureTable("DiceHeroFightBuffMo")

function slot0.init(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.id = slot1.id
	slot0.layer = slot1.layer
	slot0.co = lua_dice_buff.configDict[slot0.id]
end

return slot0
