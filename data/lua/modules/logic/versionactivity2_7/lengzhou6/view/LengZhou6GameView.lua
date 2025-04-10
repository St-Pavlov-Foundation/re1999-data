module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameView", package.seeall)

slot0 = class("LengZhou6GameView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._goRight = gohelper.findChild(slot0.viewGO, "#go_Right")
	slot0._simageGrid = gohelper.findChildSingleImage(slot0.viewGO, "#go_Right/#simage_Grid")
	slot0._goTimes = gohelper.findChild(slot0.viewGO, "#go_Right/#go_Times")
	slot0._btnLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Right/#go_Times/#btn_Left")
	slot0._txtTimes = gohelper.findChildText(slot0.viewGO, "#go_Right/#go_Times/#txt_Times")
	slot0._btnRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Right/#go_Times/#btn_Right")
	slot0._goChessBG = gohelper.findChild(slot0.viewGO, "#go_Right/#go_ChessBG")
	slot0._gochessBoard = gohelper.findChild(slot0.viewGO, "#go_Right/#go_ChessBG/#go_chessBoard")
	slot0._gochess = gohelper.findChild(slot0.viewGO, "#go_Right/#go_ChessBG/#go_chess")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Right/#go_ChessBG/#go_chess/#btn_click")
	slot0._goChessEffect = gohelper.findChild(slot0.viewGO, "#go_Right/#go_ChessEffect")
	slot0._goLoading = gohelper.findChild(slot0.viewGO, "#go_Right/#go_Loading")
	slot0._sliderloading = gohelper.findChildSlider(slot0.viewGO, "#go_Right/#go_Loading/#slider_loading")
	slot0._goContinue = gohelper.findChild(slot0.viewGO, "#go_Right/#go_Continue")
	slot0._simageMask = gohelper.findChildSingleImage(slot0.viewGO, "#go_Right/#go_Continue/#simage_Mask")
	slot0._btnContinue = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Right/#go_Continue/#btn_Continue")
	slot0._goMask = gohelper.findChild(slot0.viewGO, "#go_Right/#go_Mask")
	slot0._goAssess = gohelper.findChild(slot0.viewGO, "#go_Right/#go_Assess")
	slot0._imageAssess = gohelper.findChildImage(slot0.viewGO, "#go_Right/#go_Assess/#image_Assess")
	slot0._goAssess2 = gohelper.findChild(slot0.viewGO, "#go_Right/#go_Assess2")
	slot0._imageAssess2 = gohelper.findChildImage(slot0.viewGO, "#go_Right/#go_Assess2/#image_Assess2")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "#go_Right/#go_Assess2/#txt_Num")
	slot0._goEnemy = gohelper.findChild(slot0.viewGO, "Left/#go_Enemy")
	slot0._txtenemySkillTitle = gohelper.findChildText(slot0.viewGO, "Left/#go_Enemy/#txt_enemy_SkillTitle")
	slot0._imageEnemyHeadIcon = gohelper.findChildImage(slot0.viewGO, "Left/#go_Enemy/Head/#image_Enemy_HeadIcon")
	slot0._txtEnemyLife = gohelper.findChildText(slot0.viewGO, "Left/#go_Enemy/Life/#txt_EnemyLife")
	slot0._goTarget = gohelper.findChild(slot0.viewGO, "Left/#go_Target")
	slot0._simageHeadIcon = gohelper.findChildSingleImage(slot0.viewGO, "Left/#go_Target/go_Head/#simage_HeadIcon")
	slot0._txtendlessnum = gohelper.findChildText(slot0.viewGO, "Left/#go_Target/go_Endless/#txt_endless_num")
	slot0._goSelf = gohelper.findChild(slot0.viewGO, "Left/#go_Self")
	slot0._simagePlayerHeadIcon = gohelper.findChildSingleImage(slot0.viewGO, "Left/#go_Self/Head/#simage_Player_HeadIcon")
	slot0._txtSelfLife = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/Life/#txt_SelfLife")
	slot0._btnskillDescClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_Self/#btn_skillDescClose")
	slot0._goChooseSkillTips = gohelper.findChild(slot0.viewGO, "Left/#go_Self/#go_ChooseSkillTips")
	slot0._goUseSkillTips = gohelper.findChild(slot0.viewGO, "Left/#go_Self/#go_UseSkillTips")
	slot0._txtSkillDescr = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr")
	slot0._txtSkillName = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/#txt_SkillName")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/#txt_Round")
	slot0._btnuseSkill = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/Title/#btn_useSkill")
	slot0._goEnemySkillTips = gohelper.findChild(slot0.viewGO, "Left/#go_Self/#go_EnemySkillTips")
	slot0._txtEnemySkillDescr = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/#go_EnemySkillTips/image_TipsBG/#txt_Enemy_SkillDescr")
	slot0._txtEnemySkillName = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/#go_EnemySkillTips/image_TipsBG/#txt_Enemy_SkillDescr/#txt_Enemy_SkillName")
	slot0._goEnemyBuffTips = gohelper.findChild(slot0.viewGO, "Left/#go_Self/#go_EnemyBuffTips")
	slot0._txtEnemyBuffDescr = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/#go_EnemyBuffTips/image_TipsBG/#txt_Enemy_BuffDescr")
	slot0._txtEnemyBuffName = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/#go_EnemyBuffTips/image_TipsBG/#txt_Enemy_BuffDescr/#txt_Enemy_BuffName")
	slot0._goPlayerBuffTips = gohelper.findChild(slot0.viewGO, "Left/#go_Self/#go_PlayerBuffTips")
	slot0._txtPlayerBuffDescr = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/#go_PlayerBuffTips/image_TipsBG/#txt_Player_BuffDescr")
	slot0._txtPlayerBuffName = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/#go_PlayerBuffTips/image_TipsBG/#txt_Player_BuffDescr/#txt_Player_BuffName")
	slot0._goCombos = gohelper.findChild(slot0.viewGO, "#go_Combos")
	slot0._imageComboFire = gohelper.findChildImage(slot0.viewGO, "#go_Combos/#image_ComboFire")
	slot0._txtComboNum = gohelper.findChildText(slot0.viewGO, "#go_Combos/#txt_ComboNum")
	slot0._txtComboNum1 = gohelper.findChildText(slot0.viewGO, "#go_Combos/#txt_ComboNum1")
	slot0._goChangeTips = gohelper.findChild(slot0.viewGO, "#go_ChangeTips")
	slot0._goSkillRelease = gohelper.findChild(slot0.viewGO, "#go_SkillRelease")
	slot0._gorectMask = gohelper.findChild(slot0.viewGO, "#go_SkillRelease/#go_rectMask")
	slot0._txtskillTipDesc = gohelper.findChildText(slot0.viewGO, "#go_SkillRelease/#txt_skillTipDesc")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnskillDescClose:AddClickListener(slot0._btnskillDescCloseOnClick, slot0)
	slot0._btnuseSkill:AddClickListener(slot0._btnuseSkillOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnskillDescClose:RemoveClickListener()
	slot0._btnuseSkill:RemoveClickListener()
end

function slot0._btnskillDescCloseOnClick(slot0)
	slot0:closeSkillTips()
	slot0:closeChooseSkillTips()
	slot0:closeBuffTips()
end

function slot0._btnuseSkillOnClick(slot0)
	if slot0._playerCurSkillCanUse then
		slot0:releaseSkill()
	end
end

slot1 = ZProj.UIEffectsCollection

function slot0._editableInitView(slot0)
	slot0._goPlayerSkillParent = gohelper.findChild(slot0.viewGO, "Left/#go_Self/Scroll View/Viewport/Content")
	slot0._goEnemySkillParent = gohelper.findChild(slot0.viewGO, "Left/#go_Enemy/Scroll View/Viewport/Content")
	slot0._goPlayerChooseSkillParent = gohelper.findChild(slot0.viewGO, "Left/#go_Self/#go_ChooseSkillTips/Scroll View/Viewport/Content")
	slot0._imageUseSkillEffectCollection = uv0.Get(gohelper.findChild(slot0.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/Title/#btn_useSkill"))
	slot0._combosTr = slot0._goCombos.transform
	slot0._combosAnim = slot0._goCombos:GetComponent(typeof(UnityEngine.Animator))
	slot0._goChooseSkillTipsAnim = slot0._goChooseSkillTips:GetComponent(typeof(UnityEngine.Animator))
	slot0._playerDamageGo = gohelper.findChild(slot0.viewGO, "Left/#go_Self/Life/damage")
	slot0._playerDamageText = gohelper.findChildText(slot0.viewGO, "Left/#go_Self/Life/damage/x/txtNum")
	slot0._enemyDamageGo = gohelper.findChild(slot0.viewGO, "Left/#go_Enemy/Life/damage")
	slot0._enemyDamageText = gohelper.findChildText(slot0.viewGO, "Left/#go_Enemy/Life/damage/x/txtNum")

	gohelper.setActive(slot0._playerDamageGo, false)
	gohelper.setActive(slot0._enemyDamageGo, false)

	slot0._enemyBuffParent = gohelper.findChild(slot0.viewGO, "Left/#go_Enemy/Life/EnemyBuff")
	slot0._playerBuffParent = gohelper.findChild(slot0.viewGO, "Left/#go_Self/Life/PlayerBuff")
	slot0._playerAni = slot0._goSelf:GetComponent(gohelper.Type_Animator)
	slot0._enemyAni = slot0._goEnemy:GetComponent(gohelper.Type_Animator)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:initView()
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UpdateGameInfo, slot0.updateGameInfo, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UpdateEliminateDamage, slot0.updateEliminateDamage, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UpdateEnemySkill, slot0.updateEnemySkill, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UpdatePlayerSkill, slot0.updatePlayerSkill, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.OnClickSkill, slot0.onClickSkill, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.FinishReleaseSkill, slot0.cancelPlayerSkill, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UseEnemySkill, slot0.useEnemySkill, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ShowCombos, slot0.showCombos, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ShowEnemyEffect, slot0.showEnemyEffect, slot0)
	slot0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.EnemySkillRound, slot0.enemySkillRound, slot0)
	slot0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.OnEndlessChangeSelectState, slot0.endLessModelRefreshView, slot0)
	slot0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.ShowSelectView, slot0.showSelectView, slot0)
	slot0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.PlayerSelectFinish, slot0._playerSkillSelectFinish, slot0)
	slot0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.GameReStart, slot0._gameReStart, slot0)
	slot0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.RefreshBuffItem, slot0.refreshBuffItem, slot0)
	slot0:addEventCb(LengZhou6Controller.instance, LengZhou6Event.OnClickBuff, slot0.onClickBuff, slot0)
