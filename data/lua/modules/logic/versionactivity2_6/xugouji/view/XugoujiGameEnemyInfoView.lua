module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameEnemyInfoView", package.seeall)

slot0 = class("XugoujiGameEnemyInfoView", BaseView)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji
slot2 = 0.35

function slot0.onInitView(slot0)
	slot0._goEnemyInfo = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Right/Enemy")
	slot0._txtHP = gohelper.findChildText(slot0._goEnemyInfo, "Role/image_RoleHPNumBG/#txt_RoleHP")
	slot0._btnIcon = gohelper.findChildButtonWithAudio(slot0._goEnemyInfo, "Role/image/#simage_Role")
	slot0._imageIcon = gohelper.findChildSingleImage(slot0._goEnemyInfo, "Role/image/#simage_Role")
	slot0._txtRemainTime = gohelper.findChildText(slot0._goEnemyInfo, "Remain/#txt_RemainValue")
	slot0._txtGotPairNum = gohelper.findChildText(slot0._goEnemyInfo, "Pairs/#txt_PairsValue")
	slot0._imageHP = gohelper.findChildImage(slot0._goEnemyInfo, "Role/image_RoleHPBG/#image_RoleHPFG")
	slot0._goHp = gohelper.findChild(slot0._goEnemyInfo, "#go_HP")
	slot0._textHpDiff = gohelper.findChildText(slot0._goEnemyInfo, "#go_HP/#txt_HP")
	slot0._btnBuff = gohelper.findChildButtonWithAudio(slot0._goEnemyInfo, "#go_Buff")
	slot0._goBuffRoot = gohelper.findChild(slot0._goEnemyInfo, "#go_Buff")
	slot0._goBuffItem = gohelper.findChild(slot0._goBuffRoot, "#go_Buff")
	slot0._buffInfoRoot = gohelper.findChild(slot0._goEnemyInfo, "bufftipsview")
	slot0._goBuffInfoContent = gohelper.findChild(slot0._buffInfoRoot, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content")
	slot0._goBuffInfoItem = gohelper.findChild(slot0._buffInfoRoot, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	slot0._btnBuffInfoClose = gohelper.findChildButtonWithAudio(slot0._buffInfoRoot, "#btn_buffTipsHide")
	slot0._btnSkill = gohelper.findChildButtonWithAudio(slot0._goEnemyInfo, "Role/#btn_Skill")
	slot0._skillRoot = gohelper.findChild(slot0._goEnemyInfo, "#go_ViewSkillTips")
	slot0._btnSkillTipsHide = gohelper.findChildButtonWithAudio(slot0._skillRoot, "#btnSkillTipsHide")
	slot0._skillItemRoot = gohelper.findChild(slot0._goEnemyInfo, "#go_ViewSkillTips/image_TipsBG")
	slot0._skillItem = gohelper.findChild(slot0._skillRoot, "image_TipsBG/#go_Item")
	slot0._skillTipsAnimator = ZProj.ProjAnimatorPlayer.Get(slot0._skillRoot)
	slot0._viewAnimator = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._goDamageEffect = gohelper.findChild(slot0._goEnemyInfo, "#go_damage")
end

function slot0.addEvents(slot0)
	slot0._btnIcon:AddClickListener(slot0._onIconClick, slot0)
	slot0._btnSkill:AddClickListener(slot0._onSkillClick, slot0)
	slot0._btnSkillTipsHide:AddClickListener(slot0._onSkillHideClick, slot0)
	slot0._btnBuff:AddClickListener(slot0._onBuffClick, slot0)
	slot0._btnBuffInfoClose:AddClickListener(slot0._onBuffInfoCloseClick, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.HpUpdated, slot0._onHpUpdated, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.OperateTimeUpdated, slot0._onOperateCard, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, slot0._onTurnChanged, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GotActiveCard, slot0._refreshCardPair, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.BuffUpdated, slot0._onBuffsUpdated, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, slot0._onGameReStart, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.AutoShowSkillTips, slot0._onShowGameTips, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.AutoHideSkillTips, slot0._autoHideSkillTips, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.NewCards, slot0._onRefreshCards, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnIcon:RemoveClickListener()
	slot0._btnSkill:RemoveClickListener()
	slot0._btnBuff:RemoveClickListener()
	slot0._btnSkillTipsHide:RemoveClickListener()
	slot0._btnBuffInfoClose:RemoveClickListener()
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.HpUpdated, slot0._onHpUpdated, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.OperateTimeUpdated, slot0._onOperateCard, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, slot0._onTurnChanged, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GotActiveCard, slot0._refreshCardPair, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.BuffUpdated, slot0._onBuffsUpdated, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, slot0._onGameReStart, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.AutoShowSkillTips, slot0._onShowGameTips, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.AutoHideSkillTips, slot0._autoHideSkillTips, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.NewCards, slot0._onRefreshCards, slot0)
end

function slot0._onIconClick(slot0)
end

function slot0._onSkillClick(slot0)
	if not slot0._gameCfg then
		slot0._gameCfg = Activity188Config.instance:getGameCfg(uv0, Activity188Model.instance:getCurGameId())
	end

	slot0._abilityCfgList = {
		{
			title = true
		}
	}
	slot0._abilityIdList = Activity188Model.instance:getEnemyAbilityIds()

	for slot4, slot5 in ipairs(slot0._abilityIdList) do
		slot0._abilityCfgList[slot4 + 1] = Activity188Config.instance:getAbilityCfg(uv0, slot5)
	end

	if #slot0._abilityCfgList == 1 then
		return
	end

	gohelper.setActive(slot0._skillRoot, true)
	slot0._skillTipsAnimator:Play(UIAnimationName.Open, nil, )
	gohelper.setActive(slot0._btnSkillTipsHide.gameObject, true)
	gohelper.CreateObjList(slot0, slot0._createSkillItem, slot0._abilityCfgList, slot0._skillItemRoot, slot0._skillItem)
end

function slot0._onSkillHideClick(slot0)
	gohelper.setActive(slot0._btnSkillTipsHide.gameObject, false)
	slot0._skillTipsAnimator:Play(UIAnimationName.Close, slot0.onSkillTipsCloseAniFinish, slot0)
end

function slot0.onSkillTipsCloseAniFinish(slot0)
	gohelper.setActive(slot0._skillRoot, false)
end

function slot0._onBuffClick(slot0)
	slot0._buffDataList = Activity188Model.instance:getBuffs(false)

	if not slot0._buffDataList or #slot0._buffDataList == 0 then
		return
	end

	for slot5, slot6 in ipairs(slot0._buffDataList) do
		-- Nothing
	end

	gohelper.setActive(slot0._buffInfoRoot, true)
	gohelper.CreateObjList(slot0, slot0._createBuffInfoItem, {
		{
			bg = true
		},
		[slot5 + 1] = slot6
	}, slot0._goBuffInfoContent, slot0._goBuffInfoItem)
end

function slot0._onBuffInfoCloseClick(slot0)
	gohelper.setActive(slot0._buffInfoRoot, false)
end

function slot0._onHpUpdated(slot0)
	if slot0._curTextValue == tonumber(Activity188Model.instance:getEnemyHP()) then
		return
	elseif slot0._showingDamage then
		slot0._showDamageQueue = slot0._showDamageQueue and slot0._showDamageQueue or {}
		slot0._showDamageQueue[#slot0._showDamageQueue + 1] = slot2
	else
		slot0:_refreshHP(nil)
	end
end

function slot0._onOperateCard(slot0)
	slot0:_refreshOperateLeftTime()
end

function slot0._onTurnChanged(slot0)
	slot0:_refreshOperateLeftTime()
end

function slot0._onBuffsUpdated(slot0, slot1)
	if slot1 then
		return
	end

	slot0:_refreshBuffList()
end

function slot0._onGameReStart(slot0)
	slot0._initialHP = Activity188Model.instance:getEnemyInitialHP()

	slot0:_refreshHP()
	slot0:_refreshOperateLeftTime()
	slot0:_refreshIcon()
	slot0:_refreshBuffList()
	slot0:_refreshSkillBtn()
end

function slot0._onShowGameTips(slot0)
	slot0:_onSkillClick()
end

function slot0._autoHideSkillTips(slot0)
	slot0:_onSkillHideClick()
end

function slot0._onRefreshCards(slot0)
	slot0:_refreshCardPair()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0._initialHP = Activity188Model.instance:getEnemyInitialHP()
	slot0._txtHP.text = Activity188Model.instance:getEnemyHP()
	slot0._curTextValue = Activity188Model.instance:getEnemyHP()
	slot0._imageHP.fillAmount = 1

	slot0:_refreshHP()
	slot0:_refreshOperateLeftTime()
	slot0:_refreshIcon()
	slot0:_refreshBuffList()
	slot0:_refreshSkillBtn()
end

function slot0._refreshIcon(slot0)
	if Activity188Config.instance:getGameCfg(uv0, Activity188Model.instance:getCurGameId()).portrait or slot3 ~= "" then
		slot0._imageIcon:LoadImage(slot3)
	end
end

function slot0._refreshSkillBtn(slot0)
	if not slot0._gameCfg then
		slot0._gameCfg = Activity188Config.instance:getGameCfg(uv0, Activity188Model.instance:getCurGameId())
	end

	slot0._abilityIdList = Activity188Model.instance:getEnemyAbilityIds()

	gohelper.setActive(slot0._btnSkill.gameObject, #slot0._abilityIdList > 0)
end

function slot0._refreshTurns(slot0, slot1, slot2)
	slot0._txtTurn.text = string.format("%d/%d", slot1, slot2)
end

function slot0._refreshHP(slot0, slot1)
	if (slot0._curTextValue and slot0._curTextValue or 0) == (slot1 and slot1 or tonumber(Activity188Model.instance:getEnemyHP())) then
		return
	end

	if slot3 < slot4 and not slot0._showingDamageEffect then
		slot0._showingDamageEffect = true

		TaskDispatcher.runDelay(slot0._resetShowDemageEffect, slot0, 2.5)
		gohelper.setActive(slot0._goDamageEffect, false)
		gohelper.setActive(slot0._goDamageEffect, true)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.enemyDamage)
		slot0._viewAnimator:Play("damage1", nil, )
	end

	slot0._showingDamage = true
	slot5 = Activity188Model.instance:getEnemyHP()
	slot0._curTextValue = slot5
	slot0._txtHP.text = slot5

	ZProj.TweenHelper.DOFillAmount(slot0._imageHP, tonumber(slot5) / slot0._initialHP, uv0)
	gohelper.setActive(slot0._goHp, true)

	slot0._textHpDiff.text = slot5 - slot4 < 0 and slot7 or "+" .. slot7

	SLFramework.UGUI.GuiHelper.SetColor(slot0._textHpDiff, slot7 < 0 and "#E57279" or "#7AC886")
	TaskDispatcher.cancelTask(slot0._hpChangeDone, slot0)
	TaskDispatcher.runDelay(slot0._hpChangeDone, slot0, 1)
end

function slot0._resetShowDemageEffect(slot0)
	slot0._showingDamageEffect = false
end

function slot0._hpChangeDone(slot0)
	slot0._showingDamage = false

	gohelper.setActive(slot0._goHp, false)

	if slot0._showDamageQueue and #slot0._showDamageQueue > 0 then
		table.remove(slot0._showDamageQueue, 1)
		slot0:_refreshHP(slot0._showDamageQueue[1])
	end
end

function slot0._refreshOperateLeftTime(slot0)
	slot0._txtRemainTime.text = Activity188Model.instance:getEnemyOperateTime()
end

function slot0._refreshCardPair(slot0)
	slot0._txtGotPairNum.text = Activity188Model.instance:getEnemyPairCount()
end

function slot0._refreshBuffList(slot0)
	slot0._buffDataList = Activity188Model.instance:getBuffs(false)

	gohelper.CreateObjList(slot0, slot0._createBuffItem, slot0._buffDataList, slot0._goBuffRoot, slot0._goBuffItem)
end

function slot0._createBuffItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1, true)

	if not string.nilorempty(Activity188Config.instance:getBuffCfg(uv0, slot2.buffId).icon) then
		if slot6 ~= "0" then
			UISpriteSetMgr.instance:setBuffSprite(gohelper.findChildImage(slot1, "#image_BuffIcon"), tonumber(slot6))
		end
	end

	gohelper.setActive(gohelper.findChildText(slot1, "#txt_Num").gameObject, slot5.laminate == XugoujiEnum.BuffType.Round or slot5.laminate == XugoujiEnum.BuffType.Layer)

	slot8.text = slot2.layer
end

function slot0._createSkillItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1, true)

	if slot2.title then
		return
	end

	slot6 = gohelper.findChildImage(slot1, "#image_Icon")
	gohelper.findChildText(slot1, "txt_Descr").text = slot2.desc
end

function slot0._createBuffInfoItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1, true)

	if slot2.bg then
		return
	end

	slot4 = Activity188Config.instance:getBuffCfg(uv0, slot2.buffId)
	gohelper.findChildText(slot1, "title/txt_name").text = slot4.name

	if not string.nilorempty(slot4.icon) and slot5 == "0" then
		UISpriteSetMgr.instance:setBuffSprite(gohelper.findChildImage(slot1, "title/simage_Icon"), tonumber(slot5))
	end

	gohelper.findChildText(slot1, "txt_desc").text = slot4.desc
	slot9 = gohelper.findChildText(slot1, "title/txt_name/go_tag/bg/txt_tagname")
	slot11 = ""

	if slot4.laminate == XugoujiEnum.BuffType.Round then
		slot11 = formatLuaLang("x_round", slot2.layer)
	elseif slot4.laminate == XugoujiEnum.BuffType.Layer then
		slot11 = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_layer"), {
			slot10
		})
	else
		gohelper.setActive(gohelper.findChild(slot1, "title/txt_name/go_tag"), false)
	end

	slot9.text = slot11
end

function slot0._createTargetList(slot0)
	gohelper.CreateObjList(slot0, slot0._createTargetItem, slot0._targetDataList, slot0._gotargetItemRoot, slot0._gotargetItem)
end

function slot0._createTargetItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1, true)
end

function slot0._storyEnd(slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._resetShowDemageEffect, slot0)
	TaskDispatcher.cancelTask(slot0._hpChangeDone, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._imageIcon:UnLoadImage()
end

return slot0
