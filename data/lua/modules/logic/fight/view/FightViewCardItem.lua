module("modules.logic.fight.view.FightViewCardItem", package.seeall)

local var_0_0 = class("FightViewCardItem", LuaCompBase)

var_0_0.TagPosForLvs = nil

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.handCardType = arg_1_1 or FightEnum.CardShowType.Default
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._canvasGroup = arg_2_1:GetComponent(gohelper.Type_CanvasGroup)
	arg_2_0.tr = arg_2_1.transform
	arg_2_0._lvGOs = arg_2_0:getUserDataTb_()
	arg_2_0._lvImgIcons = arg_2_0:getUserDataTb_()
	arg_2_0._lvImgComps = arg_2_0:getUserDataTb_()
	arg_2_0._starItemCanvas = arg_2_0:getUserDataTb_()
	arg_2_0.skillIconBg = arg_2_0:getUserDataTb_()
	arg_2_0.attributeBg = arg_2_0:getUserDataTb_()

	for iter_2_0 = 0, 4 do
		local var_2_0 = gohelper.findChild(arg_2_1, "lv" .. iter_2_0)
		local var_2_1 = gohelper.findChildSingleImage(var_2_0, "imgIcon")
		local var_2_2 = gohelper.findChildImage(var_2_0, "imgIcon")

		gohelper.setActive(var_2_0, true)

		arg_2_0._lvGOs[iter_2_0] = var_2_0
		arg_2_0._lvImgIcons[iter_2_0] = var_2_1
		arg_2_0._lvImgComps[iter_2_0] = var_2_2

		local var_2_3 = gohelper.findChild(var_2_0, "image")

		arg_2_0.attributeBg[iter_2_0] = var_2_3

		local var_2_4 = gohelper.findChild(var_2_0, "bg")

		arg_2_0.skillIconBg[iter_2_0] = var_2_4
	end

	if not var_0_0.TagPosForLvs then
		var_0_0.TagPosForLvs = {}

		for iter_2_1 = 0, 4 do
			local var_2_5, var_2_6 = recthelper.getAnchor(gohelper.findChild(arg_2_1, "tag/pos" .. iter_2_1).transform)

			var_0_0.TagPosForLvs[iter_2_1] = {
				var_2_5,
				var_2_6
			}
		end
	end

	arg_2_0.goTag = gohelper.findChild(arg_2_1, "tag")
	arg_2_0.tagCanvas = gohelper.onceAddComponent(arg_2_0.goTag, typeof(UnityEngine.CanvasGroup))
	arg_2_0._tagRootTr = gohelper.findChild(arg_2_1, "tag/tag").transform
	arg_2_0._tag = gohelper.findChildSingleImage(arg_2_1, "tag/tag/tagIcon")
	arg_2_0.tagTransform = arg_2_0._tag.transform
	arg_2_0._txt = gohelper.findChildText(arg_2_1, "Text")
	arg_2_0._starGO = gohelper.findChild(arg_2_1, "star")
	arg_2_0._starCanvas = gohelper.onceAddComponent(arg_2_0._starGO, typeof(UnityEngine.CanvasGroup))
	arg_2_0._innerStartGOs = arg_2_0:getUserDataTb_()

	for iter_2_2 = 1, FightEnum.MaxSkillCardLv do
		local var_2_7 = gohelper.findChild(arg_2_1, "star/star" .. iter_2_2)

		table.insert(arg_2_0._innerStartGOs, var_2_7)
		table.insert(arg_2_0._starItemCanvas, gohelper.onceAddComponent(var_2_7, typeof(UnityEngine.CanvasGroup)))
	end

	arg_2_0._layout = gohelper.findChild(arg_2_0.go, "layout")

	gohelper.setActive(arg_2_0._layout, true)

	arg_2_0._predisplay = gohelper.findChild(arg_2_1, "layout/predisplay")
	arg_2_0._cardAni = gohelper.onceAddComponent(arg_2_1, typeof(UnityEngine.Animator))
	arg_2_0._cardAppearEffectRoot = gohelper.findChild(arg_2_1, "cardAppearEffectRoot")
	arg_2_0._cardMask = gohelper.findChild(arg_2_1, "cardmask")
	arg_2_0._maskList = arg_2_0:getUserDataTb_()

	for iter_2_3 = 1, 4 do
		table.insert(arg_2_0._maskList, gohelper.findChild(arg_2_0._cardMask, "lv" .. iter_2_3))
	end

	arg_2_0._resistanceComp = MonoHelper.addLuaComOnceToGo(arg_2_0.go, FightViewCardItemResistance, arg_2_0)
	arg_2_0._loader = arg_2_0._loader or FightLoaderComponent.New()
	arg_2_0._countRoot = gohelper.findChild(arg_2_0.go, "layout/count")
	arg_2_0._countText = gohelper.findChildText(arg_2_0.go, "layout/count/#txt_count")

	gohelper.setActive(arg_2_0._countRoot, false)

	arg_2_0._abandon = gohelper.findChild(arg_2_0.go, "layout/abandon")

	gohelper.setActive(arg_2_0._abandon, false)

	arg_2_0._blockadeTwo = gohelper.findChild(arg_2_0.go, "#go_enchant_effect")

	gohelper.setActive(arg_2_0._blockadeTwo, false)

	arg_2_0._blockadeOne = gohelper.findChild(arg_2_0.go, "#go_enchant_uneffect")

	gohelper.setActive(arg_2_0._blockadeOne, false)

	arg_2_0._precision = gohelper.findChild(arg_2_0.go, "AccurateEnchant")

	gohelper.setActive(arg_2_0._precision, false)

	arg_2_0._precisionEffect = gohelper.findChild(arg_2_0.go, "AccurateEnchant/effect")

	gohelper.setActive(arg_2_0._precisionEffect, false)

	arg_2_0.showASFD = false
	arg_2_0.goASFD = gohelper.findChild(arg_2_1, "asfd_icon")
	arg_2_0.txtASFDEnergy = gohelper.findChildText(arg_2_1, "asfd_icon/#txt_Num")
	arg_2_0.goASFDSkill = gohelper.findChild(arg_2_1, "asfd")
	arg_2_0.asfdSkillSimage = gohelper.findChildSingleImage(arg_2_1, "asfd/imgIcon")
	arg_2_0.asfdNumTxt = gohelper.findChildText(arg_2_1, "asfd/#txt_Num")
	arg_2_0.goPreDelete = gohelper.findChild(arg_2_1, "go_predelete")
	arg_2_0.goPreDeleteNormal = gohelper.findChild(arg_2_1, "go_predelete/normal")
	arg_2_0.goPreDeleteUnique = gohelper.findChild(arg_2_1, "go_predelete/ultimate")
	arg_2_0.goPreDeleteLeft = gohelper.findChild(arg_2_1, "go_predelete/Left")
	arg_2_0.goPreDeleteRight = gohelper.findChild(arg_2_1, "go_predelete/Right")
	arg_2_0.goPreDeleteBoth = gohelper.findChild(arg_2_1, "go_predelete/Both")

	arg_2_0:resetPreDelete()

	arg_2_0.goPreDeleteCard = gohelper.findChild(arg_2_1, "go_predeletecard")

	gohelper.setActive(arg_2_0.goPreDeleteCard, false)

	arg_2_0.goRedAndBlue = gohelper.findChild(arg_2_1, "#go_Liangyue")
	arg_2_0.goLyMask = gohelper.findChild(arg_2_1, "#go_Liangyue/mask")
	arg_2_0.goRed = gohelper.findChild(arg_2_1, "#go_Liangyue/red")
	arg_2_0.goBlue = gohelper.findChild(arg_2_1, "#go_Liangyue/green")
	arg_2_0.goBoth = gohelper.findChild(arg_2_1, "#go_Liangyue/both")

	arg_2_0:resetRedAndBlue()

	arg_2_0._heatRoot = gohelper.findChild(arg_2_1, "#go_heat")
	arg_2_0.goBloodPool = gohelper.findChild(arg_2_1, "blood_pool")
	arg_2_0.xingtiTxt = gohelper.findChildText(arg_2_1, "txt_xingti")
	arg_2_0.xingtiGo = arg_2_0.xingtiTxt.gameObject
	arg_2_0.alfLoadStatus = var_0_0.AlfLoadStatus.None
	arg_2_0.useSkin = false

	if (arg_2_0.handCardType == FightEnum.CardShowType.HandCard or arg_2_0.handCardType == FightEnum.CardShowType.Operation or arg_2_0.handCardType == FightEnum.CardShowType.PlayCard) and FightCardDataHelper.getCardSkin() == 672801 then
		arg_2_0.useSkin = true
	end

	if arg_2_0.useSkin then
		local var_2_8 = gohelper.create2d(arg_2_1, "skinFrontBg")

		arg_2_0.frontBgRoot = var_2_8

		gohelper.setActive(var_2_8, true)
		gohelper.setSibling(var_2_8, 5)

		local var_2_9 = gohelper.create2d(var_2_8, "skinFrontBgNormal")
		local var_2_10 = gohelper.create2d(var_2_8, "skinFrontBgBigSkill")

		arg_2_0.frontBgNormal = var_2_9
		arg_2_0.frontBgBigSkill = var_2_10
		arg_2_0.imgFrontBgNormal = gohelper.onceAddComponent(var_2_9, gohelper.Type_Image)
		arg_2_0.imgFrontBgBigSkill = gohelper.onceAddComponent(var_2_10, gohelper.Type_Image)

		UISpriteSetMgr.instance:setFightSkillCardSprite(arg_2_0.imgFrontBgNormal, "card_dz4", true)
		UISpriteSetMgr.instance:setFightSkillCardSprite(arg_2_0.imgFrontBgBigSkill, "card_dz", true)
		recthelper.setAnchorY(var_2_9.transform, -14)
		recthelper.setAnchorY(var_2_10.transform, 20)

		local var_2_11 = gohelper.create2d(arg_2_1, "skinBackBg")

		arg_2_0.backBgRoot = var_2_11

		gohelper.setActive(var_2_11, true)
		gohelper.setSibling(var_2_11, 0)

		local var_2_12 = gohelper.onceAddComponent(var_2_11, gohelper.Type_Image)

		UISpriteSetMgr.instance:setFightSkillCardSprite(var_2_12, "card_dz3", true)

		for iter_2_4 = 1, #arg_2_0._innerStartGOs do
			local var_2_13 = arg_2_0._innerStartGOs[iter_2_4].transform

			for iter_2_5 = 0, var_2_13.childCount - 1 do
				local var_2_14 = var_2_13:GetChild(iter_2_5)
				local var_2_15 = var_2_14.name
				local var_2_16 = gohelper.onceAddComponent(var_2_14.gameObject, gohelper.Type_Image)

				if var_2_15 == "light" then
					UISpriteSetMgr.instance:setFightSkillCardSprite(var_2_16, "xx1", true)
				elseif var_2_15 == "lightblue" then
					UISpriteSetMgr.instance:setFightSkillCardSprite(var_2_16, "xx3", true)
				else
					UISpriteSetMgr.instance:setFightSkillCardSprite(var_2_16, "xx2", true)
				end
			end
		end

		for iter_2_6 = 0, 4 do
			gohelper.setActive(arg_2_0.skillIconBg[iter_2_6], false)
			gohelper.setActive(arg_2_0.attributeBg[iter_2_6], false)
		end
	end
