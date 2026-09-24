-- chunkname: @modules/logic/matchgame/outside/character/MatchGameDevelopView.lua

module("modules.logic.matchgame.outside.character.MatchGameDevelopView", package.seeall)

local MatchGameDevelopView = class("MatchGameDevelopView", BaseView)
local PercentColor = "#897519"
local BracketColor = "#897519"

function MatchGameDevelopView:onInitView()
	self._scrollCharacter = gohelper.findChild(self.viewGO, "#scroll_Character")
	self._goCharacterItem = gohelper.findChild(self.viewGO, "#scroll_Character/Viewport/Content/#go_CharacterItem")
	self._goCharacterMesh = gohelper.findChild(self.viewGO, "#go_CharacterMesh")
	self._goCharacterLock = gohelper.findChild(self.viewGO, "#go_CharacterMesh/#image_CharacterIcon/#go_LockCharacter")
	self._goActiveEffect = gohelper.findChild(self.viewGO, "#go_CharacterMesh/#image_CharacterIcon/#go_LockCharacter/mask/unlockable_eff")
	self._goDetailArea = gohelper.findChild(self.viewGO, "#go_DetailArea")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_DetailArea/#txt_Name")
	self._imageCareerIcon = gohelper.findChildImage(self.viewGO, "#go_DetailArea/#image_CareerIcon")
	self._txtCareerName = gohelper.findChildText(self.viewGO, "#go_DetailArea/#txt_CareerName")
	self._txtLevel = gohelper.findChildText(self.viewGO, "#go_DetailArea/#txt_Level")
	self._goAttrContainer = gohelper.findChild(self.viewGO, "#go_DetailArea/#go_AttrContainer")
	self._goAttrItem = gohelper.findChild(self.viewGO, "#go_DetailArea/#go_AttrContainer/#go_AttrItem")
	self._btnLvUp = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_LvUp")
	self._goLvUpCost = gohelper.findChild(self.viewGO, "#btn_LvUp/#go_LvUpCost")
	self._goLvUpEffect = gohelper.findChild(self.viewGO, "#btn_LvUp/upgradeable_eff")
	self._btnActive = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Active")
	self._goActiveCost = gohelper.findChild(self.viewGO, "#btn_Active/#go_ActiveCost")
	self._goSkillContent = gohelper.findChild(self.viewGO, "#scroll_Skill/Viewport/Content")
	self._goSkillItem = gohelper.findChild(self.viewGO, "#scroll_Skill/Viewport/Content/#go_SkillItem")
	self._goLevelUpEffect = gohelper.findChild(self.viewGO, "UIEff_Upgrade")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameDevelopView:addEvents()
	self._btnLvUp:AddClickListener(self._btnLvUpOnClick, self)
	self._btnActive:AddClickListener(self._btnActiveOnClick, self)
	self:addEventCb(MatchGameController.instance, MatchGameEvent.OnUpdateCharacter, self._onUpdateCharacter, self)
end

function MatchGameDevelopView:removeEvents()
	self._btnLvUp:RemoveClickListener()
	self._btnActive:RemoveClickListener()
end

function MatchGameDevelopView:_btnLvUpOnClick()
	if not self._isItemEnough then
		GameFacade.showToast(ToastEnum.MatchGameItemNotEnough)

		return
	end

	if not self._isCanUnlock then
		return
	end

	AudioMgr.instance:trigger(MatchGameAudioEnum.LevelUpCharacter)
	gohelper.setActive(self._goLevelUpEffect, false)
	gohelper.setActive(self._goLevelUpEffect, true)
	MatchGameRpc.instance:sendAct244UpgradeHeroRequest(self._actId, self._selectCharacterId)
end

function MatchGameDevelopView:_btnActiveOnClick()
	if not self._isItemEnough then
		GameFacade.showToast(ToastEnum.MatchGameItemNotEnough)

		return
	end

	if not self._isCanUnlock then
		local episodeCo = lua_activity244_episode.configDict[self._unlockType]
		local episodeName = episodeCo and episodeCo.levelName

		GameFacade.showToast(ToastEnum.MatchGameNotPassEpisode, episodeName)

		return
	end

	AudioMgr.instance:trigger(MatchGameAudioEnum.UnlockCharacter)
	MatchGameRpc.instance:sendAct244BuyHeroRequest(self._actId, self._selectCharacterId)
end

