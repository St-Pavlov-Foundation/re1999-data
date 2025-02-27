module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroHeroItem", package.seeall)

slot0 = class("DiceHeroHeroItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._emptyRelicItem = gohelper.findChild(slot1, "root/zaowu/#go_nulllayout/#go_item")
	slot0._relicItem = gohelper.findChild(slot1, "root/zaowu/#go_iconlayout/#simage_iconitem")
	slot0._buffItem = gohelper.findChild(slot1, "root/#go_statelist/#simage_icon")
	slot0._powerItem = gohelper.findChild(slot1, "root/headbg/energylayout/#go_item")
	slot0._txtname = gohelper.findChildTextMesh(slot1, "root/#txt_name")
	slot0._hpSlider = gohelper.findChildImage(slot1, "root/#simage_hpbg/#simage_hp")
	slot0._shieldSlider = gohelper.findChildImage(slot1, "root/#simage_shieldbg/#simage_shield")
	slot0._hpNum = gohelper.findChildTextMesh(slot1, "root/#simage_hpbg/#txt_hpnum")
	slot0._shieldNum = gohelper.findChildTextMesh(slot1, "root/#simage_shieldbg/#txt_shieldnum")
	slot0._click = gohelper.findChildButtonWithAudio(slot1, "root/#btn_clickhead")
	slot0._headicon = gohelper.findChildSingleImage(slot1, "root/headbg/headicon")
	slot0._headbgAnim = gohelper.findChildAnim(slot1, "root/headbg")
	slot0._headbgTrans = slot0._headbgAnim.transform
	slot0._btnClickHead = gohelper.findChildButtonWithAudio(slot1, "root/#btn_clickhead")
	slot0._btnClickRelic = gohelper.findChildButtonWithAudio(slot1, "root/#btn_clickrelic")
	slot0._btnClickBuff = gohelper.findChildButtonWithAudio(slot1, "root/#btn_clickbuff")
	slot0._goskilltips = gohelper.findChild(slot1, "tips/#go_skilltip")
	slot0._gozaowutip = gohelper.findChild(slot1, "tips/#go_zaowutip")
	slot0._gobufftip = gohelper.findChild(slot1, "tips/#go_fightbufftips")
	slot0._goskillitem = gohelper.findChild(slot1, "tips/#go_skilltip/viewport/content/item")
	slot0._gozaowuitem = gohelper.findChild(slot1, "tips/#go_zaowutip/viewport/content/item")
	slot0._gobuffitem = gohelper.findChild(slot1, "tips/#go_fightbufftips/viewport/content/item")
	slot0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(slot0._click.gameObject)

	slot0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	slot0._txtname.text = ""

	gohelper.setActive(gohelper.findChild(slot1, "root/dice"), false)

	slot0._gobuffeffect = gohelper.findChild(slot1, "root/#go_buff")
	slot0._godebuffeffect = gohelper.findChild(slot1, "root/#go_debuff")
	slot0._goshieldeffect = gohelper.findChild(slot1, "root/#go_shield")
	slot0._godamageeffect = gohelper.findChild(slot1, "root/#go_damage")
	slot0._godeadeffect = gohelper.findChild(slot1, "root/#go_died")
	slot0._shieldEffectAnim = gohelper.findChildAnim(slot1, "root/#simage_shieldbg")
	slot0._gobigskilleffect = gohelper.findChild(slot1, "root/headbg/#go_bigskilltip")
	slot0._gopassiveeffect = gohelper.findChild(slot1, "root/headbg/#go_passivetip")

	recthelper.setHeight(slot0._gobufftip.transform, 275)
	recthelper.setHeight(slot0._goskilltips.transform, 300)
	recthelper.setHeight(slot0._gozaowutip.transform, 300)
	slot0:refreshRelic()
	slot0:refreshAll()
	slot0._headicon:LoadImage(ResUrl.getHeadIconSmall(slot0:getHeroMo().co.icon))
	DiceHeroHelper.instance:registerEntity(slot0:getHeroMo().uid, slot0)
end

function slot0.addEventListeners(slot0)
	slot0._btnLongPress:AddLongPressListener(slot0._onLongClickHero, slot0)
	slot0._btnClickHead:AddClickListener(slot0._onClickHero, slot0)
	slot0._btnClickRelic:AddClickListener(slot0._showRelic, slot0)
	slot0._btnClickBuff:AddClickListener(slot0._showBuff, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0.onTouchScreen, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnLongPress:RemoveLongPressListener()
	slot0._btnClickHead:RemoveClickListener()
	slot0._btnClickRelic:RemoveClickListener()
	slot0._btnClickBuff:RemoveClickListener()
end

function slot0.setActiveTips(slot0, slot1)
	gohelper.setActive(slot0._gozaowutip, slot1 == slot0._gozaowutip)
	gohelper.setActive(slot0._gobufftip, slot1 == slot0._gobufftip)
	gohelper.setActive(slot0._goskilltips, slot1 == slot0._goskilltips)
end

function slot0._onClickHero(slot0)
	if not slot0:getHeroMo():canUseHeroSkill() then
		if slot0._goskilltips.activeSelf then
			gohelper.setActive(slot0._goskilltips, false)

			return
		end

		if not DiceHeroFightModel.instance:getGameData().heroSkillCards[1] then
			return
		end

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
		slot0:setActiveTips(slot0._goskilltips)
		gohelper.CreateObjList(slot0, slot0._createSkillItem, slot3, nil, slot0._goskillitem)
	else
		gohelper.setActive(slot0._goskilltips, false)

		if not DiceHeroFightModel.instance:getGameData().confirmed then
			return
		end

		if DiceHeroHelper.instance:isInFlow() then
			return
		end

		DiceHeroRpc.instance:sendDiceHeroUseSkill(DiceHeroEnum.SkillType.Hero, 0, "", {}, 0)
	end
end

function slot0._onLongClickHero(slot0)
	if not slot0:getHeroMo():canUseHeroSkill() then
		return
	end

	if not DiceHeroFightModel.instance:getGameData().heroSkillCards[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	slot0:setActiveTips(slot0._goskilltips)
	gohelper.CreateObjList(slot0, slot0._createSkillItem, slot3, nil, slot0._goskillitem)
end

function slot0._createSkillItem(slot0, slot1, slot2, slot3)
	gohelper.findChildTextMesh(slot1, "#txt_title/#txt_title").text = slot2.co.name
	gohelper.findChildTextMesh(slot1, "#txt_desc").text = slot2.co.desc
end

function slot0._showBuff(slot0)
	if slot0._gobufftip.activeSelf then
		gohelper.setActive(slot0._gobufftip, false)

		return
	end

	if not DiceHeroFightModel.instance:getGameData().allyHero.buffs[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	slot0:setActiveTips(slot0._gobufftip)
	gohelper.CreateObjList(slot0, slot0._createBuffItem, slot2, nil, slot0._gobuffitem)
end

function slot0._createBuffItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildTextMesh(slot1, "name/#txt_name")
	slot5 = gohelper.findChildTextMesh(slot1, "name/#txt_layer")
	slot6 = gohelper.findChildTextMesh(slot1, "#txt_desc")
	slot7 = gohelper.findChildImage(slot1, "name/#simage_icon")

	if slot2.co.tag == 1 then
		gohelper.setActive(gohelper.findChild(slot1, "name/#txt_name/#go_tag"), true)

		gohelper.findChildTextMesh(slot1, "name/#txt_name/#go_tag/#txt_name").text = luaLang("dicehero_buff")
	elseif slot2.co.tag == 2 then
		gohelper.setActive(slot8, true)

		slot9.text = luaLang("dicehero_debuff")
	else
		gohelper.setActive(slot8, false)
	end

	UISpriteSetMgr.instance:setBuffSprite(slot7, slot2.co.icon)

	slot4.text = slot2.co.name
	slot6.text = slot2.co.desc

	if slot2.co.damp >= 0 and slot2.co.damp <= 4 then
		slot5.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_buff_" .. slot2.co.damp), slot2.layer)
	else
		slot5.text = ""
	end
end

function slot0._showRelic(slot0)
	if slot0._gozaowutip.activeSelf then
		gohelper.setActive(slot0._gozaowutip, false)

		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(DiceHeroFightModel.instance:getGameData().allyHero.relicIds) do
		table.insert(slot3, lua_dice_relic.configDict[slot8])
	end

	if #slot3 <= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	slot0:setActiveTips(slot0._gozaowutip)
	gohelper.CreateObjList(slot0, slot0._createZaowuItem, slot3, nil, slot0._gozaowuitem)
end

function slot0._createZaowuItem(slot0, slot1, slot2, slot3)
	gohelper.findChildSingleImage(slot1, "name/#simage_icon"):LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. slot2.icon .. ".png")

	gohelper.findChildTextMesh(slot1, "name/#txt_name").text = slot2.name
	gohelper.findChildTextMesh(slot1, "#txt_desc").text = slot2.desc
end

function slot0.onTouchScreen(slot0)
	if slot0._goskilltips.activeSelf then
		if gohelper.isMouseOverGo(slot0._goskilltips) and gohelper.isMouseOverGo(slot0._goskillitem.transform.parent) or gohelper.isMouseOverGo(slot0._btnClickHead) then
			return
		end

		gohelper.setActive(slot0._goskilltips, false)
	elseif slot0._gozaowutip.activeSelf then
		if gohelper.isMouseOverGo(slot0._gozaowutip) and gohelper.isMouseOverGo(slot0._gozaowuitem.transform.parent) or gohelper.isMouseOverGo(slot0._btnClickRelic) then
			return
		end

		gohelper.setActive(slot0._gozaowutip, false)
	elseif slot0._gobufftip.activeSelf then
		if gohelper.isMouseOverGo(slot0._gobufftip) and gohelper.isMouseOverGo(slot0._gobuffitem.transform.parent) or gohelper.isMouseOverGo(slot0._btnClickBuff) then
			return
		end

		gohelper.setActive(slot0._gobufftip, false)
	end
end

function slot0.refreshAll(slot0)
	gohelper.setActive(slot0._godeadeffect, false)
	slot0:refreshBuff()
	slot0:refreshPower()
	slot0:refreshInfo()
end

function slot0.refreshRelic(slot0)
	slot1 = slot0:getHeroMo()
	slot2 = {}
	slot3 = {}

	for slot7 = 1, 5 do
		if slot1.relicIds[slot7] then
			table.insert(slot2, slot1.relicIds[slot7])
		else
			table.insert(slot3, 1)
		end
	end

	gohelper.CreateObjList(slot0, slot0._createRelicItem, slot2, nil, slot0._relicItem)
	gohelper.CreateObjList(nil, , slot3, nil, slot0._emptyRelicItem)
end

function slot0._createRelicItem(slot0, slot1, slot2, slot3)
	if lua_dice_relic.configDict[slot2] then
		gohelper.findChildSingleImage(slot1, ""):LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. slot5.icon .. ".png")
	end
end

function slot0.refreshBuff(slot0)
	gohelper.CreateObjList(slot0, slot0._createBuff, slot0:getHeroMo().buffs, nil, slot0._buffItem)
	slot0:refreshCanUseHeroSkill()

	if slot0._gobufftip.activeSelf then
		if #slot1 > 0 then
			gohelper.CreateObjList(slot0, slot0._createBuffItem, slot1, nil, slot0._gobuffitem)
		else
			gohelper.setActive(slot0._gobufftip, false)
		end
	end
end

function slot0._createBuff(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setBuffSprite(gohelper.findChildImage(slot1, ""), slot2.co.icon)
end

function slot0.refreshPower(slot0)
	for slot7 = 1, slot0:getHeroMo().maxPower do
	end

	slot0._powerItemAnims = slot0._powerItemAnims or slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._createPower, {
		[slot7] = slot7 <= slot0:getHeroMo().power and 1 or 0
	}, nil, slot0._powerItem)
	slot0:refreshCanUseHeroSkill()
end

function slot0._createPower(slot0, slot1, slot2, slot3)
	slot0._powerItemAnims[slot3] = gohelper.findChildAnim(slot1, "")

	slot0._powerItemAnims[slot3]:Play("idle", 0, 0)
	gohelper.setActive(gohelper.findChild(slot1, "light"), slot2 == 1)
end

function slot0.getHeroMo(slot0)
	return DiceHeroFightModel.instance:getGameData().allyHero
end

function slot0.addHp(slot0, slot1)
	slot2 = slot0:getHeroMo()
	slot2.hp = slot2.hp + slot1

	slot0:refreshInfo()
	gohelper.setActive(slot0._godeadeffect, slot2.hp <= 0)
end

function slot0.addShield(slot0, slot1)
	slot2 = slot0:getHeroMo()
	slot2.shield = slot2.shield + slot1

	slot0:refreshInfo()
end

function slot0.addPower(slot0, slot1)
	if slot1 ~= 0 then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_ideachange)
	end

	slot2 = slot0:getHeroMo()
	slot2.power = slot2.power + slot1

	slot0:refreshPower()

	if slot2.maxPower <= slot2.power then
		for slot6 = 1, slot2.maxPower do
			slot0._powerItemAnims[slot6]:Play("full", 0, 0)
		end
	elseif slot1 > 0 then
		for slot6 = slot2.power - slot1 + 1, slot2.power do
			slot0._powerItemAnims[slot6]:Play("open", 0, 0)
		end
	else
		for slot6 = slot2.power + 1, slot2.power - slot1 do
			slot0._powerItemAnims[slot6]:Play("close", 0, 0)
		end
	end
end

function slot0.addMaxPower(slot0, slot1)
	if slot1 ~= 0 then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_ideachange)
	end

	slot2 = slot0:getHeroMo()
	slot2.maxPower = slot2.maxPower + slot1

	slot0:refreshPower()

	if slot2.maxPower <= slot2.power then
		for slot6 = 1, slot2.maxPower do
			slot0._powerItemAnims[slot6]:Play("full", 0, 0)
		end
	end
