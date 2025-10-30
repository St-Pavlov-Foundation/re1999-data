﻿-- chunkname: @modules/logic/seasonver/act166/view/Season166HeroGroupHeroItem.lua

module("modules.logic.seasonver.act166.view.Season166HeroGroupHeroItem", package.seeall)

local Season166HeroGroupHeroItem = class("Season166HeroGroupHeroItem", LuaCompBase)

function Season166HeroGroupHeroItem:ctor(heroGroupListView)
	self._heroGroupListView = heroGroupListView
end

Season166HeroGroupHeroItem.EquipTweenDuration = 0.16
Season166HeroGroupHeroItem.EquipDragOffset = Vector2(0, 150)
Season166HeroGroupHeroItem.EquipDragMobileScale = 1.7
Season166HeroGroupHeroItem.EquipDragOtherScale = 1.4
Season166HeroGroupHeroItem.PressColor = GameUtil.parseColor("#C8C8C8")

function Season166HeroGroupHeroItem:init(go)
	self.go = go
	self._noneGO = gohelper.findChild(go, "heroitemani/none")
	self._addGO = gohelper.findChild(go, "heroitemani/none/add")
	self._lockGO = gohelper.findChild(go, "heroitemani/none/lock")
	self._heroGO = gohelper.findChild(go, "heroitemani/hero")
	self._tagTr = gohelper.findChildComponent(go, "heroitemani/tags", typeof(UnityEngine.Transform))
	self._subGO = gohelper.findChild(go, "heroitemani/tags/aidtag")
	self._aidGO = gohelper.findChild(go, "heroitemani/tags/storytag")
	self._trialTagGO = gohelper.findChild(go, "heroitemani/tags/trialtag")
	self._trialTagTxt = gohelper.findChildTextMesh(go, "heroitemani/tags/trialtag/#txt_trial_tag")
	self._clickGO = gohelper.findChild(go, "heroitemani/click")
	self._clickThis = gohelper.getClick(self._clickGO)
	self._equipGO = gohelper.findChild(go, "heroitemani/equip")
	self._clickEquip = gohelper.getClick(self._equipGO)
	self._charactericon = gohelper.findChild(go, "heroitemani/hero/charactericon")
	self._careericon = gohelper.findChildImage(go, "heroitemani/hero/career")
	self._goblackmask = gohelper.findChild(go, "heroitemani/hero/blackmask")
	self.level_part = gohelper.findChild(go, "heroitemani/hero/vertical/layout")
	self._lvnum = gohelper.findChildText(go, "heroitemani/hero/vertical/layout/lv/lvnum")
	self._lvnumen = gohelper.findChildText(go, "heroitemani/hero/vertical/layout/lv/lvnum/lv")
	self._goRankList = self:getUserDataTb_()

	for i = 1, 3 do
		local rankGO = gohelper.findChildImage(go, "heroitemani/hero/vertical/layout/rankobj/rank" .. i)

		table.insert(self._goRankList, rankGO)
	end

	self._goStarList = self:getUserDataTb_()

	for i = 1, 6 do
		local starGO = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star" .. i)

		table.insert(self._goStarList, starGO)
	end

	self._goStars = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList")
	self._fakeEquipGO = gohelper.findChild(go, "heroitemani/hero/vertical/fakeequip")
	self._dragFrameGO = gohelper.findChild(go, "heroitemani/selectedeffect")
	self._dragFrameSelectGO = gohelper.findChild(go, "heroitemani/selectedeffect/xuanzhong")
	self._dragFrameCompleteGO = gohelper.findChild(go, "heroitemani/selectedeffect/wancheng")

	gohelper.setActive(self._dragFrameGO, false)

	self._emptyEquipGo = gohelper.findChild(go, "heroitemani/emptyequip")
	self._animGO = gohelper.findChild(go, "heroitemani")
	self.anim = self._animGO:GetComponent(typeof(UnityEngine.Animator))
	self._replayReady = gohelper.findChild(go, "heroitemani/hero/replayready")
	self._gorecommended = gohelper.findChild(go, "heroitemani/hero/#go_recommended")
	self._gocounter = gohelper.findChild(go, "heroitemani/hero/#go_counter")
	self._herocardGo = gohelper.findChild(go, "heroitemani/roleequip")
	self._leftDrop = gohelper.findChildDropdown(go, "heroitemani/roleequip/left")
	self._rightDrop = gohelper.findChildDropdown(go, "heroitemani/roleequip/right")
	self._imageAdd = gohelper.findChildImage(go, "heroitemani/none/add")
	self._commonHeroCard = CommonHeroCard.create(self._charactericon, self._heroGroupListView.viewName)
