module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroCardItem", package.seeall)

slot0 = class("DiceHeroCardItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot1.transform
	slot0._anim = gohelper.findChildAnim(slot1, "")
	slot0._frame2 = gohelper.findChild(slot1, "#frame_level2")
	slot0._frame3 = gohelper.findChild(slot1, "#frame_level3")
	slot0._txtname = gohelper.findChildTextMesh(slot1, "layout/#txt_name")
	slot0._gosmallselect = gohelper.findChild(slot1, "#go_smallselect")
	slot0._gobigselect = gohelper.findChild(slot1, "#go_bigselect")
	slot0._imagelimitmask = gohelper.findChildImage(slot1, "#go_limitmask")
	slot0._goredtips = gohelper.findChild(slot1, "#go_redtips")
	slot0._txtredtips = gohelper.findChildTextMesh(slot1, "#go_redtips/#txt_tip")
	slot0._golock = gohelper.findChild(slot1, "#go_limitmask/icon")
	slot0._iconbg = gohelper.findChildImage(slot1, "#simage_bg")
	slot0._iconframe = gohelper.findChildImage(slot1, "#simage_frame")
	slot0._fighticon = gohelper.findChildImage(slot1, "layout/#go_fightnum/iconpos/#simage_icon")
	slot0._useNum = gohelper.findChildTextMesh(slot1, "#go_usenum/#txt_usenum")
	slot0._godiceitem = gohelper.findChild(slot1, "bottom/dicelist/#go_item")
	slot0._godicelist = gohelper.findChild(slot1, "bottom/dicelist")
	slot0._carddes = gohelper.findChildTextMesh(slot1, "layout/#scroll_skilldesc/viewport/#txt_skilldesc")
	slot0._txtnum = gohelper.findChildTextMesh(slot1, "layout/#go_fightnum/#txt_num")
	slot0._gonum = gohelper.findChild(slot1, "layout/#go_fightnum")
	slot0._buffeffect = gohelper.findChild(slot1, "#go_buffhit")
	slot0._click = gohelper.getClick(slot1)
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickSkill, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, slot0._onSkillCardSelect, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardDiceChange, slot0._onSkillCardSelect, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.StepEnd, slot0.updateStatu, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.ConfirmDice, slot0.updateStatu, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.RerollDice, slot0.updateStatu, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, slot0._onSkillCardSelect, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardDiceChange, slot0._onSkillCardSelect, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.StepEnd, slot0.updateStatu, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.ConfirmDice, slot0.updateStatu, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.RerollDice, slot0.updateStatu, slot0)
end

slot1 = {
	[DiceHeroEnum.CardType.Atk] = "4",
	[DiceHeroEnum.CardType.Def] = "5",
	[DiceHeroEnum.CardType.Power] = "2"
}
slot2 = {
	[DiceHeroEnum.CardType.Atk] = "1",
	[DiceHeroEnum.CardType.Def] = "5",
	[DiceHeroEnum.CardType.Power] = "4"
}

function slot0.initData(slot0, slot1)
	DiceHeroHelper.instance:registerCard(slot1.skillId, slot0)

	slot0.data = slot1
	slot0._txtname.text = slot1.co.name
	slot0._canUse = false

	gohelper.setActive(slot0._gosmallselect, false)
	gohelper.setActive(slot0._gobigselect, false)

	slot0._carddes.text = slot1.co.desc

	gohelper.setActive(slot0._gonum, DiceHeroHelper.instance:isShowCarNum(slot1.co.effect1))
	UISpriteSetMgr.instance:setDiceHeroSprite(slot0._iconbg, "v2a6_dicehero_game_skillcardquality" .. (uv0[slot1.co.type] or slot1.co.type))
	UISpriteSetMgr.instance:setDiceHeroSprite(slot0._iconframe, "v2a6_dicehero_game_skillcardbg" .. slot1.co.quality)
	UISpriteSetMgr.instance:setFightSprite(slot0._fighticon, "jnk_gj" .. (uv1[slot1.co.type] or 0))
	gohelper.setActive(slot0._frame2, slot1.co.quality == "2")
	gohelper.setActive(slot0._frame3, slot1.co.quality == "3")
	slot0:updateStatu()
	gohelper.CreateObjList(slot0, slot0._createDiceItem, slot0.data.matchDiceRules, nil, slot0._godiceitem, DiceHeroCardDiceItem)

	if #slot0.data.matchDiceRules >= 5 then
		transformhelper.setLocalScale(slot0._godicelist.transform, 0.74, 0.74, 1)
	else
		transformhelper.setLocalScale(slot0._godicelist.transform, 1, 1, 1)
	end
end

