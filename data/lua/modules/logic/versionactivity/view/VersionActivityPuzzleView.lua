module("modules.logic.versionactivity.view.VersionActivityPuzzleView", package.seeall)

local var_0_0 = class("VersionActivityPuzzleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goclose = gohelper.findChild(arg_1_0.viewGO, "#go_close")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#simage_bg/#txt_title")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "#simage_bg/Scroll View/Viewport/Content/#txt_info")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_options")
	arg_1_0._gooptionitem = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_options/#go_optionitem")
	arg_1_0._godragoptionitem = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_dragoptionitem")
	arg_1_0._goadsorbrect = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_adsorbrect")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._txtgamename = gohelper.findChildText(arg_1_0.viewGO, "#simage_bg/#txt_gamename")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.AnswerAnchorPosDict = {
	[1101] = Vector2(-58.7, 115.3),
	[1102] = Vector2(19, 116.3),
	[1103] = Vector2(-83.34, 76.9)
}
var_0_0.OneCharacterWidth = 30
var_0_0.FingerAnswerOffsetX = 77
var_0_0.FingerAnswerOffsetY = -160
var_0_0.FingerOptionOffsetX = 150
var_0_0.FingerOptionOffsetY = -250
var_0_0.AbsorbOffsetX = 20
var_0_0.AbsorbOffsetY = 10
var_0_0.SpritePlaceholder = 10

function var_0_0.closeViewOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goGuide = gohelper.findChild(arg_5_0.viewGO, "guide_activitypuzzle")

	gohelper.setActive(arg_5_0._godragoptionitem, false)
	gohelper.setActive(arg_5_0._goadsorbrect, false)

	arg_5_0.goAdsorbSuccess = gohelper.findChild(arg_5_0.viewGO, "#simage_bg/#go_adsorbrect/success")
	arg_5_0.goAdsorbFail = gohelper.findChild(arg_5_0.viewGO, "#simage_bg/#go_adsorbrect/fail")

	arg_5_0:resetAdsorbEffect()

	arg_5_0.goGuideAnimationContainer = gohelper.findChild(arg_5_0.viewGO, "guide_activitypuzzle/guide1")
	arg_5_0.goGuideAnimator = arg_5_0.goGuideAnimationContainer:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0.goAnswerRect = gohelper.findChild(arg_5_0.viewGO, "guide_activitypuzzle/guide1/kuang1")
	arg_5_0.goOptionRect = gohelper.findChild(arg_5_0.viewGO, "guide_activitypuzzle/guide1/kuang2")
	arg_5_0.goFinger = gohelper.findChild(arg_5_0.viewGO, "guide_activitypuzzle/guide1/shouzhi")
	arg_5_0.rectTransformAnswer = arg_5_0.goAnswerRect.transform
	arg_5_0.rectTransformOption = arg_5_0.goOptionRect.transform
	arg_5_0.rectTransformFinger = arg_5_0.goFinger.transform

	arg_5_0:initDragOptionItem()
	arg_5_0:initTextScrollViewScenePosRect()
	gohelper.setActive(arg_5_0._gofinish, false)

	arg_5_0.bgHalfWidth = recthelper.getWidth(arg_5_0._simagebg.transform) / 2
	arg_5_0.bgHalfHeight = recthelper.getHeight(arg_5_0._simagebg.transform) / 2
	arg_5_0.closeViewClick = gohelper.getClick(arg_5_0._goclose)

	arg_5_0.closeViewClick:AddClickListener(arg_5_0.closeViewOnClick, arg_5_0)

	arg_5_0.optionItemList = {}
	arg_5_0.answerExistOptionItemDict = {}
	arg_5_0.needAnswerList = {}
	arg_5_0.answerMatched = false
end

function var_0_0.initDragOptionItem(arg_6_0)
	arg_6_0.dragOptionItem = arg_6_0:getUserDataTb_()
	arg_6_0.dragOptionItem.go = arg_6_0._godragoptionitem
	arg_6_0.dragOptionItem.txtInfo = gohelper.findChildText(arg_6_0.dragOptionItem.go, "info")
	arg_6_0.dragOptionItem.transform = arg_6_0.dragOptionItem.go.transform