end

function Season166HeroGroupHeroItem:setIndex(index)
	self._index = index
end

function Season166HeroGroupHeroItem:setParent(transform)
	self.currentParent = transform

	self._subGO.transform:SetParent(transform, true)
	self._equipGO.transform:SetParent(transform, true)
end

function Season166HeroGroupHeroItem:flowOriginParent()
	self._equipGO.transform:SetParent(self._animGO.transform, false)
end

function Season166HeroGroupHeroItem:flowCurrentParent()
	self._equipGO.transform:SetParent(self.currentParent, false)
end

function Season166HeroGroupHeroItem:initEquips(equipIndex)
	self._equipType = -1

	if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not self.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(self._equipGO, false)
		gohelper.setActive(self._fakeEquipGO, false)
		gohelper.setActive(self._emptyEquipGo, false)
	else
		gohelper.setActive(self._equipGO, true)
		gohelper.setActive(self._fakeEquipGO, true)
		gohelper.setActive(self._emptyEquipGo, true)

		if not self._equip then
			self._equip = self:getUserDataTb_()
			self._equip.moveContainer = gohelper.findChild(self._equipGO, "moveContainer")
			self._equip.equipIcon = gohelper.findChildImage(self._equipGO, "moveContainer/equipIcon")
			self._equip.equipRare = gohelper.findChildImage(self._equipGO, "moveContainer/equiprare")
			self._equip.equiptxten = gohelper.findChildText(self._equipGO, "equiptxten")
			self._equip.equiptxtlv = gohelper.findChildText(self._equipGO, "moveContainer/equiplv/txtequiplv")
			self._equip.equipGolv = gohelper.findChild(self._equipGO, "moveContainer/equiplv")

			self:_equipIconAddDrag(self._equip.moveContainer, self._equip.equipIcon)
		end

		local curGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()
		local equips = curGroupMO:getPosEquips(self.mo.id - 1).equipUid
		local equipId = equips[1]

		self._equipMO = EquipModel.instance:getEquip(equipId) or HeroGroupTrialModel.instance:getEquipMo(equipId)

		local trialEquipCO

		if self.trialCO and self.trialCO.equipId > 0 then
			trialEquipCO = EquipConfig.instance:getEquipCo(self.trialCO.equipId)
		end

		if self._equipMO then
			self._equipType = self._equipMO.config.rare - 2
		elseif trialEquipCO then
			self._equipType = trialEquipCO.rare - 2
		end

		gohelper.setActive(self._equip.equipIcon.gameObject, self._equipMO or trialEquipCO)
		gohelper.setActive(self._equip.equipRare.gameObject, self._equipMO or trialEquipCO)
		gohelper.setActive(self._equip.equipAddGO, not self._equipMO and not trialEquipCO)
		gohelper.setActive(self._equip.equipGolv, self._equipMO or trialEquipCO)
		ZProj.UGUIHelper.SetColorAlpha(self._equip.equiptxten, (self._equipMO or trialEquipCO) and 0.15 or 0.06)

		if self._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._equip.equipIcon, self._equipMO.config.icon)

			local _, _, equipLv = HeroGroupBalanceHelper.getBalanceLv()

			if equipLv and equipLv > self._equipMO.level and self._equipMO.equipType == EquipEnum.ClientEquipType.Normal then
				self._equip.equiptxtlv.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">LV." .. equipLv
			else
				self._equip.equiptxtlv.text = "LV." .. self._equipMO.level
			end

			UISpriteSetMgr.instance:setHeroGroupSprite(self._equip.equipRare, "bianduixingxian_" .. self._equipMO.config.rare)
			self:_showEquipParticleEffect(equipIndex)
		elseif trialEquipCO then
			local equipCO = EquipConfig.instance:getEquipCo(self.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._equip.equipIcon, equipCO.icon)

			self._equip.equiptxtlv.text = "LV." .. self.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(self._equip.equipRare, "bianduixingxian_" .. equipCO.rare)
			self:_showEquipParticleEffect(equipIndex)
		end
	end

	self.last_equip = self._equipMO and self._equipMO.uid
	self.last_hero = self._heroMO and self._heroMO.heroId or 0
