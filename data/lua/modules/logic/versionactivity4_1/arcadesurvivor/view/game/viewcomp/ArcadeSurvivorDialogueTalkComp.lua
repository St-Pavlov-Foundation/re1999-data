-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/viewcomp/ArcadeSurvivorDialogueTalkComp.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.viewcomp.ArcadeSurvivorDialogueTalkComp", package.seeall)

local ArcadeSurvivorDialogueTalkComp = class("ArcadeSurvivorDialogueTalkComp", LuaCompBase)

function ArcadeSurvivorDialogueTalkComp:ctor()
	self._groupId = nil
	self._step = nil
	self._contentList = nil
	self._contentIndex = 0
	self._lastShowContentTime = nil
	self._isWaitingNextStep = false
end

function ArcadeSurvivorDialogueTalkComp:init(go)
	self.go = go
	self._godialogue = gohelper.findChild(self.go, "#go_dialogue")
	self._dialogueAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self._godialogue)
	self._simagedialogueicon = gohelper.findChildSingleImage(self.go, "#go_dialogue/mask/simage_icon")
	self._txtdialoguename = gohelper.findChildText(self.go, "#go_dialogue/#txt_name")
	self._scrolldialogue = gohelper.findChildScrollRect(self.go, "#go_dialogue/#scroll_desc")
	self._txtdialoguedesc = gohelper.findChildText(self.go, "#go_dialogue/#scroll_desc/Viewport/Content/#txt_desc")
	self._btndialogueclick = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.go, "#btn_click")
	self._spawnInterval = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.TalkIntervalTime, true) / ArcadeSurvivorEnum.Const.PermillageBase
	self._nextStepTime = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.NextStepTimeMS, true) / ArcadeSurvivorEnum.Const.PermillageBase

	gohelper.setActive(self.go, false)
end

function ArcadeSurvivorDialogueTalkComp:addEventListeners()
	self._btndialogueclick:AddClickListener(self._onDialogueClick, self)
end

function ArcadeSurvivorDialogueTalkComp:removeEventListeners()
	self._btndialogueclick:RemoveClickListener()
end

function ArcadeSurvivorDialogueTalkComp:playTalk(groupId)
	if not groupId then
		return
	end

	self._groupId = groupId
	self._step = 1
	self._contentIndex = 0
	self._contentList = nil
	self._lastShowContentTime = nil
	self._isWaitingNextStep = false

	ArcadeSurvivorGameController.instance:pauseGame(ArcadeSurvivorGameEnum.StopSource.DialogTalk)
	gohelper.setActive(self.go, true)
	self._dialogueAnimatorPlayer:Play("open", nil, nil)
	AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivor.play_ui_atlantis_dialogue_loop)
	self:_playStep()
end

function ArcadeSurvivorDialogueTalkComp:endTalk(isHideImmediately)
	local isOpen = self._groupId ~= nil

	self._groupId = nil
	self._step = nil
	self._contentList = nil
	self._contentIndex = 0
	self._lastShowContentTime = nil
	self._isWaitingNextStep = false

	if not isOpen then
		gohelper.setActive(self.go, false)

		return
	end

	ArcadeSurvivorGameController.instance:resumeGame(ArcadeSurvivorGameEnum.StopSource.DialogTalk)
	AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivor.stop_ui_atlantis_dialogue_loop)

	if isHideImmediately then
		self._dialogueAnimatorPlayer:Stop()
		gohelper.setActive(self.go, false)
	else
		self._dialogueAnimatorPlayer:Play("close", self._hideDialogue, self)
	end
end

function ArcadeSurvivorDialogueTalkComp:_hideDialogue()
	gohelper.setActive(self.go, false)
end

function ArcadeSurvivorDialogueTalkComp:onUpdate()
	if not self._groupId or not self._contentList then
		return
	end

	if self._scrolldialogue.verticalNormalizedPosition > 0 then
		self._scrolldialogue.verticalNormalizedPosition = 0
	end

	local currentTime = Time.time

	if not self._isWaitingNextStep then
		if currentTime - self._lastShowContentTime < self._spawnInterval then
			return
		end

		self._contentIndex = self._contentIndex + 1

		self:_showContent(self._contentList[self._contentIndex])

		self._lastShowContentTime = currentTime

		if self._contentIndex >= #self._contentList then
			self._isWaitingNextStep = true
		end
	elseif currentTime - self._lastShowContentTime >= self._nextStepTime then
		self:_playNextStep()
	end
end

function ArcadeSurvivorDialogueTalkComp:_onDialogueClick()
	if not self._groupId then
		return
	end

	if self._isWaitingNextStep then
		self:_playNextStep()
	elseif self._contentIndex < #self._contentList then
		local currentTime = Time.time

		self._contentIndex = #self._contentList

		self:_showContent(self._contentList[#self._contentList])

		self._lastShowContentTime = currentTime
		self._isWaitingNextStep = true
	end
end

function ArcadeSurvivorDialogueTalkComp:_playStep()
	local stepCfg = ArcadeSurvivorConfig.instance:getDialogStepCfg(self._groupId, self._step, true)

	if not stepCfg then
		self:endTalk()

		return
	end

	local groupId, step = self._groupId, self._step

	self._txtdialoguename.text = ArcadeSurvivorConfig.instance:getDialogStepName(groupId, step) or ""

	self._simagedialogueicon:LoadImage(ResUrl.getArcadeSurvivorIcon(ArcadeSurvivorConfig.instance:getDialogStepAvatar(groupId, step)))

	self._contentList = ArcadeSurvivorGameHelper.getTalkCharList(ArcadeSurvivorConfig.instance:getDialogStepContent(groupId, step))
	self._contentIndex = 0
	self._lastShowContentTime = Time.time
	self._isWaitingNextStep = false

	self:_showContent("")
end

function ArcadeSurvivorDialogueTalkComp:_playNextStep()
	local nextStepCfg = ArcadeSurvivorConfig.instance:getDialogStepCfg(self._groupId, self._step + 1)

	if not nextStepCfg then
		self:endTalk()

		return
	end

	self._step = self._step + 1
	self._contentList = nil
	self._lastShowContentTime = nil

	self:_playStep()
end

function ArcadeSurvivorDialogueTalkComp:_showContent(content)
	self._txtdialoguedesc.text = content
end

function ArcadeSurvivorDialogueTalkComp:onDestroy()
	self:endTalk(true)
end

return ArcadeSurvivorDialogueTalkComp
