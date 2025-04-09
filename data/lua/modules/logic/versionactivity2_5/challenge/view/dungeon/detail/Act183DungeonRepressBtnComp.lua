module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRepressBtnComp", package.seeall)

slot0 = class("Act183DungeonRepressBtnComp", Act183DungeonBaseComp)
slot1 = 25
slot2 = 0

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._btnrepress = gohelper.getClickWithDefaultAudio(slot0.go)
	slot0._txtbtnrepress = gohelper.findChildText(slot0.go, "txt_Cn")
	slot0._gosetrepresshero = gohelper.findChild(slot0.go, "#go_setrepresshero")
	slot0._simagerepressheroicon = gohelper.findChildSingleImage(slot0.go, "#go_setrepresshero/#simage_repressheroicon")
	slot0._imagecareer = gohelper.findChildImage(slot0.go, "#go_setrepresshero/#image_Career")
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateBadgeDetailVisible, slot0._onUpdateBadgeDetailVisible, slot0)
	slot0._btnrepress:AddClickListener(slot0._btnrepressOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnrepress:RemoveClickListener()
end

function slot0._btnrepressOnClick(slot0)
	Act183Controller.instance:openAct183RepressView({
		activityId = slot0._activityId,
		episodeMo = slot0._episodeMo
	})
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)

	slot0._isCanReRepress = slot0._groupEpisodeMo:isEpisodeCanReRepress(slot0._episodeId)
end

function slot0.checkIsVisible(slot0)
	return slot0._isCanReRepress
end

function slot0.show(slot0)
	uv0.super.show(slot0)

	slot2 = slot0._episodeMo:getRepressHeroMo() ~= nil

	gohelper.setActive(slot0._gosetrepresshero, slot2)
	recthelper.setAnchorX(slot0._txtbtnrepress.transform, slot2 and uv1 or uv2)

	if not slot2 then
		return
	end

	slot0._simagerepressheroicon:LoadImage(slot1:getHeroIconUrl())
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot1:getHeroCarrer()))
end

function slot0._onUpdateBadgeDetailVisible(slot0, slot1)
	if slot0:checkIsVisible() then
		gohelper.setActive(slot0.go, not slot1)
	end
end

function slot0.onDestroy(slot0)
	slot0._simagerepressheroicon:UnLoadImage()
	uv0.super.onDestroy(slot0)
end

return slot0
