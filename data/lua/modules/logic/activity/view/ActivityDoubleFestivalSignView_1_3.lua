module("modules.logic.activity.view.ActivityDoubleFestivalSignView_1_3", package.seeall)

local var_0_0 = class("ActivityDoubleFestivalSignView_1_3", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_LimitTime")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_fulltitle"))
	arg_2_0._simageFullBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_fullbg"))
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0._txtLimitTime.text = ""

	arg_3_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	arg_3_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_3_0._refreshTimeTick, arg_3_0, 1)
end

function var_0_0._updateScrollViewPos(arg_4_0)
	if arg_4_0._isFirstUpdateScrollPos then
		return
	end

	arg_4_0._isFirstUpdateScrollPos = true

	arg_4_0:updateRewardCouldGetHorizontalScrollPixel()
end

function var_0_0.onClose(arg_5_0)
	arg_5_0._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(arg_5_0._refreshTimeTick, arg_5_0)
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0._simageTitle:UnLoadImage()
	arg_6_0._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(arg_6_0._refreshTimeTick, arg_6_0)
end

function var_0_0.onRefresh(arg_7_0)
	arg_7_0:_refreshList()
	arg_7_0:_updateScrollViewPos()
	arg_7_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_8_0)
	arg_8_0._txtLimitTime.text = arg_8_0:getRemainTimeStr()
end

function var_0_0.updateRewardCouldGetHorizontalScrollPixel(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0:getRewardCouldGetIndex()
	local var_9_2 = arg_9_0.viewContainer:getCsListScroll()
	local var_9_3 = arg_9_0.viewContainer:getListScrollParam()
	local var_9_4 = var_9_3.cellWidth
	local var_9_5 = var_9_3.cellSpaceH

	if var_9_1 <= 4 then
		var_9_1 = var_9_1 - 4
	else
		var_9_1 = 10
	end

	local var_9_6 = (var_9_4 + var_9_5) * math.max(0, var_9_1)

	var_9_2.HorizontalScrollPixel = math.max(0, var_9_6)

	var_9_2:UpdateCells(false)
end

return var_0_0
