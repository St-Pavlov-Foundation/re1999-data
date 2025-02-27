module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroCardDiceItem", package.seeall)

slot0 = class("DiceHeroCardDiceItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._icon = gohelper.findChildImage(slot1, "")
	slot0._txtdicenum = gohelper.findChildTextMesh(slot1, "#txt_dicenum")
	slot0._goselect = gohelper.findChild(slot1, "#go_select")
	slot0._canvasGroup = gohelper.onceAddComponent(slot1, typeof(UnityEngine.CanvasGroup))
end

function slot0.addEventListeners(slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, slot0.refreshUI, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardDiceChange, slot0.refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, slot0.refreshUI, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardDiceChange, slot0.refreshUI, slot0)
end

function slot0.initData(slot0, slot1, slot2, slot3)
	slot0._ruleInfo = slot1
	slot0._cardMo = slot2
	slot0._index = slot3
	slot5 = slot0._ruleInfo[2]

	if slot0._ruleInfo[1] == 0 then
		slot4 = 8
	end

	slot7 = lua_dice_point.configDict[slot5]

	if lua_dice_suit.configDict[slot4] then
		slot8 = string.split(slot6.icon2, "#")

		UISpriteSetMgr.instance:setDiceHeroSprite(slot0._icon, (slot2.matchNums[1] or 0) < slot0._index and slot8[2] or slot8[1])
	end

	if slot7 then
		slot0._txtdicenum.text = slot7.txt
	end

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if DiceHeroFightModel.instance:getGameData().curSelectCardMo == slot0._cardMo then
		slot2 = slot0._cardMo.curSelectUids[slot0._index]

		gohelper.setActive(slot0._goselect, slot2)

		slot0._canvasGroup.alpha = slot2 and 1 or 0.4
	else
		gohelper.setActive(slot0._goselect, false)

		slot0._canvasGroup.alpha = 1
	end
end

return slot0
