module("modules.logic.activity.view.ActivityDoubleFestivalSignPaiLianView_1_3", package.seeall)

slot0 = class("ActivityDoubleFestivalSignPaiLianView_1_3", Activity101SignViewBase)

function slot0.onInitView(slot0)
	slot0._btnemptyTop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyTop")
	slot0._btnemptyBottom = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyBottom")
	slot0._btnemptyLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyLeft")
	slot0._btnemptyRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyRight")
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_ItemList")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	Activity101SignViewBase.addEvents(slot0)
	slot0._btnemptyTop:AddClickListener(slot0._btnemptyTopOnClick, slot0)
	slot0._btnemptyBottom:AddClickListener(slot0._btnemptyBottomOnClick, slot0)
	slot0._btnemptyLeft:AddClickListener(slot0._btnemptyLeftOnClick, slot0)
	slot0._btnemptyRight:AddClickListener(slot0._btnemptyRightOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	Activity101SignViewBase.removeEvents(slot0)
	slot0._btnemptyTop:RemoveClickListener()
	slot0._btnemptyBottom:RemoveClickListener()
	slot0._btnemptyLeft:RemoveClickListener()
	slot0._btnemptyRight:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
end

slot1 = ActivityEnum.Activity.DoubleFestivalSign_1_3

function slot0._btnemptyTopOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyBottomOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyLeftOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyRightOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._txtLimitTime.text = ""

	slot0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_halftitle"))
	slot0._simagePanelBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_halfbg"))
end

function slot0.onOpen(slot0)
	slot0:internal_set_actId(uv0)
	slot0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	slot0:internal_onOpen()
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
end

function slot0._updateScrollViewPos(slot0)
	if slot0._isFirst then
		return
	end

	slot0._isFirst = true

	slot0:updateRewardCouldGetHorizontalScrollPixel()
end

function slot0.onClose(slot0)
	slot0._isFirst = nil

	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageTitle:UnLoadImage()
	slot0._simagePanelBG:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onRefresh(slot0)
	slot0:_refreshList()
	slot0:_updateScrollViewPos()
	slot0:_refreshTimeTick()
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = slot0:getRemainTimeStr()
end

function slot0.updateRewardCouldGetHorizontalScrollPixel(slot0)
	slot1, slot2 = slot0:getRewardCouldGetIndex()
	slot3 = slot0.viewContainer:getCsListScroll()
	slot4 = slot0.viewContainer:getListScrollParam()
	slot3.HorizontalScrollPixel = math.max(0, (slot4.cellWidth + slot4.cellSpaceH) * math.max(0, slot2 <= 4 and slot2 - 4 or 10))

	slot3:UpdateCells(false)
end

return slot0
