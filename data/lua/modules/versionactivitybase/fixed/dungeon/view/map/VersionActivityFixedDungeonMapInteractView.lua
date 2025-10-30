﻿-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/map/VersionActivityFixedDungeonMapInteractView.lua

module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapInteractView", package.seeall)

local VersionActivityFixedDungeonMapInteractView = class("VersionActivityFixedDungeonMapInteractView", BaseView)

function VersionActivityFixedDungeonMapInteractView:onInitView(go)
	self._gointeractroot = gohelper.findChild(self.viewGO, "#go_interactive_root")
	self._gointeractitem = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self._gointeractitem, "#btn_close")
	self._txttitle = gohelper.findChildText(self._gointeractitem, "rotate/#go_title/#txt_title")
	self._simagedescbg = gohelper.findChildSingleImage(self._gointeractitem, "rotate/desc_container/#simage_descbg")
	self._txtdesc = gohelper.findChildText(self._gointeractitem, "rotate/desc_container/#txt_desc")
	self._godesc = self._txtdesc.gameObject
	self._gochat = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat")
	self._gochatusericon = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/usericon")
	self._txtchatname = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/name")
	self._txtchatdesc = gohelper.findChildText(self.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/info")
	self.goRewardContainer = gohelper.findChild(self._gointeractitem, "rotate/reward_container")
	self.goRewardContent = gohelper.findChild(self._gointeractitem, "rotate/reward_container/#go_rewardContent")
	self.goRewardItem = gohelper.findChild(self._gointeractitem, "rotate/reward_container/#go_rewardContent/#go_activityrewarditem")

	self:initNoneContainer()
	self:initFightContainer()
	self:initDialogueContainer()
	self:initTalkContainer()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedDungeonMapInteractView:initNoneContainer()
	self.goNone = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_none")
	self.txtNone = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_none/#txt_none")
	self.noneBtn = gohelper.findButtonWithAudio(self.goNone)
end

function VersionActivityFixedDungeonMapInteractView:initFightContainer()
	self.goFight = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_fight")
	self.goFightTip = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip")
	self.txtRemainFightNumber = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip/#txt_remainfightnumber")
	self.fightTipClickArea = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip/clickarea")
	self.txtFight = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_fight/#txt_fight")
	self.goFightCost = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_fight/#go_cost")
	self.txtFightCost = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_fight/#go_cost/#txt_cost")
	self.simageCostIcon = gohelper.findChildSingleImage(self._gointeractitem, "rotate/option_container/#go_fight/#go_cost/#simage_costicon")
	self.fightBtn = gohelper.findButtonWithAudio(self.goFight)
end

function VersionActivityFixedDungeonMapInteractView:initDialogueContainer()
	self.goDialogue = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_dialogue")
	self.txtDialogue = gohelper.findChildText(self._gointeractitem, "rotate/option_container/#go_dialogue/#txt_dialogue")
	self.enterDialogueBtn = gohelper.findButtonWithAudio(self.goDialogue)
end

function VersionActivityFixedDungeonMapInteractView:initTalkContainer()
	self.goTalk = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_talk")
	self._gonext = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_talk/#go_next")
	self._btnnext = gohelper.findChildButtonWithAudio(self._gointeractitem, "rotate/option_container/#go_talk/#go_next/#btn_next")
	self._gooptions = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_talk/#go_options")
	self._gotalkitem = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_talk/#go_options/#go_talkitem")

	gohelper.setActive(self._gotalkitem, false)

	self._gofinishtalk = gohelper.findChild(self._gointeractitem, "rotate/option_container/#go_talk/#go_finishtalk")
	self._btnfinishtalk = gohelper.findChildButtonWithAudio(self._gointeractitem, "rotate/option_container/#go_talk/#go_finishtalk/#btn_finishtalk")
end

function VersionActivityFixedDungeonMapInteractView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.noneBtn:AddClickListener(self._onClickNoneBtn, self)
	self.fightBtn:AddClickListener(self._onClickFightBtn, self)
	self.enterDialogueBtn:AddClickListener(self._onClickEnterDialogueBtn, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnfinishtalk:AddClickListener(self._btnfinishtalkOnClick, self)
	self:addEventCb(VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.OnClickElement, self.showInteractUI, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinishCall, self)
	self:addEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, self.onDialogueInfoChange, self)
	self:addEventCb(JumpController.instance, JumpEvent.BeforeJump, self.beforeJump, self)
end

function VersionActivityFixedDungeonMapInteractView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.noneBtn:RemoveClickListener()
	self.fightBtn:RemoveClickListener()
	self.enterDialogueBtn:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnfinishtalk:RemoveClickListener()
	self:removeEventCb(VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.OnClickElement, self.showInteractUI, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinishCall, self)
	self:removeEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, self.onDialogueInfoChange, self)
	self:removeEventCb(JumpController.instance, JumpEvent.BeforeJump, self.beforeJump, self)