end

function var_0_0.initTextScrollViewScenePosRect(arg_7_0)
	arg_7_0.goScroll = gohelper.findChild(arg_7_0.viewGO, "#simage_bg/Scroll View")

	local var_7_0 = arg_7_0.goScroll.transform:GetWorldCorners()
	local var_7_1 = var_7_0[0]
	local var_7_2 = var_7_0[1]
	local var_7_3 = var_7_0[2]
	local var_7_4 = var_7_0[3]

	arg_7_0.textScrollScenePosRect = {
		var_7_1,
		var_7_2,
		var_7_3,
		var_7_4
	}
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.isFinish = arg_9_0.viewParam.isFinish
	arg_9_0.elementCo = arg_9_0.viewParam.elementCo
	arg_9_0.puzzleId = tonumber(arg_9_0.elementCo.param)
	arg_9_0.puzzleConfig = lua_version_activity_puzzle_question.configDict[arg_9_0.puzzleId]
	arg_9_0._txtgamename.text = arg_9_0.puzzleConfig.tittle

	if arg_9_0.puzzleConfig == nil then
		logError(string.format("not found puzzleId : %s, elementId : %s", arg_9_0.puzzleId, arg_9_0.elementCo.id))
		arg_9_0:closeThis()

		return
	end

	arg_9_0.options, arg_9_0.maxAnswerLenList = arg_9_0:buildOptions(arg_9_0.puzzleConfig.answer)
	arg_9_0.halfAnsWerHeight = recthelper.getHeight(arg_9_0._goadsorbrect.transform) * 0.5

	if arg_9_0.isFinish then
		arg_9_0:refreshFinishStatus()
	else
		arg_9_0:refreshNormalStatus()
	end
end

function var_0_0.refreshFinishStatus(arg_10_0)
	local var_10_0 = arg_10_0._gofinish:GetComponent(typeof(UnityEngine.Animator))

	if var_10_0 then
		var_10_0.enabled = false
	end

	gohelper.setActive(arg_10_0._gofinish, true)

	arg_10_0.showText = arg_10_0:buildFinishText(arg_10_0.puzzleConfig.text)

	arg_10_0:onTextInfoChange()
	arg_10_0:refreshOptions()
end

function var_0_0.refreshNormalStatus(arg_11_0)
	arg_11_0.showText = arg_11_0:buildText(arg_11_0.puzzleConfig.text)

	arg_11_0:onTextInfoChange()
	arg_11_0:refreshOptions()

	local var_11_0 = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LeiMiTeBeiEnteredPuzzleViewKey), 0) == 0

	gohelper.setActive(arg_11_0._goGuide, false)

	if var_11_0 then
		UIBlockMgr.instance:startBlock(arg_11_0.viewName .. "PlayGuideAnimation")
		TaskDispatcher.runDelay(arg_11_0.showGuide, arg_11_0, 0.7)
	end
end

function var_0_0.showGuide(arg_12_0)
	UIBlockMgr.instance:endBlock(arg_12_0.viewName .. "PlayGuideAnimation")
	gohelper.setActive(arg_12_0._goGuide, true)
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LeiMiTeBeiEnteredPuzzleViewKey), 1)

	arg_12_0.guideBlock = gohelper.findChild(arg_12_0.viewGO, "guide_activitypuzzle/guide_block")
	arg_12_0.guideClick = gohelper.getClick(arg_12_0.guideBlock)

	arg_12_0.guideClick:AddClickListener(arg_12_0.onClickGuideGo, arg_12_0)

	local var_12_0 = var_0_0.AnswerAnchorPosDict[arg_12_0.puzzleId]

	recthelper.setWidth(arg_12_0.rectTransformAnswer, arg_12_0:getAnswerWidth(1))
	recthelper.setAnchor(arg_12_0.rectTransformAnswer, var_12_0.x, var_12_0.y)

	local var_12_1 = arg_12_0.optionItemList[arg_12_0.firstAnswerIndex]:getScreenPos()

	arg_12_0.optionAnchor = recthelper.screenPosToAnchorPos(var_12_1, arg_12_0.rectTransformOption.parent)

	recthelper.setAnchor(arg_12_0.rectTransformOption, arg_12_0.optionAnchor.x, arg_12_0.optionAnchor.y)
	arg_12_0.goGuideAnimator:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(arg_12_0.playGuideAnimation, arg_12_0, 1)
