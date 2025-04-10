module("modules.logic.fight.view.magiccircle.FightMagicCircleNormal", package.seeall)

slot0 = class("FightMagicCircleNormal", FightMagicCircleBaseItem)

function slot0.initView(slot0)
	slot0._text = gohelper.findChildText(slot0.go, "#txt_task")
	slot0._red = gohelper.findChild(slot0.go, "#txt_task/red")
	slot0._blue = gohelper.findChild(slot0.go, "#txt_task/blue")
	slot0._red_round_num = gohelper.findChildText(slot0.go, "#txt_task/red/#txt_num")
	slot0._blue_round_num = gohelper.findChildText(slot0.go, "#txt_task/blue/#txt_num")
	slot0._redUpdate = gohelper.findChild(slot0.go, "update_red")
	slot0._blueUpdate = gohelper.findChild(slot0.go, "update_blue")
	slot0._textTr = slot0._text.transform
	slot0._click = gohelper.getClickWithDefaultAudio(slot0.go)

	slot0._click:AddClickListener(slot0.onClickSelf, slot0)
end

function slot0.onClickSelf(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnClickMagicCircleText, slot0._text.preferredHeight, slot0._textTr.position)
end

function slot0.onCreateMagic(slot0, slot1, slot2)
	uv0.super.onCreateMagic(slot0, slot1, slot2)
	slot0:playAnim("open")
end

function slot0.refreshUI(slot0, slot1, slot2)
	slot0._text.text = slot2.name

	gohelper.setActive(slot0._red, FightHelper.getMagicSide(slot1.createUid) == FightEnum.EntitySide.EnemySide)
	gohelper.setActive(slot0._blue, slot3 == FightEnum.EntitySide.MySide)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._text, slot3 == FightEnum.EntitySide.MySide and "#547ca6" or "#9f4f4f")

	slot5 = slot1.round == -1 and "∞" or slot1.round
	slot0._red_round_num.text = slot5
	slot0._blue_round_num.text = slot5

	if slot3 == FightEnum.EntitySide.MySide then
		gohelper.setActive(slot0._blueUpdate, false)
		gohelper.setActive(slot0._blueUpdate, true)
	else
		gohelper.setActive(slot0._redUpdate, false)
		gohelper.setActive(slot0._redUpdate, true)
	end
end

function slot0.destroy(slot0)
	if slot0._click then
		slot0._click:RemoveClickListener()
	end

	uv0.super.destroy(slot0)
end

return slot0
