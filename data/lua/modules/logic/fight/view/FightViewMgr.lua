module("modules.logic.fight.view.FightViewMgr", package.seeall)

slot0 = class("FightViewMgr", FightBaseView)

function slot0.onInitView(slot0)
	slot0._topLeft = gohelper.findChild(slot0.viewGO, "root/topLeftContent")
	slot0._topRightBtnRoot = gohelper.findChild(slot0.viewGO, "root/btns")
	slot0._fightSeasonChangeHero = gohelper.findChild(slot0.viewGO, "root/fightSeasonChangeHero")
	slot0._progressRoot = gohelper.findChild(slot0._topLeft, "#go_commonalityslider")
	slot0._goRoot = gohelper.findChild(slot0.viewGO, "root")
	slot0._taskRoot = gohelper.findChild(slot0.viewGO, "root/topLeftContent/#go_task")

	gohelper.setActive(slot0._fightSeasonChangeHero, false)
	gohelper.setActive(slot0._progressRoot, false)
end

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour)
	slot0:com_registFightEvent(FightEvent.OnBuffUpdate, slot0._onBuffUpdate)
	slot0:com_registFightEvent(FightEvent.BloodPool_OnCreate, slot0.onBloodPoolCreate)
	slot0:com_registFightEvent(FightEvent.DoomsdayClock_OnValueChange, slot0.onCreateDoomsdayClock)
	slot0:com_registFightEvent(FightEvent.DoomsdayClock_OnAreaChange, slot0.onCreateDoomsdayClock)
	slot0:com_registMsg(FightMsgId.FightProgressValueChange, slot0._showFightProgress)
	slot0:com_registMsg(FightMsgId.FightMaxProgressValueChange, slot0._showFightProgress)
	slot0:com_registMsg(FightMsgId.ShowDouQuQuXianHouShou, slot0._onShowDouQuQuXianHouShou)
	slot0:com_registMsg(FightMsgId.RefreshPlayerFinisherSkill, slot0._onRefreshPlayerFinisherSkill)
	slot0:com_registMsg(FightMsgId.RefreshSimplePolarizationLevel, slot0._onRefreshSimplePolarizationLevel)
end

function slot0.removeEvents(slot0)
end

function slot0.onCreateDoomsdayClock(slot0)
	slot0:createDoomsdayClock()
end

function slot0.onBloodPoolCreate(slot0, slot1)
	if slot1 ~= FightEnum.TeamType.MySide then
		return
	end

	slot0:_createBloodPool(slot1)
end

function slot0._showSimplePolarizationLevel(slot0)
	if FightDataHelper.entityMgr:getMyVertin() then
		for slot6, slot7 in ipairs(slot1:getBuffList()) do
			if slot7.buffId == 6240501 then
				slot0:_onRefreshSimplePolarizationLevel()

				return
			end
		end
	end
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot3 == 6240501 and slot1 == FightEntityScene.MySideId then
		slot0:_onRefreshSimplePolarizationLevel()
	end
end

function slot0._onRefreshSimplePolarizationLevel(slot0)
	if slot0._simplePolarizationLevel then
		return
	end

	slot0._simplePolarizationLevel = slot0:com_openSubView(FightSimplePolarizationLevelView, "ui/viewres/fight/fightsimplepolarizationlevelview.prefab", slot0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.MelodyLevel))

	slot0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.MelodyLevel)
end

function slot0._onRefreshPlayerFinisherSkill(slot0)
	if slot0._playerFinisherSkill then
		return
	end

	slot0._playerFinisherSkill = slot0:com_openSubView(FightPlayerFinisherSkillView, "ui/viewres/fight/fightplayerfinisherskillview.prefab", slot0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.MelodySkill))

	slot0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.MelodySkill)
end

function slot0._onShowDouQuQuXianHouShou(slot0, slot1)
	slot0:com_openSubView(FightAct174StartFirstView, "ui/viewres/fight/fight_act174startfirstview.prefab", slot0.viewGO, slot1)
