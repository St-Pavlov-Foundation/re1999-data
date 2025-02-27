module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroRoleItem", package.seeall)

slot0 = class("DiceHeroRoleItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.chapter = slot1.chapter
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._emptyRelicItem = gohelper.findChild(slot1, "root/zaowu/#go_nulllayout/#go_item")
	slot0._relicItem = gohelper.findChild(slot1, "root/zaowu/#go_iconlayout/#simage_iconitem")
	slot0._powerItem = gohelper.findChild(slot1, "root/headbg/energylayout/#go_item")
	slot0._txtname = gohelper.findChildTextMesh(slot1, "root/#txt_name")
	slot0._hpSlider = gohelper.findChildImage(slot1, "root/#simage_hpbg/#simage_hp")
	slot0._shieldSlider = gohelper.findChildImage(slot1, "root/#simage_shieldbg/#simage_shield")
	slot0._hpNum = gohelper.findChildTextMesh(slot1, "root/#simage_hpbg/#txt_hpnum")
	slot0._shieldNum = gohelper.findChildTextMesh(slot1, "root/#simage_shieldbg/#txt_shieldnum")
	slot0._buffConatiner = gohelper.findChild(slot1, "root/#go_statelist")
	slot0._txtdicenum = gohelper.findChildTextMesh(slot1, "root/dice/#txt_num")
	slot0._headicon = gohelper.findChildSingleImage(slot1, "root/headbg/headicon")
	slot0._btnClickHead = gohelper.findChildButtonWithAudio(slot1, "root/#btn_clickhead")
	slot0._btnClickRelic = gohelper.findChildButtonWithAudio(slot1, "root/#btn_clickrelic")
	slot0._goskilltips = gohelper.findChild(slot1, "tips/#go_skilltip")
	slot0._gozaowutip = gohelper.findChild(slot1, "tips/#go_zaowutip")
	slot0._goskillitem = gohelper.findChild(slot1, "tips/#go_skilltip/viewport/content/item")
	slot0._gozaowuitem = gohelper.findChild(slot1, "tips/#go_zaowutip/viewport/content/item")

	gohelper.setActive(slot0._buffConatiner, false)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0.onTouchScreen, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.InfoUpdate, slot0.updateInfo, slot0)
	slot0._btnClickHead:AddClickListener(slot0._showSkill, slot0)
	slot0._btnClickRelic:AddClickListener(slot0._showRelic, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnClickHead:RemoveClickListener()
	slot0._btnClickRelic:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.InfoUpdate, slot0.updateInfo, slot0)
end

function slot0.onStart(slot0)
	slot0:updateInfo()
end

function slot0.updateInfo(slot0)
	if not DiceHeroModel.instance:getGameInfo(slot0.chapter) or slot1.heroBaseInfo.id == 0 then
		gohelper.setActive(slot0.go, false)

		return
	end

	gohelper.setActive(slot0.go, true)

	slot2 = slot1.heroBaseInfo
	slot3 = {}
	slot4 = {}

	for slot8 = 1, 5 do
		if slot2.relicIds[slot8] then
			table.insert(slot3, slot2.relicIds[slot8])
		else
			table.insert(slot4, 1)
		end
	end

	gohelper.CreateObjList(slot0, slot0._createRelicItem, slot3, nil, slot0._relicItem)

	slot9 = nil

	gohelper.CreateObjList(nil, , slot4, slot9, slot0._emptyRelicItem)

	for slot9 = 1, slot2.maxPower do
	end

	gohelper.CreateObjList(slot0, slot0._createPowerItem, {
		[slot9] = slot9 <= slot2.power and 1 or 0
	}, nil, slot0._powerItem)

	slot6 = slot2.hp
	slot8 = slot2.shield
	slot9 = slot2.maxShield
	slot0._hpSlider.fillAmount = slot2.maxHp > 0 and slot6 / slot7 or 0
	slot0._shieldSlider.fillAmount = slot9 > 0 and slot8 / slot9 or 0
	slot0._hpNum.text = slot6
	slot0._shieldNum.text = slot8
	slot0._txtname.text = slot2.co.name
	slot0._txtdicenum.text = string.format("×%s", #string.split(slot2.co.dicelist, "#"))

	slot0._headicon:LoadImage(ResUrl.getHeadIconSmall(slot2.co.icon))
end

function slot0._createRelicItem(slot0, slot1, slot2, slot3)
	if lua_dice_relic.configDict[slot2] then
		gohelper.findChildSingleImage(slot1, ""):LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. slot5.icon .. ".png")
	end
end

function slot0._createPowerItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "light"), slot2 == 1)
end

function slot0._showSkill(slot0)
	if slot0._goskilltips.activeSelf then
		gohelper.setActive(slot0._goskilltips, false)

		return
	end

	gohelper.setActive(slot0._gozaowutip, false)

	slot1 = DiceHeroModel.instance:getGameInfo(slot0.chapter)
	slot5 = {
		lua_dice_card.configDict[slot1.heroBaseInfo.co.powerSkill]
	}

	for slot9, slot10 in ipairs(slot1.heroBaseInfo.relicIds) do
		if lua_dice_relic.configDict[slot10].effect == "skill" and lua_dice_card.configDict[tonumber(slot11.param)] and slot12.type == DiceHeroEnum.CardType.Hero then
			table.insert(slot5, slot12)
		end
	end

	if not slot5[1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(slot0._goskilltips, true)
	gohelper.CreateObjList(slot0, slot0._createSkillItem, slot5, nil, slot0._goskillitem)
end

function slot0._createSkillItem(slot0, slot1, slot2, slot3)
	gohelper.findChildTextMesh(slot1, "#txt_title/#txt_title").text = slot2.name
	gohelper.findChildTextMesh(slot1, "#txt_desc").text = slot2.desc
end

function slot0._showRelic(slot0)
	if slot0._gozaowutip.activeSelf then
		gohelper.setActive(slot0._gozaowutip, false)

		return
	end

	gohelper.setActive(slot0._goskilltips, false)

	slot3 = {}

	for slot7, slot8 in ipairs(DiceHeroModel.instance:getGameInfo(slot0.chapter).heroBaseInfo.relicIds) do
		table.insert(slot3, lua_dice_relic.configDict[slot8])
	end

	if #slot3 <= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_activity_open)
	gohelper.setActive(slot0._gozaowutip, true)
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
	end
end

return slot0
