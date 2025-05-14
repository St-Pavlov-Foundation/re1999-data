module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleRightItem", package.seeall)

local var_0_0 = class("AergusiDialogRoleRightItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._resPath = arg_1_2
	arg_1_0._golight = gohelper.findChild(arg_1_1, "light")
	arg_1_0._gochess = gohelper.findChild(arg_1_1, "#chessitem")
	arg_1_0._simagechess = gohelper.findChildSingleImage(arg_1_1, "#chessitem/#chess")
	arg_1_0._gotalk = gohelper.findChild(arg_1_1, "go_talking")
	arg_1_0._gobubble = gohelper.findChild(arg_1_1, "go_bubble")
	arg_1_0._gospeakbubble = gohelper.findChild(arg_1_1, "go_bubble/go_speakbubble")
	arg_1_0._txtspeakbubbledesc = gohelper.findChildText(arg_1_1, "go_bubble/go_speakbubble/txt_dec")
	arg_1_0._gothinkbubble = gohelper.findChild(arg_1_1, "go_bubble/go_thinkbubble")
	arg_1_0._txtthinkbubbledesc = gohelper.findChildText(arg_1_1, "go_bubble/go_thinkbubble/txt_dec")
	arg_1_0._goemo = gohelper.findChild(arg_1_1, "emobg")
	arg_1_0._chessAni = arg_1_0._gochess:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_1_0.go, true)
	gohelper.setActive(arg_1_0._golight, false)
	gohelper.setActive(arg_1_0._gotalk, false)
	gohelper.setActive(arg_1_0._gobubble, false)
	gohelper.setActive(arg_1_0._goemo, false)
	arg_1_0._simagechess:LoadImage(ResUrl.getV2a1AergusiSingleBg(arg_1_0._resPath))
end

function var_0_0.showTalking(arg_2_0)
	arg_2_0._chessAni:Play("jump", 0, 0)
	gohelper.setActive(arg_2_0._golight, true)
	gohelper.setActive(arg_2_0._gotalk, true)
	TaskDispatcher.runDelay(arg_2_0.hideTalking, arg_2_0, 3)
end

function var_0_0.hideTalking(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.hideTalking, arg_3_0)
	gohelper.setActive(arg_3_0._gotalk, false)
	gohelper.setActive(arg_3_0._golight, false)
end

function var_0_0.showEmo(arg_4_0)
	gohelper.setActive(arg_4_0._goemo, true)
end

function var_0_0.showBubble(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._gobubble, true)

	if arg_5_1.bubbleType == AergusiEnum.DialogBubbleType.Speaker then
		gohelper.setActive(arg_5_0._gospeakbubble, true)
		gohelper.setActive(arg_5_0._gothinkbubble, false)

		arg_5_0._txtspeakbubbledesc.text = arg_5_1.content
	else
		gohelper.setActive(arg_5_0._gothinkbubble, true)
		gohelper.setActive(arg_5_0._gospeakbubble, false)

		arg_5_0._txtthinkbubbledesc.text = arg_5_1.content
	end
end

function var_0_0.hideBubble(arg_6_0)
	gohelper.setActive(arg_6_0._gobubble, false)
end

function var_0_0.destroy(arg_7_0)
	arg_7_0._simagechess:UnLoadImage()
end

return var_0_0
