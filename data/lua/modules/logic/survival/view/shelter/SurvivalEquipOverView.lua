module("modules.logic.survival.view.shelter.SurvivalEquipOverView", package.seeall)

local var_0_0 = class("SurvivalEquipOverView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_Close")
	arg_1_0._goLeft = gohelper.findChild(arg_1_0.viewGO, "Panel/Left")
	arg_1_0._imageSkill = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Left/image_Icon")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "Panel/go_empty")
	arg_1_0._goScroll = gohelper.findChild(arg_1_0.viewGO, "Panel/#scroll_List")
	arg_1_0._goScrollBig = gohelper.findChild(arg_1_0.viewGO, "Panel/#scroll_ListBig")
	arg_1_0._godesc = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#scroll_Descr/viewport/Content/#txt_Descr")
	arg_1_0._txtTotalScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/Assess/image_NumBG/#txt_Num")
	arg_1_0._imageScore = gohelper.findChildImage(arg_1_0.viewGO, "Panel/Left/Assess/image_NumBG/#txt_Num/image_AssessIon")
	arg_1_0._imageFrequency = gohelper.findChildImage(arg_1_0.viewGO, "Panel/Left/Frequency/image_NumBG/#txt_Num/image_FrequencyIcon")
	arg_1_0._txtFrequency = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/Frequency/image_NumBG/#txt_Num")
	arg_1_0._txtFrequencyName = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/Frequency/txt_Frequency")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

local var_0_1 = {
	"#617B8E",
	"#855AA1",
	"#AF490B"
}

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
	local var_4_1 = gohelper.create2d(arg_4_0.viewGO, "#go_info")
	local var_4_2 = arg_4_0:getResInst(var_4_0, var_4_1)

	arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_2, SurvivalBagInfoPart)

	arg_4_0._infoPanel:setCloseShow(true)
	arg_4_0._infoPanel:updateMo()

	local var_4_3 = arg_4_0.viewContainer._viewSetting.otherRes.itemRes

	arg_4_0._item = arg_4_0:getResInst(var_4_3, arg_4_0.viewGO)

	gohelper.setActive(arg_4_0._item, false)

	arg_4_0._equipBox = SurvivalShelterModel.instance:getWeekInfo().equipBox

	local var_4_4 = lua_survival_equip_found.configDict[arg_4_0._equipBox.maxTagId]

	gohelper.setActive(arg_4_0._goLeft, var_4_4)
	gohelper.setActive(arg_4_0._goScroll, var_4_4)
	gohelper.setActive(arg_4_0._goScrollBig, not var_4_4)

	local var_4_5
	local var_4_6 = 0
	local var_4_7 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._equipBox.slots) do
		if not iter_4_1.item:isEmpty() then
			table.insert(var_4_7, iter_4_1.item)

			var_4_6 = var_4_6 + iter_4_1:getScore()
		end
	end

	if var_4_4 then
		local var_4_8 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.WorldLevel)
		local var_4_9 = lua_survival_equip_score.configDict[var_4_8][2].level
		local var_4_10 = 1

		if not string.nilorempty(var_4_9) then
			for iter_4_2, iter_4_3 in ipairs(string.splitToNumber(var_4_9, "#")) do
				if iter_4_3 <= var_4_6 then
					var_4_10 = iter_4_2 + 1
				end
			end
		end

		UISpriteSetMgr.instance:setSurvivalSprite(arg_4_0._imageScore, "survivalequip_scoreicon_" .. var_4_10)

		arg_4_0._txtTotalScore.text = string.format("<color=%s>%s</color>", var_0_1[var_4_10] or var_0_1[1], var_4_6)

		UISpriteSetMgr.instance:setSurvivalSprite(arg_4_0._imageFrequency, var_4_4.value)

		arg_4_0._txtFrequency.text = arg_4_0._equipBox.values[var_4_4.value] or 0

		local var_4_11 = lua_survival_attr.configDict[var_4_4.value]

		arg_4_0._txtFrequencyName.text = var_4_11 and var_4_11.name or ""

		arg_4_0._imageSkill:LoadImage(ResUrl.getSurvivalEquipIcon(var_4_4.icon))

		local var_4_12 = {}

		if not string.nilorempty(var_4_4.desc) then
			local var_4_13 = {}
			local var_4_14 = {}

			for iter_4_4, iter_4_5 in ipairs(string.split(var_4_4.desc, "|")) do
				local var_4_15, var_4_16 = SurvivalDescExpressionHelper.instance:parstDesc(iter_4_5, arg_4_0._equipBox.values)

				if var_4_16 then
					table.insert(var_4_13, {
						var_4_15,
						var_4_16
					})
				else
					table.insert(var_4_14, {
						var_4_15,
						var_4_16
					})
				end
			end

			tabletool.addValues(var_4_12, var_4_13)
			tabletool.addValues(var_4_12, var_4_14)
		end

		gohelper.CreateObjList(arg_4_0, arg_4_0._createDescItem, var_4_12, nil, arg_4_0._godesc)

		var_4_5 = gohelper.findChild(arg_4_0._goScroll, "viewport/Content/#go_Item")
	else
		var_4_5 = gohelper.findChild(arg_4_0._goScrollBig, "viewport/Content/#go_Item")
	end

	gohelper.CreateObjList(arg_4_0, arg_4_0._createEquipItem, var_4_7, nil, var_4_5)
	gohelper.setActive(arg_4_0._goEmpty, #var_4_7 == 0)
end

function var_0_0._createDescItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = gohelper.findChildTextMesh(arg_5_1, "")
	local var_5_1 = gohelper.findChildImage(arg_5_1, "image_Point")

	MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0.gameObject, SurvivalSkillDescComp):updateInfo(var_5_0, arg_5_2[1], 3028)
	ZProj.UGUIHelper.SetColorAlpha(var_5_0, arg_5_2[2] and 1 or 0.5)

	if arg_5_2[2] then
		var_5_1.color = GameUtil.parseColor("#000000")
	else
		var_5_1.color = GameUtil.parseColor("#808080")
	end
