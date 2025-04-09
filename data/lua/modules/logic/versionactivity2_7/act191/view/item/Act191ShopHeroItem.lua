module("modules.logic.versionactivity2_7.act191.view.item.Act191ShopHeroItem", package.seeall)

slot0 = class("Act191ShopHeroItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.handleView = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goEmpty = gohelper.findChild(slot1, "go_Empty")
	slot0.goHero = gohelper.findChild(slot1, "go_Hero")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "btn_Click")
	slot0.goEffect = gohelper.findChild(slot1, "add_effect")
	slot0.heroHeadItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.handleView:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, slot0.goHero), Act191HeroHeadItem)
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
end

function slot0.setData(slot0, slot1)
	gohelper.setActive(slot0.goEffect, false)

	slot0.heroId = slot1

	if slot1 and slot1 ~= 0 then
		slot0.heroHeadItem:setData(slot1)
		gohelper.setActive(slot0.goEmpty, false)
		gohelper.setActive(slot0.goEffect, true)
		gohelper.setActive(slot0.goHero, true)
	else
		gohelper.setActive(slot0.goEmpty, true)
		gohelper.setActive(slot0.goHero, false)
	end
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.onClick(slot0)
	Act191StatController.instance:statButtonClick(slot0.handleView.viewName, string.format("hero_%s_%s", slot0._index, slot0.heroId or 0))
	ViewMgr.instance:openView(ViewName.Act191ShopHeroGroupView)
end

return slot0
