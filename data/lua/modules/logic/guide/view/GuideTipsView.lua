module("modules.logic.guide.view.GuideTipsView", package.seeall)

local var_0_0 = class("GuideTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._tipsGO = gohelper.findChild(arg_1_0.viewGO, "tips")
	arg_1_0._hasIconGO = gohelper.findChild(arg_1_0.viewGO, "tips/hasIcon")
	arg_1_0._noIconGO = gohelper.findChild(arg_1_0.viewGO, "tips/noIcon")
	arg_1_0._txtContent2 = gohelper.findChildText(arg_1_0.viewGO, "tips/noIcon/imgBg/go_normalcontent/txt_contentcn")
	arg_1_0._tipsTr = arg_1_0._tipsGO.transform
	arg_1_0._goHeroIcon = gohelper.findChild(arg_1_0.viewGO, "tips/hasIcon/icon")
	arg_1_0._goNormalContent = gohelper.findChild(arg_1_0.viewGO, "tips/hasIcon/go_normalcontent")
	arg_1_0._imgHero = gohelper.findChildSingleImage(arg_1_0.viewGO, "tips/hasIcon/icon/imgHero")
	arg_1_0._txtName1 = gohelper.findChildText(arg_1_0.viewGO, "tips/hasIcon/icon/nameBg/txtName")
	arg_1_0._txtName2 = gohelper.findChildText(arg_1_0.viewGO, "tips/noIcon/txtName")
	arg_1_0._iconGO = gohelper.findChild(arg_1_0.viewGO, "tips/hasIcon")
	arg_1_0._noIconGO = gohelper.findChild(arg_1_0.viewGO, "tips/noIcon")
	arg_1_0._hasIconBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "tips/hasIcon/imgBg")
	arg_1_0._root2DTrs = ViewMgr.instance:getTopUICanvas().transform
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:_updateUI()
	arg_2_0:_updateUIPos()
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.UpdateMaskView, arg_2_0._updateUIPos, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.SetMaskPosition, arg_2_0._setMaskCustomPos, arg_2_0)
	arg_2_0:_checkAddFrameUpdate()
end

function var_0_0.onUpdateParam(arg_3_0)
	arg_3_0:_updateUI()
	arg_3_0:_updateUIPos()
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.UpdateMaskView, arg_3_0._updateUIPos, arg_3_0)
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.SetMaskPosition, arg_3_0._setMaskCustomPos, arg_3_0)
	arg_3_0:_checkAddFrameUpdate()
end

function var_0_0._checkAddFrameUpdate(arg_4_0)
	if not gohelper.isNil(arg_4_0._targetTrs) then
		TaskDispatcher.runRepeat(arg_4_0._onFrameUpdate, arg_4_0, 0.01)
	else
		TaskDispatcher.cancelTask(arg_4_0._onFrameUpdate, arg_4_0)
	end
end

function var_0_0._onFrameUpdate(arg_5_0)
	if gohelper.isNil(arg_5_0._targetTrs) then
		return
	end

	local var_5_0 = arg_5_0._targetTrs.position
	local var_5_1 = var_5_0.x
	local var_5_2 = var_5_0.y

	if not arg_5_0._lastx or not arg_5_0._lasty or math.abs(var_5_1 - arg_5_0._lastx) > 0.001 or math.abs(var_5_2 - arg_5_0._lasty) > 0.001 then
		arg_5_0._lastx = var_5_1
		arg_5_0._lasty = var_5_2

		arg_5_0:_updateUIPos()
	end
end

