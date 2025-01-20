module("modules.logic.versionactivity2_5.act187.view.Activity187PaintingView", package.seeall)

slot0 = class("Activity187PaintingView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "v2a5_lanternfestivalpainting/#btn_close")
	slot0._golowribbon = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#go_decorationLower")
	slot0._simagelantern = gohelper.findChildSingleImage(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern")
	slot0._goupribbon = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#go_decorationUpper")
	slot0._simagepicturebg = gohelper.findChildSingleImage(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#simage_pictureshadow")
	slot0._simagepicture = gohelper.findChildSingleImage(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#simage_pictureshadow/#simage_picture")
	slot0._goriddles = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles")
	slot0._txtriddles = gohelper.findChildText(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#txt_riddles")
	slot0._goriddlesRewards = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#go_riddlesRewards")
	slot0._goriddlesRewardItem = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#go_riddlesRewards/#go_riddlesRewardItem")
	slot0._gopaintTips = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#go_paintTips")
	slot0._gopaintingArea = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#go_paintingArea")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
end

function slot0._btncloseOnClick(slot0)
	slot0.viewContainer:setPaintingViewDisplay()
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0:setPaintStatus(Activity187Enum.PaintStatus.Painting)
	slot0:_onDrag(slot1, slot2)
end

function slot0._onDrag(slot0, slot1, slot2)
	slot0._writingBrush:OnMouseMove(slot2.position.x, slot2.position.y)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._writingBrush:OnMouseUp()
	slot0._writingBrush:Clear()
	gohelper.setActive(slot0._gopaintingArea, false)
	Activity187Controller.instance:finishPainting(slot0.onPainFinish, slot0)
end

function slot0.onPainFinish(slot0)
	slot0:setPaintStatus(Activity187Enum.PaintStatus.Finish)
end

function slot0._editableInitView(slot0)
	slot0._writingBrush = slot0._gopaintingArea:GetComponent(typeof(ZProj.WritingBrush))
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gopaintingArea)
	slot0._lowRibbonDict = slot0:getUserDataTb_()
	slot0._upRibbonDict = slot0:getUserDataTb_()

	slot0:_fillRibbonDict(slot0._golowribbon.transform, slot0._lowRibbonDict)
	slot0:_fillRibbonDict(slot0._goupribbon.transform, slot0._upRibbonDict)
end

function slot0._fillRibbonDict(slot0, slot1, slot2)
	for slot7 = 1, slot1.childCount do
		slot8 = slot1:GetChild(slot7 - 1)
		slot2[slot8.name] = slot8
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.ready2Paint(slot0, slot1)
	slot0._curIndex = slot1

	slot0:setPaintStatus(Activity187Enum.PaintStatus.Ready)
end

function slot0.setPaintStatus(slot0, slot1)
	slot2 = slot1 == Activity187Enum.PaintStatus.Ready
	slot4 = Activity187Enum.EmptyLantern
	slot5 = nil

	if slot1 == Activity187Enum.PaintStatus.Finish and Activity187Model.instance:getPaintingRewardId(slot0._curIndex) then
		slot7 = Activity187Model.instance:getAct187Id()
		slot4 = Activity187Config.instance:getLantern(slot7, slot6)
		slot5 = Activity187Config.instance:getLanternRibbon(slot7, slot6)

		slot0._simagepicture:LoadImage(ResUrl.getAct184LanternIcon(Activity187Config.instance:getLanternImg(slot7, slot6)))
		slot0._simagepicturebg:LoadImage(ResUrl.getAct184LanternIcon(Activity187Config.instance:getLanternImgBg(slot7, slot6)))

		slot0._txtriddles.text = Activity187Config.instance:getBlessing(slot7, slot6)

		gohelper.CreateObjList(slot0, slot0._onSetRiddlesRewardItem, Activity187Model.instance:getPaintingRewardList(slot0._curIndex), slot0._goriddlesRewards, slot0._goriddlesRewardItem)
	end

	slot9 = slot4

	slot0._simagelantern:LoadImage(ResUrl.getAct184LanternIcon(slot9))

	for slot9, slot10 in pairs(slot0._lowRibbonDict) do
		gohelper.setActive(slot10, slot9 == slot5)
	end

	for slot9, slot10 in pairs(slot0._upRibbonDict) do
		gohelper.setActive(slot10, slot9 == slot5)
	end

	gohelper.setActive(slot0._gopaintingArea, not slot3)
	gohelper.setActive(slot0._gopaintTips, slot2)
	gohelper.setActive(slot0._simagepicturebg, slot3)
	gohelper.setActive(slot0._goriddles, slot3)
	gohelper.setActive(slot0._btnclose, slot3)
end

function slot0._onSetRiddlesRewardItem(slot0, slot1, slot2, slot3)
	IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot1, "#go_item")):onUpdateMO(slot2)
end

function slot0.onClose(slot0)
	slot0._simagepicture:UnLoadImage()
	slot0._simagepicturebg:UnLoadImage()
	slot0._simagelantern:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
