module("modules.logic.fight.view.magiccircle.FightMagicCircleElectric", package.seeall)

slot0 = class("FightMagicCircleElectric", FightMagicCircleBaseItem)

function slot0.getUIType(slot0)
	return FightEnum.MagicCircleUIType.Electric
end

function slot0.initView(slot0)
	slot0.rectTr = slot0.go:GetComponent(gohelper.Type_RectTransform)
	slot4 = gohelper.Type_Animator
	slot0.sliderAnimator = gohelper.findChildComponent(slot0.go, "slider", slot4)
	slot0.textSlider = gohelper.findChildText(slot0.go, "slider/sliderbg/#txt_slidernum")
	slot0.goRoundHero = gohelper.findChild(slot0.go, "slider/round/hero")
	slot0.roundNumHero = gohelper.findChildText(slot0.go, "slider/round/hero/#txt_round")
	slot0.goRoundEnemy = gohelper.findChild(slot0.go, "slider/round/enemy")
	slot0.roundNumEnemy = gohelper.findChildText(slot0.go, "slider/round/enemy/#txt_round")
	slot0.imageSliderFlash = gohelper.findChildImage(slot0.go, "slider/sliderbg/slider_flashbg")
	slot0.imageSliderFlash.fillAmount = 0
	slot0.imageSlider = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = gohelper.findChildImage(slot0.go, "slider/sliderbg/slider_level" .. slot4)
		slot0.imageSlider[slot4] = slot5
		slot5.fillAmount = 0

		gohelper.setActive(slot5.gameObject, true)
	end

	slot0.energyList = {}

	for slot4 = 1, 3 do
		slot0.energyList[slot4] = slot0:getUserDataTb_()

		for slot10 = 1, 3 do
			table.insert(slot5, gohelper.findChild(gohelper.findChild(slot0.go, "slider/energy/" .. slot4), "light" .. slot10))
		end
	end

	slot0._click = gohelper.findChildClickWithDefaultAudio(slot0.go, "btn")

	slot0._click:AddClickListener(slot0.onClickSelf, slot0)

	slot0.levelVxDict = slot0:getUserDataTb_()
	slot0.levelVxDict[1] = gohelper.findChild(slot0.go, "slider/vx/1")
	slot0.levelVxDict[2] = gohelper.findChild(slot0.go, "slider/vx/2")
	slot0.levelVxDict[3] = gohelper.findChild(slot0.go, "slider/vx/3")

	slot0:addEventCb(FightController.instance, FightEvent.UpgradeMagicCircile, slot0.onUpgradeMagicCircle, slot0)
end

slot0.Upgrade2AnimatorName = {
	[2.0] = "upgrade_01",
	[3.0] = "upgrade_02"
}

function slot0.onUpgradeMagicCircle(slot0, slot1)
	slot2 = lua_magic_circle.configDict[slot1.magicCircleId]

	if slot0.Upgrade2AnimatorName[slot1.electricLevel] then
		slot0.sliderAnimator:Play(slot4, 0, 0)
	end

	slot0.preProgress = 0

	slot0:refreshUI(slot1, slot2)
	AudioMgr.instance:trigger(20270001)
end

function slot0.onClickSelf(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnClickMagicCircleText, recthelper.getHeight(slot0.rectTr), slot0.rectTr.position)
end

function slot0.onCreateMagic(slot0, slot1, slot2)
	uv0.super.onCreateMagic(slot0, slot1, slot2)
	AudioMgr.instance:trigger(20270001)
end

function slot0.refreshUI(slot0, slot1, slot2)
	slot0.magicMo = slot1
	slot0.magicConfig = slot2

	slot0:refreshRound(slot1, slot2)
	slot0:refreshSlider(slot1, slot2)
	slot0:refreshEnergy(slot1, slot2)
end

function slot0.refreshRound(slot0, slot1, slot2)
	slot3 = slot1.round == -1 and "∞" or slot1.round
	slot0.roundNumHero.text = slot3
	slot0.roundNumEnemy.text = slot3

	gohelper.setActive(slot0.goRoundHero, FightHelper.getMagicSide(slot1.createUid) == FightEnum.EntitySide.MySide)
	gohelper.setActive(slot0.goRoundEnemy, slot4 == FightEnum.EntitySide.EnemySide)
end

slot0.FillAmountDuration = 0.5

function slot0.refreshSlider(slot0, slot1, slot2)
	if not slot0.preProgress then
		slot0:refreshSliderByProgressAndLevel(slot1.electricProgress, slot1.electricLevel)
		slot0:showCurLevelVx()

		slot0.preProgress = slot1.electricProgress
		slot0.preLevel = slot1.electricLevel

		return
	end

	slot3 = slot1.electricProgress
	slot0.preProgress = slot3

	slot0:clearTween()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0.preProgress, slot3, uv0.FillAmountDuration, slot0.tweenProgress, slot0.onTweenFinish, slot0)
end

function slot0.tweenProgress(slot0, slot1)
	slot0:refreshSliderByProgressAndLevel(math.floor(slot1), slot0.magicMo.electricLevel)
end

function slot0.refreshSliderByProgressAndLevel(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.imageSlider) do
		if slot6 == slot2 then
			if slot6 == 3 then
				slot0.textSlider.text = "MAX"
				slot7.fillAmount = 1
			else
				slot9 = 0

				if lua_fight_dnsz.configList[slot2 + 1] then
					slot9 = slot8.progress
				end

				slot7.fillAmount = slot1 / slot9
				slot0.textSlider.text = string.format("%s/<#E3E3E3>%s</COLOR>", slot1, slot9)
			end
		else
			slot7.fillAmount = 0
		end
	end
end

function slot0.onTweenFinish(slot0)
	slot0:showCurLevelVx()
	slot0:clearTween()
end

function slot0.showCurLevelVx(slot0)
	for slot5, slot6 in pairs(slot0.levelVxDict) do
		gohelper.setActive(slot6, slot5 <= slot0.magicMo.electricLevel)
	end
end

function slot0.refreshEnergy(slot0, slot1, slot2)
	slot3 = slot1.electricLevel

	for slot7, slot8 in ipairs(slot0.energyList) do
		for slot12, slot13 in ipairs(slot8) do
			gohelper.setActive(slot13, slot7 <= slot3 and slot12 == slot3)
		end
	end
end

function slot0.getLevelByProgress(slot0, slot1)
	for slot7 = #lua_fight_dnsz.configList, 1, -1 do
		if slot2[slot7].progress <= slot1 then
			return slot8.level
		end
	end

	return 1
end

function slot0.getLevelCo(slot0, slot1)
	return lua_fight_dnsz.configDict[slot1] or lua_fight_dnsz.configDict[1]
end

function slot0.clearTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0.destroy(slot0)
	slot0:clearTween()

	if slot0._click then
		slot0._click:RemoveClickListener()
	end

	uv0.super.destroy(slot0)
end

return slot0