end

function var_0_0.resetPreDelete(arg_3_0)
	gohelper.setActive(arg_3_0.goPreDeleteNormal, false)
	gohelper.setActive(arg_3_0.goPreDeleteUnique, false)
	gohelper.setActive(arg_3_0.goPreDeleteLeft, false)
	gohelper.setActive(arg_3_0.goPreDeleteRight, false)
	gohelper.setActive(arg_3_0.goPreDeleteBoth, false)
end

function var_0_0.resetRedAndBlue(arg_4_0)
	gohelper.setActive(arg_4_0.goRedAndBlue, true)
	gohelper.setActive(arg_4_0.goLyMask, false)
	gohelper.setActive(arg_4_0.goRed, false)
	gohelper.setActive(arg_4_0.goBlue, false)
	gohelper.setActive(arg_4_0.goBoth, false)
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.ASFD_EmitterEnergyChange, arg_5_0.onEmitterEnergyChange, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.UpdateBuffActInfo, arg_5_0.onUpdateBuffActInfo, arg_5_0)
end

function var_0_0.onUpdateBuffActInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3.actId ~= FightEnum.BuffActId.NoUseCardEnergyRecordByRound then
		return
	end

	arg_6_0:refreshXiTiSpecialSkill(arg_6_0.entityId, arg_6_0.skillId)
end

function var_0_0.onEmitterEnergyChange(arg_7_0)
	if not FightHelper.isASFDSkill(arg_7_0.skillId) then
		return
	end

	arg_7_0.asfdNumTxt.text = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	if arg_7_0._disappearFlow and arg_7_0._disappearFlow.status == WorkStatus.Running then
		return
	end

	if arg_7_0._dissolveFlow and arg_7_0._dissolveFlow.status == WorkStatus.Running then
		return
	end

	AudioMgr.instance:trigger(20248003)

	arg_7_0.asfdSkillAnimator = arg_7_0.asfdSkillAnimator or arg_7_0.goASFDSkill:GetComponent(gohelper.Type_Animator)

	arg_7_0.asfdSkillAnimator:Play("aggrandizement", 0, 0)
end

