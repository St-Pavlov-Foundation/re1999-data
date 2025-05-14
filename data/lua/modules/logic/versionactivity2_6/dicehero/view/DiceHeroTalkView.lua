module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroTalkView", package.seeall)

local var_0_0 = class("DiceHeroTalkView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_title")
	arg_1_0._goNarration = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_narration")
	arg_1_0._gotalk = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_talk")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_reward")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_reward/#go_item")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/arrow")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")
	arg_1_0._scrollRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist")
	arg_1_0._rewardFullBg = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_reward/#go_fullbg")
	arg_1_0._transcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content").transform
	arg_1_0.scrollContent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_contentlist")
	arg_1_0._transscroll = arg_1_0.scrollContent.transform
end

function var_0_0.addEvents(arg_2_0)
	NavigateMgr.instance:addSpace(ViewName.DiceHeroTalkView, arg_2_0._clickSpace, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0.onTouchDown, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, arg_2_0.onTouchUp, arg_2_0)
	arg_2_0.scrollContent:AddOnValueChanged(arg_2_0.onScrollValueChanged, arg_2_0)
	arg_2_0._btnSkip:AddClickListener(arg_2_0._skipStory, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.scrollContent:RemoveOnValueChanged()
	arg_3_0._btnSkip:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewParam and arg_4_0.viewParam.co
	local var_4_1 = DiceHeroModel.instance:getGameInfo(var_4_0.chapter)

	if not var_4_0 then
		logError("配置不存在？？" .. tostring(var_4_1.currLevel))

		return
	end

	arg_4_0._co = var_4_0
	DiceHeroModel.instance.talkId = var_4_0.dialog
	DiceHeroModel.instance.stepId = 0

	local var_4_2 = lua_dice_dialogue.configDict[var_4_0.dialog]

	if not var_4_2 then
		logError("对话配置不存在" .. tostring(var_4_0.dialog))

		return
	end

	gohelper.setActive(arg_4_0._goNarration, false)
	gohelper.setActive(arg_4_0._gotalk, false)
	gohelper.setActive(arg_4_0._rewardFullBg, false)

	local var_4_3 = {}
	local var_4_4 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_2) do
		if iter_4_1.type == DiceHeroEnum.DialogContentType.Title then
			arg_4_0._txtTitle.text = iter_4_1.desc
		elseif iter_4_1.type == DiceHeroEnum.DialogContentType.Narration then
			local var_4_5 = gohelper.cloneInPlace(arg_4_0._goNarration)

			if iter_4_1.line ~= 1 then
				local var_4_6 = gohelper.findChild(var_4_5, "line")

				gohelper.setActive(var_4_6, false)
			end

			local var_4_7 = gohelper.findChildTextMesh(var_4_5, "txt")

			var_4_7.text = ""

			table.insert(var_4_3, var_4_5)
			table.insert(var_4_4, {
				isEnd = false,
				txt = var_4_7,
				chars = GameUtil.getUCharArrWithoutRichTxt(iter_4_1.desc),
				stepId = iter_4_1.step
			})
		else
			local var_4_8 = gohelper.cloneInPlace(arg_4_0._gotalk)
			local var_4_9 = gohelper.findChildTextMesh(var_4_8, "txt")

			var_4_9.text = ""

			table.insert(var_4_3, var_4_8)
			table.insert(var_4_4, {
				isEnd = false,
				txt = var_4_9,
				chars = GameUtil.getUCharArrWithoutRichTxt(iter_4_1.speaker .. iter_4_1.desc),
				stepId = iter_4_1.step
			})
		end
	end

	if var_4_1:hasReward() and var_4_1.currLevel == arg_4_0._co.id and not var_4_1.allPass then
		local var_4_10 = var_4_1.rewardItems

		if arg_4_0._co.mode == 1 then
			var_4_10 = {}

			for iter_4_2, iter_4_3 in ipairs(var_4_1.rewardItems) do
				if iter_4_3.type == DiceHeroEnum.RewardType.Hero then
					arg_4_0._noShowBg = true

					gohelper.setActive(arg_4_0._rewardFullBg, true)

					iter_4_3.index = iter_4_2

					table.insert(var_4_10, iter_4_3)

					local var_4_11 = lua_dice_character.configDict[iter_4_3.id]

					if not string.nilorempty(var_4_11.relicIds) then
						for iter_4_4, iter_4_5 in ipairs(string.splitToNumber(var_4_11.relicIds, "#")) do
							local var_4_12 = DiceHeroRewardMo.New()

							var_4_12.id = iter_4_5
							var_4_12.type = DiceHeroEnum.RewardType.Relic
							var_4_12.index = iter_4_2

							table.insert(var_4_10, var_4_12)
						end
					end

					if not string.nilorempty(var_4_11.skilllist) then
						for iter_4_6, iter_4_7 in ipairs(string.splitToNumber(var_4_11.skilllist, "#")) do
							local var_4_13 = DiceHeroRewardMo.New()

							var_4_13.id = iter_4_7
							var_4_13.type = DiceHeroEnum.RewardType.SkillCard
							var_4_13.index = iter_4_2

							table.insert(var_4_10, var_4_13)
						end
					end
				else
					iter_4_3.index = iter_4_2

					table.insert(var_4_10, iter_4_3)
				end
			end
		else
			for iter_4_8, iter_4_9 in ipairs(var_4_1.rewardItems) do
				iter_4_9.isShowAll = nil
			end
		end

		arg_4_0._rewardItem = var_4_10

		gohelper.CreateObjList(arg_4_0, arg_4_0._createRewardItem, var_4_10, arg_4_0._goreward, arg_4_0._gorewarditem, nil, nil, nil, 1)
		gohelper.setAsLastSibling(arg_4_0._goreward)
		table.insert(var_4_3, arg_4_0._goreward)
	end

	gohelper.setActive(arg_4_0._goreward, false)

	arg_4_0._contentGos = var_4_3
	arg_4_0._contentTxts = var_4_4

	gohelper.setActive(arg_4_0._goarrow, true)
	arg_4_0:nextStep()
	TaskDispatcher.runRepeat(arg_4_0._autoSpeak, arg_4_0, 0.02)

	if arg_4_0._rewardItem and var_4_0.isSkip == 1 then
		arg_4_0:_realSkipStory()
	end
