module("modules.logic.room.controller.RoomEvent", package.seeall)

slot0 = _M
slot0.FSMEnterState = 1001
slot0.FSMLeaveState = 1002
slot0.UpdateInventoryCount = 3001
slot0.BuildingUIRefreshUI = 3102
slot0.RefreshResourceUIShow = 3103
slot0.RefreshNavigateButton = 3104
slot0.InventorySelectUIRefreshUI = 3201
slot0.RoomVieiwConfirmRefreshUI = 3301
slot0.CameraTransformUpdate = 4001
slot0.BendingAmountUpdate = 4002
slot0.CameraStateUpdate = 4003
slot0.CameraUpdateFinish = 4004
slot0.RoomTimerInitComplete = 41001
slot0.ResourceLight = 5001
slot0.CharacterCanConfirm = 5002
slot0.BuildingCanConfirm = 5003
slot0.TouchClickScene = 6001
slot0.TouchClickUI3D = 6002
slot0.TouchDrag = 6003
slot0.TouchScale = 6004
slot0.TouchRotate = 6005
slot0.TouchPressBuilding = 6006
slot0.TouchDropBuilding = 6007
slot0.TouchPressCharacter = 6008
slot0.TouchDropCharacter = 6009
slot0.BuildingListShowChanged = 7001
slot0.NewBuildingPush = 7002
slot0.UseBuildingReply = 7003
slot0.BuildingFilterChanged = 7005
slot0.BackBlockShowChanged = 7006
slot0.BuildingListOnDataChanged = 7007
slot0.NewBlockPackagePush = 7008
slot0.BuildingLevelUpPush = 7009
slot0.DebugPlaceListShowChanged = 7101
slot0.DebugPackageListShowChanged = 7201
slot0.DebugPackageFilterChanged = 7205
slot0.DebugPackageOrderChanged = 7206
slot0.DebugBuildingListShowChanged = 7301
slot0.CharacterListShowChanged = 7401
slot0.CharacterFilterChanged = 7405
slot0.SelectRoomViewBlockOpTab = 7406
slot0.TransportSiteViewShowChanged = 7407
slot0.BuildingListOnDragBeginListener = 7501
slot0.BuildingListOnDragListener = 7502
slot0.BuildingListOnDragEndListener = 7503
slot0.CharacterListOnDragBeginListener = 7601
slot0.CharacterListOnDragListener = 7602
slot0.CharacterListOnDragEndListener = 7603
slot0.WaterReformShowChanged = 7701
slot0.WaterReformSelectWaterChange = 7702
slot0.WaterReformChangeWaterType = 7703
slot0.SelectNextFormula = 8001
slot0.SubmitTradeOrder = 8002
slot0.DeleteTradeOrder = 8003
slot0.GetGatherProduce = 8004
slot0.GetMachineProduce = 8005
slot0.StartMachine = 8006
slot0.UseChangeFormula = 8007
slot0.NewFormulaPush = 8008
slot0.GetExpTreeProduce = 8009
slot0.SelectFormulaIdChanged = 8030
slot0.RefreshFormulaCombineCount = 8031
slot0.ChangeSelectFormulaToTopLevel = 8032
slot0.PlayFormulaAnimation = 8033
slot0.RefreshNeedFormula = 8034
slot0.ShowInitBuildingChangeTitle = 8035
slot0.UIFormulaIdTreeLevelHideAnim = 8036
slot0.UIFormulaIdTreeLevelShowAnim = 8037
slot0.UIFormulaIdTreeLevelMoveAnim = 8038
slot0.RefreshNeedFormulaItem = 8039
slot0.UpdateProduceLineData = 8010
slot0.OnSelectProduceLineItem = 8011
slot0.ProduceLineLevelUp = 8012
slot0.OnChangePartStart = 8013
slot0.GainProductionLineReply = 8014
slot0.StartProductionLineReply = 8015
slot0.UpdateStrengthReserve = 9001
slot0.UpdateBuildingLevels = 9002
slot0.UpdateBuildingLocalLevels = 9003
slot0.AccelerateSuccess = 9004
slot0.SetBuildingColliderEnable = 9005
slot0.DetailInfoChanged = 9101
slot0.UpdateMachineInfo = 9102
slot0.UpdateGatherInfo = 9103
slot0.UpdateTradeInfo = 9104
slot0.UpdateExpTreeInfo = 9105
slot0.GetGuideBuilding = 9106
slot0.AccelerateGuidePlan = 9107
slot0.ManufactureExpand = 9108
slot0.ManufactureGuideTweenFinish = 9109
slot0.DebugConfirmPlaceBlock = 10001
slot0.DebugRotateBlock = 10002
slot0.DebugRootOutBlock = 10003
slot0.DebugReplaceBlock = 10004
slot0.DebugSetPackage = 10005
slot0.DebugPlaceBuilding = 10101
slot0.DebugRotateBuilding = 10102
slot0.DebugRootOutBuilding = 10103
slot0.RefreshUIShow = 11001
slot0.RefreshSpineShow = 11002
slot0.UpdateBlur = 12001
slot0.PressBuildingUp = 13001
slot0.DropBuildingDown = 13002
slot0.PressCharacterUp = 13003
slot0.DropCharacterDown = 13004
slot0.ConfirmBlock = 14001
slot0.ConfirmBuilding = 14002
slot0.UnUseBuilding = 14003
slot0.OpenBuildingStrengthView = 14004
slot0.Reset = 14006
slot0.ClientPlaceBlock = 14101
slot0.ClientCancelBlock = 14102
slot0.ClientPlaceBuilding = 14103
slot0.ClientCancelBuilding = 14104
slot0.ClientTryBackBlock = 14201
slot0.ClientCancelBackBlock = 14202
slot0.ConfirmBackBlock = 14203
slot0.SelectBlockPackage = 14301
slot0.ConfirmSelectBlockPackage = 14302
slot0.SelectBlock = 14401
slot0.BackBlockListDataChanged = 14402
slot0.BackBlockPlayUIAnim = 14403
slot0.ConfirmCharacter = 14501
slot0.UnUseCharacter = 14502
slot0.ClientPlaceCharacter = 14503
slot0.CharacterEntityChanged = 14504
slot0.CharacterPositionChanged = 14505
slot0.RefreshFaithShow = 14506
slot0.ClickCharacterInNormalCamera = 14507
slot0.UpdateCharacterInteractionUI = 14508
slot0.AddCharacterFootPrint = 14509
slot0.InformSuccessReply = 14601
slot0.UpdateBuildingViewRefCamera = 15001
slot0.StartPlayAmbientAudio = 16001
slot0.OnUseBlock = 18001
slot0.UpdateRoomLevel = 19001
slot0.OnPlantResourceCountSatisfy = 20001
slot0.GuideOpenBuildingView = 20002
slot0.GuideFocusBuilding = 20003
slot0.GuideTouchUIPart = 20004
slot0.GuideShowSceneTask = 20005
slot0.GuideOpenInitBuilding0 = 20006
slot0.GuideOpenInitBuilding1 = 20007
slot0.GuideOpenInitBuilding2 = 20008
slot0.GuideOpenInitBuilding3 = 20009
slot0.GuideRoomInventoryBlock = 20010
slot0.GuideRoomInventoryBuilding = 20011
slot0.GuideOpenCombineFactoryView = 20012
slot0.UpdateWater = 21001
slot0.TaskUpdate = 22001
slot0.TaskCanFinish = 22002
slot0.TaskShowHideAnim = 22003
slot0.NavigateBubbleUpdate = 23001
slot0.SwitchScene = 24001
slot0.UIFlyEffect = 25001
slot0.BlockAtmosphereEffect = 25002
slot0.ResumeAtmosphereEffect = 25003
slot0.WillOpenRoomInitBuildingView = 26001
slot0.UpdateCharacterMove = 27001
slot0.PauseCharacterMove = 27002
slot0.ShowUI = 28001
slot0.HideUI = 28002
slot0.OnLateInitDone = 29002
slot0.OnSwitchModeDone = 29003
slot0.OnHourReporting = 29101
slot0.UpdateRoomThemeReward = 29201
slot0.CheckAoutGetRoomThemeReward = 29202
slot0.UISelectLayoutPlanItem = 29301
slot0.UISelectLayoutPlanCoverItem = 29302
slot0.UICancelLayoutPlanItemTab = 29303
slot0.UISwitchLayoutPlanBuildDegree = 29304
slot0.MapEntityNightLight = 29401
slot0.UIRoomThemeFilterChanged = 29501
slot0.TransportPathLineChanged = 29601
slot0.TransportPathConfirmChange = 29602
slot0.TransportPathViewShowChanged = 29603
slot0.TransportCritterChanged = 40001
slot0.TransportBuildingChanged = 40002
slot0.TransportBuildingSelect = 40003
slot0.TransportCritterSelect = 40004
slot0.TransportSiteSelect = 40005
slot0.TransportPathDeleteLineItem = 40006
slot0.TransportPathSelectLineItem = 40007
slot0.TransportBuildingSkinSelect = 40008
slot0.VehicleStartMove = 40101
slot0.VehicleStopMove = 40102
slot0.VehicleIdChange = 40103
slot0.InteractBuildingSelectHero = 42001
slot0.InteractBuildingShowChanged = 42002
slot0.CritterTrainAttributeSelected = 50001
slot0.SceneTrainChangeSpine = 50002
slot0.CritterTrainLevelFinished = 50003
slot0.CritterTrainAttributeCancel = 50004
slot0.NewLog = 600001
slot0.SwitchRecordView = 600002

return slot0
