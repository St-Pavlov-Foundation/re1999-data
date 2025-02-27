module("modules.logic.battlepass.view.BpSPMainBtnItem", package.seeall)

slot0 = class("BpSPMainBtnItem", ActCenterItemBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, gohelper.cloneInPlace(slot1))
end

function slot0.onInit(slot0, slot1)
	slot0._btnitem = gohelper.getClickWithAudio(slot0._imgGo, AudioEnum.UI.play_ui_role_pieces_open)

	slot0:_refreshItem()
end

function slot0.onClick(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.BP))

		return
	end

	BpController.instance:openBattlePassView(true)
end

function slot0._refreshItem(slot0)
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, ActivityModel.showActivityEffect() and ActivityConfig.instance:getMainActAtmosphereConfig().mainViewActBtnPrefix .. "icon_6" or "icon_6", true)

	if not slot1 and ActivityConfig.instance:getMainActAtmosphereConfig() then
		for slot8, slot9 in ipairs(slot4.mainViewActBtn) do
			if gohelper.findChild(slot0.go, slot9) then
				gohelper.setActive(slot10, slot1)
			end
		end
	end

	slot0._redDot = RedDotController.instance:addRedDot(slot0._goactivityreddot, RedDotEnum.DotNode.BattlePassSPMain)
end

function slot0.isShowRedDot(slot0)
	return slot0._redDot and slot0._redDot.isShowRedDot
end

return slot0