function MatchGameDevelopView:_editableInitView()
	self._actId = MatchGameModel.instance:getCurActId()
	self._iconComp = MatchGameCharacterIconComp.Get(self._goCharacterMesh)
	self._iconAnimator = gohelper.findChildAnim(self.viewGO, "#go_CharacterMesh/#image_CharacterIcon")
	self._activeCostComp = MatchGameCostComp.Get(self._goActiveCost)
	self._lvUpCostComp = MatchGameCostComp.Get(self._goLvUpCost)

	MatchGameController.instance:onEnterDevelopView()
	gohelper.setActive(self._goLevelUpEffect, false)
	gohelper.setActive(self._goLvUpEffect, false)
	gohelper.setActive(self._goActiveEffect, false)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	self:initCharacterScroll()
end

function MatchGameDevelopView:onOpen()
	self._animator:Play("open", 0, 0)

	self._isFirstEnter = true

	self:refreshUI()
end

function MatchGameDevelopView:refreshUI()
	self:refreshCharacterList()
end

function MatchGameDevelopView:refreshCharacterList()
	local allCharacterList = MatchGameConfig.instance:getNotTrialCharacterList()
	local selectIndex = self._characterScroll:getSelect() or 1

	self._characterScroll:setData(allCharacterList)
	self._characterScroll:setSelect(selectIndex)
end

function MatchGameDevelopView:initCharacterScroll()
	if self._characterScroll then
		return
	end

	local listParam = SimpleListParam.New()

	listParam.cellClass = MatchGameDevelopCharacterListItem
	listParam.lineCount = 2
	listParam.cellWidth = 186
	listParam.cellHeight = 180
	listParam.cellSpaceH = 0
	listParam.cellSpaceV = 0
	listParam.scrollDir = ScrollEnum.ScrollDirV
	listParam.isClickAutoSelect = true

	local scrollParam = {
		listParam = listParam,
		viewContainer = self.viewContainer
	}

	self._characterScroll = MonoHelper.addNoUpdateLuaComOnceToGo(self._scrollCharacter, SimpleListComp, scrollParam)

	self._characterScroll:setRes(self._goCharacterItem)
	self._characterScroll:onCreate()
	self._characterScroll:setOnSelectChange(self._onSelectCharacterChange, self)
end

function MatchGameDevelopView:_onSelectCharacterChange(selectItem, selectIndex, oldSelectIndex)
	local dataList = self._characterScroll and self._characterScroll.datas
	local selectCharacterCo = dataList and dataList[selectIndex]

	if not selectCharacterCo then
		return
	end

	self._preSelectCharacterId = self._selectCharacterId
	self._preSelectCharacterStatus = self._status
	self._selectCharacterCo = selectCharacterCo or self._selectCharacterCo
	self._selectCharacterId = self._selectCharacterCo and self._selectCharacterCo.characterId

	if not self._isFirstEnter then
		self._animator:Play("switch", 0, 0)
		UIBlockHelper.instance:startBlock(self.viewName, 0.16, self.viewName)
		TaskDispatcher.cancelTask(self.refreshCharacterDetail, self)
		TaskDispatcher.runDelay(self.refreshCharacterDetail, self, 0.16)
	else
		self:refreshCharacterDetail()
	end

	self._isFirstEnter = false
end

function MatchGameDevelopView:refreshCharacterDetail()
	if not self._selectCharacterCo then
		return
	end

	self._selectCharacterMo = MatchGameModel.instance:getCharacterMo(self._selectCharacterId)
	self._selectCharacterLv = self._selectCharacterMo and self._selectCharacterMo.level or 0
	self._selectShowLv = math.max(self._selectCharacterLv, 1)
	self._status = MatchGameModel.instance:getCharacterStatus(self._selectCharacterId)

	gohelper.setActive(self._goCharacterLock, self._status <= MatchGameEnum.CharacterStatus.Unlock)
	self._iconComp:setData(self._selectCharacterId)

	self._txtName.text = self._selectCharacterCo.name

	MatchGameHelper.setCharacterElement(self._selectCharacterCo.elementId, self._imageCareerIcon, self._txtCareerName)

	local maxLv = MatchGameConfig.instance:getCharacterMaxLevel(self._selectCharacterId)

	self._isMaxLv = maxLv <= self._selectCharacterLv
	self._txtLevel.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("matchgamedevelopview_level"), self._selectShowLv, maxLv)

	self:refreshCost()
	self:refreshBtn()
	self:refreshAttrList()
	self:refreshSkillList()
	self:playIconAnim()
end