end

function slot0.initView(slot0)
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_level_open)

	slot2 = LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.infinite

	slot0:initHeroAndEnemyIcon()
	slot0:updateGameInfo()
	slot0:updateEliminateDamage()
	slot0:initPlayerSKillView(not slot2)
	slot0:initEnemySKillView()
	slot0:updatePlayerSkill()
	slot0:enemySkillRound()
	gohelper.setActive(slot0._goUseSkillTips, false)
	gohelper.setActive(slot0._btnskillDescClose.gameObject, false)
	gohelper.setActive(slot0._goSelected, false)
	gohelper.setActive(slot0._goTarget, slot2)

	if slot2 then
		slot0:initSelectView()
	end

	slot0:closeChooseSkillTips()
	slot0:endLessModelRefreshView(true)
end

function slot0.initHeroAndEnemyIcon(slot0)
	UISpriteSetMgr.instance:setHisSaBethSprite(slot0._imageEnemyHeadIcon, LengZhou6Config.instance:getEliminateBattleCostStr(25))
	slot0._simagePlayerHeadIcon:LoadImage(ResUrl.getHeadIconSmall(LengZhou6Config.instance:getEliminateBattleCostStr(24)))
end

slot2 = ""

function slot0.updateGameInfo(slot0)
	slot0._txtEnemyLife.text = LengZhou6GameModel.instance:getEnemy():getHp()
	slot0._txtSelfLife.text = LengZhou6GameModel.instance:getPlayer():getHp()

	gohelper.setActive(slot0._goCombos, false)

	slot4 = LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.normal
	slot0._txtendlessnum.text = LengZhou6GameModel.instance:getEndLessModelLayer() or LengZhou6Enum.DefaultEndLessBeginRound

	slot0:refreshBuffItem()
