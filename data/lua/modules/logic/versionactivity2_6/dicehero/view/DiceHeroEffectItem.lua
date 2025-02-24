module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroEffectItem", package.seeall)

slot0 = class("DiceHeroEffectItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._trans = slot1.transform
	slot0._godamage = gohelper.findChild(slot1, "#go_damagetxt")
	slot0._txtdamage = gohelper.findChildTextMesh(slot1, "#go_damagetxt/bg/#txt_damage")
	slot0._gohero = gohelper.findChild(slot1, "#go_hpFlyItem_hero")
	slot0._goenemy = gohelper.findChild(slot1, "#go_hpFlyItem_enemy")
end

function slot0.initData(slot0, slot1, slot2, slot3, slot4)
	ZProj.TweenHelper.KillByObj(slot0._trans)
	gohelper.setActive(slot0._godamage, slot1 == 1)
	gohelper.setActive(slot0._gohero, slot1 == 2)
	gohelper.setActive(slot0._goenemy, slot1 == 3)
	transformhelper.setPos(slot0._trans, slot2.x, slot2.y, slot2.z)

	if slot1 == 1 then
		slot0._txtdamage.text = slot4

		transformhelper.setLocalRotation(slot0._trans, 0, 0, 0)
	else
		slot5 = slot0._trans.parent:InverseTransformPoint(slot3)

		ZProj.TweenHelper.DOLocalMove(slot0._trans, slot5.x, slot5.y, slot5.z, 0.5)
		transformhelper.setLocalRotation(slot0._trans, 0, 0, math.deg(math.atan2(slot3.y - slot2.y, slot3.x - slot2.x)) + 180)
	end
end

return slot0
