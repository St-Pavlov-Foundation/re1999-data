﻿-- chunkname: @modules/logic/dungeon/view/DungeonFragmentInfoView.lua

module("modules.logic.dungeon.view.DungeonFragmentInfoView", package.seeall)

local DungeonFragmentInfoView = class("DungeonFragmentInfoView", BaseView)
local CHAT_NO_AUDIO_OFFSET = -40

function DungeonFragmentInfoView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._go1 = gohelper.findChild(self.viewGO, "#go_1")
	self._txttitlecn = gohelper.findChildText(self.viewGO, "#go_1/#txt_titlecn")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#go_1/#scroll_content")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#go_1/#scroll_content/Viewport/Content/#txt_content")
	self._gochatarea = gohelper.findChild(self.viewGO, "#go_1/#scroll_content/Viewport/Content/#go_chatarea")
	self._layoutchatarea = self._gochatarea:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	self._gochatitem = gohelper.findChild(self.viewGO, "#go_1/#scroll_content/Viewport/Content/#go_chatarea/#go_chatitem")
	self._gobottommask = gohelper.findChild(self.viewGO, "#go_1/#scroll_content/#go_bottommask")
	self._simagefragmenticon = gohelper.findChildSingleImage(self.viewGO, "#go_1/#simage_fragmenticon")
	self._go3 = gohelper.findChild(self.viewGO, "#go_3")
	self._txttitle3 = gohelper.findChildText(self.viewGO, "#go_3/#txt_title3")
	self._scrollcontent3 = gohelper.findChildScrollRect(self.viewGO, "#go_3/#scroll_content3")
	self._txtinfo3 = gohelper.findChildText(self.viewGO, "#go_3/#scroll_content3/Viewport/Content/#txt_info3")
	self._go4 = gohelper.findChild(self.viewGO, "#go_4")
	self._txttitle4 = gohelper.findChildText(self.viewGO, "#go_4/#txt_title4")
	self._scrollcontent4 = gohelper.findChildScrollRect(self.viewGO, "#go_4/#scroll_content4")
	self._txtinfo4 = gohelper.findChildText(self.viewGO, "#go_4/#scroll_content4/Viewport/Content/#txt_info4")
	self._go5 = gohelper.findChild(self.viewGO, "#go_5")
	self._txttitle5 = gohelper.findChildText(self.viewGO, "#go_5/#txt_titlecn")
	self._scrollcontent5 = gohelper.findChildScrollRect(self.viewGO, "#go_5/#scroll_content")
	self._txtinfo5 = gohelper.findChildText(self.viewGO, "#go_5/#scroll_content/Viewport/Content/#txt_content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonFragmentInfoView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._scrollcontent:AddOnValueChanged(self._onValueChnaged, self)
end

function DungeonFragmentInfoView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._scrollcontent:RemoveOnValueChanged()
end

DungeonFragmentInfoView.FragmentInfoTypeMap = {
	1,
	1,
	3,
	4,
	5
}

function DungeonFragmentInfoView:_btncloseOnClick()
	self:closeThis()
end

function DungeonFragmentInfoView:_editableInitView()
	self._pauseColor = GameUtil.parseColor("#3D3939")
	self._playColor = GameUtil.parseColor("#946747")
end

function DungeonFragmentInfoView:onUpdateParam()
	return
end

function DungeonFragmentInfoView:_showDialog(type, text, speaker, audioId)
	local item = gohelper.cloneInPlace(self._gochatitem)

	gohelper.setActive(item, true)

	local nameText = gohelper.findChildText(item, "name")
	local hasSpeaker = not string.nilorempty(speaker)

	nameText.text = hasSpeaker and speaker .. ":" or ""

	if not speaker then
		local iconGo = gohelper.findChild(item, "usericon")

		gohelper.setActive(iconGo, true)
	end

	local infoText = gohelper.findChildText(item, "info")

	infoText.text = text

	local playBtn = gohelper.findChildButtonWithAudio(item, "play")
	local pauseBtn = gohelper.findChildButtonWithAudio(item, "pause")

	if playBtn and audioId and audioId > 0 then
		gohelper.setActive(playBtn.gameObject, true)
		self:_initBtn(playBtn, pauseBtn, audioId, nameText, infoText)
	end
end

function DungeonFragmentInfoView:_initBtn(playBtn, pauseBtn, audioId, nameText, infoText)
	table.insert(self._btnList, {
		playBtn,
		pauseBtn,
		audioId,
		nameText,
		infoText
	})
	playBtn:AddClickListener(self._onPlay, self, audioId)
	pauseBtn:AddClickListener(self._onPause, self, audioId)
end

function DungeonFragmentInfoView:_onPlay(audioId)
	self:_stopAudio()

	self._audioId = audioId

	if not self._audioParam then
		self._audioParam = AudioParam.New()
	end

	self._audioParam.callback = self._onAudioStop
	self._audioParam.callbackTarget = self

	AudioEffectMgr.instance:playAudio(self._audioId, self._audioParam)
	self:_refreshBtnStatus(audioId, true)
end

function DungeonFragmentInfoView:_onPause(audioId)
	self:_stopAudio()
	self:_refreshBtnStatus(audioId, false)
end

function DungeonFragmentInfoView:_onAudioStop(audioId)
	self._audioId = nil

	self:_refreshBtnStatus(audioId, false)
end

function DungeonFragmentInfoView:_refreshBtnStatus(audioId, isPlay)
	for i, v in ipairs(self._btnList) do
		local playBtn = v[1]
		local pauseBtn = v[2]
		local audio = v[3]
		local nameText = v[4]
		local infoText = v[5]

		if audioId == audio then
			gohelper.setActive(playBtn.gameObject, not isPlay)
			gohelper.setActive(pauseBtn.gameObject, isPlay)

			nameText.color = isPlay and self._playColor or self._pauseColor
			infoText.color = isPlay and self._playColor or self._pauseColor
		else
			gohelper.setActive(playBtn.gameObject, true)
			gohelper.setActive(pauseBtn.gameObject, false)

			nameText.color = self._pauseColor
			infoText.color = self._pauseColor
		end
	end
end

function DungeonFragmentInfoView:_stopAudio()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function DungeonFragmentInfoView:_generateDialogByHandbook()
	local dialogId = HandbookConfig.instance:getDialogByFragment(self._fragmentId)
	local stepConfigDict = lua_chapter_map_element_dialog.configDict[dialogId]
	local configList = {}

	for stepId, config in pairs(stepConfigDict) do
		table.insert(configList, config)
	end

	table.sort(configList, function(x, y)
		return x.stepId < y.stepId
	end)

	local dialogIdDict = {}

	for i, dialogId in ipairs(self._dialogIdList) do
		dialogIdDict[tonumber(dialogId)] = true
	end

	local resultList = {}
	local stepId = 1

	while stepId <= #configList do
		stepId = self:_getSelectorResult(stepId, configList, resultList, dialogIdDict, true)
		stepId = stepId + 1
	end

	local isNoSpeakAudio = true

	for _, param in ipairs(resultList) do
		self:_showDialog(nil, param.text, param.speaker, param.audio)

		if param.audio and param.audio > 0 then
			isNoSpeakAudio = false
		end
	end

	local offset = 0

	if isNoSpeakAudio then
		offset = CHAT_NO_AUDIO_OFFSET
	end

	self._layoutchatarea.padding.left = offset
end

function DungeonFragmentInfoView:_getSelectorResult(stepId, configList, resultList, dialogIdDict, mark, recursion)
	while stepId <= #configList do
		local config = configList[stepId]

		if config.type == "dialog" and mark then
			table.insert(resultList, {
				text = config.content,
				speaker = config.speaker,
				audio = config.audio
			})
		elseif config.type == "selector" then
			if recursion then
				return stepId - 1
			end

			stepId = self:_getSelectorResult(stepId + 1, configList, resultList, dialogIdDict, dialogIdDict[tonumber(config.param)], true)
		elseif config.type == "selectorend" then
			return stepId
		elseif config.type == "options" then
			local options = string.splitToNumber(config.param, "#")
			local contents = string.split(config.content, "#")

			for i, id in ipairs(options) do
				if dialogIdDict[id] then
					table.insert(resultList, {
						text = string.format("<color=#c95318>\"%s\"</color>", contents[i])
					})

					break
				end
			end
		end

		stepId = stepId + 1
	end

	return stepId
end

function DungeonFragmentInfoView:onOpen()
	self._btnList = self:getUserDataTb_()
	self._elementId = self.viewParam.elementId
	self._fragmentId = self.viewParam.fragmentId
	self._dialogIdList = self.viewParam.dialogIdList
	self._isFromHandbook = self.viewParam.isFromHandbook
	self._notShowToast = self.viewParam.notShowToast

	local config = lua_chapter_map_fragment.configDict[self._fragmentId]

	for i = 1, 5 do
		local fragmentType = DungeonFragmentInfoView.FragmentInfoTypeMap[i] or 1

		gohelper.setActive(self["_go" .. fragmentType], fragmentType == (DungeonFragmentInfoView.FragmentInfoTypeMap[config.type] or 1))
	end

	local configType = DungeonFragmentInfoView.FragmentInfoTypeMap[config.type] and config.type or 1
	local handleFunc = DungeonFragmentInfoView["fragmentInfoShowHandleFunc" .. configType]

	if handleFunc then
		handleFunc(self, config)
	end

	if not DungeonEnum.NotPopFragmentToastDict[self._fragmentId] and not self._isFromHandbook and not self._notShowToast then
		local toastId = config.toastId

		if toastId and toastId ~= 0 then
			GameFacade.showToast(toastId)
		else
			GameFacade.showToast(ToastEnum.DungeonFragmentInfo, config.title)
		end
	end

	self:_loadFragmentIcon(config)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)
