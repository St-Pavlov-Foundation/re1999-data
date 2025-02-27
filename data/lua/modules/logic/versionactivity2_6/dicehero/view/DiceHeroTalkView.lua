module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroTalkView", package.seeall)

slot0 = class("DiceHeroTalkView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "#txt_title")
	slot0._goNarration = gohelper.findChild(slot0.viewGO, "#scroll_contentlist/viewport/content/#go_narration")
	slot0._gotalk = gohelper.findChild(slot0.viewGO, "#scroll_contentlist/viewport/content/#go_talk")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "#scroll_contentlist/viewport/content/#go_reward")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#scroll_contentlist/viewport/content/#go_reward/#go_item")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#scroll_contentlist/arrow")
	slot0._btnSkip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")
	slot0._scrollRoot = gohelper.findChild(slot0.viewGO, "#scroll_contentlist")
	slot0._rewardFullBg = gohelper.findChild(slot0.viewGO, "#scroll_contentlist/viewport/content/#go_reward/#go_fullbg")
	slot0._transcontent = gohelper.findChild(slot0.viewGO, "#scroll_contentlist/viewport/content").transform
	slot0.scrollContent = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_contentlist")
	slot0._transscroll = slot0.scrollContent.transform
end

function slot0.addEvents(slot0)
	NavigateMgr.instance:addSpace(ViewName.DiceHeroTalkView, slot0._clickSpace, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0.onTouchDown, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, slot0.onTouchUp, slot0)
	slot0.scrollContent:AddOnValueChanged(slot0.onScrollValueChanged, slot0)
	slot0._btnSkip:AddClickListener(slot0._skipStory, slot0)
end

function slot0.removeEvents(slot0)
	slot0.scrollContent:RemoveOnValueChanged()
	slot0._btnSkip:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam and slot0.viewParam.co

	if not slot1 then
		logError("配置不存在？？" .. tostring(DiceHeroModel.instance:getGameInfo(slot1.chapter).currLevel))

		return
	end

	slot0._co = slot1
	DiceHeroModel.instance.talkId = slot1.dialog
	DiceHeroModel.instance.stepId = 0

	if not lua_dice_dialogue.configDict[slot1.dialog] then
		logError("对话配置不存在" .. tostring(slot1.dialog))

		return
	end

	gohelper.setActive(slot0._goNarration, false)
	gohelper.setActive(slot0._gotalk, false)
	gohelper.setActive(slot0._rewardFullBg, false)

	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot3) do
		if slot10.type == DiceHeroEnum.DialogContentType.Title then
			slot0._txtTitle.text = slot10.desc
		elseif slot10.type == DiceHeroEnum.DialogContentType.Narration then
			slot11 = gohelper.cloneInPlace(slot0._goNarration)

			if slot10.line ~= 1 then
				gohelper.setActive(gohelper.findChild(slot11, "line"), false)
			end

			slot12 = gohelper.findChildTextMesh(slot11, "txt")
			slot12.text = ""

			table.insert(slot4, slot11)
			table.insert(slot5, {
				isEnd = false,
				txt = slot12,
				chars = GameUtil.getUCharArrWithoutRichTxt(slot10.desc),
				stepId = slot10.step
			})
		else
			slot11 = gohelper.cloneInPlace(slot0._gotalk)
			slot12 = gohelper.findChildTextMesh(slot11, "txt")
			slot12.text = ""

			table.insert(slot4, slot11)
			table.insert(slot5, {
				isEnd = false,
				txt = slot12,
				chars = GameUtil.getUCharArrWithoutRichTxt(slot10.speaker .. slot10.desc),
				stepId = slot10.step
			})
		end
	end

	if slot2:hasReward() and slot2.currLevel == slot0._co.id and not slot2.allPass then
		slot6 = slot2.rewardItems

		if slot0._co.mode == 1 then
			for slot10, slot11 in ipairs(slot2.rewardItems) do
				if slot11.type == DiceHeroEnum.RewardType.Hero then
					slot0._noShowBg = true

					gohelper.setActive(slot0._rewardFullBg, true)

					slot11.index = slot10

					table.insert({}, slot11)

					if not string.nilorempty(lua_dice_character.configDict[slot11.id].relicIds) then
						slot16 = "#"

						for slot16, slot17 in ipairs(string.splitToNumber(slot12.relicIds, slot16)) do
							slot18 = DiceHeroRewardMo.New()
							slot18.id = slot17
							slot18.type = DiceHeroEnum.RewardType.Relic
							slot18.index = slot10

							table.insert(slot6, slot18)
						end
					end

					if not string.nilorempty(slot12.skilllist) then
						slot16 = "#"

						for slot16, slot17 in ipairs(string.splitToNumber(slot12.skilllist, slot16)) do
							slot18 = DiceHeroRewardMo.New()
							slot18.id = slot17
							slot18.type = DiceHeroEnum.RewardType.SkillCard
							slot18.index = slot10

							table.insert(slot6, slot18)
						end
					end
				else
					slot11.index = slot10

					table.insert(slot6, slot11)
				end
			end
		else
			for slot10, slot11 in ipairs(slot2.rewardItems) do
				slot11.isShowAll = nil
			end
		end

		slot0._rewardItem = slot6

		gohelper.CreateObjList(slot0, slot0._createRewardItem, slot6, slot0._goreward, slot0._gorewarditem, nil, , , 1)
		gohelper.setAsLastSibling(slot0._goreward)
		table.insert(slot4, slot0._goreward)
	end

	gohelper.setActive(slot0._goreward, false)

	slot0._contentGos = slot4
	slot0._contentTxts = slot5

	gohelper.setActive(slot0._goarrow, true)
	slot0:nextStep()
	TaskDispatcher.runRepeat(slot0._autoSpeak, slot0, 0.02)
