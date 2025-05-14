module("modules.logic.fight.view.FightViewTips", package.seeall)

local var_0_0 = class("FightViewTips", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._tipsRoot = gohelper.findChild(arg_1_0.viewGO, "root/tips")
	arg_1_0._goglobalClick = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_globalClick")
	arg_1_0._gobufftip = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_bufftip")
	arg_1_0._passiveSkillPrefab = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_bufftip/#scroll_buff/viewport/content/#go_buffitem")
	arg_1_0._goskilltip = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_skilltip")
	arg_1_0._goHeatTips = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_skilltip/#go_heat")
	arg_1_0._txtskillname = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_skilltip/skillbg/container/#txt_skillname")
	arg_1_0._txtskilltype = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_skilltip/skillbg/container/bg/#txt_skilltype")
	arg_1_0._txtskilldesc = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_skilltip/skillbg/#txt_skilldesc")
	arg_1_0._skillTipsGO = arg_1_0._txtskilldesc.gameObject
	arg_1_0._goattrbg = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_skilltip/#go_attrbg")
	arg_1_0._gobuffinfocontainer = gohelper.findChild(arg_1_0.viewGO, "root/#go_buffinfocontainer")

	gohelper.setActive(arg_1_0._gobuffinfocontainer, false)

	arg_1_0._gobuffinfowrapper = gohelper.findChild(arg_1_0.viewGO, "root/#go_buffinfocontainer/buff")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	arg_1_0._scrollbuff = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff")
	arg_1_0._btnclosebuffinfocontainer = gohelper.findChildButton(arg_1_0.viewGO, "root/#go_buffinfocontainer/#btn_click")
	arg_1_0._gofightspecialtip = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_fightspecialtip")
	arg_1_0._promptImage = gohelper.findChildImage(arg_1_0.viewGO, "root/tips/#go_fightspecialtip/tipcontent/#image_specialtipbg")
	arg_1_0._promptText = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_fightspecialtip/tipcontent/#image_specialtipbg/#txt_specialtipdesc")
	arg_1_0._prompAni = gohelper.findChildComponent(arg_1_0.viewGO, "root/tips/#go_fightspecialtip", typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0._passiveSkillGOs = arg_1_0:getUserDataTb_()
	arg_1_0._passiveSkillImgs = arg_1_0:getUserDataTb_()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosebuffinfocontainer:AddClickListener(arg_2_0._onCloseBuffInfoContainer, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ShowFightPrompt, arg_2_0._onShowFightPrompt, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ShowSeasonGuardIntro, arg_2_0._onShowSeasonGuardIntro, arg_2_0)

	arg_2_0._loader = arg_2_0._loader or FightLoaderComponent.New()
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosebuffinfocontainer:RemoveClickListener()

	if not gohelper.isNil(arg_3_0._touchEventMgr) then
		TouchEventMgrHepler.remove(arg_3_0._touchEventMgr)
	end

	TaskDispatcher.cancelTask(arg_3_0._delayCheckHideTips, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)

	if arg_3_0._loader then
		arg_3_0._loader:disposeSelf()

		arg_3_0._loader = nil
	end
end

var_0_0.enemyBuffTipPosY = 80
var_0_0.OnKeyTipsPosY = 380
var_0_0.OnKeyTipsUniquePosY = 436

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_4_0._goglobalClick)

	arg_4_0._touchEventMgr:SetIgnoreUI(true)
	arg_4_0._touchEventMgr:SetOnlyTouch(true)
	arg_4_0._touchEventMgr:SetOnTouchDownCb(arg_4_0._onGlobalTouch, arg_4_0)

	arg_4_0._originSkillPosX, arg_4_0._originSkillPosY = recthelper.getAnchor(arg_4_0._goskilltip.transform)

	gohelper.setActive(arg_4_0._gobuffitem, false)

	arg_4_0._buffItemList = {}
	arg_4_0.rectTrScrollBuff = arg_4_0._scrollbuff:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.rectTrBuffContent = gohelper.findChildComponent(arg_4_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content", gohelper.Type_RectTransform)

	gohelper.setActive(arg_4_0._goattrbg, false)
	gohelper.addUIClickAudio(arg_4_0._btnclosebuffinfocontainer.gameObject, AudioEnum.UI.play_ui_checkpoint_click)
	gohelper.setActive(arg_4_0._txtskilltype.gameObject, false)
	gohelper.setActive(arg_4_0._gofightspecialtip, false)

	arg_4_0.buffTipClick = gohelper.getClickWithDefaultAudio(arg_4_0._gobufftip)

	arg_4_0.buffTipClick:AddClickListener(arg_4_0.onClickBuffTip, arg_4_0)
	gohelper.setActive(arg_4_0._gobufftip, false)
end

function var_0_0.onClickBuffTip(arg_5_0)
	gohelper.setActive(arg_5_0._gobufftip, false)
end

function var_0_0._onGlobalTouch(arg_6_0)
	if arg_6_0._guardTipsRoot then
		gohelper.setActive(arg_6_0._guardTipsRoot, false)
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidCloseSkilltip) then
		return
	end

	if GuideViewMgr.instance:isGuidingGO(arg_6_0._skillTipsGO) then
		arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0._onCloseView, arg_6_0)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.TouchFightViewScreen)

	arg_6_0._showingSkillTip = not gohelper.isNil(arg_6_0._goskilltip) and arg_6_0._goskilltip.activeInHierarchy

	if arg_6_0._showingSkillTip then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)

		local var_6_0 = 0.1 * Time.timeScale

		if ViewMgr.instance:isOpen(ViewName.GuideView) then
			var_6_0 = GuideBlockMgr.BlockTime
		end

		TaskDispatcher.runDelay(arg_6_0._delayCheckHideTips, arg_6_0, var_6_0)
	end
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.GuideView then
		arg_7_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_7_0._onCloseView, arg_7_0)
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
		arg_7_0:_hideTips()
	end
