module("modules.logic.versionactivity2_7.act191.view.Act191FightSuccView", package.seeall)

slot0 = class("Act191FightSuccView", BaseView)

function slot0.onInitView(slot0)
	slot0._goLeft = gohelper.findChild(slot0.viewGO, "#go_Left")
	slot0._simagecharacterbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_Left/#simage_characterbg")
	slot0._goSpine = gohelper.findChild(slot0.viewGO, "#go_Left/spineContainer/#go_Spine")
	slot0._simagemaskImage = gohelper.findChildSingleImage(slot0.viewGO, "#go_Left/#simage_maskImage")
	slot0._txtSayCn = gohelper.findChildText(slot0.viewGO, "#go_Left/#txt_SayCn")
	slot0._txtSayEn = gohelper.findChildText(slot0.viewGO, "#go_Left/SayEn/#txt_SayEn")
	slot0._goRight = gohelper.findChild(slot0.viewGO, "#go_Right")
	slot0._goWin = gohelper.findChild(slot0.viewGO, "#go_Right/#go_Win")
	slot0._goFail = gohelper.findChild(slot0.viewGO, "#go_Right/#go_Fail")
	slot0._goReward = gohelper.findChild(slot0.viewGO, "#go_Right/#go_Reward")
	slot0._txtStage = gohelper.findChildText(slot0.viewGO, "#go_Right/Stage/#txt_Stage")
	slot0._goPvp = gohelper.findChild(slot0.viewGO, "#go_Right/Stage/#go_Pvp")
	slot0._goHeroItem = gohelper.findChild(slot0.viewGO, "#go_Right/Stage/#go_Pvp/role/layout/#go_HeroItem")
	slot0._goPve = gohelper.findChild(slot0.viewGO, "#go_Right/Stage/#go_Pve")
	slot0._gobossHpRoot = gohelper.findChild(slot0.viewGO, "#go_Right/Stage/#go_Pve/#go_bossHpRoot")
	slot0._gounlimited = gohelper.findChild(slot0.viewGO, "#go_Right/Stage/#go_Pve/#go_bossHpRoot/fight_act191bosshpview/Root/bossHp/Alpha/bossHp/mask/container/imgHp/#go_unlimited")
	slot0._imageLevel = gohelper.findChildImage(slot0.viewGO, "#go_Right/Level/mainTitle/TeamLvl/#image_Level")
	slot0._btnData = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Right/#btn_Data")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnData:AddClickListener(slot0._btnDataOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnData:RemoveClickListener()
end

function slot0.onClickModalMask(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
	end

	slot0:closeThis()
end

function slot0._btnDataOnClick(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity191Model.instance:getCurActId()
	slot0._uiSpine = GuiModelAgent.Create(slot0._goSpine, true)

	slot0._uiSpine:useRT()
end

function slot0.onOpen(slot0)
	slot0.actInfo = Activity191Model.instance:getActInfo()
	slot0.gameInfo = slot0.actInfo:getGameInfo()

	if slot0.gameInfo.state == Activity191Enum.GameState.End then
		slot0.curNode = slot0.gameInfo.curNode
	else
		slot0.curNode = slot0.gameInfo.curNode - 1
	end

	slot0.nodeInfo = slot0.gameInfo:getNodeInfoById(slot0.curNode)
	slot0.isWin = slot0.viewParam

	if slot0.isWin then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	end

	gohelper.setActive(slot0._goWin, slot0.isWin)
	gohelper.setActive(slot0._goFail, not slot0.isWin)
	slot0._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	slot0._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	slot0.mySideMoList = FightDataHelper.entityMgr:getMyNormalList(nil, true)
	slot0.enemyMoList = FightDataHelper.entityMgr:getEnemyNormalList(nil, true)
	slot0._randomEntityMO = slot0:_getRandomEntityMO()

	if slot0.isWin and slot0._randomEntityMO then
		slot0:_setSpineVoice()
		gohelper.setActive(slot0._goLeft, true)
		recthelper.setAnchorX(slot0._goRight.transform, 0)
	else
		gohelper.setActive(slot0._goLeft, false)
		recthelper.setAnchorX(slot0._goRight.transform, -413)
	end

	slot0._canPlayVoice = false

	TaskDispatcher.runDelay(slot0._setCanPlayVoice, slot0, 0.9)

	for slot5, slot6 in ipairs(slot0.gameInfo:getStageNodeInfoList(slot0.nodeInfo.stage)) do
		if slot6.nodeId == slot0.curNode then
			slot0._txtStage.text = string.format("<#FAB459>%s</color>-%d", lua_activity191_stage.configDict[slot0.actId][slot6.stage].name, slot5)
		end
	end

	slot0.nodeDetailMo = slot0.gameInfo:getNodeDetailMo(slot0.curNode)
	slot0.isPvp = Activity191Helper.isPvpBattle(slot0.nodeDetailMo.type)
	slot0.isPve = Activity191Helper.isPveBattle(slot0.nodeDetailMo.type)

	if slot0.isPvp then
		slot2 = GameUtil.setFirstStrSize(lua_activity191_const.configDict[Activity191Enum.ConstKey.PvpEpisodeName].value2, 70)
		slot8 = string.lower(lua_activity191_match_rank.configDict[slot0.nodeDetailMo.matchInfo.rank].fightLevel)
		slot7 = "act191_level_" .. slot8

		UISpriteSetMgr.instance:setAct174Sprite(slot0._imageLevel, slot7)

		for slot7, slot8 in ipairs(slot0.enemyMoList) do
			if slot8.entityType == FightEnum.EntityType.Monster then
				gohelper.findChildSingleImage(gohelper.cloneInPlace(slot0._goHeroItem), "hero/simage_rolehead"):LoadImage(ResUrl.monsterHeadIcon(slot8.skin))
			else
				slot10:LoadImage(ResUrl.getHeadIconSmall(slot8.skin))
			end

			gohelper.setActive(gohelper.findChild(slot9, "go_dead"), slot8:isStatusDead())
		end

		gohelper.setActive(slot0._goHeroItem, false)
	elseif slot0.isPve or slot0.nodeDetailMo.type == Activity191Enum.NodeType.BattleEvent then
		UISpriteSetMgr.instance:setAct174Sprite(slot0._imageLevel, "act191_level_" .. string.lower(lua_activity191_fight_event.configDict[slot0.nodeDetailMo.fightEventId].fightLevel))
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.BossHpItem, slot0._gobossHpRoot), Act191BossHpItem)
	end

	slot0:refreshReward()
	gohelper.setActive(slot0._goPve, not slot0.isPvp)
	gohelper.setActive(slot0._goPvp, slot0.isPvp)
