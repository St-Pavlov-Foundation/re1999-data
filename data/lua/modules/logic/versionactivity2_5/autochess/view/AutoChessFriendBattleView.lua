module("modules.logic.versionactivity2_5.autochess.view.AutoChessFriendBattleView", package.seeall)

local var_0_0 = class("AutoChessFriendBattleView", BaseView)
local var_0_1 = {
	100,
	100,
	105
}
local var_0_2 = {
	-463,
	-480,
	-490
}
local var_0_3 = {
	228,
	144,
	60
}
local var_0_4 = 70
local var_0_5 = {
	228,
	144,
	60
}
local var_0_6 = {
	100,
	100,
	110
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBadgeRoot = gohelper.findChild(arg_1_0.viewGO, "#go_BadgeRoot")
	arg_1_0._goReward = gohelper.findChild(arg_1_0.viewGO, "root/#go_Reward")
	arg_1_0._goRewardItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_Reward/reward/#go_RewardItem")
	arg_1_0._playerBadge = gohelper.findChildText(arg_1_0.viewGO, "root/Player/Badge/#txt_badge")
	arg_1_0._playerName = gohelper.findChildText(arg_1_0.viewGO, "root/Player/#txt_Name")
	arg_1_0._playerIconRoot = gohelper.findChild(arg_1_0.viewGO, "root/Player/HeroHeadIcon")
	arg_1_0._btnPlayerAreaClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Player/#btn_Check")
	arg_1_0._playerHeadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Player/HeroHeadIcon/#simage_headicon")
	arg_1_0._goPlayerChess1 = gohelper.findChild(arg_1_0.viewGO, "root/Player/Chess/chess1")
	arg_1_0._goPlayerChess2 = gohelper.findChild(arg_1_0.viewGO, "root/Player/Chess/chess2")
	arg_1_0._goPlayerChess3 = gohelper.findChild(arg_1_0.viewGO, "root/Player/Chess/chess3")
	arg_1_0._goPlayerSnapChess = gohelper.findChild(arg_1_0.viewGO, "root/Player/image_bg/chessbg/simage_chessbg/snapChess/go_Chess")
	arg_1_0._goPlayerLeaderMesh = gohelper.findChild(arg_1_0.viewGO, "root/Player/image_bg/chessbg/simage_chessbg/snapChess/#go_LeaderMesh")
	arg_1_0._enemyRoot = gohelper.findChild(arg_1_0.viewGO, "root/Enemy")
	arg_1_0._emptyEnemy = gohelper.findChild(arg_1_0.viewGO, "root/Enemy_empty")
	arg_1_0._enemyBadge = gohelper.findChildText(arg_1_0.viewGO, "root/Enemy/Badge/#txt_badge")
	arg_1_0._enemyName = gohelper.findChildText(arg_1_0.viewGO, "root/Enemy/#txt_Name")
	arg_1_0._enemyIconRoot = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/HeroHeadIcon")
	arg_1_0._enemyHeadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Enemy/HeroHeadIcon/#simage_headicon")
	arg_1_0._goEnemyChess1 = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/Chess/chess1")
	arg_1_0._goEnemyChess2 = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/Chess/chess2")
	arg_1_0._goEnemyChess3 = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/Chess/chess3")
	arg_1_0._goEnemySnapChess = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/image_bg/chessbg/simage_chessbg/snapChess/go_Chess")
	arg_1_0._goEnemyLeaderMesh = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/image_bg/chessbg/simage_chessbg/snapChess/#go_LeaderMesh")
	arg_1_0._btnEnemyAreaClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Enemy/#btn_Check")
	arg_1_0._btnEnemySwitchLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Enemy/#btn_SwitchLeft")
	arg_1_0._btnEnemySwitchRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Enemy/#btn_SwitchRight")
	arg_1_0._goRecord = gohelper.findChild(arg_1_0.viewGO, "root/#btn_Record/txt_Record")
	arg_1_0._goRecordGray = gohelper.findChild(arg_1_0.viewGO, "root/#btn_Record/txt_RecordGrey")
	arg_1_0._btnBattleRecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Record")
	arg_1_0._btnBattleStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Start")
	arg_1_0._imageBattleStart = gohelper.findChildImage(arg_1_0.viewGO, "root/#btn_Start")
	arg_1_0._btnFriendList = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Friend")
	arg_1_0._btnJumpToFriend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Enemy_empty/#btn_AddFriend")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBattleStart:AddClickListener(arg_2_0.onClickBattleStart, arg_2_0)
	arg_2_0._btnBattleRecord:AddClickListener(arg_2_0.onClickBattleRecord, arg_2_0)
	arg_2_0._btnFriendList:AddClickListener(arg_2_0.onClickFriendList, arg_2_0)
	arg_2_0._btnJumpToFriend:AddClickListener(arg_2_0.onClickJumpToFriend, arg_2_0)
	arg_2_0._btnEnemySwitchRight:AddClickListener(arg_2_0.onClickNextFriendBtn, arg_2_0)
	arg_2_0._btnEnemySwitchLeft:AddClickListener(arg_2_0.onClickLastFriendBtn, arg_2_0)
	arg_2_0:addEventCb(AutoChessController.instance, AutoChessEvent.SelectFriendSnapshot, arg_2_0.requestNewFriendSnapshot, arg_2_0)
	arg_2_0:addEventCb(Activity182Controller.instance, Activity182Event.UpdateInfo, arg_2_0._onUpdateInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBattleStart:RemoveClickListener()
	arg_3_0._btnBattleRecord:RemoveClickListener()
	arg_3_0._btnFriendList:RemoveClickListener()
	arg_3_0._btnEnemySwitchRight:RemoveClickListener()
	arg_3_0._btnEnemySwitchLeft:RemoveClickListener()
	arg_3_0._btnJumpToFriend:RemoveClickListener()
end

function var_0_0.onClickBattleStart(arg_4_0)
	local var_4_0 = arg_4_0._enemySnap and arg_4_0._enemySnap.playerInfo
	local var_4_1 = arg_4_0._selfSnap and arg_4_0._selfSnap.playerInfo
	local var_4_2 = var_4_1 and var_4_1.userId ~= 0
	local var_4_3 = var_4_0 and var_4_0.userId ~= 0

	if not (var_4_2 and var_4_3) then
		return
	end

	local var_4_4 = arg_4_0._curFriendIdx
	local var_4_5 = Activity182Model.instance:getActMo(arg_4_0._actId):getFriendInfoList()[var_4_4].userId

	AutoChessRpc.instance:sendAutoChessEnterFriendFightSceneRequest(arg_4_0._actId, AutoChessEnum.ModuleId.Friend, var_4_5)
end

function var_0_0.onClickBattleRecord(arg_5_0)
	local var_5_0 = Activity182Model.instance:getActMo(arg_5_0._actId):getFriendFightRecords()

	if var_5_0 and #var_5_0 == 0 then
		GameFacade.showToastString(luaLang("activityweekwalkdeepview_empty"))

		return
	end

	AutoChessController.instance:openFriendBattleRecordView()
end

function var_0_0.onGotFriendFightRecordAndOpenRecordView(arg_6_0)
	arg_6_0:refreshBtnState()
	AutoChessController.instance:openFriendBattleRecordView()
end

function var_0_0.onGotFriendFightRecordCallback(arg_7_0)
	arg_7_0:refreshBtnState()
end

function var_0_0.onClickFriendList(arg_8_0)
	AutoChessController.instance:openFriendListView()
end

function var_0_0.onClickNextFriendBtn(arg_9_0)
	local var_9_0 = arg_9_0._curFriendIdx
	local var_9_1 = Activity182Model.instance:getActMo(arg_9_0._actId):getFriendInfoList()[var_9_0 + 1]

	if not var_9_1 then
		return
	end

	arg_9_0:requestNewFriendSnapshot(var_9_1.userId)
end

function var_0_0.onClickLastFriendBtn(arg_10_0)
	local var_10_0 = arg_10_0._curFriendIdx
	local var_10_1 = Activity182Model.instance:getActMo(arg_10_0._actId):getFriendInfoList()[var_10_0 - 1]

	if not var_10_1 then
		return
	end

	arg_10_0:requestNewFriendSnapshot(var_10_1.userId)
end

function var_0_0.requestNewFriendSnapshot(arg_11_0, arg_11_1)
	arg_11_0._curFriendUserId = arg_11_1

	Activity182Rpc.instance:sendAct182GetFriendSnapshotsRequest(arg_11_0._actId, arg_11_0._curFriendUserId, arg_11_0.onChangeFriendSnapshot, arg_11_0)
end

function var_0_0.onChangeFriendSnapshot(arg_12_0)
	arg_12_0:resetSnapView()

	local var_12_0 = Activity182Model.instance:getActMo(arg_12_0._actId)
	local var_12_1 = var_12_0:getFriendInfoList()

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		if iter_12_1.userId == arg_12_0._curFriendUserId then
			arg_12_0._curFriendIdx = iter_12_0

			break
		end
	end

	arg_12_0._selfSnap = var_12_0.snapshot
	arg_12_0._enemySnap = var_12_0:getCurFriendSnapshot()

	arg_12_0:refreshPlayerInfoView()

	local var_12_2 = arg_12_0._selfSnap.warZones
	local var_12_3 = arg_12_0._selfSnap.master

	arg_12_0:refreshMonsterInfoView(var_12_2, var_12_3, true)

	if arg_12_0._enemySnap then
		local var_12_4 = arg_12_0._enemySnap.warZones
		local var_12_5 = arg_12_0._enemySnap.master

		arg_12_0:refreshMonsterInfoView(var_12_4, var_12_5, false)
	end

	arg_12_0:refreshChangeFriendBtn()
end

function var_0_0.onClickJumpToFriend(arg_13_0)
	JumpController.instance:jump(JumpEnum.JumpView.SocialView)
end

function var_0_0._onUpdateInfo(arg_14_0)
	Activity182Rpc.instance:sendAct182GetFriendFightRecordsRequest(arg_14_0._actId, arg_14_0.onGotFriendFightRecordCallback, arg_14_0)
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0._actId = Activity182Model.instance:getCurActId()

	Activity182Rpc.instance:sendAct182GetFriendFightRecordsRequest(arg_15_0._actId, arg_15_0.onGotFriendFightRecordCallback, arg_15_0)

	arg_15_0._chessGoList = arg_15_0:getUserDataTb_()
	arg_15_0._leaderMeshGo = nil
	arg_15_0._enemyLeaderMeshGo = nil

	arg_15_0:resetSnapView()
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onOpen(arg_17_0)
	AudioMgr.instance:trigger(AudioEnum2_8.AutoChess.play_ui_fuleyuan_comity_open)

	arg_17_0._curFriendIdx = 1
	arg_17_0._actId = Activity182Model.instance:getCurActId()

	local var_17_0 = Activity182Model.instance:getActMo(arg_17_0._actId)

	arg_17_0._selfSnap = var_17_0.snapshot
	arg_17_0._enemySnap = var_17_0:getCurFriendSnapshot()

	arg_17_0:refreshPlayerInfoView()

	local var_17_1 = arg_17_0._selfSnap.warZones
	local var_17_2 = arg_17_0._selfSnap.master

	arg_17_0:refreshMonsterInfoView(var_17_1, var_17_2, true)

	if arg_17_0._enemySnap then
		local var_17_3 = arg_17_0._enemySnap.warZones
		local var_17_4 = arg_17_0._enemySnap.master

		arg_17_0:refreshMonsterInfoView(var_17_3, var_17_4, false)
	end

	arg_17_0:refreshChangeFriendBtn()
	arg_17_0:refreshBtnState()
end

function var_0_0.resetSnapView(arg_18_0)
	if arg_18_0._chessGoList and #arg_18_0._chessGoList > 0 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._chessGoList) do
			gohelper.destroy(iter_18_1)
		end
	end

	gohelper.setActive(arg_18_0._goPlayerChess1, false)
	gohelper.setActive(arg_18_0._goPlayerChess2, false)
	gohelper.setActive(arg_18_0._goPlayerChess3, false)
	gohelper.setActive(arg_18_0._goEnemyChess1, false)
	gohelper.setActive(arg_18_0._goEnemyChess2, false)
	gohelper.setActive(arg_18_0._goEnemyChess3, false)
	gohelper.setActive(arg_18_0._goPlayerSnapChess, false)
	gohelper.setActive(arg_18_0._goPlayerLeaderMesh, false)
	gohelper.setActive(arg_18_0._goEnemySnapChess, false)
	arg_18_0:refreshBtnState()
end

function var_0_0.refreshPlayerInfoView(arg_19_0)
	local var_19_0 = arg_19_0._selfSnap.playerInfo

	if var_19_0 and var_19_0.userId ~= 0 then
		arg_19_0._playerRankCfg = lua_auto_chess_rank.configDict[arg_19_0._actId][var_19_0.rank]

		if not arg_19_0._playerRankCfg then
			arg_19_0._playerBadge.text = luaLang("autochess_badgeitem_noget")
		end

		arg_19_0._playerBadge.text = arg_19_0._playerRankCfg.name
		arg_19_0._playerName.text = var_19_0.name

		arg_19_0._playerIconRoot:SetActive(true)

		local var_19_1 = var_19_0.portrait

		if not arg_19_0._playerLiveHeadIcon then
			arg_19_0._playerLiveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_19_0._playerHeadicon)
		end

		arg_19_0._playerLiveHeadIcon:setLiveHead(var_19_1)
	else
		local var_19_2 = PlayerModel.instance:getPlayinfo()

		arg_19_0._playerBadge.text = luaLang("autochess_badgeitem_noget")
		arg_19_0._playerName.text = var_19_2.name

		arg_19_0._playerIconRoot:SetActive(true)

		local var_19_3 = var_19_2.portrait

		if not arg_19_0._playerLiveHeadIcon then
			arg_19_0._playerLiveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_19_0._playerHeadicon)
		end

		arg_19_0._playerLiveHeadIcon:setLiveHead(var_19_3)
	end

	local var_19_4 = arg_19_0._enemySnap and arg_19_0._enemySnap.playerInfo

	if var_19_4 and var_19_4.userId ~= 0 then
		gohelper.setActive(arg_19_0._enemyRoot, true)
		gohelper.setActive(arg_19_0._emptyEnemy, false)

		arg_19_0._enemyRankCfg = lua_auto_chess_rank.configDict[arg_19_0._actId][var_19_4.rank]

		if not arg_19_0._enemyRankCfg then
			arg_19_0._enemyBadge.text = luaLang("autochess_badgeitem_noget")
		end

		arg_19_0._enemyBadge.text = arg_19_0._enemyRankCfg.name
		arg_19_0._enemyName.text = var_19_4.name

		arg_19_0._enemyIconRoot:SetActive(true)

		local var_19_5 = var_19_4.portrait

		if not arg_19_0._enemyLiveHeadIcon then
			arg_19_0._enemyLiveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_19_0._enemyHeadicon)
		end

		arg_19_0._enemyLiveHeadIcon:setLiveHead(var_19_5)
	else
		gohelper.setActive(arg_19_0._enemyRoot, false)
		gohelper.setActive(arg_19_0._emptyEnemy, true)
	end