function var_0_0.resetAllNode(arg_8_0)
	local var_8_0 = arg_8_0.tr.childCount

	for iter_8_0 = 1, var_8_0 do
		local var_8_1 = arg_8_0.tr:GetChild(iter_8_0 - 1)

		gohelper.setActive(var_8_1.gameObject, false)
	end
end

function var_0_0.updateItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.entityId = arg_9_1
	arg_9_0.skillId = arg_9_2
	arg_9_0._cardInfoMO = arg_9_3

	arg_9_0:resetAllNode()
	gohelper.setActive(arg_9_0.go, true)
	gohelper.setActive(arg_9_0.goTag, true)
	gohelper.setActive(arg_9_0.goRedAndBlue, true)
	gohelper.setActive(arg_9_0._layout, true)
	gohelper.setActive(arg_9_0.frontBgRoot, true)
	gohelper.setActive(arg_9_0.backBgRoot, true)

	arg_9_0._canvasGroup.alpha = 1
	arg_9_0.tagCanvas.alpha = 1

	if FightHelper.isBloodPoolSkill(arg_9_2) then
		gohelper.setActive(arg_9_0.frontBgRoot, false)

		return arg_9_0:refreshBloodPoolSkill(arg_9_1, arg_9_2, arg_9_3)
	end

	if FightHelper.isASFDSkill(arg_9_2) then
		gohelper.setActive(arg_9_0.frontBgRoot, false)

		return arg_9_0:refreshASFDSkill(arg_9_1, arg_9_2, arg_9_3)
	end

	if FightHelper.isPreDeleteSkill(arg_9_2) then
		gohelper.setActive(arg_9_0.frontBgRoot, false)

		return arg_9_0:refreshPreDeleteSkill(arg_9_1, arg_9_2, arg_9_3)
	end

	arg_9_0:_hideAniEffect()

	local var_9_0 = lua_skill.configDict[arg_9_2]
	local var_9_1 = FightCardDataHelper.getSkillLv(arg_9_1, arg_9_2)

	for iter_9_0, iter_9_1 in pairs(arg_9_0._lvGOs) do
		gohelper.setActive(iter_9_1, true)
		gohelper.setActiveCanvasGroup(iter_9_1, var_9_1 == iter_9_0)
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0._lvImgIcons) do
		local var_9_2 = ResUrl.getSkillIcon(var_9_0.icon)

		if gohelper.isNil(arg_9_0._lvImgComps[iter_9_2].sprite) then
			iter_9_3:UnLoadImage()
		elseif iter_9_3.curImageUrl ~= var_9_2 then
			iter_9_3:UnLoadImage()
		end

		iter_9_3:LoadImage(var_9_2)
	end

	local var_9_3 = var_9_1 < FightEnum.UniqueSkillCardLv and var_9_1 > 0

	gohelper.setActive(arg_9_0._starGO, var_9_3)

	arg_9_0._starCanvas.alpha = 1

	for iter_9_4, iter_9_5 in ipairs(arg_9_0._innerStartGOs) do
		gohelper.setActive(iter_9_5, iter_9_4 == var_9_1)

		if arg_9_0._starItemCanvas[iter_9_4] then
			arg_9_0._starItemCanvas[iter_9_4].alpha = 1
		end
	end

	arg_9_0:refreshTag()

	arg_9_0._txt.text = var_9_0.id .. "\nLv." .. var_9_1

	local var_9_4 = var_9_1 == FightEnum.UniqueSkillCardLv

	if arg_9_0.useSkin then
		var_9_4 = false
	end

	if var_9_1 == FightEnum.UniqueSkillCardLv and not arg_9_0._uniqueCardEffect then
		local var_9_5 = ResUrl.getUIEffect(FightPreloadViewWork.ui_dazhaoka)
		local var_9_6 = FightHelper.getPreloadAssetItem(var_9_5)

		arg_9_0._uniqueCardEffect = gohelper.clone(var_9_6:GetResource(var_9_5), arg_9_0.go)
	end

	gohelper.setActive(arg_9_0._uniqueCardEffect, var_9_4)
	gohelper.setActive(arg_9_0.frontBgNormal, var_9_1 ~= FightEnum.UniqueSkillCardLv)
	gohelper.setActive(arg_9_0.frontBgBigSkill, var_9_1 == FightEnum.UniqueSkillCardLv)
	gohelper.setActive(arg_9_0._predisplay, arg_9_0._cardInfoMO and arg_9_0._cardInfoMO.tempCard)
	arg_9_0:_showUpgradeEffect()
	arg_9_0:_showEnchantsEffect()
	arg_9_0:_refreshGray()
	arg_9_0:_refreshASFD()
	arg_9_0:_refreshPreDeleteArrow()
	arg_9_0:showCardHeat()
	arg_9_0:refreshXiTiSpecialSkill(arg_9_1, arg_9_2, arg_9_3)
end

function var_0_0.refreshTag(arg_10_0)
	local var_10_0 = lua_skill.configDict[arg_10_0.skillId]
	local var_10_1 = FightCardDataHelper.getSkillLv(arg_10_0.entityId, arg_10_0.skillId)
	local var_10_2 = "attribute_"
	local var_10_3 = 168
	local var_10_4 = 56

	if arg_10_0.useSkin then
		var_10_2 = "v2a8_skin/attribute_"
		var_10_3 = 180
		var_10_4 = 64
	end

	local var_10_5 = ResUrl.getAttributeIcon(var_10_2 .. var_10_0.showTag)

	arg_10_0._tag:LoadImage(var_10_5)
	recthelper.setSize(arg_10_0.tagTransform, var_10_3, var_10_4)

	local var_10_6 = var_0_0.TagPosForLvs[var_10_1]

	if var_10_6 then
		recthelper.setAnchor(arg_10_0._tagRootTr, var_10_6[1], var_10_6[2])

		if arg_10_0.useSkin then
			recthelper.setAnchorY(arg_10_0._tagRootTr, -200)
		end
	end

	gohelper.setActive(arg_10_0._tag.gameObject, var_10_1 < FightEnum.UniqueSkillCardLv)
end

function var_0_0.showCardHeat(arg_11_0)
	if arg_11_0._cardInfoMO and arg_11_0._cardInfoMO.heatId and arg_11_0._cardInfoMO.heatId ~= 0 then
		arg_11_0:setHeatRootVisible(true)

		if arg_11_0._heatObj then
			arg_11_0:_refreshCardHeat()
		elseif not arg_11_0._loadHeat then
			arg_11_0._loadHeat = true

			arg_11_0._loader:loadAsset("ui/viewres/fight/fightheatview.prefab", arg_11_0._onHeatLoadFinish, arg_11_0)
		end
	else
		arg_11_0:setHeatRootVisible(false)
	end
end

function var_0_0.setHeatRootVisible(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._heatRoot, arg_12_1)
end