end

function slot0.enemySkillRound(slot0, slot1)
	if slot1 == nil then
		slot1 = LengZhou6GameModel.instance:getEnemy():getAction():calCurResidueCd()
	end

	slot3 = math.max(slot1 - 1, 0)

	if slot1 <= 1 then
		slot0._txtenemySkillTitle.text = luaLang("lengZhou6_enemy_skill_title_2")
	else
		slot0._txtenemySkillTitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_enemy_skill_title"), slot3)
	end

	if slot0._enemySkillList == nil then
		return
	end

	for slot7 = 1, #slot0._enemySkillList do
		if slot0._enemySkillList[slot7] then
			slot8:showEnemySkillRound(slot2)
		end
	end
end

function slot0.endLessModelRefreshView(slot0, slot1)
	gohelper.setActive(slot0._goChangeTips, false)

	if LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.infinite then
		slot3 = LengZhou6GameModel.instance:getEndLessBattleProgress()
		slot4 = 0.1

		if slot1 then
			slot4 = LengZhou6Enum.openViewAniTime
		end

		TaskDispatcher.runDelay(slot0.showChangeTips, slot0, slot4)

		if slot3 == LengZhou6Enum.BattleProgress.selectFinish then
			slot0:updateGameInfo()
		end

		slot0:initPlayerSKillView(slot5)
		slot0:closeSkillTips()
		slot0:cancelPlayerSkill()
		slot0:updateEnemySkill()
		slot0:enemySkillRound()
	end
