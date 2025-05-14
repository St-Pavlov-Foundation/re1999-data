module("modules.logic.story.view.StoryDialogSlideItem", package.seeall)

local var_0_0 = class("StoryDialogSlideItem")

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = ViewMgr.instance:getContainer(ViewName.StoryView)
	local var_1_1 = var_1_0:getSetting().otherRes[3]

	arg_1_0._dialogGo = var_1_0:getResInst(var_1_1, arg_1_1)
	arg_1_0._simagedialog = gohelper.findChildSingleImage(arg_1_0._dialogGo, "#simage_dialog")
end

function var_0_0.clearSlideDialog(arg_2_0)
	arg_2_0._callback = nil
	arg_2_0._callbackObj = nil
end

function var_0_0.startShowDialog(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = ResUrl.getStoryLangPath(arg_3_1.img)

	arg_3_0._speed = arg_3_1.speed
	arg_3_0._showTime = arg_3_1.showTime
	arg_3_0._callback = arg_3_2
	arg_3_0._callbackObj = arg_3_3

	gohelper.setActive(arg_3_0._dialogGo, true)
	arg_3_0._simagedialog:LoadImage(var_3_0, arg_3_0._imgLoaded, arg_3_0)
end

function var_0_0.hideDialog(arg_4_0)
	gohelper.setActive(arg_4_0._dialogGo, false)
	arg_4_0._simagedialog:UnLoadImage()
end

function var_0_0._imgLoaded(arg_5_0)
	arg_5_0._simagedialog.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	arg_5_0:_startMove()
end

function var_0_0._moveUpdate(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = transformhelper.getLocalPos(arg_6_0._simagedialog.transform)

	transformhelper.setLocalPosXY(arg_6_0._simagedialog.transform, arg_6_1, var_6_1)
end

function var_0_0._startMove(arg_7_0)
	if arg_7_0._tweenId then
		ZProj.TweenHelper.KillById(arg_7_0._tweenId)

		arg_7_0._tweenId = nil
	end

	local var_7_0 = recthelper.getWidth(arg_7_0._simagedialog.transform)
	local var_7_1 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local var_7_2 = 0.5 * (var_7_1 + var_7_0)
	local var_7_3 = arg_7_0._showTime
	local var_7_4 = var_7_2 - 0.2 * (var_7_1 + var_7_0) * arg_7_0._speed * var_7_3

	arg_7_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_7_2, var_7_4, var_7_3, arg_7_0._moveUpdate, arg_7_0._moveDone, arg_7_0, nil, EaseType.Linear)
end

function var_0_0._moveDone(arg_8_0)
	if arg_8_0._callback then
		arg_8_0._callback(arg_8_0._callbackObj)
	end

	TaskDispatcher.runDelay(arg_8_0._startMove, arg_8_0, 3)
end

function var_0_0.destroy(arg_9_0)
	if arg_9_0._tweenId then
		ZProj.TweenHelper.KillById(arg_9_0._tweenId)

		arg_9_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_9_0._startMove, arg_9_0)
	arg_9_0._simagedialog:UnLoadImage()
end

return var_0_0
