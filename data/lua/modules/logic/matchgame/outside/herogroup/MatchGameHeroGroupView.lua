-- chunkname: @modules/logic/matchgame/outside/herogroup/MatchGameHeroGroupView.lua

module("modules.logic.matchgame.outside.herogroup.MatchGameHeroGroupView", package.seeall)

local MatchGameHeroGroupView = class("MatchGameHeroGroupView", BaseView)

function MatchGameHeroGroupView:onInitView()
	self._gonormalbg = gohelper.findChild(self.viewGO, "root/#go_normalbg")
	self._gochallengebg = gohelper.findChild(self.viewGO, "root/#go_challengebg")
	self._btntalent = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btn/#btn_talent")
	self._godevelopreddot = gohelper.findChild(self.viewGO, "root/#go_btn/#btn_talent/#go_developreddot")
	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "root/#go_btn/#drop_herogroup")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btn/#btn_start")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_info")
	self._gospcondition = gohelper.findChild(self.viewGO, "root/#scroll_info/infocontain/targetcontain/targetList/#go_specialcondition")
	self._gospcondition1 = gohelper.findChild(self.viewGO, "root/#scroll_info/infocontain/targetcontain/targetList/#go_specialcondition/condition_1")
	self._txtround = gohelper.findChildText(self.viewGO, "root/#scroll_info/infocontain/targetcontain/targetList/#go_specialcondition/condition_1/#txt_round")
	self._gospcondition2 = gohelper.findChild(self.viewGO, "root/#scroll_info/infocontain/targetcontain/targetList/#go_specialcondition/condition_2")
	self._imageelement = gohelper.findChildImage(self.viewGO, "root/#scroll_info/infocontain/targetcontain/targetList/#go_specialcondition/condition_2/#image_enemyCareer")
	self._txtelement = gohelper.findChildText(self.viewGO, "root/#scroll_info/infocontain/targetcontain/targetList/#go_specialcondition/condition_2/#txt_enemynum")
	self._gonormalcondition = gohelper.findChild(self.viewGO, "root/#scroll_info/infocontain/targetcontain/targetList/#go_normallist/#go_normalcondition")
	self._btnenemy = gohelper.findChildButtonWithAudio(self.viewGO, "root/#scroll_info/infocontain/enemycontain/enemytitle/#btn_enemy")
	self._gorecommendAttr = gohelper.findChild(self.viewGO, "root/#scroll_info/infocontain/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "root/#scroll_info/infocontain/#go_recommendAttr/attrlist/#go_attritem")
	self._imageattr = gohelper.findChildImage(self.viewGO, "root/#scroll_info/infocontain/recommendAttr/#go_recommendAttr/#go_attritem/#image_attr")
	self._txtattr = gohelper.findChildText(self.viewGO, "root/#scroll_info/infocontain/recommendAttr/#go_recommendAttr/#go_attritem/#txt_attr")
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "root/herogroupcontain")
	self._goarrow = gohelper.findChild(self.viewGO, "root/#go_arrow")
	self._txtlevelname = gohelper.findChildText(self.viewGO, "root/levelnamebg/#txt_levelname")
	self._txtherohp = gohelper.findChildText(self.viewGO, "root/herogroupcontain/hp/#txt_heroHp")
	self._imagehpicon = gohelper.findChildImage(self.viewGO, "root/herogroupcontain/hp/txt_teamhp/#image_hpicon")
	self._posNodes = {}
	self._bgNodes = {}

	for i = 1, MatchGameEnum.HeroGroupMaxHeroCount do
		self._posNodes[i] = gohelper.findChild(self.viewGO, "root/herogroupcontain/area/pos" .. i)
		self._bgNodes[i] = gohelper.findChild(self.viewGO, "root/herogroupcontain/hero/bg" .. i)
	end

	self._btntalent = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btn/#btn_talent")
	self._dropherogrouparrow = gohelper.findChild(self.viewGO, "root/#go_btn/#drop_herogroup/arrow").transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameHeroGroupView:addEvents()
	self._btnstart:AddClickListener(self._onClickStart, self)
	self._btnenemy:AddClickListener(self._onClickEnemy, self)
	self._btntalent:AddClickListener(self._onClickTalent, self)
	self._dropherogroup:AddOnValueChanged(self._onTeamDropValueChanged, self)
	self:addEventCb(MatchGameController.instance, MatchGameEvent.OnSwitchTeam, self._onSwitchTeam, self)
	self:addEventCb(MatchGameController.instance, MatchGameEvent.OnSaveTeamSuccess, self._onSaveTeamSuccess, self)
	self:addEventCb(MatchGameController.instance, MatchGameEvent.OnSwapHeroError, self._onSwapHeroError, self)
	self:addEventCb(MatchGameController.instance, MatchGameEvent.OnUpdateCharacter, self._onCharacterUpdated, self)