end

function slot0.showChangeTips(slot0)
	TaskDispatcher.cancelTask(slot0.showChangeTips, slot0)
	gohelper.setActive(slot0._goChangeTips, LengZhou6GameModel.instance:getEndLessBattleProgress() == LengZhou6Enum.BattleProgress.selectSkill)
	LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.EnterGameLevel, LengZhou6Model.instance:getCurEpisodeId())
end

function slot0.updateEliminateDamage(slot0)
	slot3 = false

	if LengZhou6GameModel.instance:getEnemy():getCurDiff() and math.abs(slot2) > 0 then
		slot0:setCombosActive(true)

		slot0._enemyDamageText.text = "-" .. math.abs(slot2)

		gohelper.setActive(slot0._enemyDamageGo, true)
		slot0._enemyAni:Play("damage", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_hp)

		slot3 = true
	else
		slot0:setCombosActive(false)
	end

	if LengZhou6GameModel.instance:getPlayer():getCurDiff() and math.abs(slot5) > 0 then
		slot0._playerDamageText.text = "+" .. math.abs(slot5)

		gohelper.setActive(slot0._playerDamageGo, true)

		slot3 = true
	end

	if slot3 then
		TaskDispatcher.runDelay(slot0._onMoveEnd, slot0, EliminateEnum_2_7.UpdateDamageStepTime)
	end
end

function slot0._onMoveEnd(slot0)
	gohelper.setActive(slot0._enemyDamageGo, false)
	gohelper.setActive(slot0._playerDamageGo, false)
	TaskDispatcher.cancelTask(slot0._onMoveEnd, slot0)
	slot0:setCombosActive(false)

	slot0._txtEnemyLife.text = LengZhou6GameModel.instance:getEnemy():getHp()
	slot0._txtSelfLife.text = LengZhou6GameModel.instance:getPlayer():getHp()

	slot0._enemyAni:Play("idle", 0, 0)
