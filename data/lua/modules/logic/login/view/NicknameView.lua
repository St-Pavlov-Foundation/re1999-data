-- chunkname: @modules/logic/login/view/NicknameView.lua

module("modules.logic.login.view.NicknameView", package.seeall)

local NicknameView = class("NicknameView", BaseView)

function NicknameView:onInitView()
	self._goname = gohelper.findChild(self.viewGO, "#go_name")
	self._inputname = gohelper.findChildTextMeshInputField(self.viewGO, "#go_name/#input_name")
	self._goplaceholdertext = gohelper.findChildText(self.viewGO, "#go_name/#input_name/PlaceholderText")
	self._simageinputnamebg = gohelper.findChildSingleImage(self.viewGO, "#go_name/#input_name/#simage_inputnamebg")
	self._btnok = gohelper.findChildClick(self.viewGO, "#go_name/#btn_ok")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_name/#btn_ok/#go_normal")
	self._imagemask = gohelper.findChildImage(self.viewGO, "#image_mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NicknameView:addEvents()
	self._inputname:AddOnEndEdit(self._onInputNameEndEdit, self)
end

function NicknameView:removeEvents()
	self._inputname:RemoveOnEndEdit()
end

function NicknameView:_btnokOnClick()
	self:_checkLimit()

	local name = self._inputname:GetText()

	gohelper.setActive(self._gonormal, false)

	if string.nilorempty(name) or self._isChangePlayerName then
		return
	end

	self._nickName = name

	local sendRenameParam = {}

	sendRenameParam.name = name
	sendRenameParam.guideId = self.guideId
	sendRenameParam.stepId = self.stepId

	ViewMgr.instance:openView(ViewName.NicknameConfirmView, sendRenameParam)
end

function NicknameView:_checkLimit()
	local inputValue = self._inputname:GetText()
	local limit = CommonConfig.instance:getConstNum(ConstEnum.CharacterNameLimit)

	inputValue = GameUtil.utf8sub(inputValue, 1, math.min(GameUtil.utf8len(inputValue), limit))

	self._inputname:SetText(inputValue)
end

function NicknameView:_editableInitView()
	local parentGO = gohelper.findChild(self.viewGO, "#videobg")
	local tempGO = self:getResInst(AvProMgr.instance:getNicknameUrl(), parentGO)

	self._videoBg = gohelper.findChildComponent(tempGO, "#videobg", typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	self._videoBg.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
	self._listPlayer = gohelper.findChildComponent(tempGO, "#list_player", typeof(RenderHeads.Media.AVProVideo.PlaylistMediaPlayer))
	self._uguiListPlayer = gohelper.findChildComponent(tempGO, "#list_player", typeof(ZProj.AvProUGUIListPlayer))

	self._uguiListPlayer:SetEventListener(self._onVideoPlayEvent, self)
	self._uguiListPlayer:SetMediaPath(langVideoUrl("make_name_start"), 0)
	self._uguiListPlayer:SetMediaPath(langVideoUrl("make_name_loop"), 1)
	gohelper.setActive(self._goname, false)
	gohelper.setActive(self._gonormal, false)

	self._isPressSureBtn = false
	self._inputnameTMP = self._inputname:GetComponent("TMP_InputField")
	self._inputNameClickListener = SLFramework.UGUI.UIClickListener.Get(self._inputname.gameObject)

	self._inputNameClickListener:AddClickListener(self._hidePlaceholderText, self)
	self._simageinputnamebg:LoadImage(ResUrl.getNickNameIcon("mingmingzi_001"))
	self:_playStartVideo()
	gohelper.addUIClickAudio(self._btnok.gameObject, AudioEnum.UI.Play_UI_Copies)
	self:_checkIsGamepad()
end

function NicknameView:_checkIsGamepad()
	if SDKNativeUtil.isGamePad() then
		self._inputname:SetText(luaLang("mainrolename"))

		self._inputname.inputField.enabled = false

		gohelper.setActive(self._gonormal, true)
	end
end

function NicknameView:_hidePlaceholderText()
	gohelper.setAsFirstSibling(self._simageinputnamebg.gameObject)
	ZProj.UGUIHelper.SetColorAlpha(self._goplaceholdertext, 0.5)
end

function NicknameView:_onInputNameEndEdit()
	ZProj.UGUIHelper.SetColorAlpha(self._goplaceholdertext, 1)
	self:_checkLimit()
end

function NicknameView:_playStartVideo()
	self._listPlayer:Play()
	TaskDispatcher.runDelay(self._showInputUI, self, 2.1)
	AudioMgr.instance:trigger(AudioEnum.CriWare.Play_Name_Start)
	TaskDispatcher.runDelay(self._delayShowNameUI, self, 5)

	if SettingsModel.instance:getVideoCompatible() and BootNativeUtil.isWindows() then
		TaskDispatcher.runDelay(self._onJumpNext, self, 2.4)
	end
end

function NicknameView:_onJumpNext()
	self._listPlayer:JumpToItem(1)
end

function NicknameView:_showInputUI()
	gohelper.setActive(self._goname, true)
	self._uguiListPlayer:SetMediaPath(langVideoUrl("make_name_end"), 0)
end

function NicknameView:_delayShowNameUI()
	logError("播放起名字start视频超时了!")
	gohelper.setActive(self._goname, true)
end

function NicknameView:_playEndVideo()
	logNormal("NicknameView:_playEndVideo() ---------------------1")
	self._listPlayer:JumpToItem(0)
	AudioMgr.instance:trigger(AudioEnum.CriWare.Play_Name_Complete)
	TaskDispatcher.runDelay(self._delayCloseView, self, 8)
end

function NicknameView:_onVideoPlayEvent(path, status, errorCode)
	local pathSplits = string.split(path, "/")
	local videoName = pathSplits[#pathSplits]

	logNormal("NicknameView:_onVideoPlayEvent, videoName = " .. videoName .. " status = " .. AvProEnum.getPlayerStatusEnumName(status) .. " errorCode = " .. AvProEnum.getErrorCodeEnumName(errorCode))

	if videoName == "make_name_start.mp4" and status == AvProEnum.PlayerStatus.Started then
		TaskDispatcher.cancelTask(self._delayShowNameUI, self)
	end

	if videoName == "make_name_end.mp4" then
		if errorCode ~= AvProEnum.ErrorCode.None then
			self._listPlayer:Stop()
			TaskDispatcher.cancelTask(self._delayCloseView, self)
			gohelper.setActive(self._goname, false)
			self:closeThis()
		end

		if status == AvProEnum.PlayerStatus.FinishedPlaying then
			TaskDispatcher.cancelTask(self._delayCloseView, self)
			gohelper.setActive(self._goname, false)
			self:closeThis()
		end
	end
end

function NicknameView:_delayCloseView()
	logError("播放起名字end视频超时了")
	self._listPlayer:Stop()
	gohelper.setActive(self._goname, false)
	self:closeThis()
end

function NicknameView:onUpdateParam()
	return
end

function NicknameView:onOpen()
	if self.viewParam then
		self.guideId = self.viewParam.guideId
		self.stepId = self.viewParam.stepId
		self.fadeTime = self.viewParam.viewParam
	end

	self:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerName, self._onChangePlayerName, self)
	self:addEventCb(PlayerController.instance, PlayerEvent.NickNameConfirmNo, self._onConfirmNo, self)
	self:addEventCb(PlayerController.instance, PlayerEvent.NickNameConfirmYes, self._onConfirmYes, self)
	self._inputname:AddOnValueChanged(self._inputValueChanged, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
	AudioMgr.instance:trigger(AudioEnum.Bgm.play_ui_nameitsfx_music)
end

function NicknameView:_onConfirmNo()
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._goname, true)

	self._inputnameTMP.interactable = true
end

function NicknameView:_onConfirmYes()
	self._inputnameTMP.interactable = false

	gohelper.setActive(self._goname, false)
end

function NicknameView:_inputValueChanged()
	local inputValue = self._inputname:GetText()

	gohelper.setActive(self._gonormal, not string.nilorempty(inputValue))
end

function NicknameView:_onChangePlayerName()
	self._isChangePlayerName = true

	TaskDispatcher.runDelay(self._playStory, self, 0.333)
end

function NicknameView:_playStory()
	local storyId

	storyId = self:_specialName(string.lower(self._nickName)) and 100012 or 100011
	StoryModel.instance.skipFade = true
	module_views.StoryBackgroundView.viewType = ViewType.Normal

	local param = {}

	param.hideBtn = true

	StoryController.instance:playStory(storyId, param, self._playStoryEnd, self)

	local roleInfo = StatModel.instance:generateRoleInfo()

	SDKMgr.instance:createRole(roleInfo)
	SDKMgr.instance:enterGame(roleInfo)
end

function NicknameView:_specialName(name)
	local constStr = CommonConfig.instance:getConstStr(ConstEnum.NickName)
	local list = string.split(constStr, "#")

	for i, v in ipairs(list) do
		if name == v then
			return true
		end
	end
end

function NicknameView:_playStoryEnd()
	StoryModel.instance.skipFade = false
	module_views.StoryBackgroundView.viewType = ViewType.Full

	self:_playEndVideo()
end

function NicknameView:_fade()
	gohelper.setActive(self._imagemask.gameObject, true)

	local time = self.fadeTime or 2

	ZProj.TweenHelper.DoFade(self._imagemask, 0, 1, time, function()
		self:closeThis()
	end)
end

function NicknameView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)
	self._inputname:RemoveOnValueChanged()
	self._btnok:RemoveClickListener()

	if self._inputNameClickListener then
		self._inputNameClickListener:RemoveClickListener()

		self._inputNameClickListener = nil
	end

	TaskDispatcher.cancelTask(self._delayShowNameUI, self)
	TaskDispatcher.cancelTask(self._delayCloseView, self)
	TaskDispatcher.cancelTask(self._playStory, self)
	TaskDispatcher.cancelTask(self._showInputUI, self)
	TaskDispatcher.cancelTask(self._onJumpNext, self)
end

function NicknameView:onDestroyView()
	self._simageinputnamebg:UnLoadImage()
	self._uguiListPlayer:Clear()

	self._uguiListPlayer = nil
	self._listPlayer = nil
end

return NicknameView