function slot0.updateStatu(slot0)
	slot1 = false
	slot2 = nil
	slot3 = DiceHeroFightModel.instance:getGameData()

	if not DiceHeroHelper.instance:isInFlow() then
		slot1, slot2 = slot0.data:canSelect()

		gohelper.setActive(slot0._buffeffect, slot0.data.co.type == DiceHeroEnum.CardType.Atk and slot3.allyHero:haveBuff2())

		if slot0._isGray == nil then
			slot0._isGray = false
			slot0._isBlack = false
		end

		slot5 = slot1 and not slot3.confirmed

		if (not slot1 ~= slot0._isGray or slot5 ~= slot0._isBlack) and not DiceHeroHelper.instance:isInFlow() then
			if slot4 and slot0._isBlack then
				slot0._anim:Play("togray", 0, 0)
			elseif slot5 and slot0._isGray then
				slot0._anim:Play("toblack", 0, 0)
			elseif slot4 and not slot0._isGray then
				slot0._anim:Play("gray", 0, 0)
			elseif not slot4 and slot0._isGray then
				slot0._anim:Play("ungray", 0, 0)
			elseif slot5 and not slot0._isBlack then
				slot0._anim:Play("black", 0, 0)
			elseif not slot5 and slot0._isBlack then
				slot0._anim:Play("unblack", 0, 0)
			end

			slot0._isGray = slot4
			slot0._isBlack = slot5
		end
	end

	gohelper.setActive(slot0._goredtips, not slot1)

	if not slot1 then
		slot0._canUse = false

		gohelper.setActive(slot0._gosmallselect, false)
		gohelper.setActive(slot0._gobigselect, false)

		if slot2 == DiceHeroEnum.CantUseReason.NoDice then
			slot0._txtredtips.text = luaLang("dicehero_card_nodice")

			gohelper.setActive(slot0._golock, false)
		elseif slot2 == DiceHeroEnum.CantUseReason.NoUseCount then
			slot0._txtredtips.text = luaLang("dicehero_card_nocount")

			gohelper.setActive(slot0._golock, false)
		elseif slot2 == DiceHeroEnum.CantUseReason.BanSkill then
			slot0._txtredtips.text = luaLang("dicehero_card_banskill")

			gohelper.setActive(slot0._golock, true)
		end
	else
		gohelper.setActive(slot0._golock, false)
	end

	if slot0.data.co.roundLimitCount == 0 then
		slot0._useNum.text = "∞"
	else
		slot0._useNum.text = slot0.data.co.roundLimitCount - slot0.data.curRoundUse
	end

	slot0:updateNumShow()
end

function slot0._createDiceItem(slot0, slot1, slot2, slot3)
	slot1:initData(slot2, slot0.data, slot3)
end

function slot0._onSkillCardSelect(slot0)
	if DiceHeroFightModel.instance:getGameData().curSelectCardMo == slot0.data then
		slot3 = slot0.data:canUse()

		if not slot0._canUse then
			slot0._canUse = false
		end

		gohelper.setActive(slot0._gosmallselect, not slot3)
		gohelper.setActive(slot0._gobigselect, slot3)
	else
		gohelper.setActive(slot0._gosmallselect, false)
		gohelper.setActive(slot0._gobigselect, false)
	end

	if not slot0._isSelect then
		slot0._isSelect = false
	end

	if slot0._isSelect ~= slot2 then
		slot0._isSelect = slot2

		if slot2 then
			slot0._anim:Play("select", 0, 0)
		elseif not slot0._isGray and not slot0._isBlack then
			slot0._anim:Play("unselect", 0, 0)
		end
	end

	slot0:updateNumShow()
end

function slot0.updateNumShow(slot0)
	if not DiceHeroHelper.instance:isShowCarNum(slot0.data.co.effect1) then
		return
	end

	if slot0.data.co.effect1 == DiceHeroEnum.SkillEffectType.Damage1 or slot0.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangeShield1 or slot0.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangePower1 then
		for slot6 = 1, #string.split(slot0.data.co.params1, ",") do
			slot2[slot6] = string.format("<color=#%s>%s</color>", slot0.data:canUse() ~= slot6 and "A28D8D" or "FFFFFF", slot2[slot6])
		end

		slot0._txtnum.text = table.concat(slot2, "/")
	elseif slot0.data.co.effect1 == DiceHeroEnum.SkillEffectType.Damage2 or slot0.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangeShield2 then
		slot1 = 0

		if slot0.data:isMatchMin() then
			for slot6, slot7 in pairs(slot0.data.curSelectUids) do
				if DiceHeroFightModel.instance:getGameData().diceBox:getDiceMoByUid(slot7) then
					slot1 = slot1 + slot8.num
				end
			end
		end

		slot0._txtnum.text = slot1
	elseif slot0.data.co.effect1 == DiceHeroEnum.SkillEffectType.ChangePower2 then
		slot1 = 0

		if slot0.data:isMatchMin() then
			slot1 = DiceHeroFightModel.instance:getGameData().allyHero.power
		end

		slot0._txtnum.text = "+" .. slot1
	end
end

function slot0._onClickSkill(slot0)
	if not DiceHeroFightModel.instance:getGameData().confirmed then
		return
	end

	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	if slot1.curSelectCardMo == slot0.data then
		slot2, slot3 = slot0.data:canUse()

		if not slot2 then
			GameFacade.showToast(ToastEnum.DiceHeroDiceNoEnoughDice)

			return
		end

		DiceHeroRpc.instance:sendDiceHeroUseSkill(DiceHeroEnum.SkillType.Normal, slot0.data.skillId, slot1.curSelectEnemyMo and slot1.curSelectEnemyMo.uid or "", slot3, slot2 > 0 and slot2 - 1 or slot2)
	elseif slot0.data:canSelect() then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardrelease)
		slot1:setCurSelectCard(slot0.data)
	end
end

function slot0.doHitAnim(slot0)
	slot0._anim:Play("hit", 0, 0)
end

function slot0.playRefreshAnim(slot0)
	slot0._anim:Play("refresh", 0, 0)

	slot0._isGray = false
	slot0._isBlack = false
end

function slot0.getPos(slot0)
	return slot0._txtname.transform.position
end

function slot0.onDestroy(slot0)
	DiceHeroHelper.instance:unregisterCard(slot0.data.skillId)
end

return slot0