end

function slot0.onTouchDown(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroTalkView) then
		slot0._isKeyDown = false

		return
	end

	if not slot0._tweenId then
		slot0._isKeyDown = true
	end
end

function slot0._clickSpace(slot0)
	if not slot0._tweenId then
		slot0:nextStep()
	end
end

function slot0.onTouchUp(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroTalkView) then
		return
	end

	if slot0._isKeyDown then
		if slot0._contentGos[1] then
			slot0:nextStep()
		elseif not DiceHeroModel.instance:getGameInfo(slot0._co.chapter):hasReward() and slot1.currLevel == slot0._co.id or slot1.currLevel ~= slot0._co.id then
			if not slot0._isSendStat then
				DiceHeroStatHelper.instance:sendStoryEnd(true, false)
			end

			slot0._isSendStat = true

			slot0:closeThis()
		end
	end
end

function slot0.onScrollValueChanged(slot0, slot1, slot2)
	if math.abs(slot2) > 0.05 then
		slot0._isKeyDown = false
	end
end

function slot0._autoSpeak(slot0)
	if not slot0._curTxtData or slot0._curTxtData.isEnd then
		if slot0._curTxtData and not slot0._curTxtData.isScrollEnd then
			slot0._curTxtData.isScrollEnd = true
			slot0.scrollContent.verticalNormalizedPosition = 0
		end

		return
	end

	slot1 = (slot0._curTxtData.index or 0) + 1
	slot0._curTxtData.index = slot1
	slot0._curTxtData.txt.text = table.concat(slot0._curTxtData.chars, "", 1, slot1)
	slot0._curTxtData.isEnd = slot1 >= #slot0._curTxtData.chars
	slot0.scrollContent.verticalNormalizedPosition = 0

	if slot0._curTxtData.isEnd then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
	end
end

function slot0.nextStep(slot0)
	if slot0._curTxtData and not slot0._curTxtData.isEnd then
		slot0._curTxtData.index = #slot0._curTxtData.chars - 1

		return
	end

	slot1 = table.remove(slot0._contentGos, 1)
	slot0._curTxtData = table.remove(slot0._contentTxts, 1)

	if slot0._curTxtData then
		DiceHeroModel.instance.stepId = slot0._curTxtData.stepId or DiceHeroModel.instance.stepId

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_feichi_yure_caption)
	else
		gohelper.setActive(slot0._btnSkip, false)
	end

	if not slot1 then
		gohelper.setActive(slot0._goarrow, false)
		slot0:checkSendLevelReq()

		return
	end

	if not slot0._contentGos[1] then
		gohelper.setActive(slot0._goarrow, false)
		slot0:checkSendLevelReq()
	end

	gohelper.setActive(slot1, true)
	ZProj.UGUIHelper.RebuildLayout(slot0._transcontent)
	slot0:killTween()

	if recthelper.getHeight(slot0._transscroll) < recthelper.getHeight(slot0._transcontent) and not slot0._curTxtData then
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0.scrollContent.verticalNormalizedPosition, Mathf.Clamp(1 - (slot2 - recthelper.getHeight(slot0._goreward.transform)) / (slot2 - slot3), 0, 1), 0.3, slot0.tweenFrameCallback, slot0.tweenFinishCallback, slot0)
	end