end

function slot0.showCombos(slot0, slot1)
	slot2 = slot1 or 0
	slot4 = LengZhou6Config.instance:getComboThreshold() <= slot2
	slot0._txtComboNum.text = slot2
	slot0._txtComboNum1.text = slot2

	if slot0._comboActive then
		slot0._combosAnim:Play("up", 0, 0)
	end

	slot0:setCombosActive(slot2 > 0)
	gohelper.setActive(slot0._imageComboFire.gameObject, slot4)
end

function slot0.setCombosActive(slot0, slot1)
	if slot0._comboActive ~= nil and slot0._comboActive == slot1 then
		return
	end

	gohelper.setActive(slot0._goCombos, slot1)

	slot0._comboActive = slot1
end

function slot0.initPlayerSKillView(slot0, slot1)
	if slot0._playerSkillList == nil then
		slot0._playerSkillList = slot0:getUserDataTb_()
	end

	slot4 = LengZhou6GameModel.instance:getSelectSkillIdList()
	slot5 = slot0.viewContainer:getSetting().otherRes[1]

	for slot9 = 1, LengZhou6Enum.PlayerSkillMaxCount do
		slot10, slot11 = nil

		if slot1 then
			slot10 = LengZhou6GameModel.instance:getPlayer():getActiveSkills()[slot9]
		else
			slot11 = slot4[slot9]
		end

		if slot0._playerSkillList[slot9] == nil then
			slot13 = slot0:getResInst(slot5, slot0._goPlayerSkillParent)

			gohelper.setActive(slot13, true)
			table.insert(slot0._playerSkillList, MonoHelper.addNoUpdateLuaComOnceToGo(slot13, LengZhou6SkillItem))
		end

		if slot12 ~= nil then
			slot12:initSkill(slot10, slot9)

			if slot10 == nil then
				slot12:initSkillConfigId(slot11)
			end

			slot12:initCamp(LengZhou6Enum.entityCamp.player)
			slot12:selectIsFinish(slot1)
			slot12:refreshState()
		end
	end
end

function slot0.updatePlayerSkill(slot0)
	if slot0._playerSkillList ~= nil then
		for slot4 = 1, #slot0._playerSkillList do
			if slot0._playerSkillList[slot4] then
				slot5:updateSkillInfo()
			end
		end
	end
end

function slot0.initEnemySKillView(slot0)
	if slot0._enemySkillList == nil then
		slot0._enemySkillList = slot0:getUserDataTb_()
	end

	slot2 = LengZhou6GameModel.instance:getEnemy():getCurSkillList()

	for slot7 = 1, 3 do
		slot8 = slot2 and slot2[slot7]

		if slot0._enemySkillList[slot7] == nil then
			slot10 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goEnemySkillParent)
			slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot10, LengZhou6SkillItem)

			gohelper.setActive(slot10, true)
		end

		slot9:initSkill(slot8)
		slot9:initCamp(LengZhou6Enum.entityCamp.enemy)
		slot9:refreshState()
		table.insert(slot0._enemySkillList, slot9)
	end
end

function slot0.updateEnemySkill(slot0)
	slot2 = LengZhou6GameModel.instance:getEnemy():getCurSkillList()

	for slot6 = 1, 3 do
		slot7 = slot2 and slot2[slot6] or nil
		slot8 = slot0._enemySkillList[slot6]

		slot8:initSkill(slot7)
		slot8:refreshState()

		if slot7 ~= nil then
			AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_refresh)
		end
	end
end

function slot0.useEnemySkill(slot0, slot1)
	for slot5 = 1, #slot0._enemySkillList do
		slot0._enemySkillList[slot5]:useSkill(slot1)
	end
end

