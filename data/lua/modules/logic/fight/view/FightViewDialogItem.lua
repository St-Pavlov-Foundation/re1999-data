﻿module("modules.logic.fight.view.FightViewDialogItem", package.seeall)

local var_0_0 = class("FightViewDialogItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._fightViewDialog = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._gocontainer = gohelper.findChild(arg_2_1, "container")
	arg_2_0._simageicon = gohelper.findChildSingleImage(arg_2_1, "container/headframe/headicon")
	arg_2_0._goframe = gohelper.findChild(arg_2_1, "container/headframe")
	arg_2_0._goNormalContent = gohelper.findChild(arg_2_1, "container/go_normalcontent")
	arg_2_0._txtdialog = gohelper.findChildText(arg_2_1, "container/go_normalcontent/txt_contentcn")
	arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_1, "container/simagebg")
	arg_2_0._canvasGroup = arg_2_0._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function var_0_0.showDialogContent(arg_3_0, arg_3_1, arg_3_2)
	gohelper.setActive(arg_3_0._goframe, arg_3_1 ~= nil)
	gohelper.setActive(arg_3_0._simageicon.gameObject, arg_3_1 ~= nil)

	if arg_3_1 then
		if arg_3_0._simageicon.curImageUrl ~= arg_3_1 then
			arg_3_0._simageicon:UnLoadImage()
		end

		arg_3_0._simageicon:LoadImage(arg_3_1)
	end

	arg_3_0._txtdialog.text = arg_3_2.text

	arg_3_0._simagebg:LoadImage(ResUrl.getFightBattleDialogBg("duihuak_002"))

	if not arg_3_0._tmpFadeIn then
		arg_3_0._tmpFadeIn = MonoHelper.addLuaComOnceToGo(arg_3_0._gocontainer, TMPFadeIn)
	end

	arg_3_0._tmpFadeIn:playNormalText(arg_3_2.text)
	recthelper.setAnchorX(arg_3_0._goframe.transform, arg_3_2.tipsDir == 2 and 920 or 0)
	recthelper.setAnchorX(arg_3_0._goNormalContent.transform, arg_3_2.tipsDir == 2 and 382 or 529.2)

	local var_3_0 = arg_3_2.tipsDir == 2 and Vector2(1, 1) or Vector2(0, 1)

	arg_3_0.go.transform.anchorMin = var_3_0
	arg_3_0.go.transform.anchorMax = var_3_0

	recthelper.setAnchorX(arg_3_0.go.transform, arg_3_2.tipsDir == 2 and -1100 or 208.6)
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0._tmpFadeIn = nil

	arg_4_0._simageicon:UnLoadImage()
	arg_4_0._simagebg:UnLoadImage()
end

return var_0_0