end

function slot0._onBeforeEnterStepBehaviour(slot0)
	if FightModel.instance:isSeason2() then
		gohelper.setActive(slot0._fightSeasonChangeHero, true)
		slot0:com_openSubView(FightSeasonChangeHeroView, slot0._fightSeasonChangeHero)
	end

	slot0:_showTopLeft()
end

function slot0._showTopLeft(slot0)
	slot0:_showFightProgress()
end

function slot0._showFightProgress(slot0)
	if FightDataHelper.fieldMgr.progressMax > 0 then
		if slot0._progressView then
			return
		end

		gohelper.setActive(slot0._progressRoot, true)

		slot3 = "ui/viewres/fight/commonalityslider.prefab"
		slot4 = FightCommonalitySlider

		if FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressId] == 1 then
			slot3 = "ui/viewres/fight/commonalityslider1.prefab"
		elseif slot2 == 2 then
			slot3 = "ui/viewres/fight/commonalityslider2.prefab"
			slot4 = FightCommonalitySlider2
		end

		slot0._progressView = slot0:com_openSubView(slot4, slot3, slot0._progressRoot, slot0._goRoot)
	end
end

function slot0.onOpen(slot0)
	slot0:_showCardDeckBtn()
	slot0:_showSeasonTalentBtn()
	slot0:_showPlayerFinisherSkill()
	slot0:_showSimplePolarizationLevel()
	slot0:_showTaskPart()
	slot0:_showBloodPool()
	slot0:_showDoomsdayClock()
	slot0:showDouQuQuCoin()
	slot0:showDouQuQuHunting()
end

function slot0.showDouQuQuHunting(slot0)
	if not FightDataHelper.fieldMgr.customData then
		return
	end

	if not FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191] then
		return
	end

	if slot1.minNeedHuntValue == -1 then
		return
	end

	slot2 = FightRightElementEnum.Elements.DouQuQuHunting

	slot0:com_openSubView(FightDouQuQuHuntingView, "ui/viewres/fight/fight_act191huntview.prefab", slot0.viewContainer.rightElementLayoutView:getElementContainer(slot2))
	slot0.viewContainer.rightElementLayoutView:showElement(slot2)
end

function slot0.showDouQuQuCoin(slot0)
	if not FightDataHelper.fieldMgr.customData then
		return
	end

	if not FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191] then
		return
	end

	slot2 = FightRightElementEnum.Elements.DouQuQuCoin

	slot0:com_openSubView(FightDouQuQuCoinView, "ui/viewres/fight/fight_act191coinview.prefab", slot0.viewContainer.rightElementLayoutView:getElementContainer(slot2))
	slot0.viewContainer.rightElementLayoutView:showElement(slot2)
end

function slot0._showDoomsdayClock(slot0)
	if FightDataHelper.fieldMgr.param and slot1:getKey(FightParamData.ParamKey.DoomsdayClock_Range4) then
		slot0:createDoomsdayClock()
	end
end

function slot0.createDoomsdayClock(slot0)
	if slot0.doomsdayClockView then
		return
	end

	slot0.doomsdayClockView = slot0:com_openSubView(FightDoomsdayClockView, "ui/viewres/fight/fightclockview.prefab", slot0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.DoomsdayClock))

	slot0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.DoomsdayClock)
end

function slot0._showBloodPool(slot0)
	if FightDataHelper.getBloodPool(FightEnum.TeamType.MySide) then
		slot0:_createBloodPool(FightEnum.TeamType.MySide)
	end
end

function slot0._createBloodPool(slot0, slot1)
	if slot0.bloodPoolView then
		return
	end

	slot0.bloodPoolView = slot0:com_openSubView(FightBloodPoolView, "ui/viewres/fight/fightbloodview.prefab", slot0.viewContainer.rightBottomElementLayoutView:getElementContainer(FightRightBottomElementEnum.Elements.BloodPool), slot1)

	slot0.viewContainer.rightBottomElementLayoutView:showElement(FightRightBottomElementEnum.Elements.BloodPool)
