module("modules.logic.herogroup.view.HeroGroupHeroItem", package.seeall)

local var_0_0 = class("HeroGroupHeroItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._heroGroupListView = arg_1_1
end

var_0_0.EquipTweenDuration = 0.16
var_0_0.EquipDragOffset = Vector2(0, 150)
var_0_0.EquipDragMobileScale = 1.7
var_0_0.EquipDragOtherScale = 1.4
var_0_0.PressColor = GameUtil.parseColor("#C8C8C8")

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._noneGO = gohelper.findChild(arg_2_1, "heroitemani/none")
	arg_2_0._addGO = gohelper.findChild(arg_2_1, "heroitemani/none/add")
	arg_2_0._lockGO = gohelper.findChild(arg_2_1, "heroitemani/none/lock")
	arg_2_0._heroGO = gohelper.findChild(arg_2_1, "heroitemani/hero")
	arg_2_0._tagTr = gohelper.findChildComponent(arg_2_1, "heroitemani/tags", typeof(UnityEngine.Transform))
	arg_2_0._subGO = gohelper.findChild(arg_2_1, "heroitemani/tags/aidtag")
	arg_2_0._aidGO = gohelper.findChild(arg_2_1, "heroitemani/tags/storytag")
	arg_2_0._trialTagGO = gohelper.findChild(arg_2_1, "heroitemani/tags/trialtag")
	arg_2_0._trialTagTxt = gohelper.findChildTextMesh(arg_2_1, "heroitemani/tags/trialtag/#txt_trial_tag")
	arg_2_0._clickGO = gohelper.findChild(arg_2_1, "heroitemani/click")
	arg_2_0._clickThis = gohelper.getClick(arg_2_0._clickGO)
	arg_2_0._equipGO = gohelper.findChild(arg_2_1, "heroitemani/equip")
	arg_2_0._clickEquip = gohelper.getClick(arg_2_0._equipGO)
	arg_2_0._charactericon = gohelper.findChild(arg_2_1, "heroitemani/hero/charactericon")
	arg_2_0._careericon = gohelper.findChildImage(arg_2_1, "heroitemani/hero/career")
	arg_2_0._goblackmask = gohelper.findChild(arg_2_1, "heroitemani/hero/blackmask")
	arg_2_0.level_part = gohelper.findChild(arg_2_1, "heroitemani/hero/vertical/layout")
	arg_2_0._lvnum = gohelper.findChildText(arg_2_1, "heroitemani/hero/vertical/layout/lv/lvnum")
	arg_2_0._lvnumen = gohelper.findChildText(arg_2_1, "heroitemani/hero/vertical/layout/lv/lvnum/lv")
	arg_2_0._goRankList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 3 do
		local var_2_0 = gohelper.findChildImage(arg_2_1, "heroitemani/hero/vertical/layout/rankobj/rank" .. iter_2_0)

		table.insert(arg_2_0._goRankList, var_2_0)
	end

	arg_2_0._goStarList = arg_2_0:getUserDataTb_()

	for iter_2_1 = 1, 6 do
		local var_2_1 = gohelper.findChild(arg_2_1, "heroitemani/hero/vertical/#go_starList/star" .. iter_2_1)

		table.insert(arg_2_0._goStarList, var_2_1)
	end

	arg_2_0._goStars = gohelper.findChild(arg_2_1, "heroitemani/hero/vertical/#go_starList")
	arg_2_0._fakeEquipGO = gohelper.findChild(arg_2_1, "heroitemani/hero/vertical/fakeequip")
	arg_2_0._dragFrameGO = gohelper.findChild(arg_2_1, "heroitemani/selectedeffect")
	arg_2_0._dragFrameSelectGO = gohelper.findChild(arg_2_1, "heroitemani/selectedeffect/xuanzhong")
	arg_2_0._dragFrameCompleteGO = gohelper.findChild(arg_2_1, "heroitemani/selectedeffect/wancheng")

	gohelper.setActive(arg_2_0._dragFrameGO, false)

	arg_2_0._emptyEquipGo = gohelper.findChild(arg_2_1, "heroitemani/emptyequip")
	arg_2_0._animGO = gohelper.findChild(arg_2_1, "heroitemani")
	arg_2_0.anim = arg_2_0._animGO:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._replayReady = gohelper.findChild(arg_2_1, "heroitemani/hero/replayready")
	arg_2_0._gorecommended = gohelper.findChild(arg_2_1, "heroitemani/hero/#go_recommended")
	arg_2_0._gocounter = gohelper.findChild(arg_2_1, "heroitemani/hero/#go_counter")
	arg_2_0._herocardGo = gohelper.findChild(arg_2_1, "heroitemani/roleequip")
	arg_2_0._leftDrop = gohelper.findChildDropdown(arg_2_1, "heroitemani/roleequip/left")
	arg_2_0._rightDrop = gohelper.findChildDropdown(arg_2_1, "heroitemani/roleequip/right")
	arg_2_0._imageAdd = gohelper.findChildImage(arg_2_1, "heroitemani/none/add")
	arg_2_0._gomojing = gohelper.findChild(arg_2_1, "heroitemani/#go_mojing")
	arg_2_0._gomojingtxt = gohelper.findChildText(arg_2_1, "heroitemani/#go_mojing/#txt")
	arg_2_0._commonHeroCard = CommonHeroCard.create(arg_2_0._charactericon, arg_2_0._heroGroupListView.viewName)
end

function var_0_0.setIndex(arg_3_0, arg_3_1)
	arg_3_0._index = arg_3_1
end

function var_0_0._showMojingTip(arg_4_0)
	local var_4_0 = false
	local var_4_1 = HeroGroupModel.instance.episodeId
	local var_4_2 = DungeonConfig.instance:getEpisodeCO(var_4_1)

	if var_4_2 and var_4_2.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.Daily then
		var_4_0 = arg_4_0._index == 3
	end

	gohelper.setActive(arg_4_0._gomojing, var_4_0)

	if not var_4_0 then
		return
	end

	arg_4_0._gomojingtxt.text = luaLang("p_v1a3_herogroup_mojing_" .. tostring(var_4_1))
end

function var_0_0.setParent(arg_5_0, arg_5_1)
	arg_5_0.currentParent = arg_5_1

	arg_5_0._subGO.transform:SetParent(arg_5_1, true)
	arg_5_0._equipGO.transform:SetParent(arg_5_1, true)
end

function var_0_0.flowOriginParent(arg_6_0)
	arg_6_0._equipGO.transform:SetParent(arg_6_0._animGO.transform, false)
end

function var_0_0.flowCurrentParent(arg_7_0)
	arg_7_0._equipGO.transform:SetParent(arg_7_0.currentParent, false)
end

function var_0_0.initEquips(arg_8_0, arg_8_1)
	arg_8_0._equipType = -1

	if arg_8_0.isLock or arg_8_0.isAid or arg_8_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not arg_8_0.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(arg_8_0._equipGO, false)
		gohelper.setActive(arg_8_0._fakeEquipGO, false)
		gohelper.setActive(arg_8_0._emptyEquipGo, false)
	else
		gohelper.setActive(arg_8_0._equipGO, true)
		gohelper.setActive(arg_8_0._fakeEquipGO, true)
		gohelper.setActive(arg_8_0._emptyEquipGo, true)

		if not arg_8_0._equip then
			arg_8_0._equip = arg_8_0:getUserDataTb_()
			arg_8_0._equip.moveContainer = gohelper.findChild(arg_8_0._equipGO, "moveContainer")
			arg_8_0._equip.equipIcon = gohelper.findChildImage(arg_8_0._equipGO, "moveContainer/equipIcon")
			arg_8_0._equip.equipRare = gohelper.findChildImage(arg_8_0._equipGO, "moveContainer/equiprare")
			arg_8_0._equip.equiptxten = gohelper.findChildText(arg_8_0._equipGO, "equiptxten")
			arg_8_0._equip.equiptxtlv = gohelper.findChildText(arg_8_0._equipGO, "moveContainer/equiplv/txtequiplv")
			arg_8_0._equip.equipGolv = gohelper.findChild(arg_8_0._equipGO, "moveContainer/equiplv")

			arg_8_0:_equipIconAddDrag(arg_8_0._equip.moveContainer, arg_8_0._equip.equipIcon)
		end

		local var_8_0 = HeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_8_0.mo.id - 1).equipUid[1]

		arg_8_0._equipMO = EquipModel.instance:getEquip(var_8_0) or HeroGroupTrialModel.instance:getEquipMo(var_8_0)

		if HeroGroupModel.instance:getCurGroupMO().isReplay then
			arg_8_0._equipMO = nil

			local var_8_1 = HeroGroupModel.instance:getCurGroupMO().replay_equip_data[arg_8_0.mo.heroUid]

			if var_8_1 then
				local var_8_2 = EquipConfig.instance:getEquipCo(var_8_1.equipId)

				if var_8_2 then
					arg_8_0._equipMO = {}
					arg_8_0._equipMO.config = var_8_2
					arg_8_0._equipMO.refineLv = var_8_1.refineLv
					arg_8_0._equipMO.level = var_8_1.equipLv
				end
			end
		end

		local var_8_3

		if arg_8_0.trialCO and arg_8_0.trialCO.equipId > 0 then
			var_8_3 = EquipConfig.instance:getEquipCo(arg_8_0.trialCO.equipId)
		end

		if arg_8_0._equipMO then
			arg_8_0._equipType = arg_8_0._equipMO.config.rare - 2
		elseif var_8_3 then
			arg_8_0._equipType = var_8_3.rare - 2
		end

		gohelper.setActive(arg_8_0._equip.equipIcon.gameObject, arg_8_0._equipMO or var_8_3)
		gohelper.setActive(arg_8_0._equip.equipRare.gameObject, arg_8_0._equipMO or var_8_3)
		gohelper.setActive(arg_8_0._equip.equipAddGO, not arg_8_0._equipMO and not var_8_3)
		gohelper.setActive(arg_8_0._equip.equipGolv, arg_8_0._equipMO or var_8_3)
		ZProj.UGUIHelper.SetColorAlpha(arg_8_0._equip.equiptxten, (arg_8_0._equipMO or var_8_3) and 0.15 or 0.06)

		if arg_8_0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_8_0._equip.equipIcon, arg_8_0._equipMO.config.icon)

			local var_8_4, var_8_5, var_8_6 = HeroGroupBalanceHelper.getBalanceLv()

			if var_8_6 and var_8_6 > arg_8_0._equipMO.level and arg_8_0._equipMO.equipType == EquipEnum.ClientEquipType.Normal then
				arg_8_0._equip.equiptxtlv.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">LV." .. var_8_6
			else
				arg_8_0._equip.equiptxtlv.text = "LV." .. arg_8_0._equipMO.level
			end

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_8_0._equip.equipRare, "bianduixingxian_" .. arg_8_0._equipMO.config.rare)
			arg_8_0:_showEquipParticleEffect(arg_8_1)
		elseif var_8_3 then
			local var_8_7 = EquipConfig.instance:getEquipCo(arg_8_0.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_8_0._equip.equipIcon, var_8_7.icon)

			arg_8_0._equip.equiptxtlv.text = "LV." .. arg_8_0.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_8_0._equip.equipRare, "bianduixingxian_" .. var_8_7.rare)
			arg_8_0:_showEquipParticleEffect(arg_8_1)
		end
	end

	arg_8_0.last_equip = arg_8_0._equipMO and arg_8_0._equipMO.uid
	arg_8_0.last_hero = arg_8_0._heroMO and arg_8_0._heroMO.heroId or 0