end

function var_0_0.playGuideAnimation(arg_13_0)
	if arg_13_0.tweenId then
		ZProj.TweenHelper.KillById(arg_13_0.tweenId)
	end

	recthelper.setAnchor(arg_13_0.rectTransformFinger, arg_13_0.optionAnchor.x + var_0_0.FingerOptionOffsetX, arg_13_0.optionAnchor.y + var_0_0.FingerOptionOffsetY)

	local var_13_0 = var_0_0.AnswerAnchorPosDict[arg_13_0.puzzleId]

	arg_13_0.tweenId = ZProj.TweenHelper.DOAnchorPos(arg_13_0.rectTransformFinger, var_13_0.x + var_0_0.FingerAnswerOffsetX, var_13_0.y + var_0_0.FingerAnswerOffsetY, 1.667, arg_13_0.playGuideAnimation, arg_13_0)

	arg_13_0.goGuideAnimator:Play(UIAnimationName.Loop, 0, 0)
end

function var_0_0.stopGuideAnimation(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.playGuideAnimation, arg_14_0)

	if arg_14_0.tweenId then
		ZProj.TweenHelper.KillById(arg_14_0.tweenId)
	end

	arg_14_0.goGuideAnimator.enabled = false
end

function var_0_0.onTextInfoChange(arg_15_0)
	arg_15_0._txtinfo.text = arg_15_0.showText
end

function var_0_0.buildOptions(arg_16_0, arg_16_1)
	arg_16_1 = string.trim(arg_16_1)

	local var_16_0 = 0
	local var_16_1
	local var_16_2 = {}
	local var_16_3 = {}

	for iter_16_0, iter_16_1 in ipairs(string.split(arg_16_1, "|")) do
		local var_16_4 = string.split(iter_16_1, "#")[2]

		var_16_0 = Mathf.Max(var_16_0, GameUtil.utf8len(var_16_4))

		if iter_16_0 % 4 == 0 then
			if var_16_0 % 2 ~= 0 then
				var_16_0 = var_16_0 + 1
			end

			var_16_0 = var_16_0 + 1

			table.insert(var_16_3, var_16_0)

			var_16_0 = 0
		end

		table.insert(var_16_2, var_16_4)
	end

	return var_16_2, var_16_3
end

function var_0_0.buildText(arg_17_0, arg_17_1)
	arg_17_0.placeholderDict = {}

	local var_17_0 = 0

	for iter_17_0 in string.gmatch(arg_17_1, "{(%d+)}") do
		local var_17_1 = tonumber(iter_17_0)

		table.insert(arg_17_0.needAnswerList, var_17_1)

		var_17_0 = var_17_0 + 1

		arg_17_0:buildPlaceholder(var_17_1, var_17_0)

		arg_17_1 = string.gsub(arg_17_1, "{(%d+)}", arg_17_0:addUnderlineTag(string.format("<link=%s>%s</link>", "%1", arg_17_0.placeholderDict[var_17_1])), 1)
	end

	arg_17_0.firstAnswerIndex = arg_17_0.needAnswerList[1]

	return arg_17_1
end

function var_0_0.buildFinishText(arg_18_0, arg_18_1)
	for iter_18_0 in string.gmatch(arg_18_1, "{(%d+)}") do
		iter_18_0 = tonumber(iter_18_0)
		arg_18_1 = string.gsub(arg_18_1, "{(%d+)}", arg_18_0:addUnderlineTag(string.format("<color=%s>%s</color>", VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor, arg_18_0.options[iter_18_0])), 1)
	end

	return arg_18_1
