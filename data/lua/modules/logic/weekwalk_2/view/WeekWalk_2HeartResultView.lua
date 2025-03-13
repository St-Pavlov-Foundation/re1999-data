module("modules.logic.weekwalk_2.view.WeekWalk_2HeartResultView", package.seeall)

slot0 = class("WeekWalk_2HeartResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagePanelBG1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_PanelBG1")
	slot0._simagePanelBG2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_PanelBG1/#simage_PanelBG2")
	slot0._goPanel = gohelper.findChild(slot0.viewGO, "#go_Panel")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_Panel/#go_left")
	slot0._simagemaskImage = gohelper.findChildSingleImage(slot0.viewGO, "#go_Panel/#go_left/#simage_maskImage")
	slot0._goAttack = gohelper.findChild(slot0.viewGO, "#go_Panel/#go_Attack")
	slot0._txtattackNum1 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_Attack/LayoutGroup/Data1/#txt_attackNum1")
	slot0._txtattackNum2 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_Attack/LayoutGroup/Data2/#txt_attackNum2")
	slot0._txtattackNum3 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_Attack/LayoutGroup/Data3/#txt_attackNum3")
	slot0._goHealth = gohelper.findChild(slot0.viewGO, "#go_Panel/#go_Health")
	slot0._txthealthNum1 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_Health/LayoutGroup/Data1/#txt_healthNum1")
	slot0._txthealthNum2 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_Health/LayoutGroup/Data2/#txt_healthNum2")
	slot0._goDefence = gohelper.findChild(slot0.viewGO, "#go_Panel/#go_Defence")
	slot0._txtdefenceNum1 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_Defence/LayoutGroup/Data1/#txt_defenceNum1")
	slot0._txtdefenceNum2 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_Defence/LayoutGroup/Data2/#txt_defenceNum2")
	slot0._goRoleData = gohelper.findChild(slot0.viewGO, "#go_Panel/#go_RoleData")
	slot0._simageRoleattack = gohelper.findChildSingleImage(slot0.viewGO, "#go_Panel/#go_RoleData/Attack/skinnode/node/#simage_Roleattack")
	slot0._txtNumattack1 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_RoleData/Attack/LayoutGroup/Data1/#txt_Numattack1")
	slot0._txtNumattack2 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_RoleData/Attack/LayoutGroup/Data2/#txt_Numattack2")
	slot0._txtNumattack3 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_RoleData/Attack/LayoutGroup/Data3/#txt_Numattack3")
	slot0._simageRolehealth = gohelper.findChildSingleImage(slot0.viewGO, "#go_Panel/#go_RoleData/Health/skinnode/node/#simage_Rolehealth")
	slot0._txtNumhealth1 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_RoleData/Health/LayoutGroup/Data1/#txt_Numhealth1")
	slot0._txtNumhealth2 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_RoleData/Health/LayoutGroup/Data2/#txt_Numhealth2")
	slot0._simageRoledefence = gohelper.findChildSingleImage(slot0.viewGO, "#go_Panel/#go_RoleData/Defence/skinnode/node/#simage_Roledefence")
	slot0._txtNumdefence1 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_RoleData/Defence/LayoutGroup/Data1/#txt_Numdefence1")
	slot0._txtNumdefence2 = gohelper.findChildText(slot0.viewGO, "#go_Panel/#go_RoleData/Defence/LayoutGroup/Data2/#txt_Numdefence2")
	slot0._goCupData = gohelper.findChild(slot0.viewGO, "#go_Panel/#go_CupData")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Panel/#btn_click")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")
	slot0._imageskip = gohelper.findChildImage(slot0.viewGO, "#btn_skip/#image_skip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
end

function slot0._btnskipOnClick(slot0)
	slot0._index = WeekWalk_2Enum.ResultAnimIndex.CupData

	slot0:_updateStatus()
end

function slot0._btnclickOnClick(slot0)
	slot0:_showNext()
end

function slot0._showNext(slot0)
	slot0._index = slot0._index + 1

	if slot0._index > #slot0._showHandler then
		slot0:closeThis()

		return
	end

	slot0:_updateStatus()
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent("Animator")
	slot0._index = 1
	slot0._showHandler = {
		[WeekWalk_2Enum.ResultAnimIndex.Attack] = slot0._showAttack,
		[WeekWalk_2Enum.ResultAnimIndex.Health] = slot0._showHealth,
		[WeekWalk_2Enum.ResultAnimIndex.Defence] = slot0._showDefence,
		[WeekWalk_2Enum.ResultAnimIndex.RoleData] = slot0._showRoleData,
		[WeekWalk_2Enum.ResultAnimIndex.CupData] = slot0._showCupData
	}
	slot0._showStatusInfo = {}
	slot0._animName = {
		[WeekWalk_2Enum.ResultAnimIndex.Attack] = "attack",
		[WeekWalk_2Enum.ResultAnimIndex.Health] = "health",
		[WeekWalk_2Enum.ResultAnimIndex.Defence] = "defence",
		[WeekWalk_2Enum.ResultAnimIndex.RoleData] = "roledata",
		[WeekWalk_2Enum.ResultAnimIndex.CupData] = "cupdata"
	}

	slot0:_initSpineNodes()
end

function slot0._initSpineNodes(slot0)
	slot0._gospine = gohelper.findChild(slot0._goleft, "spineContainer/spine")
	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, true)

	slot0._uiSpine:useRT()

	slot0._txtSayCn = gohelper.findChildText(slot0._goleft, "txtSayCn")
	slot0._txtSayEn = gohelper.findChildText(slot0._goleft, "SayEn/txtSayEn")
	slot0._txtSayCn.text = ""
	slot0._txtSayEn.text = ""