end

function VersionActivityFixedDungeonMapInteractView:_editableInitView()
	self._handleTypeMap = {
		[DungeonEnum.ElementType.None] = self.refreshNoneUI,
		[DungeonEnum.ElementType.Fight] = self.refreshFightUI,
		[DungeonEnum.ElementType.EnterDialogue] = self.refreshDialogueUI,
		[DungeonEnum.ElementType.Story] = self.refreshTalkUI
	}
	self.type2goDict = {
		[DungeonEnum.ElementType.None] = self.goNone,
		[DungeonEnum.ElementType.Fight] = self.goFight,
		[DungeonEnum.ElementType.EnterDialogue] = self.goDialogue,
		[DungeonEnum.ElementType.Story] = self.goTalk
	}
	self.rewardItemList = {}
	self._optionBtnList = self:getUserDataTb_()
	self.mapSceneElementsView = self.viewContainer.mapSceneElements
	self.rootClick = gohelper.findChildClickWithDefaultAudio(self._gointeractroot, "close_block")

	self.rootClick:AddClickListener(self.onClickRoot, self)
	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
	gohelper.setActive(self.goRewardItem, false)
end

function VersionActivityFixedDungeonMapInteractView:showInteractUI(mapElement)
	if self._show then
		return
	end

	VersionActivityFixedDungeonModel.instance:setShowInteractView(true)

	self._mapElement = mapElement
	self._config = self._mapElement._config
	self._elementGo = self._mapElement._go
	self.isFinish = false

	self:show()
	self:refreshUI()
end

function VersionActivityFixedDungeonMapInteractView:show()
	if self._show then
		return
	end

	self._show = true

	gohelper.setActive(self._gointeractitem, true)
	gohelper.setActive(self._gointeractroot, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function VersionActivityFixedDungeonMapInteractView:hide()
	if not self._show then
		return
	end

	VersionActivityFixedDungeonModel.instance:setShowInteractView(nil)

	self._show = false
	self.dispatchMo = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnHideInteractUI)
end

function VersionActivityFixedDungeonMapInteractView:refreshUI()
	for type, go in pairs(self.type2goDict) do
		gohelper.setActive(go, type == self._config.type)
	end

	self._txttitle.text = self._config.title

	local handleFunc = self._handleTypeMap[self._config.type]

	if handleFunc then
		handleFunc(self)
	else
		logError("element type undefined!")
	end

	self:refreshRewards()
end

function VersionActivityFixedDungeonMapInteractView:refreshRewards()
	local rewardStr = self._config.reward

	if string.nilorempty(rewardStr) then
		gohelper.setActive(self.goRewardContainer, false)

		return
	end

	gohelper.setActive(self.goRewardContainer, true)

	local rewardList = GameUtil.splitString2(rewardStr, true)

	for index, reward in ipairs(rewardList) do
		local rewardItem = self.rewardItemList[index]

		if not rewardItem then
			rewardItem = self:createRewardItem()

			table.insert(self.rewardItemList, rewardItem)
		end

		gohelper.setActive(rewardItem.go, true)
		rewardItem.icon:isShowCount(false)
		rewardItem.icon:setMOValue(reward[1], reward[2], reward[3])

		rewardItem.txtCount.text = reward[3]
	end

	for i = #rewardList + 1, #self.rewardItemList do
		gohelper.setActive(self.rewardItemList[i].go, false)
	end
end

function VersionActivityFixedDungeonMapInteractView:createRewardItem()
	local rewardItem = self:getUserDataTb_()

	rewardItem.go = gohelper.cloneInPlace(self.goRewardItem)
	rewardItem.goIcon = gohelper.findChild(rewardItem.go, "itemicon")
	rewardItem.goCount = gohelper.findChild(rewardItem.go, "countbg")
	rewardItem.txtCount = gohelper.findChildText(rewardItem.go, "countbg/count")
	rewardItem.goRare = gohelper.findChild(rewardItem.go, "rare")
	rewardItem.icon = IconMgr.instance:getCommonPropItemIcon(rewardItem.goIcon)

	gohelper.setActive(rewardItem.goRare, false)

	return rewardItem