end

function var_0_0.addUnderlineTag(arg_19_0, arg_19_1)
	return string.format("<u>%s</u>", arg_19_1)
end

function var_0_0.buildPlaceholder(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0.placeholderDict[arg_20_1] then
		return
	end

	local var_20_0 = arg_20_0.maxAnswerLenList[arg_20_2]
	local var_20_1 = math.floor((var_20_0 - 1) / 2)
	local var_20_2 = string.rep(luaLang("lei_mi_te_bei_placeholder"), var_20_1)
	local var_20_3 = var_20_2

	arg_20_0.placeholderDict[arg_20_1] = var_20_2 .. string.format("<sprite name=\"num%s\">", arg_20_2) .. var_20_3
end

function var_0_0.refreshOptions(arg_21_0)
	local var_21_0

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.options) do
		local var_21_1 = arg_21_0.optionItemList[iter_21_0]

		if not var_21_1 then
			var_21_1 = arg_21_0:createOptionItem()

			table.insert(arg_21_0.optionItemList, var_21_1)
		end

		var_21_1:updateInfo(iter_21_1, iter_21_0)
	end

	for iter_21_2 = #arg_21_0.options + 1, #arg_21_0.optionItemList do
		arg_21_0.optionItemList[iter_21_2]:hide()
	end
end

function var_0_0.createOptionItem(arg_22_0)
	local var_22_0 = VersionActivityPuzzleOptionItem.New()

	var_22_0:onInitView(gohelper.cloneInPlace(arg_22_0._gooptionitem), arg_22_0)

	return var_22_0
end

function var_0_0.onDragItemDragBegin(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_0.complete or arg_23_0.isFinish then
		return
	end

	gohelper.setActive(arg_23_0.dragOptionItem.go, true)

	arg_23_0.dragOptionItem.txtInfo.text = arg_23_2
	arg_23_0.draggingAnswerIndex = arg_23_3

	arg_23_0:changeDragItemAnchor(arg_23_1)
	arg_23_0:calculateLinksRectAnchor()
	arg_23_0:resetAdsorbEffect()
end

function var_0_0.onDragItemDragging(arg_24_0, arg_24_1)
	if arg_24_0.complete or arg_24_0.isFinish then
		return
	end

	arg_24_0:changeDragItemAnchor(arg_24_1)
end

function var_0_0.onDragItemDragEnd(arg_25_0, arg_25_1)
	if arg_25_0.complete or arg_25_0.isFinish then
		return
	end

	TaskDispatcher.cancelTask(arg_25_0.showEndEffect, arg_25_0)
	arg_25_0:changeDragItemAnchor(arg_25_1)

	local var_25_0 = arg_25_0:getShowAdsorbRectAnswerIndex()

	if var_25_0 > 0 then
		local var_25_1 = arg_25_0.answerExistOptionItemDict[var_25_0]

		arg_25_0.hoverAnswerIndex = var_25_0

		if not var_25_1 or var_25_1.answerIndex ~= arg_25_0.draggingAnswerIndex then
			if var_25_1 then
				var_25_1:unUse()
			end

			arg_25_0:resetGroupAnswerOption(arg_25_0:getAnswerGroupIndex(arg_25_0.draggingAnswerIndex))

			local var_25_2 = arg_25_0.optionItemList[arg_25_0.draggingAnswerIndex]

			arg_25_0.answerExistOptionItemDict[var_25_0] = var_25_2

			local var_25_3 = arg_25_0.options[arg_25_0.draggingAnswerIndex]
			local var_25_4

			if var_25_0 == arg_25_0.draggingAnswerIndex then
				var_25_2:matchCorrect()

				var_25_4 = VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor
			else
				var_25_2:matchError()

				var_25_4 = VersionActivityEnum.PuzzleColorEnum.MatchErrorColor
			end

			local var_25_5 = string.format("<color=%s>%s</color>", var_25_4, arg_25_0:getAnswerText(var_25_3, var_25_0))

			arg_25_0.showText = string.gsub(arg_25_0.showText, string.format("<link=%s>.-</link>", var_25_0), string.format("<link=%s>%s</link>", var_25_0, var_25_5))

			arg_25_0:onTextInfoChange()
			arg_25_0:checkComplete()
			TaskDispatcher.runDelay(arg_25_0.showEndEffect, arg_25_0, 0.1)
		end
	end

	gohelper.setActive(arg_25_0.dragOptionItem.go, false)
end

function var_0_0.showEndEffect(arg_26_0)
	if not arg_26_0.hoverAnswerIndex or arg_26_0.hoverAnswerIndex <= 0 then
		return
	end

	local var_26_0 = arg_26_0.hoverAnswerIndex == arg_26_0.draggingAnswerIndex

	if var_26_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_correct)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_incorrect)
	end

	arg_26_0:calculateLinksRectAnchor()

	local var_26_1 = arg_26_0.answerToAnchorPosDict[arg_26_0.hoverAnswerIndex][1]

	recthelper.setAnchor(arg_26_0._goadsorbrect.transform, var_26_1.x, var_26_1.y)
	gohelper.setActive(arg_26_0._goadsorbrect, true)
	gohelper.setActive(arg_26_0.goAdsorbSuccess, var_26_0)
	gohelper.setActive(arg_26_0.goAdsorbFail, not var_26_0)
	TaskDispatcher.runDelay(arg_26_0.hideAdsorb, arg_26_0, 1)