function var_0_0._updateUI(arg_6_0)
	if not arg_6_0.viewParam then
		return
	end

	gohelper.setActive(arg_6_0._tipsGO, false)
	gohelper.setActive(arg_6_0._tipsGO, arg_6_0.viewParam.hasTips)

	if not arg_6_0.viewParam.hasTips then
		return
	end

	if arg_6_0._goPath ~= arg_6_0.viewParam.goPath then
		arg_6_0._targetGO = nil
	end

	arg_6_0._goPath = arg_6_0.viewParam.goPath
	arg_6_0._tipsPosX = arg_6_0.viewParam.tipsPos[1] or 0
	arg_6_0._tipsPosY = arg_6_0.viewParam.tipsPos[2] or 0

	if arg_6_0._hasIconDialogItem then
		arg_6_0._hasIconDialogItem:hideDialog()
		TaskDispatcher.cancelTask(arg_6_0._showHasIconDialog, arg_6_0)
	end

	local var_6_0 = string.gsub(arg_6_0.viewParam.tipsContent, " ", " ")

	arg_6_0._hasHeroIcon = not string.nilorempty(arg_6_0.viewParam.tipsHead)

	gohelper.setActive(arg_6_0._imgHero.gameObject, arg_6_0._hasHeroIcon)
	arg_6_0._hasIconBg:LoadImage(ResUrl.getFightBattleDialogBg("duihuak_002"))

	if arg_6_0._hasHeroIcon then
		if arg_6_0.viewParam.maskChangeAlpha then
			TaskDispatcher.runDelay(arg_6_0._showHasIconDialog, arg_6_0, 0.3)
		else
			arg_6_0:_showHasIconDialog()
		end

		arg_6_0._txtName1.text = arg_6_0.viewParam.tipsTalker

		arg_6_0._imgHero:LoadImage(ResUrl.getHeadIconSmall(arg_6_0.viewParam.tipsHead))
		recthelper.setAnchorX(arg_6_0._goHeroIcon.transform, arg_6_0.viewParam.tipsDir == 2 and 920 or 0)
		recthelper.setAnchorX(arg_6_0._goNormalContent.transform, arg_6_0.viewParam.tipsDir == 2 and 382 or 529.2)
	else
		arg_6_0._txtContent2.text = var_6_0
		arg_6_0._txtName2.text = arg_6_0.viewParam.tipsTalker
	end

	gohelper.setActive(arg_6_0._iconGO, arg_6_0._hasHeroIcon)
	gohelper.setActive(arg_6_0._noIconGO, not arg_6_0._hasHeroIcon)
end

function var_0_0._updateUIPos(arg_7_0)
	if not arg_7_0.viewParam then
		return
	end

	gohelper.setActive(arg_7_0._tipsGO, arg_7_0.viewParam.hasTips)

	if not arg_7_0.viewParam.hasTips then
		return
	end

	if not string.nilorempty(arg_7_0._goPath) and not arg_7_0._hasHeroIcon then
		arg_7_0:_updatePos()
	else
		recthelper.setAnchor(arg_7_0._tipsTr, arg_7_0._tipsPosX, arg_7_0._tipsPosY)
	end
end

function var_0_0._updatePos(arg_8_0)
	arg_8_0:initTargetGo()

	if not gohelper.isNil(arg_8_0._targetGO) then
		if arg_8_0._targetIs2D then
			local var_8_0 = ZProj.GuideMaskHole.CalculateRelativeRectTransformBounds(arg_8_0._root2DTrs, arg_8_0._targetTrs)
			local var_8_1 = arg_8_0._customCenterPos and arg_8_0._customCenterPos.x or var_8_0.center.x
			local var_8_2 = arg_8_0._customCenterPos and arg_8_0._customCenterPos.y or var_8_0.center.y

			recthelper.setAnchor(arg_8_0._tipsTr, var_8_1 + arg_8_0._tipsPosX, var_8_2 + arg_8_0._tipsPosY)
		else
			local var_8_3 = arg_8_0._customCenterPos and arg_8_0._customCenterPos.x or 0
			local var_8_4 = arg_8_0._customCenterPos and arg_8_0._customCenterPos.y or 0

			transformhelper.setLocalPosXY(arg_8_0._tipsTr, var_8_3 + arg_8_0._tipsPosX, var_8_4 + arg_8_0._tipsPosY)
		end
	end
end

function var_0_0._showHasIconDialog(arg_9_0)
	local var_9_0 = string.gsub(arg_9_0.viewParam.tipsContent, " ", " ")

	if not arg_9_0._hasIconDialogItem then
		arg_9_0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(arg_9_0._hasIconGO, TMPFadeIn)
	end

	arg_9_0._hasIconDialogItem:playNormalText(var_9_0)
end

function var_0_0.initTargetGo(arg_10_0)
	arg_10_0._targetGO = gohelper.find(arg_10_0._goPath)

	if arg_10_0._targetGO then
		arg_10_0._targetTrs = arg_10_0._targetGO.transform
		arg_10_0._targetIs2D = arg_10_0._targetGO:GetComponent("RectTransform") ~= nil
	end
end

function var_0_0._setMaskCustomPos(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 then
		local var_11_0 = CameraMgr.instance:getUICamera()
		local var_11_1 = CameraMgr.instance:getMainCamera()

		arg_11_1 = recthelper.worldPosToAnchorPos(arg_11_1, arg_11_0.viewGO.transform, var_11_0, var_11_1)
	end

	arg_11_0._customCenterPos = arg_11_1

	arg_11_0:_updateUIPos()
end

function var_0_0.onClose(arg_12_0)
	arg_12_0._imgHero:UnLoadImage()
	arg_12_0._hasIconBg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_12_0._showHasIconDialog, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._onFrameUpdate, arg_12_0)
end

return var_0_0