end

function var_0_0.onTouchDown(arg_5_0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroTalkView) then
		arg_5_0._isKeyDown = false

		return
	end

	if not arg_5_0._tweenId then
		arg_5_0._isKeyDown = true
	end
end

function var_0_0._clickSpace(arg_6_0)
	if not arg_6_0._tweenId then
		arg_6_0:nextStep()
	end
end

function var_0_0.onTouchUp(arg_7_0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroTalkView) then
		return
	end

	if arg_7_0._isKeyDown then
		if arg_7_0._contentGos[1] then
			arg_7_0:nextStep()
		else
			local var_7_0 = DiceHeroModel.instance:getGameInfo(arg_7_0._co.chapter)

			if not var_7_0:hasReward() and var_7_0.currLevel == arg_7_0._co.id or var_7_0.currLevel ~= arg_7_0._co.id then
				if not arg_7_0._isSendStat then
					DiceHeroStatHelper.instance:sendStoryEnd(true, false)
				end

				arg_7_0._isSendStat = true

				arg_7_0:closeThis()
			end
		end
	end
end

function var_0_0.onScrollValueChanged(arg_8_0, arg_8_1, arg_8_2)
	if math.abs(arg_8_2) > 0.05 then
		arg_8_0._isKeyDown = false
	end
end

function var_0_0._autoSpeak(arg_9_0)
	if not arg_9_0._curTxtData or arg_9_0._curTxtData.isEnd then
		if arg_9_0._curTxtData and not arg_9_0._curTxtData.isScrollEnd then
			arg_9_0._curTxtData.isScrollEnd = true
			arg_9_0.scrollContent.verticalNormalizedPosition = 0
		end

		return
	end

	local var_9_0 = (arg_9_0._curTxtData.index or 0) + 1

	arg_9_0._curTxtData.index = var_9_0
	arg_9_0._curTxtData.txt.text = table.concat(arg_9_0._curTxtData.chars, "", 1, var_9_0)
	arg_9_0._curTxtData.isEnd = var_9_0 >= #arg_9_0._curTxtData.chars
	arg_9_0.scrollContent.verticalNormalizedPosition = 0

	if arg_9_0._curTxtData.isEnd then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
	end