end

function var_0_0.hideAdsorb(arg_27_0)
	gohelper.setActive(arg_27_0._goadsorbrect, false)
	arg_27_0:resetAdsorbEffect()
end

function var_0_0.resetGroupAnswerOption(arg_28_0, arg_28_1)
	local var_28_0 = (arg_28_1 - 1) * 4 + 1
	local var_28_1
	local var_28_2

	for iter_28_0 = var_28_0, var_28_0 + 3 do
		local var_28_3 = arg_28_0.optionItemList[iter_28_0]
		local var_28_4 = arg_28_0:getBeUsedAnswerByOptionItem(var_28_3)

		if var_28_4 > 0 then
			var_28_3:unUse()

			arg_28_0.showText = string.gsub(arg_28_0.showText, string.format("<link=%s>.-</link>", var_28_4), string.format("<link=%s>%s</link>", var_28_4, arg_28_0.placeholderDict[var_28_4]))
			arg_28_0.answerExistOptionItemDict[var_28_4] = nil
		end
	end
end

function var_0_0.getBeUsedAnswerByOptionItem(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.answerExistOptionItemDict) do
		if iter_29_1.answerIndex == arg_29_1.answerIndex then
			return iter_29_0
		end
	end

	return -1
end

function var_0_0.getAnswerText(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = GameUtil.utf8len(arg_30_1)
	local var_30_1 = arg_30_0.maxAnswerLenList[arg_30_0:getAnswerGroupIndex(arg_30_2)] - var_30_0

	if var_30_1 <= 0 then
		return arg_30_1
	end

	return string.format("%s%s%s", string.rep("<nbsp>", var_30_1), arg_30_1, string.rep("<nbsp>", var_30_1))
end

function var_0_0.changeDragItemAnchor(arg_31_0, arg_31_1)
	local var_31_0 = recthelper.screenPosToAnchorPos(arg_31_1.position, arg_31_0._simagebg.transform)
	local var_31_1 = var_31_0.x
	local var_31_2 = var_31_0.y

	if var_31_1 > 0 then
		var_31_1 = Mathf.Min(arg_31_0.bgHalfWidth, var_31_1)
	else
		var_31_1 = Mathf.Max(-arg_31_0.bgHalfWidth, var_31_1)
	end

	if var_31_2 > 0 then
		var_31_2 = Mathf.Min(arg_31_0.bgHalfHeight, var_31_2)
	else
		var_31_2 = Mathf.Max(-arg_31_0.bgHalfHeight, var_31_2)
	end

	arg_31_0.dragOptionAnchor = Vector2.New(var_31_1, var_31_2)

	recthelper.setAnchor(arg_31_0.dragOptionItem.transform, var_31_1, var_31_2)
end

function var_0_0.getDraggingOptionItemBeUsedAnswer(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.answerExistOptionItemDict) do
		if arg_32_0.draggingAnswerIndex == iter_32_1.answerIndex then
			return iter_32_0
		end
	end

	return -1
end

function var_0_0.checkComplete(arg_33_0)
	if arg_33_0:isComplete() then
		arg_33_0:onComplete()
	end
end

function var_0_0.isComplete(arg_34_0)
	local var_34_0

	for iter_34_0, iter_34_1 in pairs(arg_34_0.needAnswerList) do
		local var_34_1 = arg_34_0.answerExistOptionItemDict[iter_34_1]

		if not var_34_1 or iter_34_1 ~= var_34_1.answerIndex then
			return false
		end
	end

	return true
end

function var_0_0.onComplete(arg_35_0)
	arg_35_0.complete = true

	DungeonRpc.instance:sendPuzzleFinishRequest(arg_35_0.elementCo.id)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(arg_35_0._gofinish, true)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)