end

function var_0_0._createEquipItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = gohelper.findChildTextMesh(arg_6_1, "#txt_Descr")
	local var_6_1 = gohelper.findChildTextMesh(arg_6_1, "#txt_Descr/#txt_Name")
	local var_6_2 = gohelper.findChildTextMesh(arg_6_1, "#txt_Descr/Assess/image_NumBG/#txt_Num")
	local var_6_3 = gohelper.findChild(arg_6_1, "#txt_Descr/#go_Item")
	local var_6_4 = gohelper.findChildImage(arg_6_1, "#txt_Descr/Assess/image_NumBG/image_FrequencyIcon")
	local var_6_5 = gohelper.findChildTextMesh(arg_6_1, "#txt_Descr/Assess/image_NumBG/#txt_FrequencyNum")
	local var_6_6 = arg_6_2:getEquipEffectDesc()
	local var_6_7 = ""

	for iter_6_0, iter_6_1 in ipairs(var_6_6) do
		if iter_6_1[2] then
			var_6_7 = var_6_7 .. iter_6_1[1]
		else
			var_6_7 = var_6_7 .. "<color=#22222280>" .. iter_6_1[1] .. "</color>"
		end
	end

	MonoHelper.addNoUpdateLuaComOnceToGo(var_6_0.gameObject, SurvivalSkillDescComp):updateInfo(var_6_0, var_6_7, 3028)

	var_6_1.text = arg_6_2.co.name
	var_6_2.text = arg_6_2.equipCo.score + arg_6_2.exScore

	local var_6_8 = gohelper.clone(arg_6_0._item, var_6_3)

	gohelper.setActive(var_6_8, true)

	local var_6_9 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_8, SurvivalBagItem)

	var_6_9:updateMo(arg_6_2)
	var_6_9:setClickCallback(arg_6_0._onClickItem, arg_6_0)

	if var_6_4 then
		local var_6_10 = lua_survival_equip_found.configDict[arg_6_0._equipBox.maxTagId]

		if var_6_10 then
			UISpriteSetMgr.instance:setSurvivalSprite(var_6_4, var_6_10.value)

			var_6_5.text = arg_6_2.equipValues[var_6_10.value] or 0
		end
	end
end

function var_0_0._onClickItem(arg_7_0, arg_7_1)
	arg_7_0._infoPanel:updateMo(arg_7_1._mo)
end

function var_0_0.onClickModalMask(arg_8_0)
	arg_8_0:closeThis()
end

return var_0_0