end

function slot0._hideSpine(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
	end

	gohelper.setActive(slot0._goleft, false)
end

function slot0._showSpine(slot0, slot1)
	gohelper.setActive(slot0._goleft, true)

	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
	end

	if not (HeroModel.instance:getByHeroId(slot1) and lua_skin.configDict[slot2.skin]) then
		return
	end

	slot0._heorId = slot1
	slot0._skinId = slot3.id

	slot0._uiSpine:setImgPos(0)
	slot0._uiSpine:setResPath(slot3, function ()
		uv0._spineLoaded = true
	end, slot0)

	slot4, slot5 = SkinConfig.instance:getSkinOffset(slot3.fightSuccViewOffset)

	if slot5 then
		slot6, _ = SkinConfig.instance:getSkinOffset(slot3.characterViewOffset)
		slot4 = SkinConfig.instance:getAfterRelativeOffset(504, slot6)
	end

	slot6 = tonumber(slot4[3])

	recthelper.setAnchor(slot0._gospine.transform, tonumber(slot4[1]), tonumber(slot4[2]))
	transformhelper.setLocalScale(slot0._gospine.transform, slot6, slot6, slot6)
end

function slot0._playSpineVoice(slot0)
	if (HeroModel.instance:getVoiceConfig(slot0._heorId, CharacterEnum.VoiceType.FightResult, nil, slot0._skinId) or FightAudioMgr.instance:_getHeroVoiceCOs(slot0._heorId, CharacterEnum.VoiceType.FightResult, slot0._skinId)) and #slot1 > 0 then
		slot0._uiSpine:playVoice(slot1[1], nil, slot0._txtSayCn, slot0._txtSayEn)
	end
end

function slot0._updateStatus(slot0)
	gohelper.setActive(slot0._goAttack, true)
	gohelper.setActive(slot0._goHealth, true)
	gohelper.setActive(slot0._goDefence, true)
	gohelper.setActive(slot0._goRoleData, true)
	gohelper.setActive(slot0._goCupData, true)
	gohelper.setActive(slot0._btnskip, slot0._index ~= WeekWalk_2Enum.ResultAnimIndex.CupData)

	slot2 = slot0._showHandler[slot0._index](slot0)
	slot0._showStatusInfo[slot0._index] = slot2

	if not slot2 then
		if slot0._index ~= WeekWalk_2Enum.ResultAnimIndex.Attack then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
		end

		if slot0._index == WeekWalk_2Enum.ResultAnimIndex.Defence and slot0._showStatusInfo[WeekWalk_2Enum.ResultAnimIndex.Health] then
			slot0._animator:Play("go_" .. slot0._animName[slot0._index] .. "2", 0, 0)

			return
		end

		if slot0._index == WeekWalk_2Enum.ResultAnimIndex.CupData and slot0._prevIndex ~= WeekWalk_2Enum.ResultAnimIndex.RoleData then
			slot0._animator:Play("cupdata2", 0, 0)

			return
		end

		slot0._animator:Play("go_" .. slot0._animName[slot0._index], 0, 0)

		slot0._prevIndex = slot0._index
	else
		slot0:_showNext()
	end
end

function slot0._showAttack(slot0)
	gohelper.setActive(slot0._goAttack, true)

	slot1 = slot0._info.harmHero
	slot0._txtattackNum1.text = slot1.battleNum
	slot0._txtattackNum2.text = slot1.allHarm
	slot0._txtattackNum3.text = slot1.singleHighHarm

	slot0:_showSpine(slot1.heroId)
end

slot1 = 0.2

function slot0._showHealth(slot0)
	gohelper.setActive(slot0._goHealth, true)

	if tonumber(slot0._info.healHero.allHeal) <= 0 then
		return true
	end

	slot0._txthealthNum1.text = slot1.battleNum
	slot0._txthealthNum2.text = slot1.allHeal
	slot0._spineHeroId = slot1.heroId

	TaskDispatcher.cancelTask(slot0._delayShowSpine, slot0)
	TaskDispatcher.runDelay(slot0._delayShowSpine, slot0, uv0)
end

function slot0._showDefence(slot0)
	gohelper.setActive(slot0._goDefence, true)

	slot1 = slot0._info.hurtHero
	slot0._txtdefenceNum1.text = slot1.battleNum
	slot0._txtdefenceNum2.text = slot1.allHurt
	slot0._spineHeroId = slot1.heroId

	TaskDispatcher.cancelTask(slot0._delayShowSpine, slot0)
	TaskDispatcher.runDelay(slot0._delayShowSpine, slot0, uv0)
end

function slot0._delayShowSpine(slot0)
	if slot0._uiSpine then
		gohelper.setActive(slot0._uiSpine:getSpineGo(), false)
	end

	slot0:_showSpine(slot0._spineHeroId)
end

function slot0._showRoleData(slot0)
	slot0:_hideSpine()
	gohelper.setActive(slot0._goRoleData, true)

	slot1 = slot0._info.harmHero
	slot2 = slot0._info.healHero
	slot3 = slot0._info.hurtHero
	slot0._txtNumattack1.text = slot1.battleNum
	slot0._txtNumattack2.text = slot1.allHarm
	slot0._txtNumattack3.text = slot1.singleHighHarm
	slot0._txtNumhealth1.text = slot2.battleNum
	slot0._txtNumhealth2.text = slot2.allHeal

	if tonumber(slot2.allHeal) <= 0 then
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "#go_Panel/#go_RoleData/Health"), false)

		slot5 = gohelper.findChild(slot0.viewGO, "#go_Panel/#go_RoleData/Attack")
		slot6 = gohelper.findChild(slot0.viewGO, "#go_Panel/#go_RoleData/Defence")

		gohelper.addChild(gohelper.findChild(slot0.viewGO, "#go_Panel/#go_RoleData/2/Attack"), slot5)
		gohelper.addChild(gohelper.findChild(slot0.viewGO, "#go_Panel/#go_RoleData/2/Defence"), slot6)
		recthelper.setAnchor(slot5.transform, 0, 0)
		recthelper.setAnchor(slot6.transform, 0, 0)
	end

	slot0._txtNumdefence1.text = slot3.battleNum
	slot0._txtNumdefence2.text = slot3.allHurt

	if HeroModel.instance:getByHeroId(slot1.heroId) then
		slot0:_loadRoleImage(slot0._simageRoleattack, slot4.skin)
	end

	gohelper.setActive(slot0._simageRoleattack, slot4 ~= nil)

	if HeroModel.instance:getByHeroId(slot2.heroId) then
		slot0:_loadRoleImage(slot0._simageRolehealth, slot5.skin)
	end

	gohelper.setActive(slot0._simageRolehealth, slot5 ~= nil)

	if HeroModel.instance:getByHeroId(slot3.heroId) then
		slot0:_loadRoleImage(slot0._simageRoledefence, slot6.skin)
	end

	gohelper.setActive(slot0._simageRoledefence, slot6 ~= nil)