end

function var_0_0.onClickGuideGo(arg_36_0)
	arg_36_0:stopGuideAnimation()
	gohelper.setActive(arg_36_0._goGuide, false)
	arg_36_0.guideClick:RemoveClickListener()

	arg_36_0.guideClick = nil
end

function var_0_0.calculateLinksRectAnchor(arg_37_0)
	arg_37_0.answerToAnchorPosDict = {}

	local var_37_0 = arg_37_0._txtinfo.transform
	local var_37_1 = arg_37_0._txtinfo:GetComponent(typeof(TMPro.TMP_Text))
	local var_37_2 = var_37_1.textInfo.linkInfo
	local var_37_3 = var_37_1.textInfo.characterInfo
	local var_37_4
	local var_37_5
	local var_37_6 = var_37_2:GetEnumerator()

	while var_37_6:MoveNext() do
		local var_37_7 = var_37_6.Current
		local var_37_8 = tonumber(var_37_7:GetLinkID())
		local var_37_9 = var_37_3[var_37_7.linkTextfirstCharacterIndex]
		local var_37_10 = var_37_0:TransformPoint(Vector3.New(var_37_9.bottomLeft.x, var_37_9.descender, 0))

		if var_37_7.linkTextLength == 1 then
			local var_37_11 = var_37_0:TransformPoint(Vector3.New(var_37_9.topRight.x, var_37_9.ascender, 0))

			arg_37_0:addCenterPos(var_37_8, var_37_10, var_37_11)
		else
			local var_37_12 = var_37_3[var_37_7.linkTextfirstCharacterIndex + var_37_7.linkTextLength - 1]

			if var_37_9.lineNumber == var_37_12.lineNumber then
				local var_37_13 = var_37_0:TransformPoint(Vector3.New(var_37_12.topRight.x, var_37_12.ascender, 0))

				arg_37_0:addCenterPos(var_37_8, var_37_10, var_37_13)
			else
				local var_37_14 = var_37_0:TransformPoint(Vector3.New(var_37_9.topRight.x, var_37_9.ascender, 0))
				local var_37_15 = var_37_9.lineNumber

				for iter_37_0 = 1, var_37_7.linkTextLength - 1 do
					local var_37_16 = var_37_3[var_37_7.linkTextfirstCharacterIndex + iter_37_0]
					local var_37_17 = var_37_16.lineNumber

					if var_37_17 == var_37_15 then
						var_37_14 = var_37_0:TransformPoint(Vector3.New(var_37_16.topRight.x, var_37_16.ascender, 0))
					else
						arg_37_0:addCenterPos(var_37_8, var_37_10, var_37_14)

						var_37_15 = var_37_17
						var_37_10 = var_37_0:TransformPoint(Vector3.New(var_37_16.bottomLeft.x, var_37_16.descender, 0))
						var_37_14 = var_37_0:TransformPoint(Vector3.New(var_37_16.topRight.x, var_37_16.ascender, 0))
					end
				end

				arg_37_0:addCenterPos(var_37_8, var_37_10, var_37_14)
			end
		end
	end