end

function DungeonFragmentInfoView:_loadFragmentIcon(config)
	if not string.nilorempty(config.res) then
		self._simagefragmenticon:LoadImage(ResUrl.getDungeonFragmentIcon(config.res))
	end
end

function DungeonFragmentInfoView:_onValueChnaged(value)
	gohelper.setActive(self._gobottommask, gohelper.getRemindFourNumberFloat(self._scrollcontent.verticalNormalizedPosition) > 0)
end

function DungeonFragmentInfoView:onClose()
	self:_stopAudio()

	if self._elementId then
		DungeonController.instance:dispatchEvent(DungeonEvent.onGuideCloseFragmentInfoView, self._elementId)
	end
end

function DungeonFragmentInfoView:onDestroyView()
	self._simagefragmenticon:UnLoadImage()

	for i, v in ipairs(self._btnList) do
		v[1]:RemoveClickListener()
		v[2]:RemoveClickListener()
	end
end

function DungeonFragmentInfoView:fragmentInfoShowHandleFunc1(config)
	self._txtcontent.text = config.content
	self._txttitlecn.text = config.title

	gohelper.setActive(self._txtcontent.gameObject, true)
end

function DungeonFragmentInfoView:fragmentInfoShowHandleFunc2(config)
	self._txttitlecn.text = config.title
	self._txtcontent.text = config.content

	gohelper.setActive(self._txtcontent.gameObject, true)
	gohelper.setActive(self._gochatarea, true)

	if self._isFromHandbook and self._dialogIdList then
		self:_generateDialogByHandbook()
	else
		local isNoSpeakAudio = true
		local dialogList = DungeonMapModel.instance:getDialog()

		for i, v in ipairs(dialogList) do
			self:_showDialog(v[1], v[2], v[3], v[4])

			if v[4] and v[4] > 0 then
				isNoSpeakAudio = false
			end
		end

		local offset = 0

		if isNoSpeakAudio then
			offset = CHAT_NO_AUDIO_OFFSET
		end

		self._layoutchatarea.padding.left = offset

		DungeonMapModel.instance:clearDialog()
		DungeonMapModel.instance:clearDialogId()
	end
end

function DungeonFragmentInfoView:fragmentInfoShowHandleFunc3(config)
	self._txtinfo3.text = config.content
	self._txttitle3.text = config.title

	gohelper.setActive(self._txtinfo3.gameObject, true)
end

function DungeonFragmentInfoView:fragmentInfoShowHandleFunc4(config)
	self._txtinfo4.text = config.content
	self._txttitle4.text = config.title

	gohelper.setActive(self._txtinfo4.gameObject, true)
end

function DungeonFragmentInfoView:fragmentInfoShowHandleFunc5(config)
	self._txtinfo5.text = config.content
	self._txttitle5.text = config.title

	gohelper.setActive(self._txtinfo5.gameObject, true)
end

return DungeonFragmentInfoView