end

function slot0._showPlayerFinisherSkill(slot0)
	if FightDataHelper.fieldMgr.playerFinisherInfo and #slot1.skills > 0 then
		slot0:_onRefreshPlayerFinisherSkill()
	end
end

function slot0._showCardDeckBtn(slot0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		slot0:com_loadAsset("ui/viewres/fight/fightcarddeckbtnview.prefab", slot0._onBtnLoaded)
	end
end

function slot0.onDeckGenerate_Anim(slot0, slot1)
	if (slot1 and #slot1 or 0) <= 0 then
		return
	end

	for slot6, slot7 in ipairs(slot0.goPaiList) do
		gohelper.setActive(slot7, slot6 <= slot2)
	end

	slot0:showDeckActiveGo()
	slot0.deckAnimatorPlayer:Play("generate", slot0.hideDeckActiveGo, slot0)
	AudioMgr.instance:trigger(20250502)
end

function slot0.onPlayGenerateAnimDone(slot0)
	slot0:hideDeckActiveGo()
	slot0:com_sendFightEvent(FightEvent.CardDeckGenerateDone)
end

function slot0.onDeckDelete_Anim(slot0, slot1)
	if (slot1 and #slot1 or 0) <= 0 then
		return slot0:onPlayDeleteAnimDone()
	end

	for slot6, slot7 in ipairs(slot0.goPaiList) do
		gohelper.setActive(slot7, slot6 <= slot2)
	end

	slot0:showDeckActiveGo()
	slot0.deckAnimatorPlayer:Play("delete", slot0.onPlayDeleteAnimAnchorDone, slot0)
	AudioMgr.instance:trigger(20250503)
end

function slot0.onPlayDeleteAnimAnchorDone(slot0)
	slot0:clearFlow()

	slot0.dissolveFlow = FlowSequence.New()

	slot0.dissolveFlow:addWork(FightCardDissolveEffect.New())
	slot0.dissolveFlow:registerDoneListener(slot0.onPlayDeleteAnimDone, slot0)
	slot0.dissolveFlow:start({
		dissolveScale = 1,
		dissolveSkillItemGOs = {
			slot0.goDeckActive
		}
	})
end

function slot0.clearFlow(slot0)
	if slot0.dissolveFlow then
		slot0.dissolveFlow:stop()

		slot0.dissolveFlow = nil
	end
end

function slot0.onPlayDeleteAnimDone(slot0)
	slot0:hideDeckActiveGo()
	slot0:com_sendFightEvent(FightEvent.CardDeckDeleteDone)
end

function slot0.hideDeckActiveGo(slot0)
	gohelper.setActive(slot0.goDeckActive, false)
end

function slot0.showDeckActiveGo(slot0)
	gohelper.setActive(slot0.goDeckActive, true)
end

slot0.MaxDeckAnimLen = 15

function slot0._onBtnLoaded(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot4 = gohelper.clone(slot2:GetResource(), slot0._topRightBtnRoot, "cardBox")
	slot0.goDeckBtn = slot4
	slot9 = slot0

	slot0:com_registClick(gohelper.getClickWithDefaultAudio(slot4), slot0._onCardBoxClick, slot9)
	gohelper.setAsFirstSibling(slot4)

	slot0._deckCardAnimator = gohelper.onceAddComponent(slot4, typeof(UnityEngine.Animator))
	slot0._deckBtnAniPlayer = SLFramework.AnimatorPlayer.Get(slot4)
	slot0.txtNum = gohelper.findChildText(slot4, "txt_Num")

	gohelper.setActive(slot0.txtNum.gameObject, false)
	gohelper.setActive(gohelper.findChild(slot0.goDeckBtn, "#go_Active"), false)

	slot0.deckContainer = gohelper.findChild(slot0.goDeckBtn, "#deckbtn")

	gohelper.setActive(slot0.deckContainer, true)

	slot0.deckAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.deckContainer)
	slot0.goDeckActive = gohelper.findChild(slot0.deckContainer, "active")

	slot0:hideDeckActiveGo()

	slot0.goPaiList = slot0:newUserDataTable()

	for slot9 = 1, uv0.MaxDeckAnimLen do
		if not gohelper.findChild(slot0.goDeckActive, string.format("#pai%02d", slot9)) then
			logError("deck view not find pai , index : " .. slot9)
		end

		table.insert(slot0.goPaiList, slot10)
	end

	slot0:com_registFightEvent(FightEvent.CardDeckGenerate, slot0._onCardDeckGenerate)
	slot0:com_registFightEvent(FightEvent.CardClear, slot0._onCardClear)
	slot0:com_registFightEvent(FightEvent.CardBoxNumChange, slot0.onCardBoxNumChange)
	slot0:com_registFightEvent(FightEvent.CardDeckGenerate, slot0.onDeckGenerate_Anim)
	slot0:com_registFightEvent(FightEvent.CardDeckDelete, slot0.onDeckDelete_Anim)
end

function slot0.activeDeck(slot0)
	if FightDataHelper.fieldMgr and slot1:isAct183() then
		gohelper.setActive(gohelper.findChild(slot0.goDeckBtn, "#go_Active"), true)
		gohelper.setActive(slot0.txtNum.gameObject, true)
	end
end

function slot0.clearTweenId(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

slot0.DeckNumChangeDuration = 0.5

function slot0.onCardBoxNumChange(slot0, slot1, slot2)
	slot0:activeDeck()
	slot0:clearTweenId()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(tonumber(slot0.txtNum.text) or 0, slot2, uv0.DeckNumChangeDuration, slot0.directSetDeckNum, nil, slot0)
end

function slot0.directSetDeckNum(slot0, slot1)
	slot0.txtNum.text = math.ceil(slot1)
end

function slot0.onNumChangeDone(slot0)
	slot0:directSetDeckNum(FightDataHelper.fieldMgr.deckNum)
end

function slot0._onCardBoxClick(slot0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightCardDeckView, {
		selectType = FightCardDeckView.SelectType.CardBox
	})
end

function slot0._showSeasonTalentBtn(slot0)
	if not Season166Model.instance:getBattleContext(true) then
		return
	end

	if Season166Model.instance:checkCanShowSeasonTalent() then
		slot0:com_loadAsset("ui/viewres/fight/fightseasontalentbtn.prefab", slot0._onBtnSeasonTalentLoaded)
	end
end

function slot0._onBtnSeasonTalentLoaded(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot4 = gohelper.clone(slot2:GetResource(), slot0._topRightBtnRoot, "fightseasontalentbtn")

	slot0:com_registClick(gohelper.getClickWithDefaultAudio(slot4), slot0._onSeasonTalentClick, slot0)
	gohelper.setAsFirstSibling(slot4)
end

function slot0._onSeasonTalentClick(slot0)
	Season166Controller.instance:openTalentInfoView()
end

function slot0._deckAniFinish(slot0)
	slot0._deckCardAnimator.enabled = true

	slot0._deckCardAnimator:Play("idle")
end

function slot0._onCardDeckGenerate(slot0)
	slot0._deckBtnAniPlayer:Play("add", slot0._deckAniFinish, slot0)
end

function slot0._onCardClear(slot0)
	slot0._deckBtnAniPlayer:Play("delete", slot0._deckAniFinish, slot0)
end

function slot0._showTaskPart(slot0)
	if FightDataHelper.fieldMgr:isDungeonType(DungeonEnum.EpisodeType.Act183) then
		if not lua_challenge_episode.configDict[FightDataHelper.fieldMgr.episodeId] then
			return
		end

		if string.nilorempty(slot3.condition) then
			return
		end

		slot0:com_openSubView(Fight183TaskView, "ui/viewres/fight/fighttaskview.prefab", slot0._taskRoot, slot3.condition)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:clearFlow()
	slot0:clearTweenId()
end

return slot0
