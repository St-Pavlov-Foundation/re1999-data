module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupHeroItem", package.seeall)

slot0 = class("Act183HeroGroupHeroItem", HeroGroupHeroItem)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._goleader = gohelper.findChild(slot0.go, "heroitemani/hero/go_leader")
	slot0._goleaderframe = gohelper.findChild(slot0.go, "heroitemani/hero/go_leader/go_leaderframe")
	slot0._goleadereffect = gohelper.findChild(slot0.go, "heroitemani/hero/go_leader/go_leaderframe/#fit")
	slot0._leaderTran = slot0._goleader.transform
	slot0._leaderFrameTran = slot0._goleaderframe.transform
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._commonHeroCard:setGrayScale(false)

	slot2 = HeroGroupModel.instance.episodeId
	slot4 = HeroGroupModel.instance.battleId and lua_battle.configDict[slot3]
	slot0.mo = slot1
	slot0._posIndex = slot0.mo.id - 1
	slot0._heroMO = slot1:getHeroMO()
	slot0.monsterCO = slot1:getMonsterCO()
	slot0.trialCO = slot1:getTrialCO()

	gohelper.setActive(slot0._replayReady, HeroGroupModel.instance:getCurGroupMO().isReplay)

	slot5 = nil

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		slot5 = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[slot0.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._lvnumen, "#E9E9E9")

	for slot9 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(slot0._goRankList[slot9], "#F6F3EC")
	end

	if slot0._heroMO then
		slot0._commonHeroCard:onUpdateMO(FightConfig.instance:getSkinCO(slot5 and slot5.skin or HeroModel.instance:getByHeroId(slot0._heroMO.heroId).skin))

		if slot0.isLock or slot0.isAid or slot0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(slot0._goblackmask.transform, 125)
		else
			recthelper.setHeight(slot0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(slot0._careericon, "lssx_" .. tostring(slot0._heroMO.config.career))

		slot10 = nil

		if (slot5 and slot5.level or slot0._heroMO.level) < HeroGroupBalanceHelper.getHeroBalanceLv(slot0._heroMO.heroId) then
			slot8 = slot9
			slot10 = true
		end

		slot11, slot12 = HeroConfig.instance:getShowLevel(slot8)

		if slot10 then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._lvnumen, HeroGroupBalanceHelper.BalanceColor)

			slot16 = ">"
			slot0._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. slot16 .. slot11

			for slot16 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(slot0._goRankList[slot16], HeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			slot0._lvnum.text = slot11
		end

		for slot16 = 1, 3 do
			gohelper.setActive(slot0._goRankList[slot16], slot16 == slot12 - 1)
		end

		gohelper.setActive(slot0._goStars, true)

		for slot16 = 1, 6 do
			gohelper.setActive(slot0._goStarList[slot16], slot16 <= CharacterEnum.Star[slot0._heroMO.config.rare])
		end
	elseif slot0.monsterCO then
		slot0._commonHeroCard:onUpdateMO(FightConfig.instance:getSkinCO(slot0.monsterCO.skinId))

		slot12 = slot0.monsterCO.career

		UISpriteSetMgr.instance:setCommonSprite(slot0._careericon, "lssx_" .. tostring(slot12))

		slot0._lvnum.text, slot8 = HeroConfig.instance:getShowLevel(slot0.monsterCO.level)

		for slot12 = 1, 3 do
			gohelper.setActive(slot0._goRankList[slot12], slot12 == slot8 - 1)
		end

		gohelper.setActive(slot0._goStars, false)
	elseif slot0.trialCO then
		slot7 = nil
		slot7 = (slot0.trialCO.skin <= 0 or SkinConfig.instance:getSkinCo(slot0.trialCO.skin)) and SkinConfig.instance:getSkinCo(HeroConfig.instance:getHeroCO(slot0.trialCO.heroId).skinId)

		if slot0.isLock or slot0.isAid or slot0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(slot0._goblackmask.transform, 125)
		else
			recthelper.setHeight(slot0._goblackmask.transform, 300)
		end

		slot0._commonHeroCard:onUpdateMO(slot7)

		slot13 = slot6.career

		UISpriteSetMgr.instance:setCommonSprite(slot0._careericon, "lssx_" .. tostring(slot13))

		slot0._lvnum.text, slot9 = HeroConfig.instance:getShowLevel(slot0.trialCO.level)

		for slot13 = 1, 3 do
			gohelper.setActive(slot0._goRankList[slot13], slot13 == slot9 - 1)
		end

		gohelper.setActive(slot0._goStars, true)

		for slot13 = 1, 6 do
			gohelper.setActive(slot0._goStarList[slot13], slot13 <= CharacterEnum.Star[slot6.rare])
		end
	end

	if slot0._heroItemContainer then
		slot0._heroItemContainer.compColor[slot0._lvnumen] = slot0._lvnumen.color

		for slot9 = 1, 3 do
			slot0._heroItemContainer.compColor[slot0._goRankList[slot9]] = slot0._goRankList[slot9].color
		end
	end

	slot0.isLock = false
	slot0.isAidLock = slot0.mo.aid and slot0.mo.aid == -1
	slot0.isAid = slot0.mo.aid ~= nil
	slot0.isTrialLock = (slot0.mo.trial and slot0.mo.trialPos) ~= nil
	slot6 = HeroGroupModel.instance:getBattleRoleNum()
	slot0.isRoleNumLock = false
	slot0.isEmpty = slot1:isEmpty()

	gohelper.setActive(slot0._heroGO, (slot0._heroMO ~= nil or slot0.monsterCO ~= nil or slot0.trialCO ~= nil) and not slot0.isLock and not slot0.isRoleNumLock)
	gohelper.setActive(slot0._noneGO, slot0._heroMO == nil and slot0.monsterCO == nil and slot0.trialCO == nil or slot0.isLock or slot0.isAidLock or slot0.isRoleNumLock)
	gohelper.setActive(slot0._addGO, slot0._heroMO == nil and slot0.monsterCO == nil and slot0.trialCO == nil and not slot0.isLock and not slot0.isAidLock and not slot0.isRoleNumLock)
	gohelper.setActive(slot0._lockGO, slot0:selfIsLock())
	gohelper.setActive(slot0._aidGO, slot0.mo.aid and slot0.mo.aid ~= -1)

	if slot4 then
		gohelper.setActive(slot0._subGO, not slot0.isLock and not slot0.isAidLock and not slot0.isRoleNumLock and slot4.playerMax < slot0.mo.id)
	else
		gohelper.setActive(slot0._subGO, not slot0.isLock and not slot0.isAidLock and not slot0.isRoleNumLock and slot0.mo.id == ModuleEnum.MaxHeroCountInGroup)
	end

	transformhelper.setLocalPosXY(slot0._tagTr, 36.3, slot0._subGO.activeSelf and 144.1 or 212.1)

	if slot0.trialCO then
		gohelper.setActive(slot0._trialTagGO, true)

		slot0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(slot0._trialTagGO, false)
	end

	if not HeroSingleGroupModel.instance:isTemp() and slot0.isRoleNumLock and slot0._heroMO ~= nil and slot0.monsterCO == nil then
		HeroSingleGroupModel.instance:remove(slot0._heroMO.id)
	end

	slot0:initEquips()
	slot0:showCounterSign()

	if slot0._playDeathAnim then
		slot0._playDeathAnim = nil

		slot0:playAnim(UIAnimationName.Open)
	end

	slot0:_showMojingTip()

	slot7 = Act183Helper.isTeamLeader(slot2, slot0._index)
	slot8 = slot0:hasHero()

	gohelper.setActive(slot0._goleaderframe, slot7)
	gohelper.setActive(slot0._goleadereffect, slot7 and slot8)
	slot0:_setLeaderParent(slot8 and slot0._leaderTran or slot0._bgLeaderTran)
end

function slot0.selfIsLock(slot0)
	return false
end

function slot0.setScale(slot0, slot1, slot2, slot3)
	slot0._scaleX = slot1 or 1
	slot0._scaleY = slot2 or 1
	slot0._scaleZ = slot3 or 1

	transformhelper.setLocalScale(slot0.go.transform, slot0._scaleX, slot0._scaleY, slot0._scaleZ)
end

function slot0.onItemBeginDrag(slot0, slot1)
	uv0.super.onItemBeginDrag(slot0, slot1)

	if slot1 == slot0._index then
		slot0:_setLeaderParent(slot0._bgLeaderTran)
	end
end

function slot0.onItemEndDrag(slot0, slot1, slot2)
	if slot1 == slot0.index or slot2 == slot0._index then
		slot0:_setLeaderParent(slot0._bgLeaderTran)
	end

	ZProj.TweenHelper.DOScale(slot0.go.transform, slot0._scaleX, slot0._scaleY, slot0._scaleZ, 0.2, function ()
		uv0:_setLeaderParent(uv0:hasHero() and uv0._leaderTran or uv0._bgLeaderTran)
	end, nil, , EaseType.Linear)
	slot0:_setHeroItemPressState(false)
end

function slot0.hasHero(slot0)
	return slot0._heroMO ~= nil or slot0.monsterCO ~= nil or slot0.trialCO ~= nil
end

function slot0.setBgLeaderTran(slot0, slot1)
	slot0._bgLeaderTran = slot1
end

function slot0._setLeaderParent(slot0, slot1)
	if gohelper.isNil(slot1) then
		return
	end

	slot0._leaderFrameTran:SetParent(slot1, false)
end

return slot0
