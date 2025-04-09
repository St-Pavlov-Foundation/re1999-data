module("modules.logic.versionactivity2_7.act191.view.Act191HeroGroupView", package.seeall)

slot0 = class("Act191HeroGroupView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnChangeName = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/btnContain/horizontal/#drop_HeroGroup/#btn_ChangeName")
	slot0._btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/btnContain/horizontal/#btn_Start")
	slot0._scrollInfo = gohelper.findChildScrollRect(slot0.viewGO, "container/#scroll_Info")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "container/#scroll_Info/infocontain/episodetitle/titlebg/#txt_Name")
	slot0._btnEnemy = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#scroll_Info/infocontain/enemycontain/enemytitle/txten/#btn_Enemy")
	slot0._goEnemyTeam = gohelper.findChild(slot0.viewGO, "container/#scroll_Info/infocontain/enemycontain/enemyList/#go_EnemyTeam")
	slot0._txtRecommendLevel = gohelper.findChildText(slot0.viewGO, "container/#scroll_Info/infocontain/enemycontain/enemyLevel/#txt_RecommendLevel")
	slot0._goRewardList = gohelper.findChild(slot0.viewGO, "container/#scroll_Info/infocontain/rewardpreview/#go_RewardList")
	slot0._goRewardItem = gohelper.findChild(slot0.viewGO, "container/#scroll_Info/infocontain/rewardpreview/#go_RewardList/#go_RewardItem")
	slot0._btnDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#scroll_Info/infocontain/autofight/title/#btn_Detail")
	slot0._goDetail = gohelper.findChild(slot0.viewGO, "container/#scroll_Info/infocontain/autofight/title/#go_Detail")
	slot0._btnCloseDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#scroll_Info/infocontain/autofight/title/#go_Detail/#btn_CloseDetail")
	slot0._toggleAutoFight = gohelper.findChildToggle(slot0.viewGO, "container/#scroll_Info/infocontain/autofight/bg/#toggle_AutoFight")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnChangeName:AddClickListener(slot0._btnChangeNameOnClick, slot0)
	slot0._btnStart:AddClickListener(slot0._btnStartOnClick, slot0)
	slot0._btnEnemy:AddClickListener(slot0._btnEnemyOnClick, slot0)
	slot0._btnDetail:AddClickListener(slot0._btnDetailOnClick, slot0)
	slot0._btnCloseDetail:AddClickListener(slot0._btnCloseDetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnChangeName:RemoveClickListener()
	slot0._btnStart:RemoveClickListener()
	slot0._btnEnemy:RemoveClickListener()
	slot0._btnDetail:RemoveClickListener()
	slot0._btnCloseDetail:RemoveClickListener()
end

function slot0._btnDetailOnClick(slot0)
	gohelper.setActive(slot0._goDetail, true)
end

function slot0._btnCloseDetailOnClick(slot0)
	gohelper.setActive(slot0._goDetail, false)
end

function slot0._btnStartOnClick(slot0)
	Activity191Controller.instance:startFight()
end

function slot0._btnEnemyOnClick(slot0)
	if not slot0.isPvp then
		EnemyInfoController.instance:openAct191EnemyInfoView(FightModel.instance:getFightParam().battleId)
	else
		ViewMgr.instance:openView(ViewName.Act191EnemyInfoView, slot0.nodeDetailMo)
	end
end

function slot0._btnChangeNameOnClick(slot0)
	Act191StatController.instance:statButtonClick(slot0.viewName, "_btnChangeNameOnClick")
	ViewMgr.instance:openView(ViewName.Act191ModifyNameView)
end

function slot0._editableInitView(slot0)
	slot0.anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.dropHeroGroup = gohelper.findChildDropdown(slot0.viewGO, "container/btnContain/horizontal/#drop_HeroGroup")
	slot0._monsterGroupItemList = {}
	slot0.actId = Activity191Model.instance:getCurActId()
	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	slot0._toggleAutoFight.isOn = slot0.gameInfo:getTeamInfo() and slot1.auto or false

	slot0._toggleAutoFight:AddOnValueChanged(slot0.onToggleValueChanged, slot0)
	slot0:initDrop()

	slot0.goAutoFight = gohelper.findChild(slot0._goRewardList, "mask/#autofight")

	gohelper.setActive(slot0.goAutoFight, slot0._toggleAutoFight.isOn)

	slot0.rewardItemList = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, slot0.closeThis, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.ModifyTeamName, slot0.refreshDropValue, slot0)

	slot0.nodeDetailMo = slot0.gameInfo:getNodeDetailMo()

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshDropValue()

	slot0.isPvp = Activity191Helper.isPvpBattle(slot0.nodeDetailMo.type)

	if not slot0.isPvp then
		slot2 = lua_activity191_fight_event.configDict[slot0.nodeDetailMo.fightEventId]
		slot0._txtName.text = slot2.title
		slot0._txtRecommendLevel.text = slot2.fightLevel
	else
		slot0._txtName.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.PvpEpisodeName].value2
		slot0._txtRecommendLevel.text = lua_activity191_match_rank.configDict[slot0.nodeDetailMo.matchInfo.rank].fightLevel
	end

	slot0:showEnemyList()
	slot0:refreshReward()
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
end