end

function var_0_0.nextStep(arg_10_0)
	if arg_10_0._curTxtData and not arg_10_0._curTxtData.isEnd then
		arg_10_0._curTxtData.index = #arg_10_0._curTxtData.chars - 1

		return
	end

	local var_10_0 = table.remove(arg_10_0._contentGos, 1)

	arg_10_0._curTxtData = table.remove(arg_10_0._contentTxts, 1)

	if arg_10_0._curTxtData then
		DiceHeroModel.instance.stepId = arg_10_0._curTxtData.stepId or DiceHeroModel.instance.stepId

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_feichi_yure_caption)
	else
		gohelper.setActive(arg_10_0._btnSkip, false)
	end

	if not var_10_0 then
		gohelper.setActive(arg_10_0._goarrow, false)
		arg_10_0:checkSendLevelReq()

		return
	end

	if not arg_10_0._contentGos[1] then
		gohelper.setActive(arg_10_0._goarrow, false)
		arg_10_0:checkSendLevelReq()
	end

	gohelper.setActive(var_10_0, true)
	ZProj.UGUIHelper.RebuildLayout(arg_10_0._transcontent)

	local var_10_1 = recthelper.getHeight(arg_10_0._transcontent)
	local var_10_2 = recthelper.getHeight(arg_10_0._transscroll)

	arg_10_0:killTween()

	if var_10_2 < var_10_1 and not arg_10_0._curTxtData then
		local var_10_3 = recthelper.getHeight(arg_10_0._goreward.transform)
		local var_10_4 = Mathf.Clamp(1 - (var_10_1 - var_10_3) / (var_10_1 - var_10_2), 0, 1)

		arg_10_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_10_0.scrollContent.verticalNormalizedPosition, var_10_4, 0.3, arg_10_0.tweenFrameCallback, arg_10_0.tweenFinishCallback, arg_10_0)
	end
end

function var_0_0._skipStory(arg_11_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, arg_11_0._realSkipStory, nil, nil, arg_11_0)
end

function var_0_0._realSkipStory(arg_12_0)
	if not arg_12_0._rewardItem then
		if not arg_12_0:checkSendLevelReq(true) then
			arg_12_0:closeThis()
		end

		return
	end

	if arg_12_0._curTxtData then
		arg_12_0._curTxtData.txt.text = table.concat(arg_12_0._curTxtData.chars, "")
		arg_12_0._curTxtData = nil
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._contentTxts) do
		iter_12_1.txt.text = table.concat(iter_12_1.chars, "")
	end

	tabletool.clear(arg_12_0._contentTxts)

	for iter_12_2, iter_12_3 in ipairs(arg_12_0._contentGos) do
		gohelper.setActive(iter_12_3, true)
	end

	tabletool.clear(arg_12_0._contentGos)
	ZProj.UGUIHelper.RebuildLayout(arg_12_0._transcontent)

	local var_12_0 = recthelper.getHeight(arg_12_0._transcontent)
	local var_12_1 = recthelper.getHeight(arg_12_0._transscroll)
	local var_12_2 = recthelper.getHeight(arg_12_0._goreward.transform)

	arg_12_0.scrollContent.verticalNormalizedPosition = Mathf.Clamp(1 - (var_12_0 - var_12_2) / (var_12_0 - var_12_1), 0, 1)

	gohelper.setActive(arg_12_0._btnSkip, false)
	gohelper.setActive(arg_12_0._goarrow, false)
end