end

function Season166HeroGroupHeroItem:_showEquipParticleEffect(equipIndex)
	if equipIndex == self.mo.id - 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function Season166HeroGroupHeroItem:_equipIconAddDrag(go, icon)
	local image = icon:GetComponent(gohelper.Type_Image)

	image.raycastTarget = true

	local scale = Season166HeroGroupHeroItem.EquipDragOtherScale
	local moveOffset

	if GameUtil.isMobilePlayerAndNotEmulator() then
		moveOffset = Season166HeroGroupHeroItem.EquipDragOffset
		scale = Season166HeroGroupHeroItem.EquipDragMobileScale
	end

	CommonDragHelper.instance:registerDragObj(go, self._onBeginDrag, nil, self._onEndDrag, self._checkDrag, self, go.transform, nil, moveOffset, scale)
end

function Season166HeroGroupHeroItem:_checkDrag()
	if Season166HeroGroupModel.instance:getCurGroupMO().isReplay then
		return true
	end

	if self.trialCO and self.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return true
	end

	return false
end

function Season166HeroGroupHeroItem:_onBeginDrag()
	gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[self.mo.id].parent.gameObject)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(self._equip.equipGolv, false)
end

function Season166HeroGroupHeroItem:_onEndDrag(_, pointerEventData)
	local pos = pointerEventData.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		pos = pos + Season166HeroGroupHeroItem.EquipDragOffset
	end

	local targetHeroItem = self:_moveToTarget(pos)

	self:_setEquipDragEnabled(false)

	local isTrialDefaultEquip = targetHeroItem and targetHeroItem.trialCO and targetHeroItem.trialCO.equipId > 0

	if not targetHeroItem or targetHeroItem == self or targetHeroItem.mo.aid or isTrialDefaultEquip or not targetHeroItem._equipGO.activeSelf then
		if isTrialDefaultEquip then
			GameFacade.showToast(ToastEnum.TrialCantEditEquip)
		end

		self:_setToPos(self._equip.moveContainer.transform, Vector2(), true, function()
			gohelper.setActive(self._equip.equipGolv, true)
			self:_setEquipDragEnabled(true)
		end, self)
		self:_showEquipParticleEffect()

		return
	end

	self:_playDragEndAudio(targetHeroItem)
	gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[targetHeroItem.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[self.mo.id].parent.gameObject)

	local anotherAnchorPos = recthelper.rectToRelativeAnchorPos(self._equipGO.transform.position, targetHeroItem._equipGO.transform)

	self._tweenId = self:_setToPos(targetHeroItem._equip.moveContainer.transform, anotherAnchorPos, true)

	local anchorPos = recthelper.rectToRelativeAnchorPos(targetHeroItem._equipGO.transform.position, self._equipGO.transform)

	self:_setToPos(self._equip.moveContainer.transform, anchorPos, true, function()
		local curGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()

		EquipTeamListModel.instance:openTeamEquip(self.mo.id - 1, self._heroMO, curGroupMO)

		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)
		end

		self:_setToPos(self._equip.moveContainer.transform, Vector2())
		self:_setToPos(targetHeroItem._equip.moveContainer.transform, Vector2())
		gohelper.setActive(self._equip.equipGolv, true)
		self:_setEquipDragEnabled(true)

		local srcPos = self.mo.id - 1
		local targetPos = targetHeroItem.mo.id - 1
		local srcEquipId = EquipTeamListModel.instance:getTeamEquip(srcPos)[1]

		srcEquipId = (EquipModel.instance:getEquip(srcEquipId) or HeroGroupTrialModel.instance:getEquipMo(srcEquipId)) and srcEquipId or nil

		if srcEquipId then
			EquipTeamShowItem.removeEquip(srcPos, true)
		end

		local targetEquipId = EquipTeamListModel.instance:getTeamEquip(targetPos)[1]

		targetEquipId = (EquipModel.instance:getEquip(targetEquipId) or HeroGroupTrialModel.instance:getEquipMo(targetEquipId)) and targetEquipId or nil

		if targetEquipId then
			EquipTeamShowItem.removeEquip(targetPos, true)
		end

		if srcEquipId then
			EquipTeamShowItem.replaceEquip(targetPos, srcEquipId, true)
		end

		if targetEquipId then
			EquipTeamShowItem.replaceEquip(srcPos, targetEquipId, true)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
		Season166HeroGroupModel.instance:saveCurGroupData()
	end, self)