end

function slot0.onClose(slot0)
	slot0._canPlayVoice = false

	gohelper.setActive(slot0._goSpine, false)
	FightController.onResultViewClose()
	Act191StatController.instance:statGameTime(slot0.viewName)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._setCanPlayVoice, slot0)
end

function slot0._getRandomEntityMO(slot0)
	for slot5 = #slot0.mySideMoList, 1, -1 do
		if not slot0:_getSkin(slot1[slot5]) then
			table.remove(slot1, slot5)
		end
	end

	slot2 = {}

	tabletool.addValues(slot2, slot1)

	for slot6 = #slot2, 1, -1 do
		if FightAudioMgr.instance:_getHeroVoiceCOs(slot1[slot6].modelId, CharacterEnum.VoiceType.FightResult) and #slot8 > 0 then
			if slot7:isMonster() then
				table.remove(slot2, slot6)
			end
		else
			table.remove(slot2, slot6)
		end
	end

	if #slot2 > 0 then
		return slot2[math.random(#slot2)]
	elseif #slot1 > 0 then
		return slot1[math.random(#slot1)]
	end
end

function slot0._setCanPlayVoice(slot0)
	slot0._canPlayVoice = true

	slot0:_playSpineVoice()
end

function slot0._setSpineVoice(slot0)
	if slot0:_getSkin(slot0._randomEntityMO) then
		slot0._spineLoaded = false

		slot0._uiSpine:setImgPos(0)
		slot0._uiSpine:setResPath(slot1, function ()
			uv0._spineLoaded = true

			uv0._uiSpine:setUIMask(true)
			uv0:_playSpineVoice()
			uv0._uiSpine:setAllLayer(UnityLayer.UI)
		end, slot0)

		slot2, slot3 = SkinConfig.instance:getSkinOffset(slot1.fightSuccViewOffset)

		if slot3 then
			slot4, _ = SkinConfig.instance:getSkinOffset(slot1.characterViewOffset)
			slot2 = SkinConfig.instance:getAfterRelativeOffset(504, slot4)
		end

		slot4 = tonumber(slot2[3])

		recthelper.setAnchor(slot0._goSpine.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._goSpine.transform, slot4, slot4, slot4)
	else
		gohelper.setActive(slot0._goSpine, false)
	end
end

function slot0._playSpineVoice(slot0)
	if not slot0._canPlayVoice then
		return
	end

	if not slot0._spineLoaded then
		return
	end

	if FightAudioMgr.instance:_getHeroVoiceCOs(slot0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, slot0._randomEntityMO.skin) and #slot1 > 0 then
		slot0._uiSpine:playVoice(slot1[1], nil, slot0._txtSayCn, slot0._txtSayEn)
	end
end

function slot0._getSkin(slot0, slot1)
	if FightConfig.instance:getSkinCO(slot1.skin) and not string.nilorempty(slot2.verticalDrawing) or slot2 and not string.nilorempty(slot2.live2d) then
		return slot2
	end
end

function slot0.refreshReward(slot0)
	slot1 = {}

	if slot0.isPvp then
		if slot0.isWin then
			for slot10, slot11 in ipairs(GameUtil.splitString2(lua_activity191_pvp_match.configDict[Activity191Enum.NodeType2Key[slot0.nodeDetailMo.type]][FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191].auto and "autoRewardView" or "rewardView"], true)) do
				if not slot1[slot11[1]] then
					slot1[slot11[1]] = slot11[2]
				else
					slot1[slot11[1]] = slot1[slot11[1]] + slot11[2]
				end
			end
		end
	else
		for slot6, slot7 in ipairs(slot0.actInfo.triggerEffectPushList) do
			for slot11, slot12 in ipairs(slot7.effectId) do
				if not string.nilorempty(lua_activity191_effect.configDict[slot12].itemParam) then
					for slot18, slot19 in ipairs(GameUtil.splitString2(slot13.itemParam, true)) do
						if not slot1[slot19[1]] then
							slot1[slot19[1]] = slot19[2]
						else
							slot1[slot19[1]] = slot1[slot19[1]] + slot19[2]
						end
					end
				end
			end
		end
	end

	for slot5, slot6 in pairs(slot1) do
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.RewardItem, slot0._goReward), Act191RewardItem):setData(slot5, slot6)
	end

	gohelper.setActive(slot0._goReward, tabletool.len(slot1) ~= 0)
end

return slot0