end

function MatchGameHeroGroupView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnenemy:RemoveClickListener()
	self._btntalent:RemoveClickListener()
	self._dropherogroup:RemoveOnValueChanged()
end

function MatchGameHeroGroupView:_editableInitView()
	self._heroCardItems = self:getUserDataTb_()

	self:_createDragOverlay()

	self._heroAnimator = gohelper.findChildAnim(self.viewGO, "root/herogroupcontain")

	MatchGameHelper.setCharacterAttr(MatchGameEnum.CharacterAttrType.Hp, self._imagehpicon)
	RedDotController.instance:addRedDot(self._godevelopreddot, RedDotEnum.DotNode.MatchGameDevelopEntry)
end

function MatchGameHeroGroupView:_createDragOverlay()
	local rootGo = gohelper.findChild(self.viewGO, "root")

	self._godragOverlay = gohelper.create2d(rootGo, "dragOverlay")

	local overlayRect = self._godragOverlay.transform

	overlayRect.anchorMin = Vector2.zero
	overlayRect.anchorMax = Vector2.one
	overlayRect.sizeDelta = Vector2.zero
	overlayRect.anchoredPosition = Vector2.zero

	gohelper.setActive(self._godragOverlay, false)
end

function MatchGameHeroGroupView:checkParam()
	self._curTeamId = MatchGameHeroGroupModel.instance:getCurTeamId()
	self._episodeId = MatchGameLevelModel.instance:getCurEpisodeId()
	self._episodeCo = MatchGameLevelModel.instance:getCurEpisodeCo()
	self._episodeMo = self._episodeCo and MatchGameLevelModel.instance:getEpisodeInfoById(self._episodeCo.id)
	self._isTeachEpisode = MatchGameConfig.instance:isTeachEpisode(self._episodeId)
end

function MatchGameHeroGroupView:onUpdateParam()
	return
end

function MatchGameHeroGroupView:onOpen()
	MatchGameHeroGroupModel.instance:initTeamList()
	MatchGameHeroGroupModel.instance:checkTeachTeam()
	self:checkParam()
	self:_loadHeroCardItems()
	self:refreshUI()
end

function MatchGameHeroGroupView:onClose()
	self._heroAnimator:Play("herogroupcontain_out", 0, 0)
	GameUtil.onDestroyViewMember_TweenId(self, "_revertTweenId")
	GameUtil.onDestroyViewMember_TweenId(self, "_successTweenId")
	GameUtil.onDestroyViewMember_TweenId(self, "_errorTweenId")
	UIBlockHelper.instance:endBlock(self.viewName)
end

function MatchGameHeroGroupView:onDestroyView()
	return
end

function MatchGameHeroGroupView:_loadHeroCardItems()
	for i = 1, MatchGameEnum.HeroGroupMaxHeroCount do
		local posGo = self._posNodes[i]
		local goRoot = gohelper.findChild(posGo, "root")
		local goContainer = gohelper.findChild(posGo, "root/container")

		self:getResInst(MatchGameEnum.CommonHeroCardItemPrefabPath, goContainer, "go_Icon")

		local cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(goRoot, MatchGameHeroCardItem)

		cardItem:setPosIndex(i)
		cardItem:setInteractionCallback(self._onCardInteraction, self)

		self._heroCardItems[i] = cardItem
	end
end

function MatchGameHeroGroupView:refreshUI()
	self:_refreshBg()
	self:_refreshHeroCards()
	self:_refreshLevelInfo()
	self:_refreshTeamDropdown()
end

