module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroEnemyItem", package.seeall)

slot0 = class("DiceHeroEnemyItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._buffItem = gohelper.findChild(slot1, "root/#go_statelist/#go_list/#go_item")
	slot0._hpSlider = gohelper.findChildImage(slot1, "root/#simage_hpbg/#simage_hp")
	slot0._shieldSlider = gohelper.findChildImage(slot1, "root/#simage_shieldbg/#simage_shield")
	slot0._hpNum = gohelper.findChildTextMesh(slot1, "root/#simage_hpbg/#txt_hpnum")
	slot0._shieldNum = gohelper.findChildTextMesh(slot1, "root/#simage_shieldbg/#txt_shieldnum")
	slot0._goselect = gohelper.findChild(slot1, "root/#go_select")
	slot0._gobuffmore = gohelper.findChild(slot1, "root/#go_statelist/#go_more")
	slot0._gobehaviormask = gohelper.findChild(slot1, "root/mask")
	slot0._iconbehavior = gohelper.findChildImage(slot1, "root/#icon_begavior")
	slot0._txtbehavior = gohelper.findChildTextMesh(slot1, "root/#icon_begavior/#txt_num")
	slot0._behaviortitle = gohelper.findChildTextMesh(slot1, "tips/#go_fighttip/title/#txt_title")
	slot0._behavioricon = gohelper.findChildImage(slot1, "tips/#go_fighttip/title/#simage_icon")
	slot0._behaviordesc = gohelper.findChildTextMesh(slot1, "tips/#go_fighttip/#txt_desc")
	slot0._headicon = gohelper.findChildSingleImage(slot1, "root/headbg/headicon")
	slot0._headbgAnim = gohelper.findChildAnim(slot1, "root/headbg")
	slot0._headbgTrans = slot0._headbgAnim.transform
	slot0._btnClickSelect = gohelper.findChildButtonWithAudio(slot1, "root/#btn_select")
	slot0._btnClickBuff = gohelper.findChildButtonWithAudio(slot1, "root/#btn_buff")
	slot0._btnClickBehavior = gohelper.findChildButtonWithAudio(slot1, "root/#btn_behavior")
	slot0._gofighttips = gohelper.findChild(slot1, "tips/#go_fighttip")
	slot0._gozaowutip = gohelper.findChild(slot1, "tips/#go_fightbufftips")
	slot0._gozaowuitem = gohelper.findChild(slot1, "tips/#go_fightbufftips/viewport/content/item")
	slot0._gobuffeffect = gohelper.findChild(slot1, "root/#go_buff")
	slot0._godebuffeffect = gohelper.findChild(slot1, "root/#go_debuff")
	slot0._goshieldeffect = gohelper.findChild(slot1, "root/#go_shield")
	slot0._godamageeffect = gohelper.findChild(slot1, "root/#go_damage")
	slot0._godeadeffect = gohelper.findChild(slot1, "root/#go_died")
	slot0._gobehaviorbuff = gohelper.findChild(slot1, "tips/#go_fighttip/#go_buff")
	slot0._behaviorbufftitle = gohelper.findChildTextMesh(slot0._gobehaviorbuff, "name/#txt_name")
	slot0._behaviorbuffimage = gohelper.findChildImage(slot0._gobehaviorbuff, "name/#simage_icon")
	slot0._behaviorbuffdesc = gohelper.findChildTextMesh(slot0._gobehaviorbuff, "#txt_desc")
	slot0._behaviorbufftag = gohelper.findChild(slot0._gobehaviorbuff, "name/#txt_name/#go_tag")
	slot0._behaviorbufftagName = gohelper.findChildTextMesh(slot0._gobehaviorbuff, "name/#txt_name/#go_tag/#txt_name")

	gohelper.setActive(slot0._goselect, false)
end

function slot0.addEventListeners(slot0)
	slot0._btnClickSelect:AddClickListener(slot0._onClickEnemy, slot0)
	slot0._btnClickBehavior:AddClickListener(slot0.showBehavior, slot0)
	slot0._btnClickBuff:AddClickListener(slot0._showBuff, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0.onTouchScreen, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, slot0._onSkillCardSelectChange, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.EnemySelectChange, slot0._onSkillCardSelectChange, slot0)
	gohelper.onceAddComponent(slot0._behaviordesc.gameObject, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(slot0._onLinkClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnClickSelect:RemoveClickListener()
	slot0._btnClickBehavior:RemoveClickListener()
	slot0._btnClickBuff:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, slot0._onSkillCardSelectChange, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.EnemySelectChange, slot0._onSkillCardSelectChange, slot0)
end

function slot0.initData(slot0, slot1)
	gohelper.setActive(slot0._godeadeffect, slot1.hp <= 0)

	slot0.data = slot1

	DiceHeroHelper.instance:registerEntity(slot1.uid, slot0)
	slot0._headicon:LoadImage(ResUrl.monsterHeadIcon(slot0:getHeroMo().co.icon))
	slot0:refreshAll()
end

function slot0.refreshAll(slot0)
	slot0:refreshBuff()
	slot0:refreshInfo()
	slot0:updateBehavior()
end

function slot0.updateBehavior(slot0)
	gohelper.setActive(slot0._iconbehavior, true)
	gohelper.setActive(slot0._gobehaviormask, true)

	if slot0:getHeroMo().behaviors.type == 1 then
		slot0._txtbehavior.text = (slot1.value[1] or 0) * #slot1.value
		slot0._behaviortitle.text = luaLang("dicehero_behavior_atk_title")

		if not slot1.exList then
			slot0._behaviordesc.text = slot0:getBehaviorText(slot1)
		else
			slot4 = {
				slot0:getBehaviorText(slot1)
			}

			for slot8, slot9 in ipairs(slot1.exList) do
				table.insert(slot4, slot0:getBehaviorText(slot9))
			end

			slot0._behaviordesc.text = table.concat(slot4, "\n")
		end

		UISpriteSetMgr.instance:setFightSprite(slot0._iconbehavior, "jnk_gj1")
		UISpriteSetMgr.instance:setFightSprite(slot0._behavioricon, "jnk_gj1")
	elseif slot1.type == 2 then
		slot0._txtbehavior.text = ""

		if slot1.isToAll then
			slot0._behaviortitle.text = luaLang("dicehero_behavior_buff_title")

			UISpriteSetMgr.instance:setFightSprite(slot0._iconbehavior, "jnk_gj4")
			UISpriteSetMgr.instance:setFightSprite(slot0._behavioricon, "jnk_gj4")
		elseif slot1.isToFriend then
			slot0._behaviortitle.text = luaLang("dicehero_behavior_buff_title")

			UISpriteSetMgr.instance:setFightSprite(slot0._iconbehavior, "jnk_gj4")
			UISpriteSetMgr.instance:setFightSprite(slot0._behavioricon, "jnk_gj4")
		else
			UISpriteSetMgr.instance:setFightSprite(slot0._iconbehavior, "jnk_gj5")
			UISpriteSetMgr.instance:setFightSprite(slot0._behavioricon, "jnk_gj5")

			slot0._behaviortitle.text = luaLang("dicehero_behavior_def_title")
		end

		if not slot1.exList then
			slot0._behaviordesc.text = slot0:getBehaviorText(slot1)
		else
			slot2 = {
				slot0:getBehaviorText(slot1)
			}

			for slot6, slot7 in ipairs(slot1.exList) do
				table.insert(slot2, slot0:getBehaviorText(slot7))
			end

			slot0._behaviordesc.text = table.concat(slot2, "\n")
		end
	elseif slot1.type == 3 then
		slot0._txtbehavior.text = ""

		if not slot1.exList then
			slot0._behaviordesc.text = slot0:getBehaviorText(slot1)
		else
			slot2 = {
				slot0:getBehaviorText(slot1)
			}

			for slot6, slot7 in ipairs(slot1.exList) do
				table.insert(slot2, slot0:getBehaviorText(slot7))
			end

			slot0._behaviordesc.text = table.concat(slot2, "\n")
		end

		if slot1.isToSelf or slot1.isToAll then
			slot0._behaviortitle.text = luaLang("dicehero_behavior_buff_title")

			UISpriteSetMgr.instance:setFightSprite(slot0._iconbehavior, "jnk_gj4")
			UISpriteSetMgr.instance:setFightSprite(slot0._behavioricon, "jnk_gj4")
		else
			slot0._behaviortitle.text = luaLang("dicehero_behavior_debuff_title")

			UISpriteSetMgr.instance:setFightSprite(slot0._iconbehavior, "jnk_gj3")
			UISpriteSetMgr.instance:setFightSprite(slot0._behavioricon, "jnk_gj3")
		end
	else
		gohelper.setActive(slot0._iconbehavior, false)
		gohelper.setActive(slot0._gobehaviormask, false)
	end
end

function slot0.getBehaviorText(slot0, slot1)
	if slot1.type == 1 then
		if #slot1.value > 1 then
			slot2 = string.format("%s%s%s", slot3, luaLang("multiple"), slot1.value[1] or 0)
		end

		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_atk"), slot2)
	elseif slot1.type == 2 then
		if slot1.isToAll then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_def_all"), slot1.value[1] or 0)
		elseif slot1.isToFriend then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_def_friend"), slot2)
		else
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_def"), slot2)
		end
	elseif slot1.type == 3 then
		if lua_dice_buff.configDict[tonumber(slot1.value[1]) or 0] then
			slot2 = string.format("<u><color=#4e6698><link=\"%s\">%s</link></color></u>", slot2, slot3.name)
		end

		if slot1.isToSelf then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_buff"), slot2)
		elseif slot1.isToAll then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_buff_all"), slot2)
		else
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_behavior_debuff"), slot2)
		end
	end
end

function slot0._onLinkClick(slot0, slot1)
	if not lua_dice_buff.configDict[tonumber(slot1)] then
		return
	end

	gohelper.setActive(slot0._gobehaviorbuff, true)
	UISpriteSetMgr.instance:setBuffSprite(slot0._behaviorbuffimage, slot2.icon)

	slot0._behaviorbufftitle.text = slot2.name
	slot0._behaviorbuffdesc.text = slot2.desc

	if slot2.tag == 1 then
		gohelper.setActive(slot0._behaviorbufftag, true)

		slot0._behaviorbufftagName.text = luaLang("dicehero_buff")
	elseif slot2.tag == 2 then
		gohelper.setActive(slot0._behaviorbufftag, true)

		slot0._behaviorbufftagName.text = luaLang("dicehero_debuff")
	else
		gohelper.setActive(slot0._behaviorbufftag, false)
	end
end

function slot0.refreshBuff(slot0)
	if #slot0:getHeroMo().buffs > 7 then
		gohelper.setActive(slot0._gobuffmore, true)

		slot1 = {
			unpack(slot1, 1, 7)
		}
	else
		gohelper.setActive(slot0._gobuffmore, false)
	end

	gohelper.CreateObjList(slot0, slot0._createBuff, slot1, nil, slot0._buffItem)

	if slot0._gozaowutip.activeSelf then
		if #slot1 > 0 then
			gohelper.CreateObjList(slot0, slot0._createSkillItem, slot1, nil, slot0._gozaowuitem)
		else
			gohelper.setActive(slot0._gozaowutip, false)
		end
	end
end

function slot0._createBuff(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setBuffSprite(gohelper.findChildImage(slot1, ""), slot2.co.icon)
end

function slot0.getHeroMo(slot0)
	return slot0.data
end

function slot0.addHp(slot0, slot1)
	slot2 = slot0:getHeroMo()

	slot2:setHp(slot2.hp + slot1)
	slot0:refreshInfo()
	gohelper.setActive(slot0._godeadeffect, slot2.hp <= 0)

	if slot2.hp <= 0 then
		gohelper.setActive(slot0._iconbehavior, false)
		gohelper.setActive(slot0._gobehaviormask, false)
		slot0:refreshBuff()
	end
end

function slot0.addShield(slot0, slot1)
	slot2 = slot0:getHeroMo()
	slot2.shield = slot2.shield + slot1

	slot0:refreshInfo()
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

function slot0._onClickEnemy(slot0)
	DiceHeroFightModel.instance:getGameData():setCurEnemy(slot0.data)
end

function slot0._onSkillCardSelectChange(slot0)
	gohelper.setActive(slot0._goselect, DiceHeroFightModel.instance:getGameData().curSelectEnemyMo == slot0.data)
end

function slot0._showBuff(slot0)
	if slot0._gozaowutip.activeSelf then
		gohelper.setActive(slot0._gozaowutip, false)

		return
	end

	gohelper.setActive(slot0._gofighttips, false)

	if not slot0:getHeroMo().buffs[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(slot0._gozaowutip, true)
	gohelper.CreateObjList(slot0, slot0._createSkillItem, slot1, nil, slot0._gozaowuitem)
end

function slot0.showBehavior(slot0)
	if slot0._gofighttips.activeSelf then
		gohelper.setActive(slot0._gofighttips, false)

		return
	end

	gohelper.setActive(slot0._gozaowutip, false)

	if not slot0:getHeroMo().behaviors.type then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(slot0._gofighttips, true)
	gohelper.setActive(slot0._gobehaviorbuff, false)
end

function slot0.hideBehavior(slot0)
	gohelper.setActive(slot0._gozaowutip, false)
	gohelper.setActive(slot0._gofighttips, false)
end

function slot0._createSkillItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildTextMesh(slot1, "name/#txt_name")
	slot5 = gohelper.findChildImage(slot1, "name/#simage_icon")
	slot6 = gohelper.findChildTextMesh(slot1, "#txt_desc")
	slot8 = gohelper.findChild(slot1, "name/#txt_name/#go_tag")
	slot9 = gohelper.findChildTextMesh(slot1, "name/#txt_name/#go_tag/#txt_name")

	if slot2.co.damp >= 0 and slot2.co.damp <= 4 then
		gohelper.findChildTextMesh(slot1, "name/#txt_layer").text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("dicehero_buff_" .. slot2.co.damp), slot2.layer)
	else
		slot7.text = ""
	end

	UISpriteSetMgr.instance:setBuffSprite(slot5, slot2.co.icon)

	slot4.text = slot2.co.name
	slot6.text = slot2.co.desc

	if slot2.co.tag == 1 then
		gohelper.setActive(slot8, true)

		slot9.text = luaLang("dicehero_buff")
	elseif slot2.co.tag == 2 then
		gohelper.setActive(slot8, true)

		slot9.text = luaLang("dicehero_debuff")
	else
		gohelper.setActive(slot8, false)
	end
end

function slot0.onTouchScreen(slot0)
	if slot0._gozaowutip.activeSelf then
		if gohelper.isMouseOverGo(slot0._gozaowutip) and gohelper.isMouseOverGo(slot0._gozaowuitem.transform.parent) or gohelper.isMouseOverGo(slot0._btnClickBuff) then
			return
		end

		gohelper.setActive(slot0._gozaowutip, false)
	elseif slot0._gofighttips.activeSelf then
		if gohelper.isMouseOverGo(slot0._gofighttips) or gohelper.isMouseOverGo(slot0._btnClickBehavior) then
			return
		end

		gohelper.setActive(slot0._gofighttips, false)
	end
end

function slot0.getPos(slot0, slot1)
	if slot1 == 1 then
		return slot0._shieldSlider.transform.position
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
end

function slot0.onDestroy(slot0)
	DiceHeroHelper.instance:unregisterEntity(slot0.data.uid)
end

return slot0
