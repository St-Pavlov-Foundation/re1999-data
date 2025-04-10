module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PickChoiceItem", package.seeall)

slot0 = class("V2a7_SelfSelectSix_PickChoiceItem", ListScrollCellExtend)
slot0.FirstDungeonId = 10101

function slot0.onInitView(slot0)
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "#go_title")
	slot0._gooriginal = gohelper.findChild(slot0.viewGO, "#go_title/#go_original")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_title/#go_locked")
	slot0._txtlocked = gohelper.findChildText(slot0.viewGO, "#go_title/#go_locked/#txt_locked")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_title/#go_unlock")
	slot0._txtunlock = gohelper.findChildText(slot0.viewGO, "#go_title/#go_unlock/#txt_unlock")
	slot0._gohero = gohelper.findChild(slot0.viewGO, "#go_hero")
	slot0._herocanvas = gohelper.onceAddComponent(slot0._gohero, typeof(UnityEngine.CanvasGroup))
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "#go_hero/heroitem")
	slot0._goexskill = gohelper.findChild(slot0.viewGO, "#go_hero/heroitem/role/#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot0.viewGO, "#go_hero/heroitem/role/#go_exskill/#image_exskill")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#go_hero/heroitem/select/#go_click")
	slot0._itemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
end

function slot0._editableInitView(slot0)
	slot0._transcontent = slot0._gohero.transform

	gohelper.setActive(slot0._goheroitem, false)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.refreshUI(slot0)
	if slot0._isTitle then
		slot0:_refreshTitle()
	else
		slot0:_refreshHeroList()
	end

	slot0._herocanvas.alpha = slot0._mo.isUnlock and 1 or 0.5
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._isTitle = slot1.isTitle

	gohelper.setActive(slot0._gotitle, slot0._isTitle)
	gohelper.setActive(slot0._gohero, not slot0._isTitle)
	slot0:refreshUI()
end

function slot0._refreshTitle(slot0)
	if slot0._mo.episodeId == uv0.FirstDungeonId then
		gohelper.setActive(slot0._gooriginal, true)
		gohelper.setActive(slot0._golocked, false)
		gohelper.setActive(slot0._gounlock, false)
	else
		gohelper.setActive(slot0._gooriginal, false)
		gohelper.setActive(slot0._golocked, not slot0._mo.isUnlock)
		gohelper.setActive(slot0._gounlock, slot0._mo.isUnlock)

		slot1 = DungeonHelper.getEpisodeName(slot0._mo.episodeId)
		slot0._txtlocked.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v2a7_newbie_storyprocess_locate_item"), slot1)
		slot0._txtunlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v2a7_newbie_storyprocess_locate_item_finish"), slot1)
	end
end

function slot0._refreshHeroList(slot0)
	for slot4, slot5 in ipairs(slot0._mo.heroIdList) do
		slot7 = SummonCustomPickChoiceMO.New()

		slot7:init(tonumber(slot5))
		slot0:getOrCreateItem(slot4).component:onUpdateMO(slot7)

		if not slot0._mo.isUnlock then
			slot6.component:setLock()
		end
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._transcontent)
end

function slot0.getOrCreateItem(slot0, slot1)
	if not slot0._itemList[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.clone(slot0._goheroitem, slot0._gohero, "item" .. tostring(slot1))

		gohelper.setActive(slot2.go, true)

		slot2.component = MonoHelper.addNoUpdateLuaComOnceToGo(slot2.go, V2a7_SelfSelectSix_PickChoiceHeroItem)

		slot2.component:init(slot2.go)
		slot2.component:addEvents()

		slot0._itemList[slot1] = slot2
	end

	return slot2
end

function slot0.onDestroyView(slot0)
end

return slot0