function MatchGameHeroGroupView:_refreshBg()
	local levelType = MatchGameConfig.instance:getEpisodeLevelType(self._episodeId)

	gohelper.setActive(self._gonormalbg, levelType == MatchGameEnum.LevelType.Normal)
	gohelper.setActive(self._gochallengebg, levelType == MatchGameEnum.LevelType.Challenge)
end

function MatchGameHeroGroupView:_refreshHeroCards()
	local teamHeroes = MatchGameHeroGroupModel.instance:getCurTeamHeroes()

	for i = 1, MatchGameEnum.HeroGroupMaxHeroCount do
		local cardItem = self._heroCardItems[i]

		if cardItem then
			local singleMo = teamHeroes and teamHeroes[i]

			cardItem:onUpdateMO(singleMo)
		end
	end

	self._txtherohp.text = MatchGameHeroGroupModel.instance:getCurTeamTotalHp()
end

function MatchGameHeroGroupView:_refreshLevelInfo()
	self._txtlevelname.text = self._episodeCo.levelName or ""

	MatchGameHelper.setCharacterElement(self._episodeCo.recCareer, self._imageattr, self._txtattr)
	self:_refreshTargetConditions()
end

function MatchGameHeroGroupView:_refreshTargetConditions()
	local conditionList, conditionParamList = MatchGameHelper.getEpisodeConditionList(self._episodeCo.id)

	if not conditionList then
		return
	end

	self:_refreshSpecialCondition(conditionParamList)
	gohelper.CreateObjList(self, self._onCreateTargetItem, conditionList, nil, self._gonormalcondition)
end

function MatchGameHeroGroupView:_refreshSpecialCondition(conditionParamList)
	gohelper.setActive(self._gospcondition1, false)
	gohelper.setActive(self._gospcondition2, false)
	gohelper.setActive(self._gospcondition, false)

	if conditionParamList then
		for _, conditionParam in ipairs(conditionParamList) do
			local conditionType = conditionParam[1]

			if conditionType == MatchGameEnum.EpisodeTargetType.Round then
				self._txtround.text = conditionParam[2]

				gohelper.setActive(self._gospcondition1, true)
				gohelper.setActive(self._gospcondition, true)
			end

			if conditionType == MatchGameEnum.EpisodeTargetType.KillAttr then
				local elementId = conditionParam[2]
				local elementNum = conditionParam[3]

				self._txtelement.text = elementNum

				MatchGameHelper.setCharacterElement(elementId, self._imageelement)
				gohelper.setActive(self._gospcondition2, true)
				gohelper.setActive(self._gospcondition, true)
			end
		end
	end
end

function MatchGameHeroGroupView:_onCreateTargetItem(itemGo, condition, index)
	local episodeMo = self._episodeMo
	local isCompleted = false

	if episodeMo and episodeMo.isConditionPass then
		isCompleted = episodeMo:isConditionPass(index)
	end

	local txt = gohelper.findChildText(itemGo, "#txt_normalcondition")
	local goFinish = gohelper.findChild(itemGo, "#go_normalfinish")
	local goUnfinish = gohelper.findChild(itemGo, "#go_normalunfinish")

	txt.text = condition

	gohelper.setActive(goFinish, isCompleted)
	gohelper.setActive(goUnfinish, not isCompleted)
end

function MatchGameHeroGroupView:_refreshTeamDropdown()
	gohelper.setActive(self._dropherogroup.gameObject, not self._isTeachEpisode)

	if self._isTeachEpisode then
		return
	end

	local list = {}
	local maxSnapshotCount = MatchGameModel.instance:getMaxHeroGroupSnapshotCount()

	for i = 1, maxSnapshotCount do
		list[i] = string.format(luaLang("herogroup_common_name"), i)
	end

	self._dropherogroup:ClearOptions()
	self._dropherogroup:AddOptions(list)
	self._dropherogroup:SetValue(self._curTeamId - 1)
end

function MatchGameHeroGroupView:_onClickStart()
	MatchGameHeroGroupController.instance:enterBattle(self._episodeId)
end

function MatchGameHeroGroupView:_onClickEnemy()
	MatchGameController.instance:openMatchGameMemberInfoView({
		matchLevelId = self._episodeCo.matchLevelId
	})