end

function Season166HeroGroupHeroItem:resetEquipPos()
	if not self._equip then
		return
	end

	local trans = self._equip.moveContainer.transform

	recthelper.setAnchor(trans, 0, 0)
	transformhelper.setLocalScale(trans, 1, 1, 1)
end

function Season166HeroGroupHeroItem:_playDragEndAudio(targetHeroItem)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function Season166HeroGroupHeroItem:_setToPos(transform, anchorPos, tween, callback, callbackObj)
	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Season166HeroGroupHeroItem:_moveToTarget(position)
	for i, v in ipairs(self._heroGroupListView.heroPosTrList) do
		if self._heroGroupListView._heroItemList[i] ~= self then
			local posTr = v.parent
			local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

			if math.abs(anchorPos.x) * 2 < recthelper.getWidth(posTr) and math.abs(anchorPos.y) * 2 < recthelper.getHeight(posTr) then
				local heroItem = self._heroGroupListView._heroItemList[i]

				return not heroItem:selfIsLock() and heroItem or nil
			end
		end
	end

	return nil
end

function Season166HeroGroupHeroItem:_setEquipDragEnabled(isEnabled)
	CommonDragHelper.instance:setGlobalEnabled(isEnabled)
end

function Season166HeroGroupHeroItem:addEventListeners()
	self._clickThis:AddClickListener(self._onClickThis, self)
	self._clickThis:AddClickDownListener(self._onClickThisDown, self)
	self._clickThis:AddClickUpListener(self._onClickThisUp, self)
	self._clickEquip:AddClickListener(self._onClickEquip, self)
	self._clickEquip:AddClickDownListener(self._onClickEquipDown, self)
	self._clickEquip:AddClickUpListener(self._onClickEquipUp, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, self.setHeroGroupEquipEffect, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, self.playHeroGroupHeroEffect, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, self.initEquips, self)
	self:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, self.initEquips, self)
	self:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, self.initEquips, self)
	self:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, self.initEquips, self)
	self:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, self.initEquips, self)
	self:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, self.initEquips, self)
end

function Season166HeroGroupHeroItem:removeEventListeners()
	self._clickThis:RemoveClickListener()
	self._clickThis:RemoveClickUpListener()
	self._clickThis:RemoveClickDownListener()
	self._clickEquip:RemoveClickListener()
	self._clickEquip:RemoveClickUpListener()
	self._clickEquip:RemoveClickDownListener()
