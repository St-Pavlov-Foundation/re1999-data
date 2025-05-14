module("modules.ugui.icon.common.CommonHeroItem", package.seeall)

local var_0_0 = class("CommonHeroItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._btnClick = gohelper.getClick(arg_1_1)
	arg_1_0._lvObj = gohelper.findChild(arg_1_1, "lv")
	arg_1_0._lvTxt = gohelper.findChildText(arg_1_1, "lv/lvltxt")
	arg_1_0._lvTxtEn = gohelper.findChildText(arg_1_1, "lv/lv")
	arg_1_0._nameCnTxt = gohelper.findChildText(arg_1_1, "namecn")
	arg_1_0._nameEnTxt = gohelper.findChildText(arg_1_1, "nameen")
	arg_1_0._newObj = gohelper.findChild(arg_1_1, "new")
	arg_1_0._gofavor = gohelper.findChild(arg_1_1, "favor")
	arg_1_0._rankObj = gohelper.findChild(arg_1_1, "rankobj")
	arg_1_0._rankObjEmpty = gohelper.findChild(arg_1_1, "verticalList/lvnum/rankobj_empty") or gohelper.findChild(arg_1_1, "rankobj")
	arg_1_0._breakObj = gohelper.findChild(arg_1_1, "breakobj")
	arg_1_0._maskgray = gohelper.findChild(arg_1_1, "maskgray")
	arg_1_0._cardIcon = gohelper.findChild(arg_1_1, "mask/charactericon") or gohelper.findChild(arg_1_1, "charactericon")
	arg_1_0._careerIcon = gohelper.findChildImage(arg_1_1, "career")
	arg_1_0._injury1 = gohelper.findChild(arg_1_1, "deephurt")
	arg_1_0._gohurtcn = gohelper.findChild(arg_1_1, "deephurt/hurtcn")
	arg_1_0._gohurten = gohelper.findChild(arg_1_1, "deephurt/hurten")
	arg_1_0._gorestrict = gohelper.findChild(arg_1_1, "restrict")
	arg_1_0._selectframe = gohelper.findChild(arg_1_1, "selectframe")
	arg_1_0._injuryselectframe = gohelper.findChild(arg_1_1, "injuryselectframe")
	arg_1_0._front = gohelper.findChildImage(arg_1_1, "mask/front") or gohelper.findChildImage(arg_1_1, "front")
	arg_1_0._gobuff = gohelper.findChild(arg_1_1, "#go_buff")
	arg_1_0._imagebuff = gohelper.findChildImage(arg_1_1, "#go_buff/#image_buff") or gohelper.findChildImage(arg_1_1, "#image_buff")
	arg_1_0._simagebufftuan = gohelper.findChildSingleImage(arg_1_1, "#go_buff/#simage_bufftuan") or gohelper.findChildSingleImage(arg_1_1, "#simage_bufftuan")
	arg_1_0._goheroitemreddot = gohelper.findChild(arg_1_1, "#go_heroitemreddot")
	arg_1_0._goexskill = gohelper.findChild(arg_1_1, "#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_1, "#go_exskill/#image_exskill")
	arg_1_0._inteam = gohelper.findChild(arg_1_1, "inteam")
	arg_1_0._current = gohelper.findChild(arg_1_1, "current")
	arg_1_0._aid = gohelper.findChild(arg_1_1, "aid")
	arg_1_0._gochoose = gohelper.findChild(arg_1_1, "#go_choose")
	arg_1_0._go1st = gohelper.findChild(arg_1_1, "#go_choose/#go_1st")
	arg_1_0._go2nd = gohelper.findChild(arg_1_1, "#go_choose/#go_2nd")
	arg_1_0._go3rd = gohelper.findChild(arg_1_1, "#go_choose/#go_3rd")
	arg_1_0._goeffect = gohelper.findChild(arg_1_1, "effect")
	arg_1_0._gorareEffect1 = gohelper.findChild(arg_1_1, "effect/r")
	arg_1_0._gorareEffect2 = gohelper.findChild(arg_1_1, "effect/sr")
	arg_1_0._gorareEffect3 = gohelper.findChild(arg_1_1, "effect/ssr")
	arg_1_0._goTrialTag = gohelper.findChild(arg_1_1, "trialTag")
	arg_1_0._txtTrialTag = gohelper.findChildTextMesh(arg_1_1, "trialTag/#txt_trialTag")
	arg_1_0._goTrialRepeat = gohelper.findChild(arg_1_1, "trialRepeat")
	arg_1_0._animRepeat = arg_1_0._goTrialRepeat:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:_initObj()

	arg_1_0._commonHeroCard = CommonHeroCard.create(arg_1_0._cardIcon, arg_1_0.__cname)
	arg_1_0._goSeasonMask = gohelper.findChild(arg_1_1, "seasonmask")
	arg_1_0._goCenterTxt = gohelper.findChild(arg_1_1, "centerTxt")
	arg_1_0._txtCenterTxt = gohelper.findChildTextMesh(arg_1_1, "centerTxt/txtcn")
	arg_1_0.goLost = gohelper.findChild(arg_1_1, "lost")
end

function var_0_0._initObj(arg_2_0)
	arg_2_0._hideFavor = false

	if arg_2_0._breakObj then
		arg_2_0._breakImgs = {}

		for iter_2_0 = 1, 6 do
			arg_2_0._breakImgs[iter_2_0] = gohelper.findChildImage(arg_2_0._breakObj, "break" .. tostring(iter_2_0))
		end
	end

	arg_2_0._rankGOs = arg_2_0:getUserDataTb_()
	arg_2_0._rankEmptyGOs = arg_2_0:getUserDataTb_()

	if arg_2_0._rankGOs then
		for iter_2_1 = 1, 3 do
			local var_2_0 = gohelper.findChildImage(arg_2_0._rankObj, "rank" .. iter_2_1)
			local var_2_1 = gohelper.findChildImage(arg_2_0._rankObjEmpty, "rank" .. iter_2_1)

			table.insert(arg_2_0._rankGOs, var_2_0)
			table.insert(arg_2_0._rankEmptyGOs, var_2_1)
		end
	end

	arg_2_0._rareEffectGOs = arg_2_0:getUserDataTb_()

	table.insert(arg_2_0._rareEffectGOs, arg_2_0._gorareEffect1)
	table.insert(arg_2_0._rareEffectGOs, arg_2_0._gorareEffect2)
	table.insert(arg_2_0._rareEffectGOs, arg_2_0._gorareEffect3)

	for iter_2_2, iter_2_3 in ipairs(arg_2_0._rareEffectGOs) do
		gohelper.setActive(iter_2_3, false)
	end

	arg_2_0._callback = nil
	arg_2_0._callbackObj = nil

	gohelper.setActive(arg_2_0._injury1, false)
	gohelper.setActive(arg_2_0._gorestrict, false)
	gohelper.setActive(arg_2_0._selectframe, false)
	gohelper.setActive(arg_2_0._injuryselectframe, false)
	gohelper.setActive(arg_2_0._gobuff, false)
	gohelper.setActive(arg_2_0._inteam, false)
	gohelper.setActive(arg_2_0._current, false)
	gohelper.setActive(arg_2_0._aid, false)
	gohelper.setActive(arg_2_0._gochoose, false)
	gohelper.setActive(arg_2_0._rankObj, true)
	gohelper.setActive(arg_2_0._rankObjEmpty, true)
	gohelper.setActive(arg_2_0._goTrialTag, false)
	gohelper.setActive(arg_2_0._goTrialRepeat, false)
	gohelper.setActive(arg_2_0._goCenterTxt, false)

	arg_2_0.injuryAnim = arg_2_0._injury1:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0.exSkillFillAmount = {
		0.2,
		0.4,
		0.6,
		0.79,
		1
	}

	arg_2_0:isShowSeasonMask(false)
end

function var_0_0.addClickListener(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._callback = arg_3_1
	arg_3_0._callbackObj = arg_3_2
end

function var_0_0.addClickDownListener(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._clickDownCallback = arg_4_1
	arg_4_0._clickDownCallbackObj = arg_4_2
end

function var_0_0.addClickUpListener(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._clickUpCallback = arg_5_1
	arg_5_0._clickUpCallbackObj = arg_5_2
end

function var_0_0.addEventListeners(arg_6_0)
	arg_6_0._btnClick:AddClickListener(arg_6_0._onItemClick, arg_6_0)
	arg_6_0._btnClick:AddClickDownListener(arg_6_0._onItemClickDown, arg_6_0)
	arg_6_0._btnClick:AddClickUpListener(arg_6_0._onItemClickUp, arg_6_0)
end

function var_0_0.removeEventListeners(arg_7_0)
	arg_7_0._btnClick:RemoveClickListener()
	arg_7_0._btnClick:RemoveClickUpListener()
	arg_7_0._btnClick:RemoveClickDownListener()
end

function var_0_0._onItemClick(arg_8_0)
	if arg_8_0._callback then
		if arg_8_0._callbackObj then
			arg_8_0._callback(arg_8_0._callbackObj, arg_8_0._mo)
		else
			arg_8_0._callback(arg_8_0._mo)
		end
	end
end

function var_0_0._onItemClickDown(arg_9_0)
	if arg_9_0._clickDownCallback and arg_9_0._clickDownCallbackObj then
		arg_9_0._clickDownCallback(arg_9_0._clickDownCallbackObj)
	end
end

function var_0_0._onItemClickUp(arg_10_0)
	if arg_10_0._clickUpCallback and arg_10_0._clickUpCallbackObj then
		arg_10_0._clickUpCallback(arg_10_0._clickUpCallbackObj)
	end
end

function var_0_0.setLevel(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 and arg_11_2 == arg_11_0._mo.heroId then
		arg_11_0._lvTxt.text = HeroConfig.instance:getShowLevel(arg_11_1)
	else
		arg_11_0._lvTxt.text = HeroConfig.instance:getShowLevel(arg_11_0._mo.level)
	end
end

function var_0_0.setTrialTxt(arg_12_0, arg_12_1)
	if arg_12_1 then
		gohelper.setActive(arg_12_0._goTrialTag, true)

		arg_12_0._txtTrialTag.text = arg_12_1
	else
		gohelper.setActive(arg_12_0._goTrialTag, false)
	end
end

function var_0_0.setBalanceLv(arg_13_0, arg_13_1)
	local var_13_0, var_13_1 = HeroConfig.instance:getShowLevel(arg_13_1)

	arg_13_0._lvTxt.text = "<color=#bfdaff>" .. var_13_0

	if arg_13_0._lvTxtEn then
		SLFramework.UGUI.GuiHelper.SetColor(arg_13_0._lvTxtEn, "#bfdaff")
	end

	if arg_13_0._rankObj then
		arg_13_0:_fillStarContent(arg_13_0._mo.config.rare, var_13_1, true)
	end
end

function var_0_0.setTrialRepeat(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._goTrialRepeat, arg_14_1)
end

function var_0_0.setRepeatAnimFinish(arg_15_0)
	if not arg_15_0._goTrialRepeat.activeSelf then
		return
	end

	arg_15_0._animRepeat:Play(UIAnimationName.Open, 0, 1)
end

function var_0_0.getIsRepeat(arg_16_0)
	return arg_16_0._goTrialRepeat.activeSelf
end

function var_0_0.hideFavor(arg_17_0, arg_17_1)
	arg_17_0._hideFavor = arg_17_1
end

function var_0_0.onUpdateMO(arg_18_0, arg_18_1)
	arg_18_0._mo = arg_18_1

	local var_18_0 = CharacterModel.instance:getFakeLevel(arg_18_0._mo.heroId) or arg_18_1.level

	arg_18_0._lvTxt.text = HeroConfig.instance:getShowLevel(var_18_0)

	if arg_18_0._lvTxtEn then
		SLFramework.UGUI.GuiHelper.SetColor(arg_18_0._lvTxtEn, "#E9E9E9")
	end

	if arg_18_0._nameCnTxt then
		arg_18_0._nameCnTxt.text = arg_18_1:getHeroName()
	end

	if arg_18_0._nameEnTxt then
		arg_18_0._nameEnTxt.text = arg_18_1.config.nameEng
	end

	if arg_18_0._newObj then
		gohelper.setActive(arg_18_0._newObj, arg_18_1.isNew)
	end

	if arg_18_0._gofavor then
		gohelper.setActive(arg_18_0._gofavor, arg_18_1.isFavor and not arg_18_0._hideFavor)
	end

	if arg_18_0._breakObj then
		arg_18_0:_fillBreakContent(arg_18_1.exSkillLevel)
	end

	if arg_18_0._rankObj then
		arg_18_0:_fillStarContent(arg_18_1.config.rare, arg_18_1.rank)
	end

	arg_18_0:updateHero()
	arg_18_0:_updateExSkill()
end

function var_0_0.setAdventureBuff(arg_19_0, arg_19_1)
	return
end

function var_0_0.setHeroGroupType(arg_20_0)
	arg_20_0._heroGroupType = true
end

function var_0_0.updateHero(arg_21_0)
	if arg_21_0._heroGroupType then
		UISpriteSetMgr.instance:setHeroGroupSprite(arg_21_0._front, "bg_pz00" .. tostring(CharacterEnum.Color[arg_21_0._mo.config.rare]))
	else
		UISpriteSetMgr.instance:setCommonSprite(arg_21_0._front, "bg_pz00" .. tostring(CharacterEnum.Color[arg_21_0._mo.config.rare]))
		arg_21_0:_showRareEffect(CharacterEnum.Color[arg_21_0._mo.config.rare])
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_21_0._careerIcon, "lssx_" .. tostring(arg_21_0._mo.config.career))

	local var_21_0 = HeroModel.instance:getByHeroId(arg_21_0._mo.heroId)
	local var_21_1 = SkinConfig.instance:getSkinCo(arg_21_0._mo.skin or var_21_0.skin)

	if not var_21_1 then
		logError("找不到皮肤配置, id: " .. tostring(var_21_0.skin))

		return
	end

	arg_21_0._commonHeroCard:onUpdateMO(var_21_1)
end

function var_0_0._updateExSkill(arg_22_0)
	if arg_22_0._mo.exSkillLevel <= 0 then
		gohelper.setActive(arg_22_0._goexskill, false)

		return
	end

	gohelper.setActive(arg_22_0._goexskill, true)

	arg_22_0._imageexskill.fillAmount = arg_22_0.exSkillFillAmount[arg_22_0._mo.exSkillLevel] or 1
end

function var_0_0.setExSkillActive(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0._goexskill, arg_23_1)
end

function var_0_0._showRareEffect(arg_24_0, arg_24_1)
	for iter_24_0 = 1, 3 do
		gohelper.setActive(arg_24_0._rareEffectGOs[iter_24_0], arg_24_1 - 3 == iter_24_0)
	end
end

function var_0_0.setEffectVisible(arg_25_0, arg_25_1)
	gohelper.setActive(arg_25_0._goeffect, arg_25_1)
end

function var_0_0.setInjuryTxtVisible(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._injury1, arg_26_1)
end

function var_0_0.setInjury(arg_27_0, arg_27_1)
	gohelper.setActive(arg_27_0._injury1, arg_27_1)
	arg_27_0:setDamage(arg_27_1)
end

function var_0_0.setDamage(arg_28_0, arg_28_1)
	ZProj.UGUIHelper.SetGrayscale(arg_28_0._careerIcon.gameObject, arg_28_1)
	ZProj.UGUIHelper.SetGrayscale(arg_28_0._front.gameObject, arg_28_1)

	arg_28_0._isInjury = arg_28_1

	if arg_28_1 then
		if not CommonHeroHelper.instance:getGrayState(arg_28_0._mo.config.id) then
			TaskDispatcher.runDelay(arg_28_0.onInjuryAnimFinished, arg_28_0, 0.5)

			arg_28_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.8, arg_28_0.setGrayFactor, nil, arg_28_0)

			CommonHeroHelper.instance:setGrayState(arg_28_0._mo.config.id, true)
		else
			arg_28_0._commonHeroCard:setGrayFactor(1)
			arg_28_0._commonHeroCard:setGrayScale(true)
			arg_28_0:onInjuryAnimFinished()
		end
	else
		if arg_28_0.tweenid then
			ZProj.TweenHelper.KillById(arg_28_0.tweenid)
			TaskDispatcher.cancelTask(arg_28_0.onInjuryAnimFinished, arg_28_0)
		end

		arg_28_0._commonHeroCard:setGrayScale(false)
	end
end

function var_0_0.setRestrict(arg_29_0, arg_29_1)
	gohelper.setActive(arg_29_0._gorestrict, arg_29_1)

	arg_29_0._isInjury = false
	arg_29_0._isRestrict = arg_29_1

	gohelper.setActive(arg_29_0._gohurtcn, not arg_29_1)
	gohelper.setActive(arg_29_0._gohurten, not arg_29_1)
end

function var_0_0.setGrayFactor(arg_30_0, arg_30_1)
	arg_30_0._commonHeroCard:setGrayFactor(arg_30_1)
end

function var_0_0.onInjuryAnimFinished(arg_31_0)
	arg_31_0.injuryAnim:Play(UIAnimationName.Idle, 0, 1)
end

function var_0_0.setSelect(arg_32_0, arg_32_1)
	if arg_32_0._isRestrict then
		gohelper.setActive(arg_32_0._injuryselectframe, false)
		gohelper.setActive(arg_32_0._selectframe, false)

		return
	end

	if arg_32_0._isInjury then
		gohelper.setActive(arg_32_0._injuryselectframe, arg_32_1)
	else
		gohelper.setActive(arg_32_0._selectframe, arg_32_1)
	end
end

function var_0_0.setLevelContentShow(arg_33_0, arg_33_1)
	gohelper.setActive(arg_33_0._lvObj, arg_33_1)
	gohelper.setActive(arg_33_0._lvTxt and arg_33_0._lvTxt.gameObject, arg_33_1)
end

function var_0_0.setNameContentShow(arg_34_0, arg_34_1)
	gohelper.setActive(arg_34_0._nameCnTxt.gameObject, arg_34_1)
	gohelper.setActive(arg_34_0._nameEnTxt.gameObject, arg_34_1)
end

function var_0_0.setRedDotShow(arg_35_0, arg_35_1)
	if arg_35_0._mo.isNew then
		arg_35_1 = false
	end

	gohelper.setActive(arg_35_0._goheroitemreddot, arg_35_1)
end

function var_0_0.setInteam(arg_36_0, arg_36_1)
	gohelper.setActive(arg_36_0._inteam, false)
	gohelper.setActive(arg_36_0._current, false)
	gohelper.setActive(arg_36_0._aid, false)

	if arg_36_1 == 1 then
		gohelper.setActive(arg_36_0._inteam, true)
	elseif arg_36_1 == 2 then
		gohelper.setActive(arg_36_0._current, true)
	elseif arg_36_1 == 3 then
		gohelper.setActive(arg_36_0._aid, true)
	end
end

function var_0_0.setChoose(arg_37_0, arg_37_1)
	gohelper.setActive(arg_37_0._gochoose, arg_37_1)
	gohelper.setActive(arg_37_0._go1st, false)
	gohelper.setActive(arg_37_0._go2nd, false)
	gohelper.setActive(arg_37_0._go3rd, false)

	if arg_37_1 == 1 then
		gohelper.setActive(arg_37_0._go1st, true)
	elseif arg_37_1 == 2 then
		gohelper.setActive(arg_37_0._go2nd, true)
	elseif arg_37_1 == 3 then
		gohelper.setActive(arg_37_0._go3rd, true)
	end
end

function var_0_0.setNewShow(arg_38_0, arg_38_1)
	if arg_38_0._newObj then
		gohelper.setActive(arg_38_0._newObj, arg_38_1)
	end
end

function var_0_0.isShowSeasonMask(arg_39_0, arg_39_1)
	if gohelper.isNil(arg_39_0._goSeasonMask) then
		return
	end

	gohelper.setActive(arg_39_0._goSeasonMask, arg_39_1)
end

function var_0_0._fillBreakContent(arg_40_0, arg_40_1)
	for iter_40_0 = 1, 6 do
		if iter_40_0 <= arg_40_1 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_40_0._breakImgs[iter_40_0], "#d7a93d")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_40_0._breakImgs[iter_40_0], "#626467")
		end
	end
end

function var_0_0._fillStarContent(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	for iter_41_0 = 1, 3 do
		local var_41_0 = arg_41_0._rankGOs[iter_41_0]
		local var_41_1 = arg_41_0._rankEmptyGOs[iter_41_0]

		if arg_41_3 then
			if var_41_0 then
				SLFramework.UGUI.GuiHelper.SetColor(var_41_0, "#a9c7f1")
			end

			if var_41_1 then
				SLFramework.UGUI.GuiHelper.SetColor(var_41_1, "#a9c7f1")
			end
		else
			if var_41_0 then
				SLFramework.UGUI.GuiHelper.SetColor(var_41_0, "#F6F3EC")
			end

			if var_41_1 then
				SLFramework.UGUI.GuiHelper.SetColor(var_41_1, "#F6F3EC")
			end
		end

		gohelper.setActive(var_41_0, iter_41_0 == arg_41_2 - 1)
		gohelper.setActive(var_41_1, iter_41_0 == arg_41_2 - 1)
	end
end

function var_0_0._fillStarContentColor(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	for iter_42_0 = 1, 3 do
		local var_42_0 = arg_42_0._rankGOs[iter_42_0]
		local var_42_1 = arg_42_0._rankEmptyGOs[iter_42_0]

		if var_42_0 then
			SLFramework.UGUI.GuiHelper.SetColor(var_42_0, arg_42_3 or arg_42_4)
		end

		if var_42_1 then
			SLFramework.UGUI.GuiHelper.SetColor(var_42_1, arg_42_3 or arg_42_4)
		end

		gohelper.setActive(var_42_0, iter_42_0 == arg_42_2 - 1)
		gohelper.setActive(var_42_1, iter_42_0 == arg_42_2 - 1)
	end
end

function var_0_0._setTranScale(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	if not arg_43_0[arg_43_1] then
		return
	end

	transformhelper.setLocalScale(arg_43_0[arg_43_1].transform, arg_43_2 or 1, arg_43_3 or 1, arg_43_4 or 1)
end

function var_0_0._setTxtPos(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	if not arg_44_0[arg_44_1] then
		return
	end

	recthelper.setAnchor(arg_44_0[arg_44_1].transform, arg_44_2, arg_44_3)
end

function var_0_0.setRankObjEmptyShow(arg_45_0, arg_45_1)
	gohelper.setActive(arg_45_0._rankObj, arg_45_1)
	gohelper.setActive(arg_45_0._rankObjEmpty, not arg_45_1)
end

function var_0_0.setRankObjActive(arg_46_0, arg_46_1)
	gohelper.setActive(arg_46_0._rankObj, arg_46_1)
	gohelper.setActive(arg_46_0._rankObjEmpty, arg_46_1)
end

function var_0_0.setCenterTxt(arg_47_0, arg_47_1)
	if arg_47_1 then
		gohelper.setActive(arg_47_0._goCenterTxt, true)

		arg_47_0._txtCenterTxt.text = arg_47_1
	else
		gohelper.setActive(arg_47_0._goCenterTxt, false)
	end
end

function var_0_0.setLost(arg_48_0, arg_48_1)
	gohelper.setActive(arg_48_0.goLost, arg_48_1)
	arg_48_0:setDamage(arg_48_1)
end

function var_0_0.onDestroy(arg_49_0)
	if arg_49_0._simagebufftuan then
		arg_49_0._simagebufftuan:UnLoadImage()

		arg_49_0._simagebufftuan = nil
	end

	arg_49_0._callback = nil
	arg_49_0._callbackObj = nil
	arg_49_0._careerIcon = nil
	arg_49_0._front = nil
	arg_49_0._frame = nil

	TaskDispatcher.cancelTask(arg_49_0.onInjuryAnimFinished, arg_49_0)

	if arg_49_0.tweenid then
		ZProj.TweenHelper.KillById(arg_49_0.tweenid)
	end
end

return var_0_0
