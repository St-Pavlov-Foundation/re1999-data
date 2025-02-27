module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroDiceItem", package.seeall)

slot0 = class("DiceHeroDiceItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._index = slot1.index
end

slot1 = {
	Vector3(90, 0, 0),
	Vector3(90, 90, 0),
	Vector3(90, 180, 0),
	Vector3(90, -90, 0),
	Vector3(0, 0, 0),
	Vector3(180, 0, 0)
}

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._anim = gohelper.findChildAnim(slot1, "")
	slot0._goselect = gohelper.findChild(slot1, "#go_select")
	slot0._imagenum = gohelper.findChildImage(slot1, "#image_num")
	slot0._imageicon = gohelper.findChildImage(slot1, "#simage_dice")
	slot0._golimitlock = gohelper.findChild(slot1, "#go_lock")
	slot0._golock = gohelper.findChild(slot1, "#go_limitlock")
	slot0._golight = gohelper.findChild(slot1, "#go_light")
	slot0._gogray = gohelper.findChild(slot1, "#go_gray")
	slot0._diceRoot = gohelper.findChild(slot1, "touzi_ani/touzi").transform
	slot0._uimeshes = slot0:getUserDataTb_()

	for slot5 = 0, slot0._diceRoot.childCount - 1 do
		slot0._uimeshes[tonumber(slot0._diceRoot:GetChild(slot5).gameObject.name) or 1] = slot6:GetComponent(typeof(UIMesh))
	end

	slot0:_refresh(true)
end

function slot0.onStepEnd(slot0, slot1)
	slot0:_refresh(slot1)
end

function slot0._refresh(slot0, slot1)
	if DiceHeroFightModel.instance:getGameData().diceBox.dices[slot0._index] and not slot2.deleted then
		slot0:updateInfo(slot2, slot1)
	elseif slot0.diceMo then
		slot0.diceMo = nil

		slot0._anim:Play("out")
	else
		slot0._anim:Play("out", 0, 1)
	end
end

function slot0.updateInfo(slot0, slot1, slot2)
	if (not slot0.diceMo or slot0.diceMo.deleted or slot0.diceMo.uid ~= slot1.uid) and not DiceHeroFightModel.instance.tempRoundEnd and not slot2 then
		slot0._anim:Play("in", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_roll)
	end

	if slot0.diceMo then
		DiceHeroHelper.instance:unregisterDice(slot0.diceMo.uid)
	end

	DiceHeroHelper.instance:registerDice(slot1.uid, slot0)

	slot0.diceMo = slot1

	if uv0[slot1.num] then
		transformhelper.setLocalRotation(slot0._diceRoot, slot3.x, slot3.y, slot3.z)
	end

	if lua_dice.configDict[slot1.diceId] then
		for slot9, slot10 in pairs(slot0._uimeshes) do
			if lua_dice_suit.configDict[string.splitToNumber(slot4.suitList, "#")[slot9]] and DiceHeroHelper.instance:getDiceTexture(slot11.icon) then
				slot10.texture = slot12

				slot10:SetMaterialDirty()
			end
		end
	end

	slot0:refreshLock()
	slot0:setSelect(false)
end

function slot0.refreshLock(slot0)
	gohelper.setActive(slot0._golock, slot0.diceMo.status == DiceHeroEnum.DiceStatu.SoftLock)
	gohelper.setActive(slot0._golimitlock, slot0.diceMo.status == DiceHeroEnum.DiceStatu.HardLock)
end

function slot0.setSelect(slot0, slot1, slot2)
	gohelper.setActive(slot0._goselect, slot1)

	if slot2 == nil then
		gohelper.setActive(slot0._golight, false)
		gohelper.setActive(slot0._gogray, slot0.diceMo and slot0.diceMo.status == DiceHeroEnum.DiceStatu.HardLock)
	else
		gohelper.setActive(slot0._golight, slot2)
		gohelper.setActive(slot0._gogray, not slot2 or slot3)
	end
end

function slot0.markDeleted(slot0)
	if not slot0.diceMo then
		return
	end

	slot0.diceMo.deleted = true

	slot0._anim:Play("out", 0, 0)
	slot0:setSelect(false)
end

function slot0.playRefresh(slot0, slot1)
	slot0.diceMo = slot1

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_roll)
	slot0._anim:Play("refresh", 0, 0)

	slot2, slot3, slot4 = transformhelper.getLocalRotation(slot0._diceRoot)

	ZProj.TweenHelper.DOLocalRotate(slot0._diceRoot, slot2 + math.random(100, 200), slot3 + math.random(100, 200), slot4 + math.random(100, 200), 0.2, slot0._delayTweenRotate, slot0, nil, EaseType.Linear)
	TaskDispatcher.runDelay(slot0._refresh, slot0, 0.6)
end

function slot0._delayTweenRotate(slot0)
	slot1, slot2, slot3 = transformhelper.getLocalRotation(slot0._diceRoot)

	ZProj.TweenHelper.DOLocalRotate(slot0._diceRoot, slot1 + math.random(100, 200), slot2 + math.random(100, 200), slot3 + math.random(100, 200), 0.2, slot0._delayTweenRotate2, slot0, nil, EaseType.Linear)
end

function slot0._delayTweenRotate2(slot0)
	if uv0[slot0.diceMo.num] then
		ZProj.TweenHelper.DOLocalRotate(slot0._diceRoot, slot1.x, slot1.y, slot1.z, 0.2, nil, , , EaseType.Linear)
	end
end

function slot0.startRoll(slot0)
	if not slot0.diceMo or slot0.diceMo.deleted then
		slot0._anim:Play("out", 0, 1)

		return
	end

	slot0._anim:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_roll)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._refresh, slot0)

	if slot0.diceMo then
		DiceHeroHelper.instance:unregisterDice(slot0.diceMo.uid)
	end
end

return slot0