end

function slot0._skipStory(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, slot0._realSkipStory, nil, , slot0)
end

function slot0._realSkipStory(slot0)
	if not slot0._rewardItem then
		if not slot0:checkSendLevelReq(true) then
			slot0:closeThis()
		end

		return
	end

	if slot0._curTxtData then
		slot0._curTxtData.txt.text = table.concat(slot0._curTxtData.chars, "")
		slot0._curTxtData = nil
	end

	for slot4, slot5 in ipairs(slot0._contentTxts) do
		slot5.txt.text = table.concat(slot5.chars, "")
	end

	tabletool.clear(slot0._contentTxts)

	for slot4, slot5 in ipairs(slot0._contentGos) do
		gohelper.setActive(slot5, true)
	end

	tabletool.clear(slot0._contentGos)
	ZProj.UGUIHelper.RebuildLayout(slot0._transcontent)

	slot1 = recthelper.getHeight(slot0._transcontent)
	slot0.scrollContent.verticalNormalizedPosition = Mathf.Clamp(1 - (slot1 - recthelper.getHeight(slot0._goreward.transform)) / (slot1 - recthelper.getHeight(slot0._transscroll)), 0, 1)

	gohelper.setActive(slot0._btnSkip, false)
	gohelper.setActive(slot0._goarrow, false)
end

function slot0.checkSendLevelReq(slot0, slot1)
	if DiceHeroModel.instance:getGameInfo(slot0._co.chapter).currLevel == slot0._co.id and not slot2.allPass and slot0._co.rewardSelectType == DiceHeroEnum.GetRewardType.None then
		if slot1 then
			DiceHeroRpc.instance:sendDiceHeroEnterStory(slot0._co.id, slot0._co.chapter, slot0.closeThis, slot0)
		else
			DiceHeroRpc.instance:sendDiceHeroEnterStory(slot0._co.id, slot0._co.chapter)
		end

		DiceHeroStatHelper.instance:sendStoryEnd(true, true)

		slot0._isSendStat = true

		return true
	end
end

function slot0.tweenFrameCallback(slot0, slot1)
	slot0.scrollContent.verticalNormalizedPosition = slot1
end

function slot0.tweenFinishCallback(slot0)
	slot0._tweenId = nil
end

function slot0.killTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0._createRewardItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildTextMesh(slot1, "#txt_title")
	slot5 = gohelper.findChildTextMesh(slot1, "scroll_desc/viewport/#txt_desc")
	slot7 = gohelper.findChildButtonWithAudio(slot1, "#btn_choose")
	slot9 = gohelper.findChildSingleImage(slot1, "headbg/#simage_icon")
	slot10 = gohelper.findChildImage(slot1, "headbg/#go_cardicon")
	slot12 = gohelper.findChildAnim(slot1, "")
	gohelper.findChild(slot1, "scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect)).parentGameObject = slot0._scrollRoot

	if slot0._noShowBg then
		gohelper.setActive(gohelper.findChild(slot1, "bg"), false)
		gohelper.setActive(gohelper.findChild(slot1, "#btn_choose/line"), false)

		if slot2.type ~= DiceHeroEnum.RewardType.Hero then
			gohelper.setActive(slot7, false)
		end
	end

	slot2.anim = slot12

	slot0:removeClickCb(slot7)
	slot0:addClickCb(slot7, slot0._onClickSelect, slot0, {
		index = slot2.index or slot3,
		data = slot2
	})
	gohelper.setActive(slot10, false)
	gohelper.setActive(slot9, true)

	if slot2.type == DiceHeroEnum.RewardType.Hero then
		slot4.text = lua_dice_character.configDict[slot2.id] and slot13.name or ""
		slot5.text = slot13 and slot13.desc or ""

		slot9:LoadImage(ResUrl.getHeadIconSmall(slot13.icon))
	elseif slot2.type == DiceHeroEnum.RewardType.SkillCard then
		slot4.text = lua_dice_card.configDict[slot2.id] and slot13.name or ""
		slot5.text = slot13 and slot13.desc or ""

		UISpriteSetMgr.instance:setDiceHeroSprite(slot10, "dicehero_cardicon_" .. slot13.quality)
		gohelper.setActive(slot10, true)
		gohelper.setActive(slot9, false)
	elseif slot2.type == DiceHeroEnum.RewardType.Relic then
		slot4.text = lua_dice_relic.configDict[slot2.id] and slot13.name or ""
		slot5.text = slot13 and slot13.desc or ""

		slot9:LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. slot13.icon .. ".png")
	end

	slot12:Play("open", 0, 0)
