module("modules.logic.fight.controller.FightEvent", package.seeall)

slot0 = _M
slot0.RespBeginFight = GameUtil.getEventId()
slot0.RespBeginFightFail = GameUtil.getEventId()
slot0.RespBeginRound = GameUtil.getEventId()
slot0.RespBeginRoundFail = GameUtil.getEventId()
slot0.RespChangeSubHero = GameUtil.getEventId()
slot0.RespChangeSubHeroFail = GameUtil.getEventId()
slot0.PushCardInfo = GameUtil.getEventId()
slot0.PushTeamInfo = GameUtil.getEventId()
slot0.RespEndFight = GameUtil.getEventId()
slot0.RespEndFightFail = GameUtil.getEventId()
slot0.PushEndFight = GameUtil.getEventId()
slot0.RespReconnectFight = GameUtil.getEventId()
slot0.StartPlayClothSkill = GameUtil.getEventId()
slot0.AfterPlayClothSkill = GameUtil.getEventId()
slot0.RespUseClothSkill = GameUtil.getEventId()
slot0.RespUseClothSkillFail = GameUtil.getEventId()
slot0.RespResetCard = GameUtil.getEventId()
slot0.PushRedealCardInfo = GameUtil.getEventId()
slot0.RespGetFightOperReplay = GameUtil.getEventId()
slot0.RespGetFightOperReplayFail = GameUtil.getEventId()
slot0.RespGetFightRecordGroupReply = GameUtil.getEventId()
slot0.PushFightWave = GameUtil.getEventId()
slot0.OnReqEndFight = GameUtil.getEventId()
slot0.OnGMFightWithRecordAllReply = GameUtil.getEventId()
slot0.OnFightReconnect = GameUtil.getEventId()
slot0.OnStartFightPlayBorn = GameUtil.getEventId()
slot0.OnStartSequenceFinish = GameUtil.getEventId()
slot0.OnRoundSequenceFinish = GameUtil.getEventId()
slot0.OnEndSequenceFinish = GameUtil.getEventId()
slot0.OnResultViewClose = GameUtil.getEventId()
slot0.OnBeginWave = GameUtil.getEventId()
slot0.OnStartSequenceStart = GameUtil.getEventId()
slot0.OnRoundSequenceStart = GameUtil.getEventId()
slot0.OnClothSkillRoundSequenceFinish = GameUtil.getEventId()
slot0.OnBreakResultViewClose = GameUtil.getEventId()
slot0.OnPreloadFinish = GameUtil.getEventId()
slot0.ChangeWaveStart = GameUtil.getEventId()
slot0.OnStartFightPlayBornNormal = GameUtil.getEventId()
slot0.OnFightReconnectLastWork = GameUtil.getEventId()
slot0.ChangeWaveEnd = GameUtil.getEventId()
slot0.onReceiveEntityInfoReply = GameUtil.getEventId()
slot0.DistributeCards = GameUtil.getEventId()
slot0.PlayHandCard = GameUtil.getEventId()
slot0.RevertCard = GameUtil.getEventId()
slot0.ResetCard = GameUtil.getEventId()
slot0.DragHandCardBegin = GameUtil.getEventId()
slot0.DragHandCard = GameUtil.getEventId()
slot0.DragHandCardEnd = GameUtil.getEventId()
slot0.LongPressHandCard = GameUtil.getEventId()
slot0.LongPressHandCardEnd = GameUtil.getEventId()
slot0.UpdateHandCards = GameUtil.getEventId()
slot0.AutoToSelectSkillTarget = GameUtil.getEventId()
slot0.SelectSkillTarget = GameUtil.getEventId()
slot0.AutoPlayCard = GameUtil.getEventId()
slot0.OnMySideRoundEnd = GameUtil.getEventId()
slot0.FightRoundEnd = GameUtil.getEventId()
slot0.NeedWaitEnemyOPEnd = GameUtil.getEventId()
slot0.CardDisappear = GameUtil.getEventId()
slot0.CardDisappearFinish = GameUtil.getEventId()
slot0.FightRoundStart = GameUtil.getEventId()
slot0.BeforePlayHandCard = GameUtil.getEventId()
slot0.OnHandCardFlowCreate = GameUtil.getEventId()
slot0.OnHandCardFlowStart = GameUtil.getEventId()
slot0.OnHandCardFlowEnd = GameUtil.getEventId()
slot0.onNoActCostMoveFlowOver = GameUtil.getEventId()
slot0.DetectCardOpEndAfterOperationEffectDone = GameUtil.getEventId()
slot0.CorrectPlayCardObjList = GameUtil.getEventId()
slot0.AddPlayOperationData = GameUtil.getEventId()
slot0.ShowReadyAttackAct = GameUtil.getEventId()
slot0.PlayOperationEffectDone = GameUtil.getEventId()
slot0.OnMoveHandCard = GameUtil.getEventId()
slot0.OnPlayHandCard = GameUtil.getEventId()
slot0.OnRevertCard = GameUtil.getEventId()
slot0.OnResetCard = GameUtil.getEventId()
slot0.OnUpdateSpeed = GameUtil.getEventId()
slot0.OnDistributeCards = GameUtil.getEventId()
slot0.ShowPlayCardEffect = GameUtil.getEventId()
slot0.ShowPlayCardFlyEffect = GameUtil.getEventId()
slot0.OnCombineOneCard = GameUtil.getEventId()
slot0.OnCombineCardEnd = GameUtil.getEventId()
slot0.OneAutoPlayCardFinish = GameUtil.getEventId()
slot0.OnStageChange = GameUtil.getEventId()
slot0.ShowEnemyRoundHandCards = GameUtil.getEventId()
slot0.PlayChangeCardEffect = GameUtil.getEventId()
slot0.PlayChangeCardEffectInWaitingArea = GameUtil.getEventId()
slot0.OnChangeCardEffectDone = GameUtil.getEventId()
slot0.UniversalAppear = GameUtil.getEventId()
slot0.OnUniversalAppear = GameUtil.getEventId()
slot0.OnClothSkillExpand = GameUtil.getEventId()
slot0.OnClothSkillShrink = GameUtil.getEventId()
slot0.OnEffectExtraMoveAct = GameUtil.getEventId()
slot0.PlayEnemyChangeCardEffect = GameUtil.getEventId()
slot0.CheckCardOpEnd = GameUtil.getEventId()
slot0.OnRoundViewClose = GameUtil.getEventId()
slot0.OnFightSpecialTipView = GameUtil.getEventId()
slot0.SetPlayCardPartOutScreen = GameUtil.getEventId()
slot0.SetPlayCardPartOriginPos = GameUtil.getEventId()
slot0.OnFightQuitTipViewClose = GameUtil.getEventId()
slot0.PlayRedealCardEffect = GameUtil.getEventId()
slot0.SetCardMagicEffectChange = GameUtil.getEventId()
slot0.PlayCardMagicEffectChange = GameUtil.getEventId()
slot0.CardMagicEffectChangeDone = GameUtil.getEventId()
slot0.SetBlockCardOperate = GameUtil.getEventId()
slot0.CardOpEnd = GameUtil.getEventId()
slot0.OnPlayCardFlowDone = GameUtil.getEventId()
slot0.OnDissolveCombineEnd = GameUtil.getEventId()
slot0.SpCardAdd = GameUtil.getEventId()
slot0.SetHandCardVisible = GameUtil.getEventId()
slot0.FixWaitingAreaItemCount = GameUtil.getEventId()
slot0.TempCardRemove = GameUtil.getEventId()
slot0.AddHandCard = GameUtil.getEventId()
slot0.SwitchFightendBgm = GameUtil.getEventId()
slot0.PlayDialog = GameUtil.getEventId()
slot0.AfterPlayDialog = GameUtil.getEventId()
slot0.RefreshPlayCardRoundOp = GameUtil.getEventId()
slot0.PlayCardFlayFinish = GameUtil.getEventId()
slot0.HidePlayCardAllCard = GameUtil.getEventId()
slot0.PlayCardOver = GameUtil.getEventId()
slot0.GetFightCardDeckInfoReply = GameUtil.getEventId()
slot0.OnEnemyActionStatusChange = GameUtil.getEventId()
slot0.OnInvokeSkill = GameUtil.getEventId()
slot0.BeforePlaySkill = GameUtil.getEventId()
slot0.ToPlaySkill = GameUtil.getEventId()
slot0.OnSkillPlayStart = GameUtil.getEventId()
slot0.OnSkillPlayFinish = GameUtil.getEventId()
slot0.OnUniqueCameraTick = GameUtil.getEventId()
slot0.ParallelPlayNextSkillCheck = GameUtil.getEventId()
slot0.ParallelPlayNextSkillDoneThis = GameUtil.getEventId()
slot0.AfterPlayAppearTimeline = GameUtil.getEventId()
slot0.BeforePlayTimeline = GameUtil.getEventId()
slot0.BeforePlayUniqueSkill = GameUtil.getEventId()
slot0.AfterPlayUniqueSkill = GameUtil.getEventId()
slot0.ForceEndSkillStep = GameUtil.getEventId()
slot0.CheckPlaySameSkill = GameUtil.getEventId()
slot0.BeforePlaySameSkill = GameUtil.getEventId()
slot0.StartPlaySameSkill = GameUtil.getEventId()
slot0.PlaySameSkillOneDone = GameUtil.getEventId()
slot0.OnSkillEffectPlayFinish = GameUtil.getEventId()
slot0.InvokeEntityDeadImmediately = GameUtil.getEventId()
slot0.SkipAppearTimeline = GameUtil.getEventId()
slot0.SetBuffEffectVisible = GameUtil.getEventId()
slot0.EntityEffectLoaded = GameUtil.getEventId()
slot0.SetEntityAlpha = GameUtil.getEventId()
slot0.TimelinePlayEntityAni = GameUtil.getEventId()
slot0.SummonedAdd = GameUtil.getEventId()
slot0.SummonedDelete = GameUtil.getEventId()
slot0.SummonedLevelChange = GameUtil.getEventId()
slot0.PlayRemoveSummoned = GameUtil.getEventId()
slot0.AddMagicCircile = GameUtil.getEventId()
slot0.DeleteMagicCircile = GameUtil.getEventId()
slot0.UpdateMagicCircile = GameUtil.getEventId()
slot0.ChangeSceneVisible = GameUtil.getEventId()
slot0.BeforeEnterStepBehaviour = GameUtil.getEventId()
slot0.EntrustEntity = GameUtil.getEventId()
slot0.ChangeToTempCard = GameUtil.getEventId()
slot0.EntrustTempEntity = GameUtil.getEventId()
slot0.ReleaseAllEntrustedEntity = GameUtil.getEventId()
slot0.MasterPowerChange = GameUtil.getEventId()
slot0.SetBossEvolution = GameUtil.getEventId()
slot0.SetStateForDialogBeforeStartFight = GameUtil.getEventId()
slot0.EntityDeadFinish = GameUtil.getEventId()
slot0.CorrectHandCardScale = GameUtil.getEventId()
slot0.CountEntityInfoReply = GameUtil.getEventId()
slot0.RemoveEntityCards = GameUtil.getEventId()
slot0.RefreshHandCard = GameUtil.getEventId()
slot0.RefreshHandCardMO = GameUtil.getEventId()
slot0.CardsCompose = GameUtil.getEventId()
slot0.CardsComposeTimeOut = GameUtil.getEventId()
slot0.CardRemove = GameUtil.getEventId()
slot0.CardRemove2 = GameUtil.getEventId()
slot0.RefreshOneHandCard = GameUtil.getEventId()
slot0.BFSGSkillEnd = GameUtil.getEventId()
slot0.InvokeFightWorkEffectType = GameUtil.getEventId()
slot0.SetUseCards = GameUtil.getEventId()
slot0.AddUseCard = GameUtil.getEventId()
slot0.InvalidUsedCard = GameUtil.getEventId()
slot0.ShowSimulateClientUsedCard = GameUtil.getEventId()
slot0.CardLevelChange = GameUtil.getEventId()
slot0.InvalidPreUsedCard = GameUtil.getEventId()
slot0.InvalidEnemyUsedCard = GameUtil.getEventId()
slot0.RefreshEntityData = GameUtil.getEventId()
slot0.ForceUpdatePerformanceData = GameUtil.getEventId()
slot0.AfterForceUpdatePerformanceData = GameUtil.getEventId()
slot0.AfterPlayerSelectUpgrade = GameUtil.getEventId()
slot0.MasterAddHandCard = GameUtil.getEventId()
slot0.MasterCardRemove = GameUtil.getEventId()
slot0.CancelVisibleViewScaleTween = GameUtil.getEventId()
slot0.AfterEnterStepBehaviour = GameUtil.getEventId()
slot0.ChangeCareer = GameUtil.getEventId()
slot0.TouchFightViewScreen = GameUtil.getEventId()
slot0.CardAConvertCardB = GameUtil.getEventId()
slot0.ChangeCardEnchant = GameUtil.getEventId()
slot0.CardLongPressEffectEnd = GameUtil.getEventId()
slot0.PolarizationLevel = GameUtil.getEventId()
slot0.ResonanceLevel = GameUtil.getEventId()
slot0.RougeCoinChange = GameUtil.getEventId()
slot0.UpdateUIFollower = GameUtil.getEventId()
slot0.RougeMagicChange = GameUtil.getEventId()
slot0.RougeMagicLimitChange = GameUtil.getEventId()
slot0.ForceEndAutoCardFlow = GameUtil.getEventId()
slot0.CorrectPlayCardVisible = GameUtil.getEventId()
slot0.CorrectPlayCardScrollViewPos = GameUtil.getEventId()
slot0.CardLevelChangeDone = GameUtil.getEventId()
slot0.PlayCardAroundUpRank = GameUtil.getEventId()
slot0.PlayCardAroundDownRank = GameUtil.getEventId()
slot0.PlayCardAroundSetGray = GameUtil.getEventId()
slot0.PlayChangeRankFail = GameUtil.getEventId()
slot0.TriggerStressBehaviour = GameUtil.getEventId()
slot0.TriggerCardShowResistanceTag = GameUtil.getEventId()
slot0.ChangeSubHeroExSkillReply = GameUtil.getEventId()
slot0.ReplaceEntityMO = GameUtil.getEventId()
slot0.EntityGuardChange = GameUtil.getEventId()
slot0.PlayDiscardEffect = GameUtil.getEventId()
slot0.CancelAutoPlayCardFinishEvent = GameUtil.getEventId()
slot0.RevertAutoPlayCardFinishEvent = GameUtil.getEventId()
slot0.PlayCombineCards = GameUtil.getEventId()
slot0.DiscardAfterPlayCardFinish = GameUtil.getEventId()
slot0.StartPlayDiscardEffect = GameUtil.getEventId()
slot0.EnterStage = GameUtil.getEventId()
slot0.ExitStage = GameUtil.getEventId()
slot0.StageChanged = GameUtil.getEventId()
slot0.EnterFightState = GameUtil.getEventId()
slot0.ExitFightState = GameUtil.getEventId()
slot0.EnterOperateState = GameUtil.getEventId()
slot0.ExitOperateState = GameUtil.getEventId()
slot0.ChangeSubEntityHp = GameUtil.getEventId()
slot0.SeasonSelectChangeHeroTarget = GameUtil.getEventId()
slot0.ReceiveChangeSubHeroReply = GameUtil.getEventId()
slot0.EntitySync = GameUtil.getEventId()
slot0.CancelOperation = GameUtil.getEventId()
slot0.ClearMonsterSub = GameUtil.getEventId()
slot0.RefreshMonsterSubCount = GameUtil.getEventId()
slot0.CardDeckGenerate = GameUtil.getEventId()
slot0.CardDeckGenerateDone = GameUtil.getEventId()
slot0.CardDeckDelete = GameUtil.getEventId()
slot0.CardDeckDeleteDone = GameUtil.getEventId()
slot0.CardClear = GameUtil.getEventId()
slot0.CardBoxNumChange = GameUtil.getEventId()
slot0.StartFightEnd = GameUtil.getEventId()
slot0.CardEffectChange = GameUtil.getEventId()
slot0.RefreshHandCardPrecisionEffect = GameUtil.getEventId()
slot0.ChangeEntitySubCd = GameUtil.getEventId()
slot0.GuideSubEntityExpoint5 = GameUtil.getEventId()
slot0.FightWorkStepSkillTimeout = GameUtil.getEventId()
slot0.ShowSeasonGuardIntro = GameUtil.getEventId()
slot0.DouQuQuSettlementFinish = GameUtil.getEventId()
slot0.BeforeStartFight = GameUtil.getEventId()
slot0.ChangeShield = GameUtil.getEventId()
slot0.RefreshUIRound = GameUtil.getEventId()
slot0.CoverPerformanceEntityData = GameUtil.getEventId()
slot0.OnGuideBeforeSkillPause = GameUtil.getEventId()
slot0.OnGuideBeforeSkillContinue = GameUtil.getEventId()
slot0.OnGuideEntityDeadPause = GameUtil.getEventId()
slot0.OnGuideEntityDeadContinue = GameUtil.getEventId()
slot0.OnGuideCardEndPause = GameUtil.getEventId()
slot0.OnGuideCardEndContinue = GameUtil.getEventId()
slot0.OnGuideFightEndPause = GameUtil.getEventId()
slot0.OnGuideFightEndPause_sp = GameUtil.getEventId()
slot0.OnGuideFightEndContinue = GameUtil.getEventId()
slot0.OnGuideFightEndContinue_sp = GameUtil.getEventId()
slot0.OnGuideDistributePause = GameUtil.getEventId()
slot0.OnGuideDistributeContinue = GameUtil.getEventId()
slot0.OnHpChange = GameUtil.getEventId()
slot0.OnShieldChange = GameUtil.getEventId()
slot0.OnChangeEntity = GameUtil.getEventId()
slot0.OnEntityDead = GameUtil.getEventId()
slot0.OnSpineLoaded = GameUtil.getEventId()
slot0.UpdateExPoint = GameUtil.getEventId()
slot0.OnBuffUpdate = GameUtil.getEventId()
slot0.OnPassiveSkillClick = GameUtil.getEventId()
slot0.ShowCardSkillTips = GameUtil.getEventId()
slot0.HideCardSkillTips = GameUtil.getEventId()
slot0.PlayAddExPointEffect = GameUtil.getEventId()
slot0.PlayRemoveExPointEffect = GameUtil.getEventId()
slot0.UpdateWaitingArea = GameUtil.getEventId()
slot0.OnSkillLastHit = GameUtil.getEventId()
slot0.OnBuffClick = GameUtil.getEventId()
slot0.ShowClothSkillTips = GameUtil.getEventId()
slot0.OnSpineMaterialChange = GameUtil.getEventId()
slot0.BeforeDeadEffect = GameUtil.getEventId()
slot0.OnExPointChange = GameUtil.getEventId()
slot0.OnTimelineHeal = GameUtil.getEventId()
slot0.OnStartChangeEntity = GameUtil.getEventId()
slot0.OnCameraFocusChanged = GameUtil.getEventId()
slot0.OnChangeFocusViewPage = GameUtil.getEventId()
slot0.OnMonsterChange = GameUtil.getEventId()
slot0.OnChangeHeroEnd = GameUtil.getEventId()
slot0.SetEntityVisibleByTimeline = GameUtil.getEventId()
slot0.SetNameUIVisibleByTimeline = GameUtil.getEventId()
slot0.SetEntityWeatherEffectVisible = GameUtil.getEventId()
slot0.OnRemoveFightEntity = GameUtil.getEventId()
slot0.SetEntityFootEffectVisible = GameUtil.getEventId()
slot0.OnShowPoisoningEffectPlay = GameUtil.getEventId()
slot0.OnFloatEquipEffect = GameUtil.getEventId()
slot0.OnExpointMaxAdd = GameUtil.getEventId()
slot0.PlaySpecialIdle = GameUtil.getEventId()
slot0.OnRestartStageBefore = GameUtil.getEventId()
slot0.BeforeRestartAbandon = GameUtil.getEventId()
slot0.OnRestartFightDisposeDone = GameUtil.getEventId()
slot0.BeforeDestroyEntity = GameUtil.getEventId()
slot0.OnSkillDamage = GameUtil.getEventId()
slot0.OnMaxHpChange = GameUtil.getEventId()
slot0.OnCurrentHpChange = GameUtil.getEventId()
slot0.OnDamageTotal = GameUtil.getEventId()
slot0.OnExSkillPointChange = GameUtil.getEventId()
slot0.BeforeEntityDestroy = GameUtil.getEventId()
slot0.OnIndicatorChange = GameUtil.getEventId()
slot0.ContinueMonsterChange = GameUtil.getEventId()
slot0.BeforeSkillDialog = GameUtil.getEventId()
slot0.DialogContinueSkill = GameUtil.getEventId()
slot0.OnIndicatorAnimationDone = GameUtil.getEventId()
slot0.FightDialog = GameUtil.getEventId()
slot0.FightDialogEnd = GameUtil.getEventId()
slot0.MultiHpChange = GameUtil.getEventId()
slot0.ShowFightPrompt = GameUtil.getEventId()
slot0.TriggerDialogEnd = GameUtil.getEventId()
slot0.PowerMaxChange = GameUtil.getEventId()
slot0.PowerChange = GameUtil.getEventId()
slot0.OnPlayVideo = GameUtil.getEventId()
slot0.BeforeChangeSubHero = GameUtil.getEventId()
slot0.FightDialogShow = GameUtil.getEventId()
slot0.SetEntityRendererEnabled = GameUtil.getEventId()
slot0.AddEntityBuff = GameUtil.getEventId()
slot0.RemoveEntityBuff = GameUtil.getEventId()
slot0.ForbidBossRushHpChannelSkillOpItem = GameUtil.getEventId()
slot0.HeroUpgradeDone = GameUtil.getEventId()
slot0.ChangeRound = GameUtil.getEventId()
slot0.BeContract = GameUtil.getEventId()
slot0.OnSkillTimeLineDone = GameUtil.getEventId()
slot0.AddSubEntity = GameUtil.getEventId()
slot0.PowerInfoChange = GameUtil.getEventId()
slot0.RefreshCardHeatShow = GameUtil.getEventId()
slot0.SetIsShowUI = GameUtil.getEventId()
slot0.SetIsShowFloat = GameUtil.getEventId()
slot0.UpdateUIPartVisible = GameUtil.getEventId()
slot0.SetIsShowNameUI = GameUtil.getEventId()
slot0.OnCameraFovChange = GameUtil.getEventId()
slot0.AddPlayCardClientExPoint = GameUtil.getEventId()
slot0.OnStoreExPointChange = GameUtil.getEventId()
slot0.OnAssistBossPowerChange = GameUtil.getEventId()
slot0.OnAssistBossCDChange = GameUtil.getEventId()
slot0.OnPlayAssistBossCardFlowDone = GameUtil.getEventId()
slot0.OnSwitchAssistBossSkill = GameUtil.getEventId()
slot0.OnSwitchAssistBossSpine = GameUtil.getEventId()
slot0.OnAssistBossScoreChange = GameUtil.getEventId()
slot0.OnGuideDragCard = GameUtil.getEventId()
slot0.OnGuideGetUniqueCard = GameUtil.getEventId()
slot0.OnGuideStopAutoFight = GameUtil.getEventId()
slot0.OnEndFightForGuide = GameUtil.getEventId()
slot0.OnGuideShowEnemyNum = GameUtil.getEventId()
slot0.OnGuideShowRougeSkill = GameUtil.getEventId()
slot0.GuideSeasonChangeHeroClickEntity = GameUtil.getEventId()
slot0.GuideCreateClickBySkinId = GameUtil.getEventId()
slot0.GuideReleaseClickBySkilId = GameUtil.getEventId()
slot0.OnAddActPoint = GameUtil.getEventId()
slot0.OnSummon = GameUtil.getEventId()
slot0.OnDiceEnd = GameUtil.getEventId()
slot0.StartReplay = GameUtil.getEventId()
slot0.SimulateDragHandCardBegin = GameUtil.getEventId()
slot0.SimulateDragHandCard = GameUtil.getEventId()
slot0.SimulateDragHandCardEnd = GameUtil.getEventId()
slot0.SimulatePlayHandCard = GameUtil.getEventId()
slot0.SimulateClickClothSkillIcon = GameUtil.getEventId()
slot0.SimulateSelectSkillTargetInView = GameUtil.getEventId()
slot0.ReplayTick = GameUtil.getEventId()
slot0.SwitchInfoState = GameUtil.getEventId()
slot0.TriggerSceneAnimator = GameUtil.getEventId()
slot0.OnHideSkillEditorUIEvent = GameUtil.getEventId()
slot0.OnSkillEditorSceneChange = GameUtil.getEventId()
slot0.OnEditorPlaySpineAniStart = GameUtil.getEventId()
slot0.OnEditorPlaySpineAniEnd = GameUtil.getEventId()
slot0.OnEditorPlayBuffStart = GameUtil.getEventId()
slot0.OnEditorPlayBuffEnd = GameUtil.getEventId()
slot0.GMHideFightView = GameUtil.getEventId()
slot0.SetSkillEditorViewVisible = GameUtil.getEventId()
slot0.SkillEditorPlayCardCameraAni = GameUtil.getEventId()
slot0.SkillEditorRefreshBuff = GameUtil.getEventId()
slot0.GMCopyRoundLog = GameUtil.getEventId()
slot0.CacheRoundLog = GameUtil.getEventId()
slot0.CacheFightProto = GameUtil.getEventId()
slot0.GMForceRefreshNameUIBuff = GameUtil.getEventId()
slot0.OnSelectMonsterCardMo = GameUtil.getEventId()
slot0.ASFD_OnStart = GameUtil.getEventId()
slot0.ASFD_OnASFDEffectFlowDone = GameUtil.getEventId()
slot0.ASFD_OnASFDExplosionDone = GameUtil.getEventId()
slot0.ASFD_OnASFDArrivedDone = GameUtil.getEventId()
slot0.ASFD_OnDone = GameUtil.getEventId()
slot0.ASFD_TeamEnergyChange = GameUtil.getEventId()
slot0.ASFD_EmitterEnergyChange = GameUtil.getEventId()
slot0.ASFD_AllocateCardEnergyDone = GameUtil.getEventId()
slot0.ASFD_StartAllocateCardEnergy = GameUtil.getEventId()
slot0.ASFD_PullOut = GameUtil.getEventId()
slot0.TimelineLYSpecialSpinePlayAniName = GameUtil.getEventId()
slot0.LY_CardAreaSizeChange = GameUtil.getEventId()
slot0.LY_PointAreaSizeChange = GameUtil.getEventId()
slot0.LY_HadRedAndBluePointChange = GameUtil.getEventId()
slot0.LY_TriggerCountSkill = GameUtil.getEventId()

return slot0
