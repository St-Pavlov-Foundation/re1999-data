module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchHeroItem", package.seeall)

slot0 = class("VersionActivity1_8DispatchHeroItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._simageicon = gohelper.findChildSingleImage(slot0._go, "#simage_icon")
	slot0._imagecareer = gohelper.findChildImage(slot0._go, "#image_career")
	slot0._godispatched = gohelper.findChild(slot0._go, "#go_dispatched")
	slot0._goselected = gohelper.findChild(slot0._go, "#go_selected")

	gohelper.setActive(slot0._goselected, false)

	slot0._txtindex = gohelper.findChildText(slot0._go, "#go_selected/#txt_index")
	slot0.click = gohelper.getClick(slot0._go)
	slot0.isSelected = false
	slot0.dispatched = false
end

function slot0.addEventListeners(slot0)
	slot0.click:AddClickListener(slot0.onClickSelf, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, slot0.updateSelect, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.click:RemoveClickListener()
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, slot0.updateSelect, slot0)
end

function slot0.onClickSelf(slot0)
	if not DispatchHeroListModel.instance:canChangeHeroMo() then
		return
	end

	if slot0.mo:isDispatched() then
		return
	end

	if slot0.isSelected then
		DispatchHeroListModel.instance:deselectMo(slot0.mo)
	elseif DispatchHeroListModel.instance:canAddMo() then
		DispatchHeroListModel.instance:selectMo(slot0.mo)
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function slot0.updateSelect(slot0)
	slot0.isSelected = DispatchHeroListModel.instance:getSelectedIndex(slot0.mo) ~= nil

	gohelper.setActive(slot0._goselected, slot0.isSelected)

	if slot0.isSelected then
		slot0._txtindex.text = slot1
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0.config = slot1.config

	slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot0.config.id .. "01"))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. slot0.config.career)

	slot0.dispatched = slot0.mo:isDispatched()

	if slot0.dispatched then
		slot0.isSelected = false
	else
		slot0.isSelected = DispatchHeroListModel.instance:getSelectedIndex(slot0.mo) ~= nil
	end

	gohelper.setActive(slot0._godispatched, slot0.dispatched)
	slot0:updateSelect()
end

function slot0.onDestroy(slot0)
	slot0._simageicon:UnLoadImage()
end

return slot0