end

function slot0._onClickSelect(slot0, slot1)
	if slot1.data.type == DiceHeroEnum.RewardType.Hero and slot0._co.mode == 2 and not slot2.isShowAll then
		slot2.isShowAll = true

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)

		slot2.index = slot1.index

		table.insert({}, slot2)

		if not string.nilorempty(lua_dice_character.configDict[slot2.id].relicIds) then
			slot8 = "#"

			for slot8, slot9 in ipairs(string.splitToNumber(slot4.relicIds, slot8)) do
				slot10 = DiceHeroRewardMo.New()
				slot10.id = slot9
				slot10.type = DiceHeroEnum.RewardType.Relic
				slot10.index = slot1.index

				table.insert(slot3, slot10)
			end
		end

		if not string.nilorempty(slot4.skilllist) then
			slot8 = "#"

			for slot8, slot9 in ipairs(string.splitToNumber(slot4.skilllist, slot8)) do
				slot10 = DiceHeroRewardMo.New()
				slot10.id = slot9
				slot10.type = DiceHeroEnum.RewardType.SkillCard
				slot10.index = slot1.index

				table.insert(slot3, slot10)
			end
		end

		slot0._rewardItem = slot3

		slot2.anim:Play("finish", 0, 0)
		UIBlockHelper.instance:startBlock("DiceHeroTalkView_GetReward", 0.5)
		TaskDispatcher.runDelay(slot0._delayRefrshReward, slot0, 0.5)

		return
	end

	slot3 = DiceHeroModel.instance:getGameInfo(slot0._co.chapter)
	slot0._allGetIndexes = {}

	if slot0._co.rewardSelectType == DiceHeroEnum.GetRewardType.One then
		table.insert({}, slot1.index - 1)

		slot0._allGetIndexes[slot1.index] = true

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)
	else
		for slot8, slot9 in ipairs(slot3.rewardItems) do
			table.insert(slot4, slot8 - 1)

			slot0._allGetIndexes[slot8] = true
		end

		if #slot4 > 1 then
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards_rare)
		else
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)
		end
	end

	DiceHeroRpc.instance:sendDiceHeroGetReward(slot4, slot0._co.chapter, slot0._getReward, slot0)
end

function slot0._delayRefrshReward(slot0)
	gohelper.setActive(slot0._rewardFullBg, true)

	slot0._noShowBg = true

	gohelper.CreateObjList(slot0, slot0._createRewardItem, slot0._rewardItem, slot0._goreward, slot0._gorewarditem, nil, , , 1)
end

function slot0._getReward(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		for slot7, slot8 in ipairs(slot0._rewardItem) do
			if slot0._allGetIndexes[slot8.index or slot7] then
				slot8.anim:Play("finish", 0, 0)
			end
		end

		UIBlockHelper.instance:startBlock("DiceHeroTalkView_GetReward", 0.5)
		TaskDispatcher.runDelay(slot0.closeThis, slot0, 0.5)

		if slot0._co.type == 1 then
			DiceHeroStatHelper.instance:sendStoryEnd(true, true)

			slot0._isSendStat = true
		end
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._delayRefrshReward, slot0)
	TaskDispatcher.cancelTask(slot0._autoSpeak, slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	slot0:killTween()

	slot0._contentGos = {}

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
end

function slot0.onClose(slot0)
	if DiceHeroModel.instance.isUnlockNewChapter then
		ViewMgr.instance:closeView(ViewName.DiceHeroLevelView)
	end
end

return slot0
