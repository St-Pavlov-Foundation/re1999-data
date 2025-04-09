module("modules.logic.tower.view.TowerHeroTrialView", package.seeall)

slot0 = class("TowerHeroTrialView", BaseView)

function slot0.onInitView(slot0)
	slot0._btncloseFullView = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeFullView")
	slot0._scrollhero = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_hero")
	slot0._goheroContent = gohelper.findChild(slot0.viewGO, "#scroll_hero/Viewport/#go_heroContent")
	slot0._goheroItem = gohelper.findChild(slot0.viewGO, "#scroll_hero/Viewport/#go_heroContent/#go_heroItem")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_desc")
	slot0._godescContent = gohelper.findChild(slot0.viewGO, "#scroll_desc/Viewport/#go_descContent")
	slot0._godescItem = gohelper.findChild(slot0.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem")
	slot0._btnrule = gohelper.findChildButtonWithAudio(slot0.viewGO, "title/txt/#btn_rule")
	slot0._goruleTip = gohelper.findChild(slot0.viewGO, "#go_ruleTip")
	slot0._btncloseRuleTip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ruleTip/#btn_closeRuleTip")
	slot0._txtrule = gohelper.findChildText(slot0.viewGO, "#go_ruleTip/#txt_rule")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._imagefacetsIcon = gohelper.findChildImage(slot0.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/facets/image_facetsIcon")
	slot0._txtfacets = gohelper.findChildText(slot0.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/facets/txt_facets")
	slot0._gofacetsDesc = gohelper.findChild(slot0.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/go_facetsDesc")
	slot0._gofacetsDescItem = gohelper.findChild(slot0.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/go_facetsDesc/txt_facetsDesc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseFullView:AddClickListener(slot0._btncloseFullViewOnClick, slot0)
	slot0._btnrule:AddClickListener(slot0._btnruleOnClick, slot0)
	slot0._btncloseRuleTip:AddClickListener(slot0._btncloseRuleTipOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseFullView:RemoveClickListener()
	slot0._btnrule:RemoveClickListener()
	slot0._btncloseRuleTip:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseFullViewOnClick(slot0)
	slot0:_btncloseOnClick()
end

function slot0._btnruleOnClick(slot0)
	gohelper.setActive(slot0._goruleTip, true)
end

function slot0._btncloseRuleTipOnClick(slot0)
	gohelper.setActive(slot0._goruleTip, false)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onHeroTrialItemClick(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.HeroItemList) do
		if slot6.trialHeroId == slot1.trialHeroId then
			gohelper.setActive(slot6.goSelect, true)

			slot0.curSelectHeroItem = slot6

			slot0:createOrRefreshDesc()
		else
			gohelper.setActive(slot6.goSelect, false)
		end
	end
end

function slot0._editableInitView(slot0)
	slot0.HeroItemList = slot0:getUserDataTb_()
	slot0.descItemList = slot0:getUserDataTb_()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
	gohelper.setActive(slot0._goruleTip, false)
	gohelper.setActive(slot0._goheroItem, false)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.curSeason = TowerModel.instance:getTrialHeroSeason()
	slot0._txtrule.text = TowerConfig.instance:getTowerConstLangConfig(TowerEnum.ConstId.HeroTrialRule)

	slot0:createOrRefreshTrialHero()
	slot0:createOrRefreshDesc()
end

function slot0.createOrRefreshTrialHero(slot0)
	for slot6, slot7 in ipairs(string.splitToNumber(TowerConfig.instance:getHeroTrialConfig(slot0.curSeason).heroIds, "|")) do
		if not slot0.HeroItemList[slot6] then
			slot8 = {
				go = gohelper.clone(slot0._goheroItem, slot0._goheroContent, slot7)
			}
			slot8.rare = gohelper.findChildImage(slot8.go, "role/rare")
			slot8.heroIcon = gohelper.findChildSingleImage(slot8.go, "role/heroicon")
			slot8.career = gohelper.findChildImage(slot8.go, "role/career")
			slot8.name = gohelper.findChildText(slot8.go, "role/name")
			slot8.nameEn = gohelper.findChildText(slot8.go, "role/name/nameEn")
			slot8.goSelect = gohelper.findChild(slot8.go, "go_select")
			slot8.btnClick = gohelper.findChildButtonWithAudio(slot8.go, "btn_click")

			slot8.btnClick:AddClickListener(slot0.onHeroTrialItemClick, slot0, slot8)

			slot0.HeroItemList[slot6] = slot8
		end

		gohelper.setActive(slot8.go, true)

		slot8.trialHeroId = slot7
		slot8.trialConfig = lua_hero_trial.configDict[slot7][0]
		slot9 = HeroConfig.instance:getHeroCO(slot8.trialConfig.heroId)

		slot8.heroIcon:LoadImage(ResUrl.getRoomHeadIcon(SkinConfig.instance:getSkinCo(slot8.trialConfig.skin).headIcon))

		slot8.name.text = slot9.name
		slot8.nameEn.text = slot9.nameEng

		UISpriteSetMgr.instance:setCommonSprite(slot8.career, "lssx_" .. slot9.career)
		UISpriteSetMgr.instance:setCommonSprite(slot8.rare, "bgequip" .. CharacterEnum.Color[slot9.rare])
	end

	for slot6 = #slot2 + 1, #slot0.HeroItemList do
		gohelper.setActive(slot0.HeroItemList[slot6].go, false)
	end

	if not slot0.curSelectHeroItem then
		slot0.curSelectHeroItem = slot0.HeroItemList[1]

		gohelper.setActive(slot0.curSelectHeroItem.goSelect, true)
	end
end

function slot0.createOrRefreshDesc(slot0)
	slot2 = slot0.curSelectHeroItem.trialConfig.facetslevel

	if not CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(slot0.curSelectHeroItem.trialConfig.facetsId) then
		logError(slot0.curSelectHeroItem.trialConfig.id .. "角色命石消耗表中狂想配置不存在，请检查： " .. slot1)

		return
	end

	slot4 = CharacterDestinyEnum.SlotTend[slot3.tend]

	UISpriteSetMgr.instance:setUiCharacterSprite(slot0._imagefacetsIcon, slot4.TitleIconName)

	slot0._txtfacets.color = GameUtil.parseColor(slot4.TitleColor)
	slot0._txtfacets.text = slot3.name
	slot6 = {}

	for slot10 = 1, slot2 do
		table.insert(slot6, CharacterDestinyConfig.instance:getDestinyFacets(slot1, slot10))
	end

	gohelper.CreateObjList(slot0, slot0.showFacetsDescItem, slot6, slot0._gofacetsDesc, slot0._gofacetsDescItem)
end

function slot0.showFacetsDescItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.txtdesc = slot1:GetComponent(gohelper.Type_TextMesh)
	slot4.txtdesc.text = slot2.desc
	slot4.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(slot1, SkillDescComp)

	slot4.skillDesc:updateInfo(slot4.txtdesc, slot2.desc, slot0.curSelectHeroItem.trialConfig.heroId)
	slot4.skillDesc:setTipParam(0, Vector2(-200, 100))
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0.HeroItemList) do
		slot5.btnClick:RemoveClickListener()
		slot5.heroIcon:UnLoadImage()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