end

function slot0._loadRoleImage(slot0, slot1, slot2)
	slot1:LoadImage(ResUrl.getHeadIconImg(slot2), function ()
		ZProj.UGUIHelper.SetImageSize(uv1.gameObject)

		if string.nilorempty(SkinConfig.instance:getSkinCo(uv0).lucidescapeViewImgOffset) then
			slot1 = slot0.playercardViewImgOffset
		end

		if string.nilorempty(slot1) then
			slot1 = slot0.characterViewImgOffset
		end

		if not string.nilorempty(slot1) then
			slot2 = string.splitToNumber(slot1, "#")

			recthelper.setAnchor(uv1.transform, tonumber(slot2[1]), tonumber(slot2[2]))
			transformhelper.setLocalScale(uv1.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
		end
	end)
end

function slot0._showCupData(slot0)
	gohelper.setActive(slot0._goCupData, true)

	for slot5, slot6 in pairs(slot0._info.layerInfos) do
		slot0:_showLayerInfo(slot6.config.layer, slot6)
	end
end

function slot0._showLayerInfo(slot0, slot1, slot2)
	slot3 = slot2.config

	slot0:_showLayerBattleInfo(slot1, 1, slot2.battleInfos[slot3.fightIdFront], slot2)
	slot0:_showLayerBattleInfo(slot1, 2, slot2.battleInfos[slot3.fightIdRear], slot2)
end

function slot0._showLayerBattleInfo(slot0, slot1, slot2, slot3, slot4)
	slot6 = gohelper.findChild(gohelper.findChild(slot0._goCupData, tostring(slot1)), "Level/" .. tostring(slot2))

	if slot2 == 1 then
		gohelper.findChildText(slot5, "battlename").text = slot4.sceneConfig.battleName
	end

	slot7 = gohelper.findChild(slot6, "badgelayout/1")

	slot0:_showBattleCup(slot7, slot3.cupInfos[1])
	slot0:_showBattleCup(gohelper.cloneInPlace(slot7), slot3.cupInfos[2])
	slot0:_showBattleCup(gohelper.cloneInPlace(slot7), slot3.cupInfos[3])
end

function slot0._showBattleCup(slot0, slot1, slot2)
	slot4 = (slot2 and slot2.result or 0) > 0

	gohelper.setActive(gohelper.findChild(slot1, "1"), slot4)

	if not slot4 then
		return
	end

	slot6 = gohelper.findChildImage(slot1, "1")
	slot6.enabled = false

	WeekWalk_2Helper.setCupEffect(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot6.gameObject), slot2)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._info = WeekWalk_2Model.instance:getSettleInfo()

	slot0:_showEndingAnim()
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnShowSkin, slot0._onShowSkin, slot0)
end

function slot0._onShowSkin(slot0, slot1)
	slot0:_loadRoleImage(slot0._simageRoledefence, slot1)
end

function slot0._showEndingAnim(slot0)
	gohelper.setActive(slot0._goweekwalkending, true)
	gohelper.setActive(slot0._goPanel, false)
	gohelper.setActive(slot0._goAttack, false)
	gohelper.setActive(slot0._goHealth, false)
	gohelper.setActive(slot0._goDefence, false)
	gohelper.setActive(slot0._goRoleData, false)
	gohelper.setActive(slot0._goCupData, false)
	slot0:_showInfos()
end

function slot0._showInfos(slot0)
	gohelper.setActive(slot0._goweekwalkending, false)
	gohelper.setActive(slot0._goPanel, true)
	slot0:_updateStatus()
end

function slot0.onClose(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)

	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
	end

	WeekWalk_2Model.instance:clearSettleInfo()
	TaskDispatcher.cancelTask(slot0._delayShowSpine, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