function slot0.onDestroyView(slot0)
	slot0.dropClick:RemoveClickListener()
	slot0._toggleAutoFight:RemoveOnValueChanged()

	if slot0.dropExtend then
		slot0.dropExtend:dispose()
	end
end

function slot0.onDropShow(slot0)
	transformhelper.setLocalScale(slot0.trDropArrow, 1, -1, 1)
end

function slot0.onDropHide(slot0)
	transformhelper.setLocalScale(slot0.trDropArrow, 1, 1, 1)
end

function slot0.onDropValueChanged(slot0, slot1)
	if not slot0.initDropDone then
		return
	end

	slot0.gameInfo:setCurTeamIndex(slot1 + 1)
	Act191StatController.instance:statButtonClick(slot0.viewName, "onDropValueChanged")
end

function slot0.initDrop(slot0)
	slot0.trDropArrow = gohelper.findChildComponent(slot0.dropHeroGroup.gameObject, "arrow", typeof(UnityEngine.Transform))
	slot0.dropClick = gohelper.getClick(slot0.dropHeroGroup.gameObject)

	slot0.dropClick:AddClickListener(function ()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, slot0)

	slot0.dropExtend = DropDownExtend.Get(slot0.dropHeroGroup.gameObject)

	slot0.dropExtend:init(slot0.onDropShow, slot0.onDropHide, slot0)

	slot0.initDropDone = true
end

function slot0.refreshDropValue(slot0)
	for slot6 = 1, 4 do
	end

	slot0.dropHeroGroup:ClearOptions()
	slot0.dropHeroGroup:AddOptions({
		[slot6] = Activity191Model.instance:getActInfo(slot0.actId):getGameInfo():getTeamInfo(slot6).name
	})
	slot0.dropHeroGroup:SetValue(slot0.gameInfo.curTeamIndex - 1)
end

function slot0.onToggleValueChanged(slot0)
	slot1 = slot0._toggleAutoFight.isOn

	slot0.gameInfo:setAutoFight(slot1)
	gohelper.setActive(slot0.goAutoFight, slot1)
	slot0:refreshReward()
	Act191StatController.instance:statButtonClick(slot0.viewName, "onToggleValueChanged")
end

function slot0.showEnemyList(slot0)
	slot1 = {}
	slot2 = {}

	if slot0.isPvp then
		for slot7, slot8 in pairs(slot0.nodeDetailMo.matchInfo.heroMap) do
			if slot3:getRoleCo(slot8.heroId) then
				slot2[slot10] = (slot2[slot9.career] or 0) + 1
			end
		end

		for slot7, slot8 in pairs(slot3.subHeroMap) do
			if slot3:getRoleCo(slot8) then
				slot2[slot10] = (slot2[slot9.career] or 0) + 1
			end
		end
	else
		for slot7, slot8 in ipairs(FightModel.instance:getFightParam().monsterGroupIds) do
			for slot14, slot15 in ipairs(FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[slot8].monster, "#")) do
				slot16 = lua_monster.configDict[slot15].career

				if FightHelper.isBossId(lua_monster_group.configDict[slot8].bossId, slot15) then
					slot1[slot16] = (slot1[slot16] or 0) + 1
				else
					slot2[slot16] = (slot2[slot16] or 0) + 1
				end
			end
		end
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		table.insert(slot3, {
			career = slot7,
			count = slot8
		})
	end

	slot0._enemy_boss_end_index = #slot3

	for slot7, slot8 in pairs(slot2) do
		table.insert(slot3, {
			career = slot7,
			count = slot8
		})
	end

	gohelper.CreateObjList(slot0, slot0._onEnemyItemShow, slot3, gohelper.findChild(slot0._goEnemyTeam, "enemyList"), gohelper.findChild(slot0._goEnemyTeam, "enemyList/go_enemyitem"))
end

function slot0._onEnemyItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot1, "icon"), "lssx_" .. tostring(slot2.career))

	gohelper.findChildTextMesh(slot1, "enemycount").text = slot2.count > 1 and luaLang("multiple") .. slot2.count or ""

	gohelper.setActive(gohelper.findChild(slot1, "icon/kingIcon"), slot3 <= slot0._enemy_boss_end_index)
end

function slot0.refreshReward(slot0)
	slot1 = slot0._toggleAutoFight.isOn and "autoRewardView" or "rewardView"
	slot2 = nil
	slot2 = (not slot0.isPvp or GameUtil.splitString2(lua_activity191_pvp_match.configDict[Activity191Enum.NodeType2Key[slot0.nodeDetailMo.type]][slot1], true)) and GameUtil.splitString2(lua_activity191_fight_event.configDict[slot0.nodeDetailMo.fightEventId][slot1], true)

	for slot6, slot7 in ipairs(slot0.rewardItemList) do
		gohelper.setActive(slot7.parent, false)
	end

	for slot6, slot7 in ipairs(slot2) do
		if not slot0.rewardItemList[slot6] then
			slot8 = slot0:getUserDataTb_()
			slot8.parent = gohelper.cloneInPlace(slot0._goRewardItem)
			slot8.item = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.RewardItem, slot8.parent), Act191RewardItem)
			slot0.rewardItemList[slot6] = slot8
		end

		slot8.item:setData(slot7[1], slot7[2])
		slot8.item:setExtraParam({
			fromView = slot0.viewName,
			index = slot6
		})
		gohelper.setActive(slot8.parent, true)
	end
end

return slot0