function slot0.onClickSkill(slot0, slot1)
	if slot1 == nil then
		return
	end

	if slot1:getSkillType() == LengZhou6Enum.SkillType.enemyActive then
		slot0:_showEnemySkillDesc(slot1)
	else
		slot0:_showPlayerSkillDesc(slot1)
	end

	gohelper.setActive(slot0._btnskillDescClose.gameObject, true)
end

function slot0._showEnemySkillDesc(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0._txtEnemySkillDescr.text = slot1:getSkillDesc()
	slot0._txtEnemySkillName.text = slot1:getConfig().name

	gohelper.setActive(slot0._goEnemySkillTips, true)
end

function slot0._showPlayerSkillDesc(slot0, slot1)
	slot0._playerCurSkill = slot1
	slot2 = slot1:getConfig()
	slot0._txtSkillDescr.text = slot2.desc
	slot3 = slot1:getCd()

	if slot2.type == LengZhou6Enum.SkillType.active then
		slot0._txtRound.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_skill_round"), slot1:getConfig().cd)
	else
		slot0._txtRound.text = luaLang("lengZhou6_skill_round_end")
	end

	slot0._txtSkillName.text = slot2.name
	slot0._playerCurSkillCanUse = slot3 == 0 and slot4

	if slot0._imageUseSkillEffectCollection ~= nil then
		slot0._imageUseSkillEffectCollection:SetGray(not slot0._playerCurSkillCanUse)
	end

	gohelper.setActive(slot0._btnuseSkill.gameObject, slot4)
	gohelper.setActive(slot0._goUseSkillTips, true)
end

function slot0.closeSkillTips(slot0)
	gohelper.setActive(slot0._goUseSkillTips, false)
	gohelper.setActive(slot0._btnskillDescClose.gameObject, false)
	gohelper.setActive(slot0._goEnemySkillTips, false)
end

function slot0.releaseSkill(slot0)
	if slot0._playerCurSkill ~= nil then
		if slot0._playerCurSkill:paramIsFull() then
			slot0._playerCurSkill:execute()

			slot0._playerCurSkill = nil
		else
			slot0:initCharacterSkill()
			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ReleaseSkill, slot0._playerCurSkill)
		end
	end

	slot0:closeSkillTips()
end

function slot0.cancelPlayerSkill(slot0)
	slot0._playerCurSkill = nil

	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.CancelSkill)
	slot0:hideSkillRelease()
end

function slot0.hideSkillRelease(slot0)
	if slot0._skillReleaseView ~= nil then
		gohelper.setActive(slot0._goSkillRelease, false)
	end
end

function slot0.initCharacterSkill(slot0)
	if slot0._skillReleaseView == nil then
		slot0._skillReleaseView = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goSkillRelease, LengZhou6EliminatePlayerSkill)
	end

	slot1 = slot0._goChessBG.transform

	slot0._skillReleaseView:setTargetTrAndHoleSize(slot1, recthelper.getWidth(slot1), recthelper.getHeight(slot1), -56, 325)
	slot0._skillReleaseView:setClickCb(slot0.cancelPlayerSkill, slot0)
	gohelper.setActive(slot0._goSkillRelease, true)
end

function slot0.initSelectView(slot0)
	if slot0._allSelectSkillItemList == nil then
		slot0._allSelectSkillItemList = slot0:getUserDataTb_()
	end

	for slot6 = 1, #LengZhou6Config.instance:getPlayerAllSkillId() do
		slot7 = slot1[slot6]

		if slot0._allSelectSkillItemList[slot6] == nil then
			slot9 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._goPlayerChooseSkillParent, slot7)

			table.insert(slot0._allSelectSkillItemList, MonoHelper.addNoUpdateLuaComOnceToGo(slot9, LengZhou6PlayerSelectSkillItem))
			gohelper.setActive(slot9, true)
		end

		slot8:initSkill(slot7)
	end
end