end

function VersionActivityFixedDungeonMapInteractView:refreshNoneUI()
	self.txtNone.text = self._config.acceptText
	self._txtdesc.text = self._config.desc

	self:setIsChat(false)
end

function VersionActivityFixedDungeonMapInteractView:setFinishText()
	local finishText = self._config.finishText

	if string.nilorempty(finishText) then
		self._txtdesc.text = self._config.desc
	else
		self._txtdesc.text = finishText
	end
end

function VersionActivityFixedDungeonMapInteractView:refreshFightUI()
	local episodeId = tonumber(self._config.param)

	self.isFinish = DungeonModel.instance:hasPassLevel(episodeId)

	if self.isFinish then
		self.txtFight.text = luaLang("p_v1a5_news_order_finish")

		self:setFinishText()
	else
		self.txtFight.text = self._config.acceptText
		self._txtdesc.text = self._config.desc
	end

	self:setIsChat(false)
end

function VersionActivityFixedDungeonMapInteractView:refreshDialogueUI()
	self.dialogueId = tonumber(self._config.param)
	self.isFinish = DialogueModel.instance:isFinishDialogue(self.dialogueId)

	if self.isFinish then
		self.txtDialogue.text = luaLang("p_v1a5_news_order_finish")

		self:setFinishText()
	else
		self.txtDialogue.text = self._config.acceptText
		self._txtdesc.text = self._config.desc
	end

	self:setIsChat(false)
end

function VersionActivityFixedDungeonMapInteractView:refreshTalkUI()
	self._sectionStack = {}
	self._dialogId = tonumber(self._config.param)

	self:_playSection(0)
end

function VersionActivityFixedDungeonMapInteractView:_playSection(sectionId, dialogIndex)
	self:_setSectionData(sectionId, dialogIndex)
	self:_playNextDialog()
end

function VersionActivityFixedDungeonMapInteractView:_setSectionData(sectionId, dialogIndex)
	self._sectionList = DungeonConfig.instance:getDialog(self._dialogId, sectionId)
	self._dialogIndex = dialogIndex or 1
	self._sectionId = sectionId
end

function VersionActivityFixedDungeonMapInteractView:_playNextDialog()
	local config = self._sectionList[self._dialogIndex]

	self._dialogIndex = self._dialogIndex + 1

	if config.type == "dialog" then
		self:_showDialog("dialog", config.content, config.speaker, config.audio)
	end

	if #self._sectionStack > 0 and #self._sectionList < self._dialogIndex then
		local prevSectionInfo = table.remove(self._sectionStack)

		self:_setSectionData(prevSectionInfo[1], prevSectionInfo[2])
	end

	local showOption = false
	local nextConfig = self._sectionList[self._dialogIndex]

	if nextConfig and nextConfig.type == "options" then
		self._dialogIndex = self._dialogIndex + 1

		for _, v in pairs(self._optionBtnList) do
			gohelper.setActive(v[1], false)
		end

		local optionList = string.split(nextConfig.content, "#")
		local sectionIdList = string.split(nextConfig.param, "#")

		for i, v in ipairs(optionList) do
			self:_addDialogOption(i, sectionIdList[i], v)
		end

		showOption = true
	end

	local hasNext = not nextConfig or nextConfig.type ~= "dialogend"

	self:_refreshDialogBtnState(showOption, hasNext)
end

function VersionActivityFixedDungeonMapInteractView:_showDialog(type, text, speaker, audio)
	DungeonMapModel.instance:addDialog(type, text, speaker, audio)
	gohelper.setActive(self._gochatusericon, not speaker)

	local hasSpeaker = not string.nilorempty(speaker)

	self._txtchatname.text = hasSpeaker and speaker .. ":" or ""
	self._txtchatdesc.text = text

	self:setIsChat(true)
end

function VersionActivityFixedDungeonMapInteractView:setIsChat(isChat)
	gohelper.setActive(self._godesc, not isChat)
	gohelper.setActive(self._gochat, isChat)
end

function VersionActivityFixedDungeonMapInteractView:_addDialogOption(index, sectionId, text)
	local optionGo = self._optionBtnList[index] and self._optionBtnList[index][1] or gohelper.cloneInPlace(self._gotalkitem)

	gohelper.setActive(optionGo, true)

	local optionTxt = gohelper.findChildText(optionGo, "txt_talkitem")

	optionTxt.text = text

	local btnOption = gohelper.findChildButtonWithAudio(optionGo, "btn_talkitem")

	btnOption:AddClickListener(self._onOptionClick, self, {
		sectionId,
		text
	})

	if not self._optionBtnList[index] then
		local btnItem = self:getUserDataTb_()

		btnItem[1] = optionGo
		btnItem[2] = btnOption
		self._optionBtnList[index] = btnItem
	end
