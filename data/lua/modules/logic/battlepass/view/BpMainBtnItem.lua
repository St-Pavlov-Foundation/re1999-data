module("modules.logic.battlepass.view.BpMainBtnItem", package.seeall)

slot0 = class("BpMainBtnItem", ActCenterItemBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, gohelper.cloneInPlace(slot1))
end

function slot0.onInit(slot0, slot1)
	slot0._btnitem = gohelper.getClickWithAudio(slot0._imgGo, AudioEnum2_6.BP.MainBtn)

	if BpConfig.instance:getBpCO(BpModel.instance.id) and slot2.isSp then
		gohelper.setActive(gohelper.findChild(slot0.go, "link"), true)
	end

	gohelper.setActive(gohelper.findChild(slot0.go, "bg_tarot"), true)
	slot0:_initReddotitem()
	slot0:_refreshItem()
end

function slot0.onClick(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.BP))

		return
	end

	BpController.instance:openBattlePassView()
end

function slot0._refreshItem(slot0)
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, ActivityModel.showActivityEffect() and ActivityConfig.instance:getMainActAtmosphereConfig().mainViewActBtnPrefix .. "icon_3" or "icon_3", true)

	if not slot1 and ActivityConfig.instance:getMainActAtmosphereConfig() then
		for slot8, slot9 in ipairs(slot4.mainViewActBtn) do
			if gohelper.findChild(slot0.go, slot9) then
				gohelper.setActive(slot10, slot1)
			end
		end
	end

	slot0._redDot:refreshDot()
end

function slot0.isShowRedDot(slot0)
	return slot0._redDot.show
end

function slot0._initReddotitem(slot0)
	slot1 = slot0.go
	slot0._redDot = RedDotController.instance:addRedDot(gohelper.findChild(slot1, "go_activityreddot"), RedDotEnum.DotNode.BattlePass)

	return

	for slot8 = 1, gohelper.findChild(slot1, "go_activityreddot/#go_special_reds").transform.childCount do
		gohelper.setActive(slot3:GetChild(slot8 - 1).gameObject, false)
	end

	slot5 = gohelper.findChild(slot2, "#go_bp_red")
	slot0._redDot = RedDotController.instance:addRedDotTag(slot5, RedDotEnum.DotNode.BattlePass, false, slot0._onRefreshDot, slot0)
	slot0._btnitem2 = gohelper.getClickWithAudio(slot5, AudioEnum2_6.BP.MainBtn)
end

function slot0._onRefreshDot(slot0, slot1)
	slot2 = RedDotModel.instance:isDotShow(slot1.dotId, 0)
	slot1.show = slot2

	gohelper.setActive(slot1.go, slot2)
	gohelper.setActive(slot0._imgGo, not slot2)
end

return slot0