end

function var_0_0.refreshMonsterInfoView(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		local var_20_1 = iter_20_1.id
		local var_20_2 = iter_20_1.positions

		for iter_20_2, iter_20_3 in ipairs(var_20_2) do
			local var_20_3 = iter_20_3.index
			local var_20_4 = iter_20_3.chess.id
			local var_20_5 = {
				zoneId = var_20_1,
				chessId = var_20_4,
				idx = var_20_3
			}

			var_20_0[#var_20_0 + 1] = var_20_5
		end
	end

	local var_20_6 = arg_20_3 and "_goPlayerChess" or "_goEnemyChess"
	local var_20_7 = arg_20_3 and arg_20_0._goPlayerSnapChess or arg_20_0._goEnemySnapChess

	for iter_20_4, iter_20_5 in ipairs(var_20_0) do
		local var_20_8 = AutoChessConfig.instance:getChessCfgById(iter_20_5.chessId, 1)

		if iter_20_4 <= 3 then
			local var_20_9 = arg_20_0[var_20_6 .. iter_20_4]

			gohelper.setActive(var_20_9, true)

			local var_20_10 = gohelper.findChild(var_20_9, "Mesh")

			MonoHelper.addNoUpdateLuaComOnceToGo(var_20_10, AutoChessMeshComp):setData(var_20_8.image)
		end

		local var_20_11 = gohelper.cloneInPlace(var_20_7, iter_20_5.chessId)

		arg_20_0._chessGoList[#arg_20_0._chessGoList + 1] = var_20_11

		gohelper.setActive(var_20_11, true)

		local var_20_12 = gohelper.findChild(var_20_11, "Mesh")

		MonoHelper.addNoUpdateLuaComOnceToGo(var_20_12, AutoChessMeshComp):setData(var_20_8.image)

		local var_20_13 = 0
		local var_20_14

		if arg_20_3 then
			var_20_13 = var_0_2[iter_20_5.zoneId] + iter_20_5.idx * var_0_1[iter_20_5.zoneId]
			var_20_14 = var_0_3[iter_20_5.zoneId]
		else
			var_20_13 = var_0_4 + (iter_20_5.idx - 5) * var_0_6[iter_20_5.zoneId]
			var_20_14 = var_0_5[iter_20_5.zoneId]
		end

		recthelper.setAnchor(var_20_11.transform, var_20_13, var_20_14)

		local var_20_15, var_20_16, var_20_17 = transformhelper.getLocalScale(var_20_11.transform)

		var_20_15 = arg_20_3 and -1 * var_20_15 or var_20_15

		transformhelper.setLocalScale(var_20_11.transform, var_20_15, var_20_16, var_20_17)
	end

	if not arg_20_2 then
		return
	end

	local var_20_18 = arg_20_3 and arg_20_0._goPlayerLeaderMesh or arg_20_0._goEnemyLeaderMesh
	local var_20_19 = arg_20_2.id
	local var_20_20 = lua_auto_chess_master.configDict[var_20_19]

	if var_20_20 then
		MonoHelper.addNoUpdateLuaComOnceToGo(var_20_18, AutoChessMeshComp):setData(var_20_20.image, false, true)
	end
end

function var_0_0.refreshChangeFriendBtn(arg_21_0)
	local var_21_0 = arg_21_0._curFriendIdx
	local var_21_1 = Activity182Model.instance:getActMo(arg_21_0._actId):getFriendInfoList()

	gohelper.setActive(arg_21_0._btnEnemySwitchRight.gameObject, var_21_0 < #var_21_1)
	gohelper.setActive(arg_21_0._btnEnemySwitchLeft.gameObject, var_21_0 > 1)
end

function var_0_0.refreshBtnState(arg_22_0)
	local var_22_0 = arg_22_0._enemySnap and arg_22_0._enemySnap.playerInfo
	local var_22_1 = arg_22_0._selfSnap and arg_22_0._selfSnap.playerInfo
	local var_22_2 = var_22_1 and var_22_1.userId ~= 0
	local var_22_3 = var_22_0 and var_22_0.userId ~= 0
	local var_22_4 = var_22_2 and var_22_3

	SLFramework.UGUI.GuiHelper.SetColor(arg_22_0._imageBattleStart, var_22_4 and "#FFFFFF" or "#B0B0B0")

	local var_22_5 = Activity182Model.instance:getActMo(arg_22_0._actId):getFriendFightRecords()
	local var_22_6 = false

	if var_22_5 then
		for iter_22_0, iter_22_1 in ipairs(var_22_5) do
			var_22_6 = true
		end
	end

	local var_22_7 = not var_22_6

	gohelper.setActive(arg_22_0._goRecord, not var_22_7)
	gohelper.setActive(arg_22_0._goRecordGray, var_22_7)
	ZProj.UGUIHelper.SetGrayscale(arg_22_0._btnBattleRecord.gameObject, var_22_7)
end

function var_0_0.onClose(arg_23_0)
	AutoChessController.instance:openMainView()
end

return var_0_0