end

function VersionActivityFixedDungeonMapInteractView:_onOptionClick(param)
	local sectionId = param[1]
	local text = string.format("<color=#c95318>\"%s\"</color>", param[2])

	self:_showDialog("option", text)

	if #self._sectionList >= self._dialogIndex then
		table.insert(self._sectionStack, {
			self._sectionId,
			self._dialogIndex
		})
	end

	DungeonMapModel.instance:addDialogId(sectionId)
	self:_playSection(sectionId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function VersionActivityFixedDungeonMapInteractView:_refreshDialogBtnState(showOption, hasNext)
	gohelper.setActive(self._gooptions, showOption)

	if showOption then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(self._gonext, false)
		gohelper.setActive(self._gofinishtalk, false)

		self._curBtnGo = self._gooptions

		return
	end

	hasNext = hasNext and (#self._sectionStack > 0 or #self._sectionList >= self._dialogIndex)

	if hasNext then
		self._curBtnGo = self._gonext

		gohelper.setActive(self._gonext, hasNext)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		self._curBtnGo = self._gofinishtalk
	end

	gohelper.setActive(self._gonext, hasNext)
	gohelper.setActive(self._gofinishtalk, not hasNext)
end

function VersionActivityFixedDungeonMapInteractView:onClickRoot()
	self:hide()
end

function VersionActivityFixedDungeonMapInteractView:_btncloseOnClick()
	self:hide()
end

function VersionActivityFixedDungeonMapInteractView:_onClickNoneBtn()
	self:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	self:finishElement()
end

function VersionActivityFixedDungeonMapInteractView:_onClickFightBtn()
	self:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	if self.isFinish then
		self:finishElement()

		return
	end

	local episodeId = tonumber(self._config.param)

	DungeonModel.instance.curLookEpisodeId = episodeId

	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not config then
		logError("episode config not exist , episodeId : " .. tostring(episodeId))

		return
	end

	VersionActivityFixedDungeonModel.instance:setLastEpisodeId(self.activityDungeonMo.episodeId)
	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function VersionActivityFixedDungeonMapInteractView:_onClickEnterDialogueBtn()
	if self.isFinish then
		self:hide()
		self:finishElement()

		return
	end

	DialogueController.instance:enterDialogue(self.dialogueId)
end

function VersionActivityFixedDungeonMapInteractView:finishElement(dialogIds)
	local elementId = self._config.id

	DungeonMapModel.instance:addFinishedElement(elementId)
	DungeonMapModel.instance:removeElement(elementId)
	DungeonRpc.instance:sendMapElementRequest(elementId, dialogIds, self.refreshElement, self)
end

function VersionActivityFixedDungeonMapInteractView:refreshElement()
	return
end

function VersionActivityFixedDungeonMapInteractView:_btnnextOnClick()
	self:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function VersionActivityFixedDungeonMapInteractView:_playNextSectionOrDialog()
	if #self._sectionList >= self._dialogIndex then
		self:_playNextDialog()

		return
	end

	local prevSectionInfo = table.remove(self._sectionStack)

	if not prevSectionInfo then
		return
	end

	self:_playSection(prevSectionInfo[1], prevSectionInfo[2])
end

function VersionActivityFixedDungeonMapInteractView:_btnfinishtalkOnClick()
	self:hide()

	local dialogIds = DungeonMapModel.instance:getDialogId()

	self:finishElement(dialogIds)
	DungeonMapModel.instance:clearDialogId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function VersionActivityFixedDungeonMapInteractView:onDialogueInfoChange(dialogueId)
	if dialogueId == self.dialogueId then
		self:refreshDialogueUI()
	end
end

function VersionActivityFixedDungeonMapInteractView:onCloseViewFinishCall(viewName)
	if viewName == ViewName.DialogueView and self.isFinish then
		self:refreshUI()
	end
end

function VersionActivityFixedDungeonMapInteractView:beforeJump()
	self:hide()
end

function VersionActivityFixedDungeonMapInteractView:onClose()
	return
end

function VersionActivityFixedDungeonMapInteractView:onDestroyView()
	self.rootClick:RemoveClickListener()
end

return VersionActivityFixedDungeonMapInteractView