end

function var_0_0._delayCheckHideTips(arg_8_0)
	if arg_8_0._showingSkillTip then
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
	end

	if arg_8_0._showingSkillTip then
		arg_8_0:_hideTips()
	end
end

function var_0_0._onCloseBuffInfoContainer(arg_9_0)
	gohelper.setActive(arg_9_0._gobuffinfocontainer, false)
	ViewMgr.instance:closeView(ViewName.CommonBuffTipView)
	ViewMgr.instance:closeView(ViewName.FightBuffTipsView)
end

function var_0_0.onOpen(arg_10_0)
	gohelper.setActive(gohelper.findChild(arg_10_0.viewGO, "root/tips"), true)
	arg_10_0:_hideTips()
	arg_10_0:addEventCb(FightController.instance, FightEvent.OnBuffClick, arg_10_0._onBuffClick, arg_10_0)
	arg_10_0:addEventCb(FightController.instance, FightEvent.OnPassiveSkillClick, arg_10_0._onPassiveSkillClick, arg_10_0)
	arg_10_0:addEventCb(FightController.instance, FightEvent.ShowCardSkillTips, arg_10_0._showCardSkillTips, arg_10_0)
	arg_10_0:addEventCb(FightController.instance, FightEvent.HideCardSkillTips, arg_10_0._hideCardSkillTips, arg_10_0)
	arg_10_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_10_0._onCloseBuffInfoContainer, arg_10_0)
	arg_10_0:addEventCb(FightController.instance, FightEvent.EnterOperateState, arg_10_0._onEnterOperateState, arg_10_0)
	arg_10_0:addEventCb(FightController.instance, FightEvent.EnterStage, arg_10_0._onEnterStage, arg_10_0)
end

function var_0_0._onEnterStage(arg_11_0, arg_11_1)
	if arg_11_1 == FightStageMgr.StageType.Play then
		arg_11_0:_hideTips()

		if arg_11_0._guardTipsRoot then
			gohelper.setActive(arg_11_0._guardTipsRoot, false)
		end
	end
end

function var_0_0._onEnterOperateState(arg_12_0, arg_12_1)
	if arg_12_1 == FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(arg_12_0._gobuffinfocontainer, false)
		arg_12_0:_hideTips()
	end
end