end

function Season166HeroGroupHeroItem:playHeroGroupHeroEffect(state)
	self:playAnim(state)

	self.last_equip = nil
	self.last_hero = nil
end

function Season166HeroGroupHeroItem:onUpdateMO(mo)
	self._commonHeroCard:setGrayScale(false)

	local battleId = Season166HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]

	self.mo = mo
	self._posIndex = self.mo.id - 1
	self._heroMO = mo:getHeroMO()
	self.monsterCO = not mo.isAssist and mo:getMonsterCO()
	self.trialCO = not mo.isAssist and mo:getTrialCO()

	gohelper.setActive(self._replayReady, Season166HeroGroupModel.instance:getCurGroupMO().isReplay)

	local replay_data

	if Season166HeroGroupModel.instance:getCurGroupMO().isReplay then
		replay_data = Season166HeroGroupModel.instance:getCurGroupMO().replay_hero_data[self.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._lvnumen, "#E9E9E9")

	for i = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(self._goRankList[i], "#F6F3EC")
	end

	if self._heroMO then
		local heroSkin = self.mo.isAssist and self._heroMO or HeroModel.instance:getByHeroId(self._heroMO.heroId)
		local skinConfig = FightConfig.instance:getSkinCO(replay_data and replay_data.skin or heroSkin.skin)

		self._commonHeroCard:onUpdateMO(skinConfig)

		if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(self._goblackmask.transform, 125)
		else
			recthelper.setHeight(self._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(self._heroMO.config.career))

		local lv = replay_data and replay_data.level or self._heroMO.level
		local roleLv = HeroGroupBalanceHelper.getHeroBalanceLv(self._heroMO.heroId)
		local isBalanceLv

		if lv < roleLv then
			lv = roleLv
			isBalanceLv = true
		end

		local hero_level, hero_rank = HeroConfig.instance:getShowLevel(lv)

		if isBalanceLv then
			SLFramework.UGUI.GuiHelper.SetColor(self._lvnumen, HeroGroupBalanceHelper.BalanceColor)

			self._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">" .. hero_level

			for i = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(self._goRankList[i], HeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			self._lvnum.text = hero_level
		end

		for i = 1, 3 do
			local rankGO = self._goRankList[i]

			gohelper.setActive(rankGO, i == hero_rank - 1)
		end

		gohelper.setActive(self._goStars, true)

		for i = 1, 6 do
			local starGO = self._goStarList[i]

			gohelper.setActive(starGO, i <= CharacterEnum.Star[self._heroMO.config.rare])
		end
	elseif self.monsterCO then
		local skinConfig = FightConfig.instance:getSkinCO(self.monsterCO.skinId)

		self._commonHeroCard:onUpdateMO(skinConfig)
		UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(self.monsterCO.career))

		local showLevel, rank = HeroConfig.instance:getShowLevel(self.monsterCO.level)

		self._lvnum.text = showLevel

		for i = 1, 3 do
			local rankGO = self._goRankList[i]

			gohelper.setActive(rankGO, i == rank - 1)
		end

		gohelper.setActive(self._goStars, false)
	elseif self.trialCO then
		local heroCo = HeroConfig.instance:getHeroCO(self.trialCO.heroId)
		local skinConfig

		if self.trialCO.skin > 0 then
			skinConfig = SkinConfig.instance:getSkinCo(self.trialCO.skin)
		else
			skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)
		end

		if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(self._goblackmask.transform, 125)
		else
			recthelper.setHeight(self._goblackmask.transform, 300)
		end

		self._commonHeroCard:onUpdateMO(skinConfig)
		UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(heroCo.career))

		local showLevel, rank = HeroConfig.instance:getShowLevel(self.trialCO.level)

		self._lvnum.text = showLevel

		for i = 1, 3 do
			local rankGO = self._goRankList[i]

			gohelper.setActive(rankGO, i == rank - 1)
		end

		gohelper.setActive(self._goStars, true)

		for i = 1, 6 do
			local starGO = self._goStarList[i]

			gohelper.setActive(starGO, i <= CharacterEnum.Star[heroCo.rare])
		end
	end

	if self._heroItemContainer then
		self._heroItemContainer.compColor[self._lvnumen] = self._lvnumen.color

		for i = 1, 3 do
			self._heroItemContainer.compColor[self._goRankList[i]] = self._goRankList[i].color
		end
	end

	self.isLock = not Season166HeroGroupModel.instance:isPositionOpen(self.mo.id)
	self.isAidLock = self.isTeachItem and not self.mo.trial
	self.isAid = not self.mo.trial and self.isTeachItem
	self.isTrialLock = (self.mo.trial and self.mo.trialPos) ~= nil
	self.roleNum = Season166HeroGroupModel.instance:getBattleRoleNum()
	self.isRoleNumLock = self.roleNum and self.roleNum < self.mo.id
	self.isEmpty = mo:isEmpty()

	gohelper.setActive(self._heroGO, (self._heroMO ~= nil or self.monsterCO ~= nil or self.trialCO ~= nil) and not self.isLock and not self.isRoleNumLock)
	gohelper.setActive(self._noneGO, self._heroMO == nil and self.monsterCO == nil and self.trialCO == nil or self.isLock or self.isAidLock or self.isRoleNumLock)
	gohelper.setActive(self._addGO, self._heroMO == nil and self.monsterCO == nil and self.trialCO == nil and not self.isLock and not self.isAidLock and not self.isRoleNumLock)
	gohelper.setActive(self._lockGO, self:selfIsLock())
	gohelper.setActive(self._aidGO, self.mo.trial and self.isTeachItem)
	gohelper.setActive(self._subGO, false)
	transformhelper.setLocalPosXY(self._tagTr, 36.3, self._subGO.activeSelf and 144.1 or 212.1)

	if (self.trialCO or self.mo.isAssist) and not self.isTeachItem then
		gohelper.setActive(self._trialTagGO, true)

		self._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(self._trialTagGO, false)
	end

	if not Season166HeroSingleGroupModel.instance:isTemp() and self.isRoleNumLock and self._heroMO ~= nil and self.monsterCO == nil then
		Season166HeroSingleGroupModel.instance:remove(self._heroMO.id)
	end

	self:initEquips()
	self:showCounterSign()

	if self._playDeathAnim then
		self._playDeathAnim = nil

		self:playAnim(UIAnimationName.Open)
	end