end

function MatchGameHeroGroupView:_onClickTalent()
	MatchGameController.instance:openCharacterView()
end

function MatchGameHeroGroupView:_onCardInteraction(action, posIndex, ...)
	if action == "drag" then
		local cardItem = ...

		self:_moveDragOverlay(cardItem)
	elseif action == "swap" then
		local screenPos = ...

		if not screenPos then
			return
		end

		local targetPosIndex = self:_getSlotAtScreenPos(screenPos)

		self:swapSlots(posIndex, targetPosIndex)
	end
end

function MatchGameHeroGroupView:swapSlots(posA, posB)
	if posA == posB or not posA or not posB then
		self:_onSwapHeroError(posA, posB)

		return
	end

	local teamHeroes = MatchGameHeroGroupModel.instance:getCurTeamHeroes()

	if not teamHeroes then
		self:_onSwapHeroError(posA, posB)

		return
	end

	local curEpisodeId = MatchGameLevelModel.instance:getCurEpisodeId()
	local maxRoleNum = MatchGameConfig.instance:getEpisodeRoleNum(curEpisodeId)

	if not posA or posA < 0 or maxRoleNum < posA or not posB or posB < 0 or maxRoleNum < posB then
		self:_onSwapHeroError(posA, posB)

		return
	end

	return self:_reallyStartSwap(posA, posB)
end

function MatchGameHeroGroupView:_onSwapHeroError(sourcePosIndex, targetPosIndex)
	self._errorTweenId = self:_tweenCardPosition(sourcePosIndex, sourcePosIndex, function()
		self:_refreshHeroCards()
	end)
end

function MatchGameHeroGroupView:_tweenCardPosition(sourcePosIndex, targetPosIndex, callback, callbackObj)
	local duration = 0.2
	local sourceItem = self._heroCardItems[sourcePosIndex].transform
	local defaultPos = self._heroCardItems[targetPosIndex]:getDefaultCardPos()
	local targetPos = recthelper.rectToRelativeAnchorPos(defaultPos, sourceItem.transform.parent)

	UIBlockHelper.instance:startBlock(self.viewName, duration, self.viewName)

	return ZProj.TweenHelper.DOAnchorPos(sourceItem, targetPos.x, targetPos.y, duration, callback, callbackObj)
end

function MatchGameHeroGroupView:_reallyStartSwap(sourcePosIndex, targetPosIndex)
	self._revertTweenId = self:_tweenCardPosition(targetPosIndex, sourcePosIndex)
	self._successTweenId = self:_tweenCardPosition(sourcePosIndex, targetPosIndex, function()
		MatchGameHeroGroupController.instance:swapSlots(self._curTeamId, sourcePosIndex, targetPosIndex)
	end)
end

function MatchGameHeroGroupView:_moveDragOverlay(cardItem)
	if not cardItem or not cardItem._drag then
		return
	end

	local dragInfo = cardItem._drag:dragInfo()

	if not dragInfo or not dragInfo.screenPos then
		return
	end

	local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(dragInfo.screenPos, cardItem.transform.parent)

	recthelper.setAnchor(cardItem.transform, anchorPosX, anchorPosY)
end

function MatchGameHeroGroupView:_getSlotAtScreenPos(screenPos)
	for i, posNode in ipairs(self._posNodes) do
		local rect = posNode.transform

		if recthelper.screenPosInRect(rect, nil, screenPos.x, screenPos.y) then
			return i
		end
	end

	return nil
end

function MatchGameHeroGroupView:_onTeamDropValueChanged(value)
	local teamId = value + 1

	MatchGameHeroGroupController.instance:switchTeam(teamId)
end

function MatchGameHeroGroupView:_onSwitchTeam()
	self._curTeamId = MatchGameModel.instance:getCurTeamIndex()

	self:_refreshHeroCards()
	self:_refreshTeamDropdown()
end

function MatchGameHeroGroupView:_onSaveTeamSuccess(teamId)
	self:refreshUI()
end

function MatchGameHeroGroupView:_onCharacterUpdated(characterId)
	self:_refreshHeroCards()
end

return MatchGameHeroGroupView