function var_0_0._setPassiveSkillTip(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = gohelper.findChildText(arg_13_1, "title/txt_name")
	local var_13_1 = gohelper.findChildText(arg_13_1, "txt_desc")
	local var_13_2 = lua_skill.configDict[arg_13_2.skillId]

	var_13_0.text = var_13_2.name

	local var_13_3 = FightConfig.instance:getEntitySkillDesc(arg_13_3, var_13_2)

	var_13_1.text = HeroSkillModel.instance:skillDesToSpot(var_13_3, "#CC492F", "#485E92")
end

function var_0_0._setSkillTip(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	gohelper.setActive(arg_14_0._goskilltip, true)

	local var_14_0 = lua_skill.configDict[arg_14_1]

	arg_14_0._txtskillname.text = var_14_0.name
	arg_14_0._txtskilltype.text = arg_14_0:_formatSkillType(var_14_0)

	local var_14_1 = FightConfig.instance:getEntitySkillDesc(arg_14_2, var_14_0)
	local var_14_2 = arg_14_0:_buildLinkTag(var_14_1)

	arg_14_0._txtskilldesc.text = HeroSkillModel.instance:skillDesToSpot(var_14_2, "#c56131", "#7c93ad")

	gohelper.setActive(arg_14_0._goHeatTips, false)

	if arg_14_3 and arg_14_3.heatId ~= 0 then
		gohelper.setActive(arg_14_0._goHeatTips, true)

		arg_14_0._heatId = arg_14_3.heatId

		if lua_card_heat.configDict[arg_14_0._heatId] then
			if arg_14_0._heatTitle then
				arg_14_0:_refreshCardHeat()
			elseif not arg_14_0._loadHeatTips then
				arg_14_0._loadHeatTips = true

				arg_14_0._loader:loadAsset("ui/viewres/fight/fightheattipsview.prefab", arg_14_0._onHeatTipsLoadFinish, arg_14_0)
			end
		end
	end
end

function var_0_0._refreshCardHeat(arg_15_0)
	local var_15_0 = arg_15_0._heatId
	local var_15_1 = lua_card_heat.configDict[var_15_0]

	if not var_15_1 then
		return
	end

	local var_15_2 = FightDataHelper.teamDataMgr.myData.cardHeat.values[var_15_0]

	if var_15_2 then
		local var_15_3 = FightDataHelper.teamDataMgr.myCardHeatOffset[var_15_0] or 0
		local var_15_4 = {}

		if not string.nilorempty(var_15_1.descParam) then
			local var_15_5 = string.split(var_15_1.descParam, "#")

			for iter_15_0, iter_15_1 in ipairs(var_15_5) do
				if iter_15_1 == "curValue" then
					table.insert(var_15_4, var_15_2.value + var_15_3)
				elseif iter_15_1 == "upperLimit" then
					table.insert(var_15_4, var_15_2.upperLimit)
				elseif iter_15_1 == "lowerLimit" then
					table.insert(var_15_4, var_15_2.lowerLimit)
				elseif iter_15_1 == "changeValue" then
					table.insert(var_15_4, var_15_2.changeValue)
				end
			end
		end

		arg_15_0._heatTitle.text = ""
		arg_15_0._heatDesc.text = GameUtil.getSubPlaceholderLuaLang(var_15_1.desc, var_15_4)
	end
end

function var_0_0._onHeatTipsLoadFinish(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 then
		return
	end

	local var_16_0 = arg_16_2:GetResource()
	local var_16_1 = gohelper.clone(var_16_0, arg_16_0._goHeatTips)

	arg_16_0._heatTitle = gohelper.findChildText(var_16_1, "tips/heatbg/#txt_heatname")
	arg_16_0._heatDesc = gohelper.findChildText(var_16_1, "tips/heatbg/#txt_heatdesc")

	arg_16_0:_refreshCardHeat()
end

function var_0_0._buildLinkTag(arg_17_0, arg_17_1)
	local var_17_0 = string.gsub(arg_17_1, "%[(.-)%]", "<link=\"%1\">[%1]</link>")

	return (string.gsub(var_17_0, "%【(.-)%】", "<link=\"%1\">【%1】</link>"))
end

function var_0_0._updateBuffs(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._gobuffinfocontainer, false)
end

function var_0_0._hideTips(arg_19_0)
	gohelper.setActive(arg_19_0._goskilltip, false)
end

function var_0_0.onClose(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._correctPos, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._hidePrompt, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._playPromptCloseAnim, arg_20_0)
	arg_20_0:removeEventCb(FightController.instance, FightEvent.OnBuffClick, arg_20_0._onBuffClick, arg_20_0)
	arg_20_0:removeEventCb(FightController.instance, FightEvent.OnPassiveSkillClick, arg_20_0._onPassiveSkillClick, arg_20_0)
	arg_20_0:removeEventCb(FightController.instance, FightEvent.ShowCardSkillTips, arg_20_0._showCardSkillTips, arg_20_0)
	arg_20_0:removeEventCb(FightController.instance, FightEvent.HideCardSkillTips, arg_20_0._hideCardSkillTips, arg_20_0)
	arg_20_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_20_0._onCloseBuffInfoContainer, arg_20_0)
end

function var_0_0._showCardSkillTips(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0:_hideTips()
	arg_21_0:_setSkillTip(arg_21_1, arg_21_2, arg_21_3)

	local var_21_0 = arg_21_0._goskilltip.transform

	if PCInputController.instance:getIsUse() and PlayerPrefsHelper.getNumber("keyTips", 0) ~= 0 then
		if FightCardDataHelper.isBigSkill(arg_21_1) then
			recthelper.setAnchor(var_21_0, arg_21_0._originSkillPosX, var_0_0.OnKeyTipsUniquePosY)
		else
			recthelper.setAnchor(var_21_0, arg_21_0._originSkillPosX, var_0_0.OnKeyTipsPosY)
		end
	else
		recthelper.setAnchor(var_21_0, arg_21_0._originSkillPosX, arg_21_0._originSkillPosY)
	end
end

function var_0_0._hideCardSkillTips(arg_22_0)
	arg_22_0:_hideTips()
end

function var_0_0._onPassiveSkillClick(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	if arg_23_1 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
			local var_23_0 = arg_23_0._passiveSkillGOs[iter_23_0]

			if not var_23_0 then
				var_23_0 = gohelper.cloneInPlace(arg_23_0._passiveSkillPrefab, "item" .. iter_23_0)

				table.insert(arg_23_0._passiveSkillGOs, var_23_0)

				local var_23_1 = gohelper.findChildImage(var_23_0, "title/simage_icon")

				table.insert(arg_23_0._passiveSkillImgs, var_23_1)
				arg_23_0:_setPassiveSkillTip(var_23_0, iter_23_1, arg_23_5)
				UISpriteSetMgr.instance:setFightPassiveSprite(var_23_1, iter_23_1.icon)
			end

			local var_23_2 = gohelper.findChild(arg_23_0._passiveSkillGOs[#arg_23_1], "txt_desc/image_line")

			gohelper.setActive(var_23_2, false)
			gohelper.setActive(var_23_0, true)
		end

		for iter_23_2 = #arg_23_1 + 1, #arg_23_0._passiveSkillGOs do
			gohelper.setActive(arg_23_0._passiveSkillGOs[iter_23_2], false)
		end

		gohelper.setActive(arg_23_0._gobufftip, true)
	end
end

function var_0_0._onBuffClick(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = FightDataHelper.entityMgr:getById(arg_24_1)

	if not var_24_0 then
		logError("get EntityMo fail, entityId : " .. tostring(arg_24_1))

		return
	end

	if isDebugBuild then
		local var_24_1 = {}

		for iter_24_0, iter_24_1 in pairs(var_24_0:getBuffDic()) do
			local var_24_2 = lua_skill_buff.configDict[iter_24_1.buffId]
			local var_24_3 = var_24_2.isNoShow == 0 and "show" or "noShow"
			local var_24_4 = var_24_2.isGoodBuff == 1 and "good" or "bad"
			local var_24_5 = iter_24_1.buffId
			local var_24_6 = var_24_2.name
			local var_24_7 = iter_24_1.count
			local var_24_8 = iter_24_1.duration
			local var_24_9 = var_24_2.desc
			local var_24_10 = string.format("id=%d count=%d duration=%d name=%s desc=%s %s %s", var_24_5, var_24_7, var_24_8, var_24_6, var_24_9, var_24_4, var_24_3)

			table.insert(var_24_1, var_24_10)
		end

		logNormal(string.format("buff list %d :\n%s", #var_24_1, table.concat(var_24_1, "\n")))
	end

	local var_24_11 = true
	local var_24_12 = var_24_0:getBuffDic()

	for iter_24_2, iter_24_3 in pairs(var_24_12) do
		local var_24_13 = lua_skill_buff.configDict[iter_24_3.buffId]

		if var_24_13 and var_24_13.isNoShow == 0 then
			var_24_11 = false

			break
		end
	end

	if var_24_11 then
		return
	end

	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = arg_24_1,
		iconPos = arg_24_2.position,
		offsetX = arg_24_3,
		offsetY = arg_24_4,
		viewname = arg_24_0.viewName
	})
	arg_24_0:_hideTips()

	local var_24_14 = arg_24_0._gobuffinfowrapper.transform
	local var_24_15 = recthelper.rectToRelativeAnchorPos(arg_24_2.position, var_24_14.parent)

	if var_24_0.side == FightEnum.EntitySide.MySide then
		recthelper.setAnchor(var_24_14, var_24_15.x - arg_24_3 + 100, var_24_15.y + arg_24_4)
	else
		recthelper.setAnchor(var_24_14, var_24_15.x + arg_24_3, var_0_0.enemyBuffTipPosY)
	end

	arg_24_0._buffinfoWrapperTr = var_24_14
	gohelper.onceAddComponent(arg_24_0._buffinfoWrapperTr.gameObject, gohelper.Type_CanvasGroup).alpha = 0

	TaskDispatcher.runDelay(arg_24_0._correctPos, arg_24_0, 0.01)
end

function var_0_0._correctPos(arg_25_0)
	if gohelper.fitScreenOffset(arg_25_0._buffinfoWrapperTr) then
		recthelper.setAnchor(arg_25_0._buffinfoWrapperTr, 0, 0)
	end

	gohelper.onceAddComponent(arg_25_0._buffinfoWrapperTr.gameObject, gohelper.Type_CanvasGroup).alpha = 1
end

function var_0_0._formatSkillType(arg_26_0, arg_26_1)
	if arg_26_1.effectTag == FightEnum.EffectTag.CounterSpell and FightEnum.EffectTagDesc[FightEnum.EffectTag.CounterSpell] then
		return FightEnum.EffectTagDesc[FightEnum.EffectTag.CounterSpell]
	end

	local var_26_0 = FightEnum.LogicTargetDesc[arg_26_1.logicTarget] or luaLang("logic_target_single")
	local var_26_1 = FightEnum.EffectTagDesc[arg_26_1.effectTag] or ""

	return var_26_0 .. var_26_1
end

function var_0_0._formatSkillDesc(arg_27_0, arg_27_1)
	return string.gsub(arg_27_1, "(%d+%%*)", "<color=#DC6262><size=26>%1</size></color>")
end

function var_0_0._formatPassiveSkillDesc(arg_28_0, arg_28_1)
	return
end

function var_0_0._onShowFightPrompt(arg_29_0, arg_29_1, arg_29_2)
	TaskDispatcher.cancelTask(arg_29_0._hidePrompt, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._playPromptCloseAnim, arg_29_0)

	local var_29_0 = lua_fight_prompt.configDict[arg_29_1]

	gohelper.setActive(arg_29_0._gofightspecialtip, true)

	arg_29_0._promptText.text = var_29_0.content

	UISpriteSetMgr.instance:setFightSprite(arg_29_0._promptImage, "img_tsk_" .. var_29_0.color)
	arg_29_0._prompAni:Play("open", 0, 0)

	if arg_29_2 then
		TaskDispatcher.runDelay(arg_29_0._playPromptCloseAnim, arg_29_0, arg_29_2 / 1000)
	end
end

function var_0_0._playPromptCloseAnim(arg_30_0)
	arg_30_0._prompAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_30_0._hidePrompt, arg_30_0, 0.0005)
end

function var_0_0._hidePrompt(arg_31_0)
	gohelper.setActive(arg_31_0._gofightspecialtip, false)
end

function var_0_0._onShowSeasonGuardIntro(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0._guardTipsRoot = arg_32_0._guardTipsRoot

	if not arg_32_0._guardTipsRoot then
		arg_32_0._guardTipsRoot = gohelper.create2d(arg_32_0._tipsRoot, "guardTips")

		arg_32_0._loader:loadAsset("ui/viewres/fight/fightseasonguardtipsview.prefab", arg_32_0._onGuardTipsLoadFinish, arg_32_0)

		arg_32_0._guardTipsTran = arg_32_0._guardTipsRoot.transform
	end

	gohelper.setActive(arg_32_0._guardTipsRoot, true)

	arg_32_2 = arg_32_2 + 307

	recthelper.setAnchor(arg_32_0._guardTipsTran, arg_32_2, arg_32_3)
end

function var_0_0._onGuardTipsLoadFinish(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_1 then
		return
	end

	local var_33_0 = arg_33_2:GetResource()
	local var_33_1 = gohelper.clone(var_33_0, arg_33_0._guardTipsRoot)
	local var_33_2 = gohelper.findChildText(var_33_1, "#scroll_ShieldTips/viewport/content/#go_shieldtipsitem/layout/#txt_title")
	local var_33_3 = gohelper.findChildText(var_33_1, "#scroll_ShieldTips/viewport/content/#go_shieldtipsitem/layout/#txt_dec")
	local var_33_4 = lua_activity166_const_global.configDict[109]

	var_33_2.text = var_33_4 and var_33_4.value2 or ""

	local var_33_5 = lua_activity166_const_global.configDict[110]

	var_33_3.text = var_33_5 and var_33_5.value2 or ""
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0.buffTipClick:RemoveClickListener()

	arg_34_0.buffTipClick = nil
end

return var_0_0