end

function Season166HeroGroupHeroItem:selfIsLock()
	return self.isLock or self.isAidLock or self.isRoleNumLock
end

function Season166HeroGroupHeroItem:setIsTeachItem(isTeachItem)
	self.isTeachItem = isTeachItem
end

function Season166HeroGroupHeroItem:playRestrictAnimation(needRestrictHeroUidDict)
	if self._heroMO and needRestrictHeroUidDict[self._heroMO.uid] then
		self._playDeathAnim = true

		self:playAnim("herogroup_hero_deal")

		self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)
	end
end

function Season166HeroGroupHeroItem:setGrayFactor(value)
	self._commonHeroCard:setGrayFactor(value)
end

function Season166HeroGroupHeroItem:showCounterSign()
	local career

	if self._heroMO then
		local hero_config = lua_character.configDict[self._heroMO.heroId]

		career = hero_config.career
	elseif self.trialCO then
		local heroCo = HeroConfig.instance:getHeroCO(self.trialCO.heroId)

		career = heroCo.career
	elseif self.monsterCO then
		career = self.monsterCO.career
	end

	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.setActive(self._gorecommended, tabletool.indexOf(recommended, career))
	gohelper.setActive(self._gocounter, tabletool.indexOf(counter, career))
end

function Season166HeroGroupHeroItem:_setUIPressState(graphicCompArr, isPress, oriColorMap)
	if not graphicCompArr then
		return
	end

	local iter = graphicCompArr:GetEnumerator()

	while iter:MoveNext() do
		local color

		if isPress then
			color = oriColorMap and oriColorMap[iter.Current] * 0.7 or Season166HeroGroupHeroItem.PressColor

			local alpha = iter.Current.color.a

			color.a = alpha
		else
			color = oriColorMap and oriColorMap[iter.Current] or Color.white
		end

		iter.Current.color = color
	end