function var_0_0._refreshCardHeat(arg_13_0)
	if arg_13_0._cardInfoMO and arg_13_0._cardInfoMO.heatId ~= 0 then
		local var_13_0 = arg_13_0._cardInfoMO.heatId
		local var_13_1 = FightDataHelper.teamDataMgr.myData.cardHeat.values[var_13_0]

		if var_13_1 then
			local var_13_2 = FightDataHelper.teamDataMgr.myCardHeatOffset[var_13_0] or 0

			arg_13_0._heatText.text = Mathf.Clamp(var_13_1.value + var_13_2, var_13_1.lowerLimit, var_13_1.upperLimit)
		else
			arg_13_0._heatText.text = ""
		end
	end
end

function var_0_0._onHeatLoadFinish(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1 then
		return
	end

	arg_14_0._heatObj = gohelper.clone(arg_14_2:GetResource(), arg_14_0._heatRoot)
	arg_14_0._heatText = gohelper.findChildText(arg_14_0._heatObj, "heatText")

	arg_14_0:_refreshCardHeat()
end

function var_0_0._refreshPreDeleteArrow(arg_15_0)
	local var_15_0 = arg_15_0.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(arg_15_0.goPreDelete, var_15_0)

	if var_15_0 then
		gohelper.setActive(arg_15_0.goPreDeleteBoth, false)
		gohelper.setActive(arg_15_0.goPreDeleteLeft, false)
		gohelper.setActive(arg_15_0.goPreDeleteRight, false)

		local var_15_1 = lua_fight_card_pre_delete.configDict[arg_15_0.skillId]

		if var_15_1 then
			local var_15_2 = var_15_1.left > 0
			local var_15_3 = var_15_1.right > 0

			if var_15_2 and var_15_3 then
				gohelper.setActive(arg_15_0.goPreDeleteBoth, true)
			elseif var_15_2 then
				gohelper.setActive(arg_15_0.goPreDeleteLeft, true)
			elseif var_15_3 then
				gohelper.setActive(arg_15_0.goPreDeleteRight, true)
			end

			gohelper.setActive(arg_15_0._starGO, false)
		end
	end
end

function var_0_0._refreshPreDeleteImage(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(arg_16_0.goPreDelete, var_16_0)

	if var_16_0 then
		local var_16_1 = FightCardDataHelper.isBigSkill(arg_16_0.skillId)

		gohelper.setActive(arg_16_0.goPreDeleteNormal, not var_16_1 and arg_16_1)
		gohelper.setActive(arg_16_0.goPreDeleteUnique, var_16_1 and arg_16_1)
	end
end

function var_0_0.refreshPreDeleteSkill(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	gohelper.setActive(arg_17_0.goPreDeleteCard, true)
	gohelper.setActive(arg_17_0.goPreDeleteNormal, false)
	gohelper.setActive(arg_17_0.goPreDeleteUnique, false)
	arg_17_0:refreshTag()
	arg_17_0:_refreshPreDeleteArrow()
end

function var_0_0.refreshBloodPoolSkill(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	gohelper.setActive(arg_18_0.goBloodPool, true)
	gohelper.setActive(arg_18_0.goTag, true)
	gohelper.setActive(arg_18_0._tag.gameObject, true)

	arg_18_0.bloodPoolAnimator = arg_18_0.bloodPoolAnimator or arg_18_0.goBloodPool:GetComponent(gohelper.Type_Animator)

	if arg_18_0.handCardType == FightEnum.CardShowType.Operation then
		arg_18_0.bloodPoolAnimator:Play("open", 0, 0)
		AudioMgr.instance:trigger(20270007)
	else
		arg_18_0.bloodPoolAnimator:Play("open", 0, 1)
	end

	arg_18_0._tag:LoadImage(ResUrl.getAttributeIcon("blood_tex2"))

	local var_18_0 = var_0_0.TagPosForLvs[1]

	recthelper.setAnchor(arg_18_0._tagRootTr, var_18_0[1], var_18_0[2])
end

function var_0_0.refreshASFDSkill(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	gohelper.setActive(arg_19_0.goASFDSkill, true)
	gohelper.setActive(arg_19_0.goTag, true)
	gohelper.setActive(arg_19_0._tag.gameObject, true)

	local var_19_0 = ResUrl.getSkillIcon(FightASFDConfig.instance.normalSkillIcon)

	arg_19_0.asfdSkillSimage:LoadImage(var_19_0)

	arg_19_0.asfdNumTxt.text = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	arg_19_0._tag:LoadImage(ResUrl.getAttributeIcon("attribute_asfd"))

	local var_19_1 = var_0_0.TagPosForLvs[1]

	recthelper.setAnchor(arg_19_0._tagRootTr, var_19_1[1], var_19_1[2])
end

function var_0_0.refreshXiTiSpecialSkill(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if not FightHelper.isXiTiSpecialSkill(arg_20_2) then
		gohelper.setActive(arg_20_0.xingtiGo, false)

		return
	end

	gohelper.setActive(arg_20_0.xingtiGo, true)

	arg_20_0.xingtiTxt.text = FightASFDHelper.getLastRoundRecordCardEnergy()
end

function var_0_0.updateResistanceByCardInfo(arg_21_0, arg_21_1)
	arg_21_0._resistanceComp:updateByCardInfo(arg_21_1)
end

function var_0_0.updateResistanceByBeginRoundOp(arg_22_0, arg_22_1)
	arg_22_0._resistanceComp:updateByBeginRoundOp(arg_22_1)
end

function var_0_0.updateResistanceBySkillDisplayMo(arg_23_0, arg_23_1)
	arg_23_0._resistanceComp:updateBySkillDisplayMo(arg_23_1)
end

function var_0_0.detectShowBlueStar(arg_24_0)
	local var_24_0 = arg_24_0.entityId and arg_24_0.skillId and FightCardDataHelper.getSkillLv(arg_24_0.entityId, arg_24_0.skillId)

	arg_24_0:showBlueStar(var_24_0)
end

function var_0_0.showBlueStar(arg_25_0, arg_25_1)
	if arg_25_0._lightBlueObj then
		for iter_25_0, iter_25_1 in ipairs(arg_25_0._lightBlueObj) do
			gohelper.setActive(iter_25_1.blue, false)
			gohelper.setActive(iter_25_1.dark, true)
		end
	else
		arg_25_0._lightBlueObj = {}
		arg_25_0._lightBlueObj[1] = arg_25_0:getUserDataTb_()
		arg_25_0._lightBlueObj[1].blue = gohelper.findChild(arg_25_0._innerStartGOs[1], "lightblue")
		arg_25_0._lightBlueObj[1].dark = gohelper.findChild(arg_25_0._innerStartGOs[1], "dark2")
		arg_25_0._lightBlueObj[2] = arg_25_0:getUserDataTb_()
		arg_25_0._lightBlueObj[2].blue = gohelper.findChild(arg_25_0._innerStartGOs[2], "lightblue")
		arg_25_0._lightBlueObj[2].dark = gohelper.findChild(arg_25_0._innerStartGOs[2], "dark3")
	end

	if arg_25_1 == 1 or arg_25_1 == 2 then
		local var_25_0 = FightDataHelper.entityMgr:getById(arg_25_0.entityId)

		if var_25_0 and var_25_0:hasBuffFeature(FightEnum.BuffFeature.SkillLevelJudgeAdd) then
			local var_25_1 = arg_25_0._lightBlueObj[arg_25_1]

			gohelper.setActive(var_25_1.blue, true)
			gohelper.setActive(var_25_1.dark, false)
		end
	end
end

function var_0_0.showPrecisionEffect(arg_26_0)
	gohelper.setActive(arg_26_0._precisionEffect, true)
end

function var_0_0.hidePrecisionEffect(arg_27_0)
	gohelper.setActive(arg_27_0._precisionEffect, false)
end

local var_0_1 = {
	[FightEnum.EnchantedType.Frozen] = "ui/viewres/fight/card_freeze.prefab",
	[FightEnum.EnchantedType.Burn] = "ui/viewres/fight/card_flaring.prefab",
	[FightEnum.EnchantedType.Chaos] = "ui/viewres/fight/card_chaos.prefab",
	[FightEnum.EnchantedType.depresse] = "ui/viewres/fight/card_qmyj.prefab"
}

function var_0_0._showEnchantsEffect(arg_28_0)
	gohelper.setActive(arg_28_0._abandon, false)
	gohelper.setActive(arg_28_0._blockadeTwo, false)
	gohelper.setActive(arg_28_0._blockadeOne, false)
	gohelper.setActive(arg_28_0._precision, false)
	gohelper.setActive(arg_28_0._precisionEffect, false)

	if not arg_28_0._cardInfoMO then
		return
	end

	local var_28_0 = arg_28_0:_refreshEnchantEffectActive()

	if #var_28_0 > 0 then
		arg_28_0._loader:loadListAsset(var_28_0, arg_28_0._onEnchantEffectLoaded, arg_28_0._onEnchantEffectsLoaded, arg_28_0)
	end

	if arg_28_0._cardInfoMO.enchants then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0._cardInfoMO.enchants) do
			if iter_28_1.enchantId == FightEnum.EnchantedType.Discard then
				gohelper.setActive(arg_28_0._abandon, true)
			elseif iter_28_1.enchantId == FightEnum.EnchantedType.Blockade then
				local var_28_1 = FightDataHelper.handCardMgr.handCard

				if arg_28_0._cardInfoMO.clientData.custom_playedCard then
					gohelper.setActive(arg_28_0._blockadeOne, true)
				elseif arg_28_0._cardInfoMO.clientData.custom_handCardIndex then
					if arg_28_0._cardInfoMO.clientData.custom_handCardIndex == 1 or arg_28_0._cardInfoMO.clientData.custom_handCardIndex == #var_28_1 then
						gohelper.setActive(arg_28_0._blockadeOne, true)
					else
						gohelper.setActive(arg_28_0._blockadeTwo, true)
					end
				else
					gohelper.setActive(arg_28_0._blockadeOne, true)
				end
			elseif iter_28_1.enchantId == FightEnum.EnchantedType.Precision then
				gohelper.setActive(arg_28_0._precision, true)

				if arg_28_0._cardInfoMO.clientData.custom_handCardIndex == 1 then
					FightController.instance:dispatchEvent(FightEvent.RefreshHandCardPrecisionEffect)
				end
			end
		end
	end
end

function var_0_0._refreshEnchantEffectActive(arg_29_0)
	arg_29_0:_hideEnchantsEffect()

	arg_29_0._enchantsEffect = arg_29_0._enchantsEffect or {}

	local var_29_0 = arg_29_0._cardInfoMO.enchants or {}
	local var_29_1 = {}

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		local var_29_2 = iter_29_1.enchantId

		if arg_29_0._enchantsEffect[var_29_2] then
			for iter_29_2, iter_29_3 in ipairs(arg_29_0._enchantsEffect[var_29_2]) do
				gohelper.setActive(iter_29_3, true)
			end
		else
			local var_29_3 = var_0_1[var_29_2]

			if var_29_3 then
				table.insert(var_29_1, var_29_3)
			end
		end
	end

	return var_29_1
end

function var_0_0._hideEnchantsEffect(arg_30_0)
	if arg_30_0._enchantsEffect then
		for iter_30_0, iter_30_1 in pairs(arg_30_0._enchantsEffect) do
			for iter_30_2, iter_30_3 in ipairs(iter_30_1) do
				gohelper.setActive(iter_30_3, false)
			end
		end
	end
end

function var_0_0._onEnchantEffectLoaded(arg_31_0, arg_31_1, arg_31_2)
	return
end

function var_0_0._onEnchantEffectsLoaded(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in pairs(var_0_1) do
		if not arg_32_0._enchantsEffect[iter_32_0] then
			local var_32_0 = arg_32_1:getAssetItem(iter_32_1)

			if var_32_0 then
				local var_32_1 = var_32_0:GetResource()

				if arg_32_0._lvGOs then
					arg_32_0._enchantsEffect[iter_32_0] = arg_32_0:getUserDataTb_()

					for iter_32_2, iter_32_3 in pairs(arg_32_0._lvGOs) do
						local var_32_2 = gohelper.clone(var_32_1, gohelper.findChild(iter_32_3, "#cardeffect"))

						for iter_32_4 = 0, 4 do
							local var_32_3 = gohelper.findChild(var_32_2, "lv" .. iter_32_4)

							gohelper.setActive(var_32_3, iter_32_4 == iter_32_2)
						end

						table.insert(arg_32_0._enchantsEffect[iter_32_0], var_32_2)
					end
				end
			end
		end
	end

	arg_32_0:_refreshEnchantEffectActive()
end

function var_0_0._showUpgradeEffect(arg_33_0)
	if lua_fight_upgrade_show_skillid.configDict[arg_33_0.skillId] then
		if not arg_33_0._upgradeEffects then
			arg_33_0._loader:loadAsset("ui/viewres/fight/card_aggrandizement.prefab", arg_33_0._onUpgradeEffectLoaded, arg_33_0)

			return
		end

		for iter_33_0, iter_33_1 in ipairs(arg_33_0._upgradeEffects) do
			gohelper.setActive(iter_33_1, false)
			gohelper.setActive(iter_33_1, true)
		end
	else
		arg_33_0:_hideUpgradeEffects()
	end
end

function var_0_0._hideUpgradeEffects(arg_34_0)
	if arg_34_0._upgradeEffects then
		for iter_34_0, iter_34_1 in ipairs(arg_34_0._upgradeEffects) do
			gohelper.setActive(iter_34_1, false)
		end
	end
end

function var_0_0._onUpgradeEffectLoaded(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_1 then
		return
	end

	if arg_35_0._upgradeEffects then
		return
	end

	arg_35_0._upgradeEffects = arg_35_0:getUserDataTb_()

	local var_35_0 = arg_35_2:GetResource()

	if arg_35_0._lvGOs and var_35_0 then
		for iter_35_0, iter_35_1 in pairs(arg_35_0._lvGOs) do
			local var_35_1 = gohelper.clone(var_35_0, gohelper.findChild(iter_35_1, "#cardeffect"))

			for iter_35_2 = 0, 4 do
				local var_35_2 = gohelper.findChild(var_35_1, "lv" .. iter_35_2)

				gohelper.setActive(var_35_2, iter_35_2 == iter_35_0)
			end

			table.insert(arg_35_0._upgradeEffects, var_35_1)
		end
	end

	arg_35_0:_showUpgradeEffect()
end

function var_0_0.showCountPart(arg_36_0, arg_36_1)
	gohelper.setActive(arg_36_0._countRoot, true)

	arg_36_0._countText.text = luaLang("multiple") .. arg_36_1
end

function var_0_0.changeToTempCard(arg_37_0)
	gohelper.setActive(arg_37_0._predisplay, true)
end

function var_0_0.dissolveCard(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_0.go.activeInHierarchy then
		return
	end

	if FightHelper.isASFDSkill(arg_38_0.skillId) then
		return arg_38_0:disappearCard()
	end

	if FightHelper.isPreDeleteSkill(arg_38_0.skillId) then
		return arg_38_0:disappearCard()
	end

	if FightHelper.isBloodPoolSkill(arg_38_0.skillId) then
		return arg_38_0:disappearCard()
	end

	arg_38_0:setASFDActive(false)
	arg_38_0:revertASFDSkillAnimator()

	local var_38_0 = arg_38_0:getUserDataTb_()

	var_38_0.dissolveScale = arg_38_1 or 1

	local var_38_1 = arg_38_0:getUserDataTb_()

	arg_38_2 = arg_38_2 or arg_38_0.go

	table.insert(var_38_1, arg_38_2)

	var_38_0.dissolveSkillItemGOs = var_38_1

	if not arg_38_0._dissolveFlow then
		arg_38_0._dissolveFlow = FlowSequence.New()

		arg_38_0._dissolveFlow:addWork(FightCardDissolveEffect.New())
	else
		arg_38_0._dissolveFlow:stop()
	end

	arg_38_0:_hideAllEffect()
	arg_38_0._dissolveFlow:start(var_38_0)
end

function var_0_0.disappearCard(arg_39_0)
	if not arg_39_0.go.activeInHierarchy then
		return
	end

	arg_39_0:setASFDActive(false)
	arg_39_0:revertASFDSkillAnimator()

	local var_39_0 = arg_39_0:getUserDataTb_()

	var_39_0.hideSkillItemGOs = arg_39_0:getUserDataTb_()

	table.insert(var_39_0.hideSkillItemGOs, arg_39_0.go)

	if not arg_39_0._disappearFlow then
		arg_39_0._disappearFlow = FlowSequence.New()

		arg_39_0._disappearFlow:addWork(FightCardDisplayHideAllEffect.New())
	else
		arg_39_0._disappearFlow:stop()
	end

	arg_39_0._disappearFlow:start(var_39_0)
end

function var_0_0.revertASFDSkillAnimator(arg_40_0)
	if not FightHelper.isASFDSkill(arg_40_0.skillId) then
		return
	end

	if arg_40_0.asfdSkillAnimator then
		arg_40_0.asfdSkillAnimator:Play("open", 0, 0)
	end
end

function var_0_0.playUsedCardDisplay(arg_41_0, arg_41_1)
	if not arg_41_0.go.activeInHierarchy then
		return
	end

	if not arg_41_0._cardDisplayFlow then
		arg_41_0._cardDisplayFlow = FlowSequence.New()

		arg_41_0._cardDisplayFlow:addWork(FightCardDisplayEffect.New())
	end

	local var_41_0 = arg_41_0:getUserDataTb_()

	var_41_0.skillTipsGO = arg_41_1
	var_41_0.skillItemGO = arg_41_0.go

	arg_41_0._cardDisplayFlow:start(var_41_0)
end

function var_0_0.playUsedCardFinish(arg_42_0, arg_42_1, arg_42_2)
	if not arg_42_0.go.activeInHierarchy then
		return
	end

	if not arg_42_0._cardDisplayEndFlow then
		arg_42_0._cardDisplayEndFlow = FlowSequence.New()

		arg_42_0._cardDisplayEndFlow:addWork(FightCardDisplayEndEffect.New())
	end

	local var_42_0 = arg_42_0:getUserDataTb_()

	var_42_0.skillTipsGO = arg_42_1
	var_42_0.skillItemGO = arg_42_0.go
	var_42_0.waitingAreaGO = arg_42_2

	arg_42_0._cardDisplayEndFlow:start(var_42_0)
end

function var_0_0.playCardLevelChange(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if not arg_43_0._cardInfoMO then
		return
	end

	if not arg_43_0.go.activeInHierarchy then
		return
	end

	arg_43_0._cardInfoMO = arg_43_1 or arg_43_0._cardInfoMO

	local var_43_0 = FightConfig.instance:getSkillLv(arg_43_2)
	local var_43_1 = FightConfig.instance:getSkillLv(arg_43_0._cardInfoMO.skillId)

	if not arg_43_0._cardLevelChangeFlow then
		arg_43_0._cardLevelChangeFlow = FlowSequence.New()

		arg_43_0._cardLevelChangeFlow:addWork(FightCardChangeEffect.New())
		arg_43_0._cardLevelChangeFlow:registerDoneListener(arg_43_0._onCardLevelChangeFlowDone, arg_43_0)
	else
		var_43_0 = arg_43_0._cardLevelChangeFlow.status == WorkStatus.Running and arg_43_0._cardLevelChangeFlow.context and arg_43_0._cardLevelChangeFlow.context.oldCardLevel or var_43_0

		arg_43_0._cardLevelChangeFlow:stop()
	end

	local var_43_2 = arg_43_0:getUserDataTb_()

	var_43_2.skillId = arg_43_0._cardInfoMO.skillId
	var_43_2.entityId = arg_43_0._cardInfoMO.uid
	var_43_2.oldCardLevel = var_43_0
	var_43_2.newCardLevel = var_43_1
	var_43_2.cardItem = arg_43_0
	var_43_2.failType = arg_43_3

	arg_43_0._cardLevelChangeFlow:start(var_43_2)

	if var_43_0 <= var_43_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_cardstarup)
	else
		AudioMgr.instance:trigger(20211403)
	end
end

function var_0_0._refreshGray(arg_44_0)
	if arg_44_0._cardInfoMO and arg_44_0._cardInfoMO.status == FightEnum.CardInfoStatus.STATUS_PLAYSETGRAY then
		gohelper.setActive(arg_44_0._cardMask, true)

		local var_44_0 = arg_44_0._cardInfoMO.uid
		local var_44_1 = arg_44_0._cardInfoMO.skillId
		local var_44_2 = FightCardDataHelper.getSkillLv(var_44_0, var_44_1)
		local var_44_3 = FightCardDataHelper.isBigSkill(var_44_1)

		for iter_44_0, iter_44_1 in ipairs(arg_44_0._maskList) do
			if iter_44_0 < 4 then
				gohelper.setActive(iter_44_1, iter_44_0 == var_44_2)
			else
				gohelper.setActive(iter_44_1, var_44_3)
			end
		end
	else
		gohelper.setActive(arg_44_0._cardMask, false)
	end
end

function var_0_0.playCardAroundSetGray(arg_45_0)
	arg_45_0:_refreshGray()
end

function var_0_0.playChangeRankFail(arg_46_0, arg_46_1)
	if arg_46_0._cardInfoMO then
		arg_46_0:playCardLevelChange(arg_46_0._cardInfoMO, arg_46_0._cardInfoMO.skillId, arg_46_1)
	end
end

function var_0_0.setASFDActive(arg_47_0, arg_47_1)
	arg_47_0.showASFD = arg_47_1

	arg_47_0:_refreshASFD()
end

function var_0_0._refreshASFD(arg_48_0)
	local var_48_0 = arg_48_0.showASFD and arg_48_0._cardInfoMO and arg_48_0._cardInfoMO.energy > 0

	gohelper.setActive(arg_48_0.goASFD, var_48_0)

	if var_48_0 then
		arg_48_0.txtASFDEnergy.text = arg_48_0._cardInfoMO.energy
	end
end

function var_0_0.changeEnergy(arg_49_0)
	local var_49_0 = arg_49_0.showASFD and arg_49_0._cardInfoMO and arg_49_0._cardInfoMO.energy > 0

	gohelper.setActive(arg_49_0.goASFD, var_49_0)

	if var_49_0 then
		arg_49_0.txtASFDEnergy.text = arg_49_0._cardInfoMO.energy
		arg_49_0.asfdAnimator = arg_49_0.asfdAnimator or arg_49_0.goASFD:GetComponent(gohelper.Type_Animator)

		arg_49_0.asfdAnimator:Play("add", 0, 0)
	end
end

function var_0_0._allocateEnergyDone(arg_50_0)
	local var_50_0 = arg_50_0.showASFD and arg_50_0._cardInfoMO and arg_50_0._cardInfoMO.energy > 0

	gohelper.setActive(arg_50_0.goASFD, var_50_0)

	if var_50_0 then
		arg_50_0.txtASFDEnergy.text = arg_50_0._cardInfoMO.energy
		arg_50_0.asfdAnimator = arg_50_0.asfdAnimator or arg_50_0.goASFD:GetComponent(gohelper.Type_Animator)

		arg_50_0.asfdAnimator:Play("open", 0, 0)
	end
end

function var_0_0.playASFDAnim(arg_51_0, arg_51_1)
	if arg_51_0.goASFD.activeSelf then
		arg_51_0.asfdAnimator = arg_51_0.asfdAnimator or arg_51_0.goASFD:GetComponent(gohelper.Type_Animator)

		arg_51_0.asfdAnimator:Play(arg_51_1, 0, 0)
	end
end

function var_0_0._onCardLevelChangeFlowDone(arg_52_0)
	arg_52_0:updateItem(arg_52_0._cardInfoMO.uid, arg_52_0._cardInfoMO.skillId, arg_52_0._cardInfoMO)
	FightController.instance:dispatchEvent(FightEvent.CardLevelChangeDone, arg_52_0._cardInfoMO)
	arg_52_0:detectShowBlueStar()
end

function var_0_0.playCardAni(arg_53_0, arg_53_1, arg_53_2)
	arg_53_0._cardAniName = arg_53_2 or UIAnimationName.Open

	arg_53_0._loader:loadAsset(arg_53_1, arg_53_0._onCardAniLoaded, arg_53_0)
end

function var_0_0._onCardAniLoaded(arg_54_0, arg_54_1, arg_54_2)
	if not arg_54_1 then
		return
	end

	if not arg_54_0._cardAniName then
		arg_54_0:_hideAniEffect()

		return
	end

	arg_54_0._cardAni.runtimeAnimatorController = arg_54_2:GetResource()
	arg_54_0._cardAni.enabled = true
	arg_54_0._cardAni.speed = FightModel.instance:getUISpeed()

	SLFramework.AnimatorPlayer.Get(arg_54_0.go):Play(arg_54_0._cardAniName, arg_54_0.onCardAniFinish, arg_54_0)
end

function var_0_0.onCardAniFinish(arg_55_0)
	arg_55_0:_hideAniEffect()
	arg_55_0:hideCardAppearEffect()
end

function var_0_0._hideAniEffect(arg_56_0)
	arg_56_0._cardAniName = nil
	arg_56_0._cardAni.enabled = false

	gohelper.setActive(gohelper.findChild(arg_56_0.go, "vx_balance"), false)
end

function var_0_0.playAppearEffect(arg_57_0)
	gohelper.setActive(arg_57_0._cardAppearEffectRoot, true)

	if not arg_57_0._appearEffect then
		if arg_57_0._appearEffectLoadStart then
			return
		end

		arg_57_0._appearEffectLoadStart = true

		arg_57_0._loader:loadAsset("ui/viewres/fight/card_appear.prefab", arg_57_0._onAppearEffectLoaded, arg_57_0)
	else
		arg_57_0:showAppearEffect()
	end
end

function var_0_0._onAppearEffectLoaded(arg_58_0, arg_58_1, arg_58_2)
	if not arg_58_1 then
		return
	end

	local var_58_0 = arg_58_2:GetResource()

	arg_58_0._appearEffect = gohelper.clone(var_58_0, arg_58_0._cardAppearEffectRoot)

	gohelper.addChild(arg_58_0._cardAppearEffectRoot.transform.parent.parent.gameObject, arg_58_0._cardAppearEffectRoot)
	arg_58_0:showAppearEffect()
end

function var_0_0.showAppearEffect(arg_59_0)
	local var_59_0 = FightCardDataHelper.isBigSkill(arg_59_0.skillId)

	gohelper.setActive(gohelper.findChild(arg_59_0._appearEffect, "nomal_skill"), not var_59_0)
	gohelper.setActive(gohelper.findChild(arg_59_0._appearEffect, "ultimate_skill"), var_59_0)
end

function var_0_0.hideCardAppearEffect(arg_60_0)
	gohelper.setActive(arg_60_0._cardAppearEffectRoot, false)
end

function var_0_0.getASFDScreenPos(arg_61_0)
	arg_61_0.rectTrASFD = arg_61_0.rectTrASFD or arg_61_0.goASFD:GetComponent(gohelper.Type_RectTransform)

	return recthelper.uiPosToScreenPos2(arg_61_0.rectTrASFD)
end

function var_0_0.setActiveRed(arg_62_0, arg_62_1)
	gohelper.setActive(arg_62_0.goRed, arg_62_1)
	arg_62_0:refreshLyMaskActive()
end

function var_0_0.setActiveBlue(arg_63_0, arg_63_1)
	gohelper.setActive(arg_63_0.goBlue, arg_63_1)
	arg_63_0:refreshLyMaskActive()
end

function var_0_0.setActiveBoth(arg_64_0, arg_64_1)
	gohelper.setActive(arg_64_0.goBoth, arg_64_1)
	arg_64_0:refreshLyMaskActive()
end

function var_0_0.refreshLyMaskActive(arg_65_0)
	local var_65_0 = arg_65_0.goRed.activeInHierarchy or arg_65_0.goBlue.activeInHierarchy or arg_65_0.goBoth.activeInHierarchy

	gohelper.setActive(arg_65_0.goLyMask, var_65_0)
end

function var_0_0.releaseEffectFlow(arg_66_0)
	if arg_66_0._cardLevelChangeFlow then
		arg_66_0._cardLevelChangeFlow:unregisterDoneListener(arg_66_0._onCardLevelChangeFlowDone, arg_66_0)
		arg_66_0._cardLevelChangeFlow:stop()

		arg_66_0._cardLevelChangeFlow = nil
	end

	if arg_66_0._dissolveFlow then
		arg_66_0._dissolveFlow:stop()

		arg_66_0._dissolveFlow = nil
	end

	if arg_66_0._cardDisplayFlow then
		arg_66_0._cardDisplayFlow:stop()

		arg_66_0._cardDisplayFlow = nil
	end

	if arg_66_0._cardDisplayEndFlow then
		arg_66_0._cardDisplayEndFlow:stop()

		arg_66_0._cardDisplayEndFlow = nil
	end

	if arg_66_0._disappearFlow then
		if not gohelper.isNil(arg_66_0.go) then
			gohelper.onceAddComponent(arg_66_0.go, gohelper.Type_CanvasGroup).alpha = 1
		end

		arg_66_0._disappearFlow:stop()

		arg_66_0._disappearFlow = nil
	end
end

function var_0_0.onDestroy(arg_67_0)
	if arg_67_0._loader then
		arg_67_0._loader:disposeSelf()

		arg_67_0._loader = nil
	end

	arg_67_0:releaseEffectFlow()

	for iter_67_0, iter_67_1 in pairs(arg_67_0._lvGOs) do
		arg_67_0._lvImgIcons[iter_67_0]:UnLoadImage()
	end

	arg_67_0._tag:UnLoadImage()
	arg_67_0:clearAlfEffect()
end

function var_0_0._hideAllEffect(arg_68_0)
	arg_68_0:_hideUpgradeEffects()
	arg_68_0:_hideEnchantsEffect()
	gohelper.setActive(arg_68_0.goPreDelete, false)
end

var_0_0.AlfLoadStatus = {
	Loaded = 3,
	Loading = 2,
	None = 1
}

function var_0_0.tryPlayAlfEffect(arg_69_0)
	if not arg_69_0._cardInfoMO then
		return
	end

	if not FightHeroALFComp.ALFSkillDict[arg_69_0._cardInfoMO.clientData.custom_fromSkillId] then
		return
	end

	arg_69_0.showAlfEffectIng = true

	FightController.instance:dispatchEvent(FightEvent.ALF_AddCardEffectAppear, arg_69_0)

	if arg_69_0.alfLoadStatus == var_0_0.AlfLoadStatus.Loaded then
		arg_69_0:_tryPlayAlfEffect()
	elseif arg_69_0.alfLoadStatus == var_0_0.AlfLoadStatus.Loading then
		-- block empty
	else
		arg_69_0.alfLoadStatus = var_0_0.AlfLoadStatus.Loading
		arg_69_0.alfLoader = PrefabInstantiate.Create(arg_69_0.tr.parent.gameObject)

		arg_69_0.alfLoader:startLoad(FightHeroALFComp.CardAddEffect, arg_69_0.onLoadedAlfEffect, arg_69_0)
	end
end

function var_0_0.onLoadedAlfEffect(arg_70_0)
	arg_70_0.goAlfAddCardEffect = arg_70_0.alfLoader:getInstGO()
	arg_70_0.goAlfAddCardAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_70_0.goAlfAddCardEffect)
	arg_70_0.alfLoadStatus = var_0_0.AlfLoadStatus.Loaded

	arg_70_0:_tryPlayAlfEffect()
end

function var_0_0._tryPlayAlfEffect(arg_71_0)
	if not arg_71_0.goAlfAddCardAnimatorPlayer then
		return
	end

	gohelper.setActive(arg_71_0.go, false)
	gohelper.setActive(arg_71_0.goAlfAddCardEffect, true)
	arg_71_0.goAlfAddCardAnimatorPlayer:Play("open", arg_71_0.playAlfCloseAnim, arg_71_0)
end

function var_0_0.playAlfCloseAnim(arg_72_0)
	arg_72_0.goAlfAddCardAnimatorPlayer:Play("close", arg_72_0.playAlfCloseAnimDone, arg_72_0)
	TaskDispatcher.runDelay(arg_72_0.showCardGo, arg_72_0, 0.2 / FightModel.instance:getUISpeed())
end

function var_0_0.showCardGo(arg_73_0)
	gohelper.setActive(arg_73_0.go, true)
	arg_73_0:playCardAni(ViewAnim.FightCardAppear, "fightcard_apper")
end

function var_0_0.playAlfCloseAnimDone(arg_74_0)
	gohelper.setActive(arg_74_0.goAlfAddCardEffect, false)

	arg_74_0.showAlfEffectIng = false

	FightController.instance:dispatchEvent(FightEvent.ALF_AddCardEffectEnd, arg_74_0)
end

function var_0_0.clearAlfEffect(arg_75_0)
	if arg_75_0.alfLoader then
		arg_75_0.alfLoader:dispose()

		arg_75_0.alfLoader = nil
	end

	arg_75_0.alfLoadStatus = var_0_0.AlfLoadStatus.None
	arg_75_0.goAlfAddCardEffect = nil

	if arg_75_0.goAlfAddCardAnimatorPlayer then
		arg_75_0.goAlfAddCardAnimatorPlayer:Stop()

		arg_75_0.goAlfAddCardAnimatorPlayer = nil
	end

	TaskDispatcher.cancelTask(arg_75_0.showCardGo, arg_75_0)
end

return var_0_0
