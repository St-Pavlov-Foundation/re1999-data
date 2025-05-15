module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErEventItem", package.seeall)

local var_0_0 = class("MoLiDeErEventItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._imagePoint = gohelper.findChildImage(arg_1_0.viewGO, "#image_Point")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "#image_Icon")
	arg_1_0._imageStar = gohelper.findChildImage(arg_1_0.viewGO, "#image_Star")
	arg_1_0._imageLine = gohelper.findChildImage(arg_1_0.viewGO, "#image_Line")
	arg_1_0._imagePointFinish = gohelper.findChildImage(arg_1_0.viewGO, "#image_Pointfinish")
	arg_1_0._imageIconFinish = gohelper.findChildImage(arg_1_0.viewGO, "#image_Iconfinish")
	arg_1_0._imageStarFinish = gohelper.findChildImage(arg_1_0.viewGO, "#image_Starfinish")
	arg_1_0._imageLineFinish = gohelper.findChildImage(arg_1_0.viewGO, "#image_Linefinish")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#txt_Num")
	arg_1_0._simageHead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Dispatch/image_HeadBG/image/#simage_Head")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "#go_Dispatch/#txt_Time")
	arg_1_0._goDispatch = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch")
	arg_1_0._btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Detail")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._animator = gohelper.findChildComponent(arg_2_0.viewGO, "", gohelper.Type_Animator)
	arg_2_0._roleAnimator = gohelper.findChildComponent(arg_2_0.viewGO, "#go_Dispatch", gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnDetail:AddClickListener(arg_3_0.onDetailClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnDetail:RemoveClickListener()
end

function var_0_0.onDetailClick(arg_5_0)
	local var_5_0 = MoLiDeErGameModel.instance:getSelectEventId()
	local var_5_1 = arg_5_0._eventId

	if var_5_0 == var_5_1 then
		return
	end

	MoLiDeErGameModel.instance:setSelectEventId(var_5_1)
end

function var_0_0.setData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	arg_6_0._eventId = arg_6_1
	arg_6_0._isChose = arg_6_2
	arg_6_0._currentRound = arg_6_4
	arg_6_0._eventEndRound = arg_6_3
	arg_6_0._teamId = arg_6_5

	arg_6_0:refreshUI(arg_6_6)
end

function var_0_0.setActive(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0.viewGO, arg_7_1)
end

function var_0_0.showAnim(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2 and 0 or 1

	arg_8_0._animator:Play(arg_8_1, 0, var_8_0)
end

function var_0_0.showRoleAnim(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2 and 0 or 1

	arg_9_0._roleAnimator:Play(arg_9_1, 0, var_9_0)
end

function var_0_0.refreshUI(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._isChose
	local var_10_1 = arg_10_0._eventEndRound
	local var_10_2 = arg_10_0._currentRound
	local var_10_3 = var_10_1 ~= 0 and var_10_1 <= var_10_2
	local var_10_4 = var_10_0 and var_10_2 < var_10_1 and arg_10_0._teamId ~= nil and arg_10_0._teamId ~= 0
	local var_10_5 = MoLiDeErGameModel.instance:getCurGameInfo()
	local var_10_6 = arg_10_1 and var_10_5.newBackTeamEventDic[arg_10_0._eventId] and not var_10_4
	local var_10_7 = var_10_3 and MoLiDeErEnum.EventState.Complete or MoLiDeErEnum.EventState.Unlock
	local var_10_8 = tostring(var_10_7)
	local var_10_9 = tostring(MoLiDeErEnum.EventState.Complete)
	local var_10_10 = MoLiDeErConfig.instance:getEventConfig(arg_10_0._eventId)

	UISpriteSetMgr.instance:setMoLiDeErSprite(arg_10_0._imageIcon, string.format("v2a8_molideer_game_stage_%s_%s", var_10_10.eventType, var_10_8))
	UISpriteSetMgr.instance:setMoLiDeErSprite(arg_10_0._imageStar, "v2a8_molideer_game_stage_star_" .. var_10_8)
	UISpriteSetMgr.instance:setMoLiDeErSprite(arg_10_0._imageLine, "v2a8_molideer_game_stage_line_" .. var_10_8)
	UISpriteSetMgr.instance:setMoLiDeErSprite(arg_10_0._imagePoint, "v2a8_molideer_game_stage_point_" .. var_10_8)

	if var_10_3 then
		UISpriteSetMgr.instance:setMoLiDeErSprite(arg_10_0._imageIconFinish, string.format("v2a8_molideer_game_stage_%s_%s", var_10_10.eventType, var_10_9))
		UISpriteSetMgr.instance:setMoLiDeErSprite(arg_10_0._imageStarFinish, "v2a8_molideer_game_stage_star_" .. var_10_9)
		UISpriteSetMgr.instance:setMoLiDeErSprite(arg_10_0._imageLineFinish, "v2a8_molideer_game_stage_line_" .. var_10_9)
		UISpriteSetMgr.instance:setMoLiDeErSprite(arg_10_0._imagePointFinish, "v2a8_molideer_game_stage_point_" .. var_10_9)
	end

	gohelper.setActive(arg_10_0._imageIconFinish.gameObject, var_10_3)
	gohelper.setActive(arg_10_0._imageStarFinish.gameObject, var_10_3)
	gohelper.setActive(arg_10_0._imageLineFinish.gameObject, var_10_3)
	gohelper.setActive(arg_10_0._imagePointFinish.gameObject, var_10_3)

	local var_10_11
	local var_10_12

	if var_10_4 then
		var_10_11 = MoLiDeErEnum.EventTitleColor.Dispatching
		var_10_12 = MoLiDeErEnum.EventBgColor.Dispatching
	else
		var_10_11 = var_10_3 and MoLiDeErEnum.EventTitleColor.Complete or MoLiDeErEnum.EventTitleColor.NoComplete
		var_10_12 = MoLiDeErEnum.EventBgColor.Normal
	end

	UIColorHelper.set(arg_10_0._imageIcon, var_10_12)

	local var_10_13 = MoLiDeErModel.instance:getCurActId()
	local var_10_14 = MoLiDeErEnum.EventName[var_10_10.eventType]
	local var_10_15 = MoLiDeErConfig.instance:getConstConfig(var_10_13, var_10_14)
	local var_10_16 = GameUtil.getSubPlaceholderLuaLangOneParam(var_10_15.value2, var_10_10.number)

	arg_10_0._txtNum.text = string.format("<color=%s>%s</color>", var_10_11, var_10_16)
	arg_10_0.viewGO.name = var_10_10.eventId

	gohelper.setActive(arg_10_0._goDispatch, not var_10_3 and var_10_4 or var_10_6)

	local var_10_17 = string.splitToNumber(var_10_10.position, "#")

	transformhelper.setLocalPosXY(arg_10_0.viewGO.transform, var_10_17[1], var_10_17[2])
	arg_10_0:showAnim(MoLiDeErEnum.AnimName.GameViewEventItemOpen, false)

	if not var_10_4 and not var_10_6 then
		return
	end

	local var_10_18
	local var_10_19
	local var_10_20 = var_10_4 and MoLiDeErEnum.AnimName.GameViewEventRoleIn or MoLiDeErEnum.AnimName.GameViewEventRoleOut

	if var_10_4 then
		var_10_19 = var_10_1 - var_10_2
		var_10_18 = arg_10_0._teamId
	elseif var_10_6 then
		var_10_18 = var_10_5.newBackTeamEventDic[arg_10_0._eventId]
		arg_10_0._txtTime.text = tostring(var_10_19)
	end

	arg_10_0._txtTime.text = tostring(var_10_19)

	local var_10_21 = MoLiDeErConfig.instance:getTeamConfig(var_10_18)

	if not string.nilorempty(var_10_21.picture) then
		arg_10_0._simageHead:LoadImage(var_10_21.picture, MoLiDeErHelper.handleImage, {
			imgTransform = arg_10_0._simageHead.transform,
			offsetParam = var_10_21.iconOffset
		})
	end

	arg_10_0:showRoleAnim(var_10_20, arg_10_1)
end

function var_0_0.onDestroy(arg_11_0)
	return
end

return var_0_0