function var_0_0.checkSendLevelReq(arg_13_0, arg_13_1)
	local var_13_0 = DiceHeroModel.instance:getGameInfo(arg_13_0._co.chapter)

	if var_13_0.currLevel == arg_13_0._co.id and not var_13_0.allPass and arg_13_0._co.rewardSelectType == DiceHeroEnum.GetRewardType.None then
		if arg_13_1 then
			DiceHeroRpc.instance:sendDiceHeroEnterStory(arg_13_0._co.id, arg_13_0._co.chapter, arg_13_0.closeThis, arg_13_0)
		else
			DiceHeroRpc.instance:sendDiceHeroEnterStory(arg_13_0._co.id, arg_13_0._co.chapter)
		end

		DiceHeroStatHelper.instance:sendStoryEnd(true, true)

		arg_13_0._isSendStat = true

		return true
	end
end

function var_0_0.tweenFrameCallback(arg_14_0, arg_14_1)
	arg_14_0.scrollContent.verticalNormalizedPosition = arg_14_1
end

function var_0_0.tweenFinishCallback(arg_15_0)
	arg_15_0._tweenId = nil
end

function var_0_0.killTween(arg_16_0)
	if arg_16_0._tweenId then
		ZProj.TweenHelper.KillById(arg_16_0._tweenId)

		arg_16_0._tweenId = nil
	end
end

function var_0_0._createRewardItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = gohelper.findChildTextMesh(arg_17_1, "#txt_title")
	local var_17_1 = gohelper.findChildTextMesh(arg_17_1, "scroll_desc/viewport/#txt_desc")
	local var_17_2 = gohelper.findChild(arg_17_1, "scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	local var_17_3 = gohelper.findChildButtonWithAudio(arg_17_1, "#btn_choose")
	local var_17_4 = gohelper.findChild(arg_17_1, "#btn_choose/line")
	local var_17_5 = gohelper.findChildSingleImage(arg_17_1, "headbg/#simage_icon")
	local var_17_6 = gohelper.findChildImage(arg_17_1, "headbg/#go_cardicon")
	local var_17_7 = gohelper.findChild(arg_17_1, "bg")
	local var_17_8 = gohelper.findChildAnim(arg_17_1, "")

	var_17_2.parentGameObject = arg_17_0._scrollRoot

	if arg_17_0._noShowBg then
		gohelper.setActive(var_17_7, false)
		gohelper.setActive(var_17_4, false)

		if arg_17_2.type ~= DiceHeroEnum.RewardType.Hero then
			gohelper.setActive(var_17_3, false)
		end
	end

	arg_17_2.anim = var_17_8

	arg_17_0:removeClickCb(var_17_3)
	arg_17_0:addClickCb(var_17_3, arg_17_0._onClickSelect, arg_17_0, {
		index = arg_17_2.index or arg_17_3,
		data = arg_17_2
	})
	gohelper.setActive(var_17_6, false)
	gohelper.setActive(var_17_5, true)

	if arg_17_2.type == DiceHeroEnum.RewardType.Hero then
		local var_17_9 = lua_dice_character.configDict[arg_17_2.id]

		var_17_0.text = var_17_9 and var_17_9.name or ""
		var_17_1.text = var_17_9 and var_17_9.desc or ""

		var_17_5:LoadImage(ResUrl.getHeadIconSmall(var_17_9.icon))
	elseif arg_17_2.type == DiceHeroEnum.RewardType.SkillCard then
		local var_17_10 = lua_dice_card.configDict[arg_17_2.id]

		var_17_0.text = var_17_10 and var_17_10.name or ""
		var_17_1.text = var_17_10 and var_17_10.desc or ""

		UISpriteSetMgr.instance:setDiceHeroSprite(var_17_6, "dicehero_cardicon_" .. var_17_10.quality)
		gohelper.setActive(var_17_6, true)
		gohelper.setActive(var_17_5, false)
	elseif arg_17_2.type == DiceHeroEnum.RewardType.Relic then
		local var_17_11 = lua_dice_relic.configDict[arg_17_2.id]

		var_17_0.text = var_17_11 and var_17_11.name or ""
		var_17_1.text = var_17_11 and var_17_11.desc or ""

		var_17_5:LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. var_17_11.icon .. ".png")
	end

	var_17_8:Play("open", 0, 0)
end