function slot0.showSelectView(slot0, slot1)
	if slot0._allSelectSkillItemList == nil or tabletool.len(slot0._allSelectSkillItemList) == 0 then
		return
	end

	slot2 = LengZhou6Config.instance:getPlayerAllSkillId()

	for slot6 = 1, #slot0._allSelectSkillItemList do
		slot0._allSelectSkillItemList[slot6]:initSelectIndex(slot1)
	end

	table.sort(slot2, function (slot0, slot1)
		if LengZhou6GameModel.instance:isSelectSkill(slot0) and not LengZhou6GameModel.instance:isSelectSkill(slot1) then
			return false
		elseif not slot2 and slot3 then
			return true
		else
			return slot0 < slot1
		end
	end)

	for slot6 = 1, #slot2 do
		slot0._allSelectSkillItemList[slot6]:initSkill(slot2[slot6])
	end

	slot0:setChooseSkillActive(true)
	gohelper.setActive(slot0._btnskillDescClose.gameObject, true)
end

function slot0.setChooseSkillActive(slot0, slot1)
	if slot0._lastChooseActive ~= nil and slot0._lastActive == slot1 then
		return
	end

	if slot1 then
		gohelper.setActive(slot0._goChooseSkillTips, true)
		slot0._goChooseSkillTipsAnim:Play("open", 0, 0)

		slot0._lastChooseActive = slot1
	else
		slot0._goChooseSkillTipsAnim:Play("close", 0, 0)
		TaskDispatcher.runDelay(slot0._setChooseSkillTipsFalse, slot0, 0.167)
	end
end

function slot0._setChooseSkillTipsFalse(slot0)
	gohelper.setActive(slot0._goChooseSkillTips, false)

	slot0._lastChooseActive = false
end

function slot0._playerSkillSelectFinish(slot0, slot1, slot2)
	slot0:closeChooseSkillTips()

	if slot0._playerSkillList ~= nil and slot0._playerSkillList[slot1] ~= nil then
		slot3:initSkillConfigId(slot2)
		slot3:initCamp(LengZhou6Enum.entityCamp.player)
		slot3:refreshState()
	end
end

function slot0.closeChooseSkillTips(slot0)
	slot0:setChooseSkillActive(false)
	gohelper.setActive(slot0._btnskillDescClose.gameObject, false)
end

function slot0.showEnemyEffect(slot0, slot1)
	if slot1 == LengZhou6Enum.SkillEffect.DealsDamage then
		slot0._playerDamageText.text = LengZhou6GameModel.instance:getPlayer():getCurDiff()

		gohelper.setActive(slot0._playerDamageGo, true)
		slot0._playerAni:Play("damage", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_hp)
		TaskDispatcher.cancelTask(slot0._showPlayerEffectEnd, slot0)
		TaskDispatcher.runDelay(slot0._showPlayerEffectEnd, slot0, LengZhou6Enum.EnemySkillTime)
	end

	if slot1 == LengZhou6Enum.SkillEffect.Heal then
		slot0._enemyDamageText.text = LengZhou6GameModel.instance:getEnemy():getCurDiff() > 0 and string.format("+%s", slot3)

		gohelper.setActive(slot0._enemyDamageGo, true)
		TaskDispatcher.cancelTask(slot0._showEnemyEffectEnd, slot0)
		TaskDispatcher.runDelay(slot0._showEnemyEffectEnd, slot0, LengZhou6Enum.EnemySkillTime)
	end

	if slot1 == LengZhou6Enum.BuffEffect.poison then
		slot0._enemyDamageText.text = LengZhou6GameModel.instance:getEnemy():getCurDiff() > 0 and string.format("+%s", slot3) or slot3

		gohelper.setActive(slot0._enemyDamageGo, true)
		slot0._enemyAni:Play("damage", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_hp)

		slot4 = LengZhou6GameModel.instance:getEnemy()

		TaskDispatcher.cancelTask(slot0._showEnemyEffectEnd, slot0)
		TaskDispatcher.runDelay(slot0._showEnemyEffectEnd, slot0, LengZhou6Enum.EnemyBuffEffectShowTime)
	end
