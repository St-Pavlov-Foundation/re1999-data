module("modules.versionactivitybase.fixed.enterview.view.VersionActivityFixedEnterViewTabItem1", package.seeall)

slot0 = class("VersionActivityFixedEnterViewTabItem1", VersionActivityFixedEnterViewTabItemBase)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0.simageSelectTabImg = gohelper.findChildSingleImage(slot0.go, "#go_select/#simage_tabimg")
	slot0.simageUnSelectTabImg = gohelper.findChildSingleImage(slot0.go, "#go_unselect/#simage_tabimg")
end

function slot0._getTagPath(slot0)
	return "#go_tag"
end

function slot0.afterSetData(slot0)
	uv0.super.afterSetData(slot0)

	if not slot0.actId then
		return
	end

	slot1 = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting

	slot0:setTabImg("simageSelectTabImg", slot1.select.act2TabImg[slot0.actId])
	slot0:setTabImg("simageUnSelectTabImg", slot1.unselect.act2TabImg[slot0.actId])
end

function slot0.setTabImg(slot0, slot1, slot2)
	if string.nilorempty(slot1) or string.nilorempty(slot2) or not slot0[slot1] then
		return
	end

	slot0[slot1]:LoadImage(slot2)
end

function slot0.dispose(slot0)
	slot0.simageSelectTabImg:UnLoadImage()
	slot0.simageUnSelectTabImg:UnLoadImage()
	uv0.super.dispose(slot0)
end

return slot0