end

function Season166HeroGroupHeroItem:_onClickThis()
	if Season166HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if self.isTeachItem or self.isRoleNumLock then
		if not self.mo.trial or self.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if self.isLock then
		logError(self.mo.id .. " is lock, check Error")
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, self.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function Season166HeroGroupHeroItem:_onClickThisDown()
	self:_setHeroItemPressState(true)
end

function Season166HeroGroupHeroItem:_onClickThisUp()
	self:_setHeroItemPressState(false)
end

function Season166HeroGroupHeroItem:_setHeroItemPressState(press)
	if not self._heroItemContainer then
		self._heroItemContainer = self:getUserDataTb_()

		local images = self._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)

		self._heroItemContainer.images = images

		local tmps = self._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		self._heroItemContainer.tmps = tmps
		self._heroItemContainer.compColor = {}

		local iter = images:GetEnumerator()

		while iter:MoveNext() do
			self._heroItemContainer.compColor[iter.Current] = iter.Current.color
		end

		iter = tmps:GetEnumerator()

		while iter:MoveNext() do
			self._heroItemContainer.compColor[iter.Current] = iter.Current.color
		end
	end

	local spines = self._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

	self._heroItemContainer.spines = spines

	if self._heroItemContainer then
		self:_setUIPressState(self._heroItemContainer.images, press, self._heroItemContainer.compColor)
		self:_setUIPressState(self._heroItemContainer.tmps, press, self._heroItemContainer.compColor)
		self:_setUIPressState(self._heroItemContainer.spines, press)
	end

	if self._imageAdd then
		local color = press and Season166HeroGroupHeroItem.PressColor or Color.white

		self._imageAdd.color = color
	end
end

function Season166HeroGroupHeroItem:_onClickEquip()
	local heroGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or self.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		self._viewParam = {
			heroGroupMo = heroGroupMO,
			heroMo = self._heroMO,
			equipMo = self._equipMO,
			posIndex = self._posIndex,
			fromView = EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView,
			maxHeroNum = self.roleNum
		}

		if self.trialCO then
			self._viewParam.heroMo = HeroGroupTrialModel.instance:getHeroMo(self.trialCO)

			if self.trialCO.equipId > 0 then
				self._viewParam.equipMo = self._viewParam.heroMo.trialEquipMo
			end
		end

		self:_onOpenEquipTeamView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function Season166HeroGroupHeroItem:_onClickEquipDown()
	self:_setEquipItemPressState(true)
end

function Season166HeroGroupHeroItem:_onClickEquipUp()
	self:_setEquipItemPressState(false)
end