function MatchGameDevelopView:refreshCost()
	if self._isMaxLv then
		return
	end

	local costItemList = MatchGameConfig.instance:getCharacterLevelUpCost(self._selectCharacterId, self._selectCharacterLv + 1)

	self._isItemEnough = MatchGameModel.instance:isItemEnough(costItemList)

	self._activeCostComp:onUpdateMO(costItemList)
	self._lvUpCostComp:onUpdateMO(costItemList)
end

function MatchGameDevelopView:refreshBtn()
	local showActiveBtn = self._status <= MatchGameEnum.CharacterStatus.Unlock
	local showLvBtn = self._status == MatchGameEnum.CharacterStatus.Active and not self._isMaxLv

	gohelper.setActive(self._btnActive.gameObject, showActiveBtn)
	gohelper.setActive(self._btnLvUp.gameObject, showLvBtn)

	self._isCanUnlock = true
	self._unlockType = tonumber(self._selectCharacterCo.unlockType)

	if self._unlockType and self._unlockType ~= 0 then
		self._isCanUnlock = MatchGameModel.instance:getEpisodeStatus(self._unlockType) >= MatchGameEnum.EpisodeStatus.Finish
	end

	local isCanActive = self._isCanUnlock and self._isItemEnough

	ZProj.UGUIHelper.SetGrayscale(self._btnActive.gameObject, not isCanActive)
	ZProj.UGUIHelper.SetGrayscale(self._btnLvUp.gameObject, not isCanActive)
	gohelper.setActive(self._goLvUpEffect, isCanActive)
	gohelper.setActive(self._goActiveEffect, isCanActive)
end

function MatchGameDevelopView:refreshAttrList()
	local attrList = lua_activity244_character_attr.configList

	gohelper.CreateObjList(self, self._refreshAttrItem, attrList, self._goAttrContainer, self._goAttrItem)
end

function MatchGameDevelopView:_refreshAttrItem(goItem, attrCo, index)
	local imageIcon = gohelper.findChildImage(goItem, "image_Icon")
	local txtName = gohelper.findChildText(goItem, "txt_Name")
	local txtValue = gohelper.findChildText(goItem, "txt_Value")
	local attrType = attrCo.id

	MatchGameHelper.setCharacterAttr(attrType, imageIcon, txtName)

	local attrValue = MatchGameModel.instance:getCharacterAttrValue(self._selectCharacterId, self._selectShowLv, attrType)

	txtValue.text = attrValue
end

function MatchGameDevelopView:refreshSkillList()
	local skillIdList = string.splitToNumber(self._selectCharacterCo.activeSkillId, "#")

	gohelper.CreateObjList(self, self._refreshSkillItem, skillIdList, self._goSkillContent, self._goSkillItem)
end

function MatchGameDevelopView:_refreshSkillItem(goItem, skillId, index)
	local txtName = gohelper.findChildText(goItem, "namebg/txt_Name")
	local txtDesc = gohelper.findChildText(goItem, "txt_Desc")
	local goTagList = gohelper.findChild(goItem, "go_TagList")
	local goTagItem = gohelper.findChild(goItem, "go_TagList/go_TagItem")
	local skillCo = lua_activity244_character_skill.configDict[skillId]

	txtName.text = skillCo and skillCo.name
	txtDesc.text = SkillHelper.buildDesc(skillCo and skillCo.desc or "", PercentColor, BracketColor)

	local tagList = string.split(skillCo.skillTag, "|") or {}

	gohelper.CreateObjList(self, self._refreshSkillTag, tagList, goTagList, goTagItem)
end

function MatchGameDevelopView:_refreshSkillTag(goItem, tag, index)
	local txtTag = gohelper.findChildText(goItem, "txt_TagName")

	txtTag.text = tag
end

function MatchGameDevelopView:playIconAnim()
	if self._preSelectCharacterId == self._selectCharacterId and self._preSelectCharacterStatus ~= self._status and self._status == MatchGameEnum.CharacterStatus.Active then
		self._iconAnimator:Play("unlock")

		return
	end

	local isUnlock = self._status == MatchGameEnum.CharacterStatus.Active

	self._iconAnimator:Play(isUnlock and "unlocked" or "locked")
end

function MatchGameDevelopView:_onUpdateCharacter()
	self:refreshUI()
end

function MatchGameDevelopView:onClose()
	UIBlockHelper.instance:endBlock(self.viewName)
	TaskDispatcher.cancelTask(self.refreshCharacterDetail, self)
end

function MatchGameDevelopView:onDestroyView()
	return
end

return MatchGameDevelopView