end

function var_0_0.addCenterPos(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = (arg_38_2 + arg_38_3) * 0.5

	if arg_38_0:checkScenePosIsValid(var_38_0) then
		if not arg_38_0.answerToAnchorPosDict[arg_38_1] then
			arg_38_0.answerToAnchorPosDict[arg_38_1] = {}
		end

		table.insert(arg_38_0.answerToAnchorPosDict[arg_38_1], recthelper.worldPosToAnchorPos(var_38_0, arg_38_0._goadsorbrect.transform.parent, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUICamera()))
	end
end

function var_0_0.getShowAdsorbRectAnswerIndex(arg_39_0)
	local var_39_0 = 0
	local var_39_1 = 99999

	for iter_39_0, iter_39_1 in pairs(arg_39_0.answerToAnchorPosDict) do
		local var_39_2 = arg_39_0:getAnswerWidth(arg_39_0:getAnswerGroupIndex(iter_39_0)) / 2

		for iter_39_2, iter_39_3 in ipairs(iter_39_1) do
			if arg_39_0.dragOptionAnchor.x >= iter_39_3.x - (var_39_2 + var_0_0.AbsorbOffsetX) and arg_39_0.dragOptionAnchor.x <= iter_39_3.x + (var_39_2 + var_0_0.AbsorbOffsetX) and arg_39_0.dragOptionAnchor.y >= iter_39_3.y - (arg_39_0.halfAnsWerHeight + var_0_0.AbsorbOffsetY) and arg_39_0.dragOptionAnchor.y <= iter_39_3.y + (arg_39_0.halfAnsWerHeight + var_0_0.AbsorbOffsetY) then
				local var_39_3 = Vector2.Distance(iter_39_3, arg_39_0.dragOptionAnchor)

				if var_39_3 < var_39_1 then
					var_39_1 = var_39_3
					var_39_0 = iter_39_0
				end
			end
		end
	end

	return var_39_0
end

function var_0_0.checkScenePosIsValid(arg_40_0, arg_40_1)
	return GameUtil.checkPointInRectangle(arg_40_1, arg_40_0.textScrollScenePosRect[1], arg_40_0.textScrollScenePosRect[2], arg_40_0.textScrollScenePosRect[3], arg_40_0.textScrollScenePosRect[4])
end

function var_0_0.getAnswerGroupIndex(arg_41_0, arg_41_1)
	return math.ceil(arg_41_1 / 4)
end

function var_0_0.resetAdsorbEffect(arg_42_0)
	gohelper.setActive(arg_42_0.goAdsorbSuccess, false)
	gohelper.setActive(arg_42_0.goAdsorbFail, false)
end

function var_0_0.getAnswerWidth(arg_43_0, arg_43_1)
	return arg_43_0.maxAnswerLenList[arg_43_1] * var_0_0.OneCharacterWidth
end

function var_0_0.onClose(arg_44_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	TaskDispatcher.cancelTask(arg_44_0.showGuide, arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0.hideAdsorb, arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0.showEndEffect, arg_44_0)
	arg_44_0:stopGuideAnimation()

	if DungeonMapModel.instance:hasMapPuzzleStatus(arg_44_0.elementCo.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, arg_44_0.elementCo.id)
	end
end

function var_0_0.onDestroyView(arg_45_0)
	arg_45_0.closeViewClick:RemoveClickListener()

	if arg_45_0.guideClick then
		arg_45_0.guideClick:RemoveClickListener()
	end

	for iter_45_0, iter_45_1 in ipairs(arg_45_0.optionItemList) do
		iter_45_1:onDestroy()
	end
end

return var_0_0