function Season166HeroGroupHeroItem:_setEquipItemPressState(press)
	if not self._equipItemContainer then
		self._equipItemContainer = self:getUserDataTb_()
		self._equipEmtpyContainer = self:getUserDataTb_()

		local images = self._equipGO:GetComponentsInChildren(gohelper.Type_Image, true)

		self._equipItemContainer.images = images

		local tmps = self._equipGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		self._equipItemContainer.tmps = tmps
		self._equipItemContainer.compColor = {}

		local emptyEquipImages = self._emptyEquipGo:GetComponentsInChildren(gohelper.Type_Image, true)

		self._equipEmtpyContainer.images = emptyEquipImages

		local emptyEquipTmps = self._emptyEquipGo:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		self._equipEmtpyContainer.tmps = emptyEquipTmps
		self._equipEmtpyContainer.compColor = {}

		local iter = images:GetEnumerator()

		while iter:MoveNext() do
			self._equipItemContainer.compColor[iter.Current] = iter.Current.color
		end

		iter = tmps:GetEnumerator()

		while iter:MoveNext() do
			self._equipItemContainer.compColor[iter.Current] = iter.Current.color
		end

		iter = emptyEquipImages:GetEnumerator()

		while iter:MoveNext() do
			self._equipEmtpyContainer.compColor[iter.Current] = iter.Current.color
		end

		iter = emptyEquipTmps:GetEnumerator()

		while iter:MoveNext() do
			self._equipEmtpyContainer.compColor[iter.Current] = iter.Current.color
		end
	end

	if self._equipItemContainer then
		self:_setUIPressState(self._equipItemContainer.images, press, self._equipItemContainer.compColor)
		self:_setUIPressState(self._equipItemContainer.tmps, press, self._equipItemContainer.compColor)
	end

	if self._equipEmtpyContainer then
		self:_setUIPressState(self._equipEmtpyContainer.images, press, self._equipEmtpyContainer.compColor)
		self:_setUIPressState(self._equipEmtpyContainer.tmps, press, self._equipEmtpyContainer.compColor)
	end
end

function Season166HeroGroupHeroItem:_onOpenEquipTeamView()
	EquipController.instance:openEquipInfoTeamView(self._viewParam)
end

function Season166HeroGroupHeroItem:onItemBeginDrag(index)
	if index == self.mo.id then
		ZProj.TweenHelper.DOScale(self.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(self._dragFrameGO, true)
		gohelper.setActive(self._dragFrameSelectGO, true)
		gohelper.setActive(self._dragFrameCompleteGO, false)
	end

	gohelper.setActive(self._clickGO, false)
end

function Season166HeroGroupHeroItem:onItemEndDrag(index, dragToIndex)
	ZProj.TweenHelper.DOScale(self.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	self:_setHeroItemPressState(false)
end

function Season166HeroGroupHeroItem:onItemCompleteDrag(index, dragToIndex, complete)
	if dragToIndex == self.mo.id and index ~= dragToIndex then
		if complete then
			gohelper.setActive(self._dragFrameGO, true)
			gohelper.setActive(self._dragFrameSelectGO, false)
			gohelper.setActive(self._dragFrameCompleteGO, false)
			gohelper.setActive(self._dragFrameCompleteGO, true)
			TaskDispatcher.cancelTask(self.hideDragEffect, self)
			TaskDispatcher.runDelay(self.hideDragEffect, self, 0.833)
		end
	else
		gohelper.setActive(self._dragFrameGO, false)
	end

	gohelper.setActive(self._clickGO, true)
end

function Season166HeroGroupHeroItem:hideDragEffect()
	gohelper.setActive(self._dragFrameGO, false)
end

function Season166HeroGroupHeroItem:setHeroGroupEquipEffect(show)
	self._canPlayEffect = show
end

function Season166HeroGroupHeroItem:getAnimStateLength(stateName)
	self.clipLengthDict = self.clipLengthDict or {
		swicth = 0.833,
		herogroup_hero_deal = 1.667,
		[UIAnimationName.Open] = 0.833,
		[UIAnimationName.Close] = 0.333
	}

	local length = self.clipLengthDict[stateName]

	if not length then
		logError("not get animation state name :  " .. tostring(stateName))
	end

	return length or 0
end

function Season166HeroGroupHeroItem:playAnim(animName)
	local length = self:getAnimStateLength(animName)

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, length)
	self.anim:Play(animName, 0, 0)
end

function Season166HeroGroupHeroItem:onDestroy()
	if self._equip then
		CommonDragHelper.instance:unregisterDragObj(self._equip.moveContainer)
	end

	TaskDispatcher.cancelTask(self._onOpenEquipTeamView, self)
	TaskDispatcher.cancelTask(self.hideDragEffect, self)
end

return Season166HeroGroupHeroItem
