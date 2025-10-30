﻿-- chunkname: @modules/logic/herogroup/view/CharacterSkillContainer.lua

module("modules.logic.herogroup.view.CharacterSkillContainer", package.seeall)

local CharacterSkillContainer = class("CharacterSkillContainer", LuaCompBase)
local AnimKey_ReplaceSkillEvent = "ReplaceSkill"
local AnimKey_ReplaceSkill_ndk = "ndk"
local AnimKey_ReplaceSkill_Click = "CharacterSkillContainer_Click"

function CharacterSkillContainer:ctor(posParam)
	self._param = posParam
end

function CharacterSkillContainer:init(go)
	self._goskills = gohelper.findChild(go, "line/go_skills")
	self._skillitems = self:getUserDataTb_()

	for i = 1, 3 do
		local item = gohelper.findChild(self._goskills, "skillicon" .. tostring(i))
		local o = {}

		o.icon = gohelper.findChildSingleImage(item, "imgIcon")
		o.tag = gohelper.findChildSingleImage(item, "tag/tagIcon")
		o.btn = gohelper.findChildButtonWithAudio(item, "bg", AudioEnum.UI.Play_ui_role_description)
		o.index = i
		o.go = item

		o.btn:AddClickListener(self._onSkillCardClick, self, o.index)

		self._skillitems[i] = o
	end

	self._reddot = gohelper.findChild(go, "line/#RedDot")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._animationEvent = go:GetComponent(typeof(ZProj.AnimationEventWrap))

	if self._animationEvent then
		self._animationEvent:AddEventListener(AnimKey_ReplaceSkillEvent, self._replaceSkill, self)
	end

	if self._anim then
		self._animationPlayer = SLFramework.AnimatorPlayer.Get(go)
	end
end

function CharacterSkillContainer:onDestroy()
	for i = 1, 3 do
		self._skillitems[i].btn:RemoveClickListener()
		self._skillitems[i].icon:UnLoadImage()
		self._skillitems[i].tag:UnLoadImage()
	end

	if self._animationEvent then
		self._animationEvent:RemoveEventListener(AnimKey_ReplaceSkillEvent)
	end
end

function CharacterSkillContainer:onUpdateMO(heroId, showAttributeOption, heroMo, isBalance)
	self._heroId = heroId
	self._heroName = HeroConfig.instance:getHeroCO(self._heroId).name
	self._heroMo = heroMo
	self._isBalance = isBalance
	self._showAttributeOption = showAttributeOption or CharacterEnum.showAttributeOption.ShowCurrent

	self:_refreshSkillUI()
end

function CharacterSkillContainer:_refreshSkillUI()
	if self._heroId then
		local skillIdDict = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(self._heroId, self._showAttributeOption, self._heroMo)

		self:_showSkillUI(skillIdDict)
	end
end

function CharacterSkillContainer:_showSkillUI(skillIdDict)
	for i, skillId in pairs(skillIdDict) do
		local hasSkill = skillId ~= 0

		if hasSkill then
			local skillCO = lua_skill.configDict[skillId]

			if not skillCO then
				logError(string.format("heroID : %s, skillId not found : %s", self._heroId, skillId))
			end

			self._skillitems[i].icon:LoadImage(ResUrl.getSkillIcon(skillCO.icon))
			self._skillitems[i].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillCO.showTag))
			gohelper.setActive(self._skillitems[i].tag.gameObject, i ~= 3)
		end

		gohelper.setActive(self._skillitems[i].go.gameObject, hasSkill)
	end
end

function CharacterSkillContainer:_onSkillCardClick(index)
	if self._heroId then
		local info = {}
		local skillDict = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(self._heroId, self._showAttributeOption, self._heroMo)

		info.super = index == 3
		info.skillIdList = skillDict[index]
		info.isBalance = self._isBalance
		info.monsterName = self._heroName
		info.heroId = self._heroId
		info.heroMo = self._heroMo
		info.skillIndex = index

		if self._param then
			info.anchorX = self._param.skillTipX
			info.anchorY = self._param.skillTipY
			info.adjustBuffTip = self._param.adjustBuffTip
			info.showAssassinBg = self._param.showAssassinBg
		end

		ViewMgr.instance:openView(ViewName.SkillTipView, info)

		local isOverRank, isCanShow = CharacterModel.instance:isNeedShowNewSkillReddot(self._heroMo)

		if isOverRank and isCanShow then
			CharacterModel.instance:cencelCardReddot(self._heroId)
		end

		self:_showSkillReddot(false)
	end
end

function CharacterSkillContainer:_replaceSkill()
	CharacterModel.instance:cencelPlayReplaceSkillAnim(self._heroMo)
	self:_refreshSkillUI()
end

function CharacterSkillContainer:onFinishreplaceSkillAnim()
	if self._isPlayReplaceSkillAnim then
		UIBlockMgr.instance:endBlock(AnimKey_ReplaceSkill_Click)

		self._isPlayReplaceSkillAnim = nil
	end
end

function CharacterSkillContainer:checkShowReplaceBeforeSkillUI()
	if not self._anim then
		return
	end

	if self._heroMo then
		local isCanPlayAnim, isCanShow = CharacterModel.instance:isCanPlayReplaceSkillAnim(self._heroMo)

		isCanPlayAnim = isCanPlayAnim and self._heroMo:isOwnHero()
		isCanShow = isCanShow and self._heroMo:isOwnHero()

		if isCanPlayAnim then
			local heroCo = self._heroMo.config
			local skillStr = heroCo.skill
			local exSkillStr = heroCo.exSkill
			local skillIdDict = SkillConfig.instance:getHeroBaseSkillIdDictByStr(skillStr, exSkillStr)

			self:_showSkillUI(skillIdDict)
			self._animationPlayer:Play(AnimKey_ReplaceSkill_ndk, self.onFinishreplaceSkillAnim, self)
			UIBlockMgrExtend.setNeedCircleMv(false)
			UIBlockMgr.instance:startBlock(AnimKey_ReplaceSkill_Click)
			TaskDispatcher.runDelay(self.playNuodikaReplaceSkillAudio, self, 0.5)

			self._isPlayReplaceSkillAnim = true
		end

		self:_showSkillReddot(isCanShow)
	else
		self:_showSkillReddot(false)
	end
end

function CharacterSkillContainer:clearDelay()
	TaskDispatcher.cancelTask(self.playNuodikaReplaceSkillAudio, self)
end

function CharacterSkillContainer:playNuodikaReplaceSkillAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_nuodika)
end

function CharacterSkillContainer:_showSkillReddot(isNeedPlay)
	if self._reddot then
		gohelper.setActive(self._reddot.gameObject, isNeedPlay)
	end
end

return CharacterSkillContainer
