module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroGroupItem1", package.seeall)

slot0 = class("Act191HeroGroupItem1", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.handleView = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goEmpty = gohelper.findChild(slot1, "go_Empty")
	slot0.goHero = gohelper.findChild(slot1, "go_Hero")
	slot0.btnClick = gohelper.findChildButton(slot1, "btn_Click")
	slot0.loader = PrefabInstantiate.Create(slot0.goHero)

	slot0.loader:startLoad(Activity191Enum.PrefabPath.HeroHeadItem, slot0.onLoadCallBack, slot0)

	slot0.enableClick = true
end

function slot0.onLoadCallBack(slot0)
	if slot0.loader:getInstGO() then
		slot0.heroHeadItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot1, Act191HeroHeadItem, {
			exSkill = true
		})

		if slot0.needFresh then
			slot0.heroHeadItem:setData(slot0.heroId)

			slot0.needFresh = false
		end
	end
end

function slot0.addEventListeners(slot0)
	if slot0.btnClick then
		slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
	end
end

function slot0.setData(slot0, slot1)
	slot0.heroId = slot1

	if slot1 and slot1 ~= 0 then
		if slot0.heroHeadItem then
			slot0.heroHeadItem:setData(slot1)

			slot0.needFresh = false
		else
			slot0.needFresh = true
		end

		gohelper.setActive(slot0.goEmpty, false)
		gohelper.setActive(slot0.goHero, true)
	else
		gohelper.setActive(slot0.goEmpty, true)
		gohelper.setActive(slot0.goHero, false)
	end
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.setClickEnable(slot0, slot1)
	slot0.enableClick = slot1
end

function slot0.onClick(slot0)
	if not slot0.enableClick or slot0.handleView and slot0.handleView._nowDragingIndex then
		return
	end

	if slot0.param then
		slot1 = ""

		if slot0.heroHeadItem and slot0.heroHeadItem.config then
			slot1 = slot0.heroHeadItem.config.name
		end

		Act191StatController.instance:statButtonClick(slot0.param.fromView, string.format("heroClick_%s_%s_%s", slot0.param.type, slot0._index, slot1))
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	ViewMgr.instance:openView(ViewName.Act191HeroEditView, {
		index = slot0._index,
		heroId = slot0.heroId
	})
end

function slot0.setExtraParam(slot0, slot1)
	slot0.param = slot1
end

return slot0
