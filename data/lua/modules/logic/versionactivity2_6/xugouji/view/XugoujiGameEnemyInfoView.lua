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
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GotCardPair, slot0._refreshCardPair, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.BuffUpdated, slot0._onBuffsUpdated, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, slot0._onGameReStart, slot0)
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
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GotCardPair, slot0._refreshCardPair, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.BuffUpdated, slot0._onBuffsUpdated, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, slot0._onGameReStart, slot0)
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
	slot5 = "#"
	slot0._abilityIdList = string.splitToNumber(slot0._gameCfg.bossAbilityIds, slot5)

	for slot5, slot6 in ipairs(slot0._abilityIdList) do
		slot0._abilityCfgList[slot5 + 1] = Activity188Config.instance:getAbilityCfg(uv0, slot6)
	end

	gohelper.setActive(slot0._skillRoot, true)
	gohelper.CreateObjList(slot0, slot0._createSkillItem, slot0._abilityCfgList, slot0._skillItemRoot, slot0._skillItem)
end

function slot0._onSkillHideClick(slot0)
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
	slot0:_refreshHP()
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

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0._initialHP = Activity188Model.instance:getEnemyInitialHP()

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

	slot0._abilityIdList = string.splitToNumber(slot0._gameCfg.bossAbilityIds, "#")

	gohelper.setActive(slot0._btnSkill.gameObject, #slot0._abilityIdList > 0)
end

function slot0._refreshTurns(slot0, slot1, slot2)
	slot0._txtTurn.text = string.format("%d/%d", slot1, slot2)
end

function slot0._refreshHP(slot0)
	if tonumber(slot0._txtHP.text) == tonumber(Activity188Model.instance:getEnemyHP()) then
		return
	end

	slot3 = Activity188Model.instance:getEnemyHP()
	slot0._txtHP.text = slot3

	ZProj.TweenHelper.DOScale(slot0._txtHP.transform, -1.5, 1.5, 1.5, 0.25, slot0.onScaleTweenEnd, slot0)
	ZProj.TweenHelper.DOFillAmount(slot0._imageHP, tonumber(slot3) / slot0._initialHP, uv0)
end

function slot0._refreshOperateLeftTime(slot0)
	slot0._txtRemainTime.text = Activity188Model.instance:getEnemyOperateTime()
end

function slot0._refreshCardPair(slot0)
	slot0._txtGotPairNum.text = Activity188Model.instance:getEnemyPairCount()
end

function slot0.onScaleTweenEnd(slot0)
	ZProj.TweenHelper.DOScale(slot0._txtHP.transform, -1, 1, 1, 0.5)
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
end

function slot0.onDestroyView(slot0)
	slot0._imageIcon:UnLoadImage()
end

return slot0
