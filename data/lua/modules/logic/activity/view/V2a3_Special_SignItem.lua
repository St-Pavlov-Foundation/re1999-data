module("modules.logic.activity.view.V2a3_Special_SignItem", package.seeall)

slot0 = class("V2a3_Special_SignItem", LinkageActivity_Page2RewardBase)

function slot0.onInitView(slot0)
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "icon/#txt_num")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "icon/#simage_icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = string.split

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

function slot0._editableAddEvents(slot0)
	uv0.super._editableInitView(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._OnOpenView, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._OnOpenView, slot0)
end

function slot0._editableInitView(slot0)
	slot0._simageiconImg = gohelper.findChildImage(slot0._simageicon.gameObject, "")
	slot0._bgImg = gohelper.findChildImage(slot0.viewGO, "icon/bg")
	slot0._go_nextday = gohelper.findChild(slot0.viewGO, "go_nextday")
	slot0._goCanGet = gohelper.findChild(slot0.viewGO, "go_canget")
	slot0._goGet = gohelper.findChild(slot0.viewGO, "go_hasget")
	slot0._click = gohelper.getClick(gohelper.findChild(slot0.viewGO, "clickarea"))
	slot0._txtnum.text = ""

	slot0:setActive_goGet(false)
	slot0:setActive_goCanGet(false)
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)

	slot3 = slot0:isType101RewardGet() and "#808080" or "#ffffff"

	assert(#uv1(slot0:getNorSignActivityCo().bonus, "|") == 1, string.format("[V2a3_Special_SignItem] rewardCount=%s", tostring(slot7)))

	slot8 = string.splitToNumber(slot6[1], "#")
	slot1._itemCo = slot8

	GameUtil.loadSImage(slot0._simageicon, slot0:_assetGetViewContainer():getItemIconResUrl(slot8[1], slot8[2]))
	UIColorHelper.set(slot0._simageiconImg, slot3)
	UIColorHelper.set(slot0._bgImg, slot3)

	slot0._txtnum.text = luaLang("multiple") .. slot8[3]

	slot0:setActive_goGet(slot2)
	slot0:setActive_goCanGet(slot0:isType101RewardCouldGet())
	slot0:setActive_goTmr(slot0:getType101LoginCount() + 1 == slot0._index)
end

function slot0.setActive_goCanGet(slot0, slot1)
	gohelper.setActive(slot0._goCanGet, slot1)
end

function slot0.setActive_goGet(slot0, slot1)
	gohelper.setActive(slot0._goGet, slot1)
end

function slot0.setActive_goTmr(slot0, slot1)
	gohelper.setActive(slot0._go_nextday, slot1)
end

function slot0._onClick(slot0)
	if not slot0:isActOnLine() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if slot0:isType101RewardCouldGet() then
		slot0:sendGet101BonusRequest()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tags_2000013)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_25050217)

	slot3 = slot0._mo._itemCo

	MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2])
end

function slot0._OnOpenView(slot0, slot1)
	if slot1 == ViewName.RoomBlockPackageGetView then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_building_collect_20234002)
	end
end

return slot0