end

function var_0_0._showEquipParticleEffect(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0.mo.id - 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function var_0_0._equipIconAddDrag(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:GetComponent(gohelper.Type_Image).raycastTarget = true

	local var_10_0 = var_0_0.EquipDragOtherScale
	local var_10_1

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_10_1 = var_0_0.EquipDragOffset
		var_10_0 = var_0_0.EquipDragMobileScale
	end

	CommonDragHelper.instance:registerDragObj(arg_10_1, arg_10_0._onBeginDrag, nil, arg_10_0._onEndDrag, arg_10_0._checkDrag, arg_10_0, arg_10_1.transform, nil, var_10_1, var_10_0)
end

function var_0_0._checkDrag(arg_11_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return true
	end

	if arg_11_0.trialCO and arg_11_0.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return true
	end

	return false
end

function var_0_0._onBeginDrag(arg_12_0)
	gohelper.setAsLastSibling(arg_12_0._heroGroupListView.heroPosTrList[arg_12_0.mo.id].parent.gameObject)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(arg_12_0._equip.equipGolv, false)
end

function var_0_0._onEndDrag(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_13_0 = var_13_0 + var_0_0.EquipDragOffset
	end

	local var_13_1 = arg_13_0:_moveToTarget(var_13_0)

	arg_13_0:_setEquipDragEnabled(false)

	local var_13_2 = var_13_1 and var_13_1.trialCO and var_13_1.trialCO.equipId > 0

	if not var_13_1 or var_13_1 == arg_13_0 or var_13_1.mo.aid or var_13_2 or not var_13_1._equipGO.activeSelf then
		if var_13_2 then
			GameFacade.showToast(ToastEnum.TrialCantEditEquip)
		end

		arg_13_0:_setToPos(arg_13_0._equip.moveContainer.transform, Vector2(), true, function()
			gohelper.setActive(arg_13_0._equip.equipGolv, true)
			arg_13_0:_setEquipDragEnabled(true)
		end, arg_13_0)
		arg_13_0:_showEquipParticleEffect()

		return
	end

	arg_13_0:_playDragEndAudio(var_13_1)
	gohelper.setAsLastSibling(arg_13_0._heroGroupListView.heroPosTrList[var_13_1.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(arg_13_0._heroGroupListView.heroPosTrList[arg_13_0.mo.id].parent.gameObject)

	local var_13_3 = recthelper.rectToRelativeAnchorPos(arg_13_0._equipGO.transform.position, var_13_1._equipGO.transform)

	arg_13_0._tweenId = arg_13_0:_setToPos(var_13_1._equip.moveContainer.transform, var_13_3, true)

	local var_13_4 = recthelper.rectToRelativeAnchorPos(var_13_1._equipGO.transform.position, arg_13_0._equipGO.transform)

	arg_13_0:_setToPos(arg_13_0._equip.moveContainer.transform, var_13_4, true, function()
		EquipTeamListModel.instance:openTeamEquip(arg_13_0.mo.id - 1, arg_13_0._heroMO)

		if arg_13_0._tweenId then
			ZProj.TweenHelper.KillById(arg_13_0._tweenId)
		end

		arg_13_0:_setToPos(arg_13_0._equip.moveContainer.transform, Vector2())
		arg_13_0:_setToPos(var_13_1._equip.moveContainer.transform, Vector2())
		gohelper.setActive(arg_13_0._equip.equipGolv, true)
		arg_13_0:_setEquipDragEnabled(true)

		local var_15_0 = arg_13_0.mo.id - 1
		local var_15_1 = var_13_1.mo.id - 1
		local var_15_2 = EquipTeamListModel.instance:getTeamEquip(var_15_0)[1]

		var_15_2 = (EquipModel.instance:getEquip(var_15_2) or HeroGroupTrialModel.instance:getEquipMo(var_15_2)) and var_15_2 or nil

		if var_15_2 then
			EquipTeamShowItem.removeEquip(var_15_0, true)
		end

		local var_15_3 = EquipTeamListModel.instance:getTeamEquip(var_15_1)[1]

		var_15_3 = (EquipModel.instance:getEquip(var_15_3) or HeroGroupTrialModel.instance:getEquipMo(var_15_3)) and var_15_3 or nil

		if var_15_3 then
			EquipTeamShowItem.removeEquip(var_15_1, true)
		end

		if var_15_2 then
			EquipTeamShowItem.replaceEquip(var_15_1, var_15_2, true)
		end

		if var_15_3 then
			EquipTeamShowItem.replaceEquip(var_15_0, var_15_3, true)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
		HeroGroupModel.instance:saveCurGroupData()
	end, arg_13_0)
end

function var_0_0.resetEquipPos(arg_16_0)
	if not arg_16_0._equip then
		return
	end

	local var_16_0 = arg_16_0._equip.moveContainer.transform

	recthelper.setAnchor(var_16_0, 0, 0)
	transformhelper.setLocalScale(var_16_0, 1, 1, 1)
end

function var_0_0._playDragEndAudio(arg_17_0, arg_17_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function var_0_0._setToPos(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0, var_18_1 = recthelper.getAnchor(arg_18_1)

	if arg_18_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_18_1, arg_18_2.x, arg_18_2.y, 0.2, arg_18_4, arg_18_5)
	else
		recthelper.setAnchor(arg_18_1, arg_18_2.x, arg_18_2.y)

		if arg_18_4 then
			arg_18_4(arg_18_5)
		end
	end
end

function var_0_0._moveToTarget(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._heroGroupListView.heroPosTrList) do
		if arg_19_0._heroGroupListView._heroItemList[iter_19_0] ~= arg_19_0 then
			local var_19_0 = iter_19_1.parent
			local var_19_1 = recthelper.screenPosToAnchorPos(arg_19_1, var_19_0)

			if math.abs(var_19_1.x) * 2 < recthelper.getWidth(var_19_0) and math.abs(var_19_1.y) * 2 < recthelper.getHeight(var_19_0) then
				local var_19_2 = arg_19_0._heroGroupListView._heroItemList[iter_19_0]

				return not var_19_2:selfIsLock() and var_19_2 or nil
			end
		end
	end

	return nil
end

function var_0_0._setEquipDragEnabled(arg_20_0, arg_20_1)
	CommonDragHelper.instance:setGlobalEnabled(arg_20_1)
end

function var_0_0.addEventListeners(arg_21_0)
	arg_21_0._clickThis:AddClickListener(arg_21_0._onClickThis, arg_21_0)
	arg_21_0._clickThis:AddClickDownListener(arg_21_0._onClickThisDown, arg_21_0)
	arg_21_0._clickThis:AddClickUpListener(arg_21_0._onClickThisUp, arg_21_0)
	arg_21_0._clickEquip:AddClickListener(arg_21_0._onClickEquip, arg_21_0)
	arg_21_0._clickEquip:AddClickDownListener(arg_21_0._onClickEquipDown, arg_21_0)
	arg_21_0._clickEquip:AddClickUpListener(arg_21_0._onClickEquipUp, arg_21_0)
	arg_21_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, arg_21_0.setHeroGroupEquipEffect, arg_21_0)
	arg_21_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, arg_21_0.playHeroGroupHeroEffect, arg_21_0)
	arg_21_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, arg_21_0.initEquips, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_21_0.initEquips, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_21_0.initEquips, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_21_0.initEquips, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_21_0.initEquips, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_21_0.initEquips, arg_21_0)
end

function var_0_0.removeEventListeners(arg_22_0)
	arg_22_0._clickThis:RemoveClickListener()
	arg_22_0._clickThis:RemoveClickUpListener()
	arg_22_0._clickThis:RemoveClickDownListener()
	arg_22_0._clickEquip:RemoveClickListener()
	arg_22_0._clickEquip:RemoveClickUpListener()
	arg_22_0._clickEquip:RemoveClickDownListener()
end

function var_0_0.playHeroGroupHeroEffect(arg_23_0, arg_23_1)
	arg_23_0:playAnim(arg_23_1)

	arg_23_0.last_equip = nil
	arg_23_0.last_hero = nil
end

function var_0_0.onUpdateMO(arg_24_0, arg_24_1)
	arg_24_0._commonHeroCard:setGrayScale(false)

	local var_24_0 = HeroGroupModel.instance.battleId
	local var_24_1 = var_24_0 and lua_battle.configDict[var_24_0]

	arg_24_0.mo = arg_24_1
	arg_24_0._posIndex = arg_24_0.mo.id - 1
	arg_24_0._heroMO = arg_24_1:getHeroMO()
	arg_24_0.monsterCO = arg_24_1:getMonsterCO()
	arg_24_0.trialCO = arg_24_1:getTrialCO()

	gohelper.setActive(arg_24_0._replayReady, HeroGroupModel.instance:getCurGroupMO().isReplay)

	local var_24_2

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		var_24_2 = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[arg_24_0.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_24_0._lvnumen, "#E9E9E9")

	for iter_24_0 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(arg_24_0._goRankList[iter_24_0], "#F6F3EC")
	end

	if arg_24_0._heroMO then
		local var_24_3 = HeroModel.instance:getByHeroId(arg_24_0._heroMO.heroId)
		local var_24_4 = FightConfig.instance:getSkinCO(var_24_2 and var_24_2.skin or var_24_3.skin)

		arg_24_0._commonHeroCard:onUpdateMO(var_24_4)

		if arg_24_0.isLock or arg_24_0.isAid or arg_24_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_24_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_24_0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(arg_24_0._careericon, "lssx_" .. tostring(arg_24_0._heroMO.config.career))

		local var_24_5 = var_24_2 and var_24_2.level or arg_24_0._heroMO.level
		local var_24_6 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_24_0._heroMO.heroId)
		local var_24_7

		if var_24_5 < var_24_6 then
			var_24_5 = var_24_6
			var_24_7 = true
		end

		local var_24_8, var_24_9 = HeroConfig.instance:getShowLevel(var_24_5)

		if var_24_7 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_24_0._lvnumen, HeroGroupBalanceHelper.BalanceColor)

			arg_24_0._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">" .. var_24_8

			for iter_24_1 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(arg_24_0._goRankList[iter_24_1], HeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			arg_24_0._lvnum.text = var_24_8
		end

		for iter_24_2 = 1, 3 do
			local var_24_10 = arg_24_0._goRankList[iter_24_2]

			gohelper.setActive(var_24_10, iter_24_2 == var_24_9 - 1)
		end

		gohelper.setActive(arg_24_0._goStars, true)

		for iter_24_3 = 1, 6 do
			local var_24_11 = arg_24_0._goStarList[iter_24_3]

			gohelper.setActive(var_24_11, iter_24_3 <= CharacterEnum.Star[arg_24_0._heroMO.config.rare])
		end
	elseif arg_24_0.monsterCO then
		local var_24_12 = FightConfig.instance:getSkinCO(arg_24_0.monsterCO.skinId)

		arg_24_0._commonHeroCard:onUpdateMO(var_24_12)
		UISpriteSetMgr.instance:setCommonSprite(arg_24_0._careericon, "lssx_" .. tostring(arg_24_0.monsterCO.career))

		local var_24_13, var_24_14 = HeroConfig.instance:getShowLevel(arg_24_0.monsterCO.level)

		arg_24_0._lvnum.text = var_24_13

		for iter_24_4 = 1, 3 do
			local var_24_15 = arg_24_0._goRankList[iter_24_4]

			gohelper.setActive(var_24_15, iter_24_4 == var_24_14 - 1)
		end

		gohelper.setActive(arg_24_0._goStars, false)
	elseif arg_24_0.trialCO then
		local var_24_16 = HeroConfig.instance:getHeroCO(arg_24_0.trialCO.heroId)
		local var_24_17

		if arg_24_0.trialCO.skin > 0 then
			var_24_17 = SkinConfig.instance:getSkinCo(arg_24_0.trialCO.skin)
		else
			var_24_17 = SkinConfig.instance:getSkinCo(var_24_16.skinId)
		end

		if arg_24_0.isLock or arg_24_0.isAid or arg_24_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_24_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_24_0._goblackmask.transform, 300)
		end

		arg_24_0._commonHeroCard:onUpdateMO(var_24_17)
		UISpriteSetMgr.instance:setCommonSprite(arg_24_0._careericon, "lssx_" .. tostring(var_24_16.career))

		local var_24_18, var_24_19 = HeroConfig.instance:getShowLevel(arg_24_0.trialCO.level)

		arg_24_0._lvnum.text = var_24_18

		for iter_24_5 = 1, 3 do
			local var_24_20 = arg_24_0._goRankList[iter_24_5]

			gohelper.setActive(var_24_20, iter_24_5 == var_24_19 - 1)
		end

		gohelper.setActive(arg_24_0._goStars, true)

		for iter_24_6 = 1, 6 do
			local var_24_21 = arg_24_0._goStarList[iter_24_6]

			gohelper.setActive(var_24_21, iter_24_6 <= CharacterEnum.Star[var_24_16.rare])
		end
	end

	if arg_24_0._heroItemContainer then
		arg_24_0._heroItemContainer.compColor[arg_24_0._lvnumen] = arg_24_0._lvnumen.color

		for iter_24_7 = 1, 3 do
			arg_24_0._heroItemContainer.compColor[arg_24_0._goRankList[iter_24_7]] = arg_24_0._goRankList[iter_24_7].color
		end
	end

	arg_24_0.isLock = not HeroGroupModel.instance:isPositionOpen(arg_24_0.mo.id)
	arg_24_0.isAidLock = arg_24_0.mo.aid and arg_24_0.mo.aid == -1
	arg_24_0.isAid = arg_24_0.mo.aid ~= nil
	arg_24_0.isTrialLock = (arg_24_0.mo.trial and arg_24_0.mo.trialPos) ~= nil

	local var_24_22 = HeroGroupModel.instance:getBattleRoleNum()

	arg_24_0.isRoleNumLock = var_24_22 and var_24_22 < arg_24_0.mo.id
	arg_24_0.isEmpty = arg_24_1:isEmpty()

	gohelper.setActive(arg_24_0._heroGO, (arg_24_0._heroMO ~= nil or arg_24_0.monsterCO ~= nil or arg_24_0.trialCO ~= nil) and not arg_24_0.isLock and not arg_24_0.isRoleNumLock)
	gohelper.setActive(arg_24_0._noneGO, arg_24_0._heroMO == nil and arg_24_0.monsterCO == nil and arg_24_0.trialCO == nil or arg_24_0.isLock or arg_24_0.isAidLock or arg_24_0.isRoleNumLock)
	gohelper.setActive(arg_24_0._addGO, arg_24_0._heroMO == nil and arg_24_0.monsterCO == nil and arg_24_0.trialCO == nil and not arg_24_0.isLock and not arg_24_0.isAidLock and not arg_24_0.isRoleNumLock)
	gohelper.setActive(arg_24_0._lockGO, arg_24_0:selfIsLock())
	gohelper.setActive(arg_24_0._aidGO, arg_24_0.mo.aid and arg_24_0.mo.aid ~= -1)

	if var_24_1 then
		gohelper.setActive(arg_24_0._subGO, not arg_24_0.isLock and not arg_24_0.isAidLock and not arg_24_0.isRoleNumLock and arg_24_0.mo.id > var_24_1.playerMax)
	else
		gohelper.setActive(arg_24_0._subGO, not arg_24_0.isLock and not arg_24_0.isAidLock and not arg_24_0.isRoleNumLock and arg_24_0.mo.id == ModuleEnum.MaxHeroCountInGroup)
	end

	transformhelper.setLocalPosXY(arg_24_0._tagTr, 36.3, arg_24_0._subGO.activeSelf and 144.1 or 212.1)

	if arg_24_0.trialCO then
		gohelper.setActive(arg_24_0._trialTagGO, true)

		arg_24_0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(arg_24_0._trialTagGO, false)
	end

	if not HeroSingleGroupModel.instance:isTemp() and arg_24_0.isRoleNumLock and arg_24_0._heroMO ~= nil and arg_24_0.monsterCO == nil then
		HeroSingleGroupModel.instance:remove(arg_24_0._heroMO.id)
	end

	arg_24_0:initEquips()
	arg_24_0:showCounterSign()

	if arg_24_0._playDeathAnim then
		arg_24_0._playDeathAnim = nil

		arg_24_0:playAnim(UIAnimationName.Open)
	end

	arg_24_0:_showMojingTip()
end

function var_0_0.selfIsLock(arg_25_0)
	return arg_25_0.isLock or arg_25_0.isAidLock or arg_25_0.isRoleNumLock
end

function var_0_0.playRestrictAnimation(arg_26_0, arg_26_1)
	if arg_26_0._heroMO and arg_26_1[arg_26_0._heroMO.uid] then
		arg_26_0._playDeathAnim = true

		arg_26_0:playAnim("herogroup_hero_deal")

		arg_26_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_26_0.setGrayFactor, nil, arg_26_0)
	end
end

function var_0_0.setGrayFactor(arg_27_0, arg_27_1)
	arg_27_0._commonHeroCard:setGrayFactor(arg_27_1)
end

function var_0_0.resetGrayFactor(arg_28_0)
	arg_28_0._commonHeroCard:setGrayFactor(0)
end

function var_0_0.showCounterSign(arg_29_0)
	local var_29_0

	if arg_29_0._heroMO then
		var_29_0 = lua_character.configDict[arg_29_0._heroMO.heroId].career
	elseif arg_29_0.trialCO then
		var_29_0 = HeroConfig.instance:getHeroCO(arg_29_0.trialCO.heroId).career
	elseif arg_29_0.monsterCO then
		var_29_0 = arg_29_0.monsterCO.career
	end

	local var_29_1, var_29_2 = FightHelper.detectAttributeCounter()

	gohelper.setActive(arg_29_0._gorecommended, tabletool.indexOf(var_29_1, var_29_0))
	gohelper.setActive(arg_29_0._gocounter, tabletool.indexOf(var_29_2, var_29_0))
end

function var_0_0._setUIPressState(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if not arg_30_1 then
		return
	end

	local var_30_0 = arg_30_1:GetEnumerator()

	while var_30_0:MoveNext() do
		local var_30_1

		if arg_30_2 then
			var_30_1 = arg_30_3 and arg_30_3[var_30_0.Current] * 0.7 or var_0_0.PressColor
			var_30_1.a = var_30_0.Current.color.a
		else
			var_30_1 = arg_30_3 and arg_30_3[var_30_0.Current] or Color.white
		end

		var_30_0.Current.color = var_30_1
	end
end

function var_0_0._onClickThis(arg_31_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_31_0.mo.aid or arg_31_0.isRoleNumLock then
		if arg_31_0.mo.aid == -1 or arg_31_0.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if arg_31_0.isLock then
		local var_31_0, var_31_1 = HeroGroupModel.instance:getPositionLockDesc(arg_31_0.mo.id)

		GameFacade.showToast(var_31_0, var_31_1)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, arg_31_0.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function var_0_0._onClickThisDown(arg_32_0)
	arg_32_0:_setHeroItemPressState(true)
end

function var_0_0._onClickThisUp(arg_33_0)
	arg_33_0:_setHeroItemPressState(false)
end

function var_0_0._setHeroItemPressState(arg_34_0, arg_34_1)
	if not arg_34_0._heroItemContainer then
		arg_34_0._heroItemContainer = arg_34_0:getUserDataTb_()

		local var_34_0 = arg_34_0._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_34_0._heroItemContainer.images = var_34_0

		local var_34_1 = arg_34_0._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_34_0._heroItemContainer.tmps = var_34_1
		arg_34_0._heroItemContainer.compColor = {}

		local var_34_2 = var_34_0:GetEnumerator()

		while var_34_2:MoveNext() do
			arg_34_0._heroItemContainer.compColor[var_34_2.Current] = var_34_2.Current.color
		end

		local var_34_3 = var_34_1:GetEnumerator()

		while var_34_3:MoveNext() do
			arg_34_0._heroItemContainer.compColor[var_34_3.Current] = var_34_3.Current.color
		end
	end

	local var_34_4 = arg_34_0._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

	arg_34_0._heroItemContainer.spines = var_34_4

	if arg_34_0._heroItemContainer then
		arg_34_0:_setUIPressState(arg_34_0._heroItemContainer.images, arg_34_1, arg_34_0._heroItemContainer.compColor)
		arg_34_0:_setUIPressState(arg_34_0._heroItemContainer.tmps, arg_34_1, arg_34_0._heroItemContainer.compColor)
		arg_34_0:_setUIPressState(arg_34_0._heroItemContainer.spines, arg_34_1)
	end

	if arg_34_0._imageAdd then
		local var_34_5 = arg_34_1 and var_0_0.PressColor or Color.white

		arg_34_0._imageAdd.color = var_34_5
	end
end

function var_0_0._onClickEquip(arg_35_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or arg_35_0.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		arg_35_0._viewParam = {
			heroMo = arg_35_0._heroMO,
			equipMo = arg_35_0._equipMO,
			posIndex = arg_35_0._posIndex,
			fromView = EquipEnum.FromViewEnum.FromHeroGroupFightView
		}

		if arg_35_0.trialCO then
			arg_35_0._viewParam.heroMo = HeroGroupTrialModel.instance:getHeroMo(arg_35_0.trialCO)

			if arg_35_0.trialCO.equipId > 0 then
				arg_35_0._viewParam.equipMo = arg_35_0._viewParam.heroMo.trialEquipMo
			end
		end

		arg_35_0:_onOpenEquipTeamView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function var_0_0._onClickEquipDown(arg_36_0)
	arg_36_0:_setEquipItemPressState(true)
end

function var_0_0._onClickEquipUp(arg_37_0)
	arg_37_0:_setEquipItemPressState(false)
end

function var_0_0._setEquipItemPressState(arg_38_0, arg_38_1)
	if not arg_38_0._equipItemContainer then
		arg_38_0._equipItemContainer = arg_38_0:getUserDataTb_()
		arg_38_0._equipEmtpyContainer = arg_38_0:getUserDataTb_()

		local var_38_0 = arg_38_0._equipGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_38_0._equipItemContainer.images = var_38_0

		local var_38_1 = arg_38_0._equipGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_38_0._equipItemContainer.tmps = var_38_1
		arg_38_0._equipItemContainer.compColor = {}

		local var_38_2 = arg_38_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_38_0._equipEmtpyContainer.images = var_38_2

		local var_38_3 = arg_38_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_38_0._equipEmtpyContainer.tmps = var_38_3
		arg_38_0._equipEmtpyContainer.compColor = {}

		local var_38_4 = var_38_0:GetEnumerator()

		while var_38_4:MoveNext() do
			arg_38_0._equipItemContainer.compColor[var_38_4.Current] = var_38_4.Current.color
		end

		local var_38_5 = var_38_1:GetEnumerator()

		while var_38_5:MoveNext() do
			arg_38_0._equipItemContainer.compColor[var_38_5.Current] = var_38_5.Current.color
		end

		local var_38_6 = var_38_2:GetEnumerator()

		while var_38_6:MoveNext() do
			arg_38_0._equipEmtpyContainer.compColor[var_38_6.Current] = var_38_6.Current.color
		end

		local var_38_7 = var_38_3:GetEnumerator()

		while var_38_7:MoveNext() do
			arg_38_0._equipEmtpyContainer.compColor[var_38_7.Current] = var_38_7.Current.color
		end
	end

	if arg_38_0._equipItemContainer then
		arg_38_0:_setUIPressState(arg_38_0._equipItemContainer.images, arg_38_1, arg_38_0._equipItemContainer.compColor)
		arg_38_0:_setUIPressState(arg_38_0._equipItemContainer.tmps, arg_38_1, arg_38_0._equipItemContainer.compColor)
	end

	if arg_38_0._equipEmtpyContainer then
		arg_38_0:_setUIPressState(arg_38_0._equipEmtpyContainer.images, arg_38_1, arg_38_0._equipEmtpyContainer.compColor)
		arg_38_0:_setUIPressState(arg_38_0._equipEmtpyContainer.tmps, arg_38_1, arg_38_0._equipEmtpyContainer.compColor)
	end
end

function var_0_0._onOpenEquipTeamView(arg_39_0)
	EquipController.instance:openEquipInfoTeamView(arg_39_0._viewParam)
end

function var_0_0.onItemBeginDrag(arg_40_0, arg_40_1)
	if arg_40_1 == arg_40_0.mo.id then
		ZProj.TweenHelper.DOScale(arg_40_0.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(arg_40_0._dragFrameGO, true)
		gohelper.setActive(arg_40_0._dragFrameSelectGO, true)
		gohelper.setActive(arg_40_0._dragFrameCompleteGO, false)
	end

	gohelper.setActive(arg_40_0._clickGO, false)
end

function var_0_0.onItemEndDrag(arg_41_0, arg_41_1, arg_41_2)
	ZProj.TweenHelper.DOScale(arg_41_0.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	arg_41_0:_setHeroItemPressState(false)
end

function var_0_0.onItemCompleteDrag(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	if arg_42_2 == arg_42_0.mo.id and arg_42_1 ~= arg_42_2 then
		if arg_42_3 then
			gohelper.setActive(arg_42_0._dragFrameGO, true)
			gohelper.setActive(arg_42_0._dragFrameSelectGO, false)
			gohelper.setActive(arg_42_0._dragFrameCompleteGO, false)
			gohelper.setActive(arg_42_0._dragFrameCompleteGO, true)
			TaskDispatcher.cancelTask(arg_42_0.hideDragEffect, arg_42_0)
			TaskDispatcher.runDelay(arg_42_0.hideDragEffect, arg_42_0, 0.833)
		end
	else
		gohelper.setActive(arg_42_0._dragFrameGO, false)
	end

	gohelper.setActive(arg_42_0._clickGO, true)
end

function var_0_0.hideDragEffect(arg_43_0)
	gohelper.setActive(arg_43_0._dragFrameGO, false)
end

function var_0_0.setHeroGroupEquipEffect(arg_44_0, arg_44_1)
	arg_44_0._canPlayEffect = arg_44_1
end

function var_0_0.getAnimStateLength(arg_45_0, arg_45_1)
	arg_45_0.clipLengthDict = arg_45_0.clipLengthDict or {
		swicth = 0.833,
		herogroup_hero_deal = 1.667,
		[UIAnimationName.Open] = 0.833,
		[UIAnimationName.Close] = 0.333
	}

	local var_45_0 = arg_45_0.clipLengthDict[arg_45_1]

	if not var_45_0 then
		logError("not get animation state name :  " .. tostring(arg_45_1))
	end

	return var_45_0 or 0
end

function var_0_0.playAnim(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:getAnimStateLength(arg_46_1)

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, var_46_0)
	arg_46_0.anim:Play(arg_46_1, 0, 0)
end

function var_0_0.onDestroy(arg_47_0)
	if arg_47_0._equip then
		CommonDragHelper.instance:unregisterDragObj(arg_47_0._equip.moveContainer)
	end

	TaskDispatcher.cancelTask(arg_47_0._onOpenEquipTeamView, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0.hideDragEffect, arg_47_0)
end

return var_0_0