end

function slot0.addOrUpdateBuff(slot0, slot1)
	slot0:getHeroMo():addOrUpdateBuff(slot1)
	slot0:refreshBuff()
end

function slot0.removeBuff(slot0, slot1)
	slot0:getHeroMo():removeBuff(slot1)
	slot0:refreshBuff()
end

function slot0.refreshInfo(slot0)
	slot1 = slot0:getHeroMo()
	slot2 = slot1.hp
	slot4 = slot1.shield
	slot5 = slot1.maxShield

	ZProj.TweenHelper.DOFillAmount(slot0._hpSlider, slot1.maxHp > 0 and slot2 / slot3 or 0, 0.2)
	ZProj.TweenHelper.DOFillAmount(slot0._shieldSlider, slot5 > 0 and slot4 / slot5 or 0, 0.2)

	slot0._hpNum.text = slot2
	slot0._shieldNum.text = slot4
end

function slot0.refreshCanUseHeroSkill(slot0)
	slot1 = slot0:getHeroMo()

	gohelper.setActive(slot0._gobigskilleffect, slot1:canUseHeroSkill())
	gohelper.setActive(slot0._gopassiveeffect, slot1:canUsePassiveSkill())
end

function slot0.getPos(slot0, slot1)
	if slot1 == 1 then
		return slot0._shieldSlider.transform.position
	elseif slot1 == 2 then
		return slot0._powerItem.transform.parent.position
	end

	return slot0._headbgTrans.position
end

function slot0.playHitAnim(slot0)
	slot0._headbgAnim:Play("hit", 0, 0)
end

function slot0.showEffect(slot0, slot1)
	gohelper.setActive(slot0._gobuffeffect, false)
	gohelper.setActive(slot0._godebuffeffect, false)
	gohelper.setActive(slot0._goshieldeffect, false)
	gohelper.setActive(slot0._godamageeffect, false)
	gohelper.setActive(slot0._gobuffeffect, slot1 == 1)
	gohelper.setActive(slot0._godebuffeffect, slot1 == 2)
	gohelper.setActive(slot0._goshieldeffect, slot1 == 3)
	gohelper.setActive(slot0._godamageeffect, slot1 == 4)

	if slot1 == 3 then
		slot0._shieldEffectAnim:Play("light", 0, 0)
	end
end

function slot0.onDestroy(slot0)
	DiceHeroHelper.instance:unregisterEntity(slot0:getHeroMo().uid)
end

return slot0