end

function slot0._showPlayerEffectEnd(slot0)
	gohelper.setActive(slot0._playerDamageGo, false)

	slot0._txtSelfLife.text = LengZhou6GameModel.instance:getPlayer():getHp()

	slot0._playerAni:Play("idle", 0, 0)
end

function slot0._showEnemyEffectEnd(slot0)
	gohelper.setActive(slot0._enemyDamageGo, false)

	slot0._txtEnemyLife.text = LengZhou6GameModel.instance:getEnemy():getHp()

	slot0._enemyAni:Play("idle", 0, 0)
end

function slot0.refreshBuffItem(slot0)
	slot0:_refreshPlayerBuffItem()
	slot0:_refreshEnemyBuffItem()
end

function slot0._refreshPlayerBuffItem(slot0)
	if slot0._playerBuffItems == nil then
		slot0._playerBuffItems = slot0:getUserDataTb_()
	end

	for slot7 = 1, math.max(tabletool.len(LengZhou6GameModel.instance:getPlayer():getBuffs()), tabletool.len(slot0._playerBuffItems)) do
		slot9 = slot2[slot7]

		if slot0._playerBuffItems[slot7] == nil then
			table.insert(slot0._playerBuffItems, MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[3], slot0._playerBuffParent), LengZhou6BuffItem))
		end

		if slot8 ~= nil then
			slot10 = slot0._playerBuffParent

			if slot9 ~= nil and slot9._configId == 1001 then
				slot10 = slot0._enemyBuffParent
			end

			slot8:changeParent(slot10)
		end

		if slot8 ~= nil then
			slot8:updateBuffItem(slot9)
		end
	end
end

function slot0._refreshEnemyBuffItem(slot0)
	if slot0._enemyBuffItems == nil then
		slot0._enemyBuffItems = slot0:getUserDataTb_()
	end

	for slot7 = 1, math.max(tabletool.len(LengZhou6GameModel.instance:getEnemy():getBuffs()), tabletool.len(slot0._enemyBuffItems)) do
		if slot0._enemyBuffItems[slot7] == nil and slot2[slot7] ~= nil then
			slot10 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[3], slot0._enemyBuffParent)

			gohelper.setActive(slot10, true)
			table.insert(slot0._enemyBuffItems, MonoHelper.addNoUpdateLuaComOnceToGo(slot10, LengZhou6BuffItem))
		end

		if slot8 ~= nil then
			slot8:updateBuffItem(slot9)
		end
	end
end

function slot0.onClickBuff(slot0, slot1)
	if slot1 == nil then
		return
	end

	if LengZhou6Config.instance:getEliminateBattleBuff(slot1) then
		if slot1 == 1001 or slot1 == 1002 then
			slot0._txtEnemyBuffDescr.text = slot2.desc
			slot0._txtEnemyBuffName.text = slot2.name

			gohelper.setActive(slot0._goEnemyBuffTips, true)
		end

		if slot1 == 1003 then
			slot0._txtPlayerBuffDescr.text = slot2.desc
			slot0._txtPlayerBuffName.text = slot2.name

			gohelper.setActive(slot0._goPlayerBuffTips, true)
		end

		gohelper.setActive(slot0._btnskillDescClose.gameObject, true)
	end
end

function slot0.closeBuffTips(slot0)
	gohelper.setActive(slot0._goEnemyBuffTips, false)
	gohelper.setActive(slot0._goPlayerBuffTips, false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onMoveEnd, slot0)
	TaskDispatcher.cancelTask(slot0.showChangeTips, slot0)
	TaskDispatcher.cancelTask(slot0._showEffectEnd, slot0)
	TaskDispatcher.cancelTask(slot0._showPlayerEffectEnd, slot0)
	TaskDispatcher.cancelTask(slot0._showEnemyEffectEnd, slot0)
end

function slot0._gameReStart(slot0)
	slot0:initView()
end

function slot0.onDestroyView(slot0)
end

return slot0