function var_0_0._onClickSelect(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.data

	if var_18_0.type == DiceHeroEnum.RewardType.Hero and arg_18_0._co.mode == 2 and not var_18_0.isShowAll then
		var_18_0.isShowAll = true

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)

		local var_18_1 = {}

		var_18_0.index = arg_18_1.index

		table.insert(var_18_1, var_18_0)

		local var_18_2 = lua_dice_character.configDict[var_18_0.id]

		if not string.nilorempty(var_18_2.relicIds) then
			for iter_18_0, iter_18_1 in ipairs(string.splitToNumber(var_18_2.relicIds, "#")) do
				local var_18_3 = DiceHeroRewardMo.New()

				var_18_3.id = iter_18_1
				var_18_3.type = DiceHeroEnum.RewardType.Relic
				var_18_3.index = arg_18_1.index

				table.insert(var_18_1, var_18_3)
			end
		end

		if not string.nilorempty(var_18_2.skilllist) then
			for iter_18_2, iter_18_3 in ipairs(string.splitToNumber(var_18_2.skilllist, "#")) do
				local var_18_4 = DiceHeroRewardMo.New()

				var_18_4.id = iter_18_3
				var_18_4.type = DiceHeroEnum.RewardType.SkillCard
				var_18_4.index = arg_18_1.index

				table.insert(var_18_1, var_18_4)
			end
		end

		arg_18_0._rewardItem = var_18_1

		var_18_0.anim:Play("finish", 0, 0)
		UIBlockHelper.instance:startBlock("DiceHeroTalkView_GetReward", 0.5)
		TaskDispatcher.runDelay(arg_18_0._delayRefrshReward, arg_18_0, 0.5)

		return
	end

	local var_18_5 = DiceHeroModel.instance:getGameInfo(arg_18_0._co.chapter)
	local var_18_6 = {}

	arg_18_0._allGetIndexes = {}

	if arg_18_0._co.rewardSelectType == DiceHeroEnum.GetRewardType.One then
		table.insert(var_18_6, arg_18_1.index - 1)

		arg_18_0._allGetIndexes[arg_18_1.index] = true

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)
	else
		for iter_18_4, iter_18_5 in ipairs(var_18_5.rewardItems) do
			table.insert(var_18_6, iter_18_4 - 1)

			arg_18_0._allGetIndexes[iter_18_4] = true
		end

		if #var_18_6 > 1 then
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards_rare)
		else
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)
		end
	end

	DiceHeroRpc.instance:sendDiceHeroGetReward(var_18_6, arg_18_0._co.chapter, arg_18_0._getReward, arg_18_0)
end

function var_0_0._delayRefrshReward(arg_19_0)
	gohelper.setActive(arg_19_0._rewardFullBg, true)

	arg_19_0._noShowBg = true

	gohelper.CreateObjList(arg_19_0, arg_19_0._createRewardItem, arg_19_0._rewardItem, arg_19_0._goreward, arg_19_0._gorewarditem, nil, nil, nil, 1)
end

function var_0_0._getReward(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 == 0 then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._rewardItem) do
			local var_20_0 = iter_20_1.index or iter_20_0

			if arg_20_0._allGetIndexes[var_20_0] then
				iter_20_1.anim:Play("finish", 0, 0)
			end
		end

		UIBlockHelper.instance:startBlock("DiceHeroTalkView_GetReward", 0.5)
		TaskDispatcher.runDelay(arg_20_0.closeThis, arg_20_0, 0.5)

		if arg_20_0._co.type == 1 then
			DiceHeroStatHelper.instance:sendStoryEnd(true, true)

			arg_20_0._isSendStat = true
		end
	end
end

function var_0_0.onDestroyView(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._delayRefrshReward, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._autoSpeak, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.closeThis, arg_21_0)
	arg_21_0:killTween()

	arg_21_0._contentGos = {}

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
end

function var_0_0.onClose(arg_22_0)
	if DiceHeroModel.instance.isUnlockNewChapter then
		ViewMgr.instance:closeView(ViewName.DiceHeroLevelView)
	end
end

return var_0_0
