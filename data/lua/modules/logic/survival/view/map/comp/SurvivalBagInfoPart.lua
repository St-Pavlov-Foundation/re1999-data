module("modules.logic.survival.view.map.comp.SurvivalBagInfoPart", package.seeall)

local var_0_0 = class("SurvivalBagInfoPart", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_1, "")
	arg_1_0.go = arg_1_1
	arg_1_0.parent = arg_1_1.transform.parent
	arg_1_0._goinfo = gohelper.findChild(arg_1_1, "root/#go_info")
	arg_1_0._goempty = gohelper.findChild(arg_1_1, "root/#go_empty")
	arg_1_0._goprice = gohelper.findChild(arg_1_1, "root/#go_info/top/right/price")
	arg_1_0._txtprice = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/right/price/#txt_price")
	arg_1_0._goheavy = gohelper.findChild(arg_1_1, "root/#go_info/top/right/heavy")
	arg_1_0._txtheavy = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/right/heavy/#txt_heavy")
	arg_1_0._goequipTagItem = gohelper.findChild(arg_1_1, "root/#go_info/top/right/tag/go_item")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/middle/#txt_name")
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/middle/#txt_num")
	arg_1_0._gonpc = gohelper.findChild(arg_1_1, "root/#go_info/top/middle/npc")
	arg_1_0._imagenpc = gohelper.findChildImage(arg_1_1, "root/#go_info/top/middle/npc/#simage_chess")
	arg_1_0._goitem = gohelper.findChild(arg_1_1, "root/#go_info/top/middle/collection")
	arg_1_0._imageitem = gohelper.findChildSingleImage(arg_1_1, "root/#go_info/top/middle/collection/#simage_icon")
	arg_1_0._imageitemrare = gohelper.findChildImage(arg_1_1, "root/#go_info/top/middle/collection/#image_quailty2")
	arg_1_0._btnremove = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/#btn_remove")
	arg_1_0._btnleave = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/#btn_leave")
	arg_1_0._goTips = gohelper.findChild(arg_1_1, "root/#go_info/top/left/go_tips")
	arg_1_0._btncloseTips = gohelper.findChildClick(arg_1_1, "root/#go_info/top/left/go_tips/#btn_close")
	arg_1_0._btntipremove = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/go_tips/#btn_remove")
	arg_1_0._btntipleave = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/go_tips/#btn_leave")
	arg_1_0._txthave = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/left/go_tips/#txt_currency")
	arg_1_0._txtremain = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/left/go_tips/#txt_after")
	arg_1_0._gotipsnum = gohelper.findChild(arg_1_1, "root/#go_info/top/left/go_tips/#go_num")
	arg_1_0._inputtipnum = gohelper.findChildTextMeshInputField(arg_1_1, "root/#go_info/top/left/go_tips/#go_num/valuebg/#input_value")
	arg_1_0._btntipsaddnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/go_tips/#go_num/#btn_add")
	arg_1_0._btntipssubnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/go_tips/#go_num/#btn_sub")
	arg_1_0._btngoequip = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_goequip")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_use")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_equip")
	arg_1_0._btnunequip = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_unequip")
	arg_1_0._btnsearch = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_search")
	arg_1_0._btnsell = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_sell")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_buy")
	arg_1_0._btnplace = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_place")
	arg_1_0._btnunplace = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_unplace")
	arg_1_0._gonum = gohelper.findChild(arg_1_1, "root/#go_info/bottom/#go_num")
	arg_1_0._txtcount = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/bottom/#go_num/#txt_count")
	arg_1_0._goicon1 = gohelper.findChild(arg_1_1, "root/#go_info/bottom/#go_num/#txt_count/icon1")
	arg_1_0._goicon2 = gohelper.findChild(arg_1_1, "root/#go_info/bottom/#go_num/#txt_count/icon2")
	arg_1_0._goinput = gohelper.findChild(arg_1_1, "root/#go_info/bottom/#go_num/valuebg")
	arg_1_0._inputnum = gohelper.findChildTextMeshInputField(arg_1_1, "root/#go_info/bottom/#go_num/valuebg/#input_value")
	arg_1_0._btnaddnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#go_num/#btn_add")
	arg_1_0._btnsubnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#go_num/#btn_sub")
	arg_1_0._btnmaxnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#go_num/#btn_max")
	arg_1_0._btnminnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#go_num/#btn_min")
	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_select")
	arg_1_0._goscore = gohelper.findChild(arg_1_1, "root/#go_info/#go_score")
	arg_1_0._txtscore = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/#go_score/image_NumBG/#txt_Num")
	arg_1_0._imagescore = gohelper.findChildImage(arg_1_1, "root/#go_info/#go_score/image_NumBG/image_AssessIon")
	arg_1_0._goattritem = gohelper.findChild(arg_1_1, "root/#go_info/scroll_base/Viewport/Content/#go_attrs/#go_baseitem")
	arg_1_0._goFrequency = gohelper.findChild(arg_1_1, "root/#go_info/Frequency")
	arg_1_0._imageFrequency = gohelper.findChildImage(arg_1_1, "root/#go_info/Frequency/image_NumBG/#txt_Num/image_FrequencyIcon")
	arg_1_0._txtFrequency = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/Frequency/image_NumBG/#txt_Num")
	arg_1_0._txtFrequencyName = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/Frequency/txt_Frequency")
	arg_1_0._goscroll = gohelper.findChild(arg_1_1, "root/#go_info/scroll_base")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_close")

	gohelper.setActive(arg_1_0._btnClose, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnremove:AddClickListener(arg_2_0._openTips, arg_2_0)
	arg_2_0._btnleave:AddClickListener(arg_2_0._openTips, arg_2_0)
	arg_2_0._btncloseTips:AddClickListener(arg_2_0._closeTips, arg_2_0)
	arg_2_0._btntipremove:AddClickListener(arg_2_0._removeItem, arg_2_0)
	arg_2_0._btntipleave:AddClickListener(arg_2_0._removeItem, arg_2_0)
	arg_2_0._inputtipnum:AddOnEndEdit(arg_2_0._ontipnuminputChange, arg_2_0)
	arg_2_0._btntipsaddnum:AddClickListener(arg_2_0._addtipnum, arg_2_0, 1)
	arg_2_0._btntipssubnum:AddClickListener(arg_2_0._addtipnum, arg_2_0, -1)
	arg_2_0._btngoequip:AddClickListener(arg_2_0._onGoEquipClick, arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._onUseClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._onEquipClick, arg_2_0)
	arg_2_0._btnunequip:AddClickListener(arg_2_0._onUnEquipClick, arg_2_0)
	arg_2_0._btnsearch:AddClickListener(arg_2_0._onSearchClick, arg_2_0)
	arg_2_0._btnsell:AddClickListener(arg_2_0._onSellClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._onBuyClick, arg_2_0)
	arg_2_0._btnplace:AddClickListener(arg_2_0._onPlaceClick, arg_2_0)
	arg_2_0._btnunplace:AddClickListener(arg_2_0._onUnPlaceClick, arg_2_0)
	arg_2_0._inputnum:AddOnEndEdit(arg_2_0._ontnuminputChange, arg_2_0)
	arg_2_0._btnaddnum:AddClickListener(arg_2_0._onAddNumClick, arg_2_0, 1)
	arg_2_0._btnsubnum:AddClickListener(arg_2_0._onAddNumClick, arg_2_0, -1)
	arg_2_0._btnmaxnum:AddClickListener(arg_2_0._onMaxNumClick, arg_2_0)
	arg_2_0._btnminnum:AddClickListener(arg_2_0._onMinNumClick, arg_2_0)
	arg_2_0._btnselect:AddClickListener(arg_2_0._onSelectClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._onClickCloseTips, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnremove:RemoveClickListener()
	arg_3_0._btnleave:RemoveClickListener()
	arg_3_0._btncloseTips:RemoveClickListener()
	arg_3_0._btntipremove:RemoveClickListener()
	arg_3_0._btntipleave:RemoveClickListener()
	arg_3_0._inputtipnum:RemoveOnEndEdit()
	arg_3_0._btntipsaddnum:RemoveClickListener()
	arg_3_0._btntipssubnum:RemoveClickListener()
	arg_3_0._btngoequip:RemoveClickListener()
	arg_3_0._btnuse:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnunequip:RemoveClickListener()
	arg_3_0._btnsearch:RemoveClickListener()
	arg_3_0._btnsell:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnplace:RemoveClickListener()
	arg_3_0._btnunplace:RemoveClickListener()
	arg_3_0._inputnum:RemoveOnEndEdit()
	arg_3_0._btnaddnum:RemoveClickListener()
	arg_3_0._btnsubnum:RemoveClickListener()
	arg_3_0._btnmaxnum:RemoveClickListener()
	arg_3_0._btnminnum:RemoveClickListener()
	arg_3_0._btnselect:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._onSelectClick(arg_4_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickBagItem, arg_4_0.mo)
end

function var_0_0._openTips(arg_5_0)
	gohelper.setActive(arg_5_0._goTips, true)
end

function var_0_0._closeTips(arg_6_0)
	gohelper.setActive(arg_6_0._goTips, false)
end

function var_0_0.setIsShowEmpty(arg_7_0, arg_7_1)
	arg_7_0._isShowEmpty = arg_7_1
end

function var_0_0.setCloseShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	gohelper.setActive(arg_8_0._btnClose, arg_8_1)

	arg_8_0._clickCloseCallback = arg_8_2
	arg_8_0._clickCloseCallobj = arg_8_3
end

function var_0_0._onClickCloseTips(arg_9_0)
	arg_9_0:updateMo()

	if arg_9_0._clickCloseCallback then
		arg_9_0._clickCloseCallback(arg_9_0._clickCloseCallobj)
	end
end

function var_0_0.setChangeSource(arg_10_0, arg_10_1)
	arg_10_0._changeSourceDict = arg_10_1
end

function var_0_0.getItemSource(arg_11_0)
	return arg_11_0._changeSourceDict and arg_11_0._changeSourceDict[arg_11_0.mo.source] or arg_11_0.mo.source
end

function var_0_0.setHideParent(arg_12_0, arg_12_1)
	arg_12_0.parent = arg_12_1
end

function var_0_0.updateMo(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goTips, false)

	local var_13_0 = arg_13_1 and arg_13_0.mo and arg_13_1 ~= arg_13_0.mo

	arg_13_0.mo = arg_13_1

	if arg_13_0._isShowEmpty then
		gohelper.setActive(arg_13_0._goinfo, arg_13_1)
		gohelper.setActive(arg_13_0._goempty, not arg_13_1)
	else
		gohelper.setActive(arg_13_0.parent, arg_13_1)
	end

	if var_13_0 then
		arg_13_0._anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(arg_13_0._refreshAll, arg_13_0, 0.167)
	else
		arg_13_0:_refreshAll()
	end
end

function var_0_0._refreshAll(arg_14_0)
	if arg_14_0.mo then
		arg_14_0:updatePrice()
		arg_14_0:updateHeavy()
		arg_14_0:updateEquipTag()
		arg_14_0:updateBaseInfo()
	end
end

function var_0_0.updatePrice(arg_15_0)
	local var_15_0 = arg_15_0.mo.co.worth

	gohelper.setActive(arg_15_0._goprice, not arg_15_0.mo:isNPC() and not arg_15_0.mo:isCurrency())

	arg_15_0._txtprice.text = var_15_0
end

function var_0_0.updateHeavy(arg_16_0)
	local var_16_0 = arg_16_0.mo.co.mass

	gohelper.setActive(arg_16_0._goheavy, var_16_0 > 0 and not arg_16_0.mo:isCurrency())

	arg_16_0._txtheavy.text = var_16_0
end

function var_0_0.updateEquipTag(arg_17_0)
	local var_17_0 = {}

	if arg_17_0.mo.equipCo then
		var_17_0 = string.splitToNumber(arg_17_0.mo.equipCo.tag, "#") or {}
	end

	gohelper.CreateObjList(arg_17_0, arg_17_0._createEquipTag, var_17_0, nil, arg_17_0._goequipTagItem)
end

function var_0_0._createEquipTag(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = gohelper.findChildImage(arg_18_1, "#image_tag")
	local var_18_1 = lua_survival_equip_found.configDict[arg_18_2]

	if not var_18_1 then
		return
	end

	UISpriteSetMgr.instance:setSurvivalSprite(var_18_0, var_18_1.icon4)
end

function var_0_0.updateBaseInfo(arg_19_0)
	local var_19_0 = luaLang("multiple")

	arg_19_0._txtname.text = arg_19_0.mo.co.name

	if arg_19_0.mo.count > 1 then
		arg_19_0._txtnum.text = var_19_0 .. arg_19_0.mo.count
	else
		arg_19_0._txtnum.text = ""
	end

	local var_19_1 = arg_19_0:getItemSource()
	local var_19_2 = var_19_1 == SurvivalEnum.ItemSource.Search or arg_19_0.mo.co.disposable == 0 and not arg_19_0.mo:isCurrency() and (var_19_1 == SurvivalEnum.ItemSource.Map or var_19_1 == SurvivalEnum.ItemSource.Shelter)

	gohelper.setActive(arg_19_0._btnleave, var_19_2 and arg_19_0.mo.npcCo)
	gohelper.setActive(arg_19_0._btntipleave, arg_19_0.mo.npcCo)
	gohelper.setActive(arg_19_0._btnremove, var_19_2 and not arg_19_0.mo.npcCo)
	gohelper.setActive(arg_19_0._btntipremove, not arg_19_0.mo.npcCo)
	gohelper.setActive(arg_19_0._gonpc, arg_19_0.mo.npcCo)
	gohelper.setActive(arg_19_0._goitem, not arg_19_0.mo.npcCo)

	if arg_19_0.mo.npcCo then
		UISpriteSetMgr.instance:setV2a2ChessSprite(arg_19_0._imagenpc, arg_19_0.mo.npcCo.headIcon, false)
	else
		UISpriteSetMgr.instance:setSurvivalSprite(arg_19_0._imageitemrare, "survival_bag_itemquality2_" .. arg_19_0.mo.co.rare, false)
		arg_19_0._imageitem:LoadImage(ResUrl.getSurvivalItemIcon(arg_19_0.mo.co.icon))
	end

	arg_19_0:updateTipCountShow()
	arg_19_0:updateBtnsShow()
	arg_19_0:updateCenterShow()
end

function var_0_0.updateTipCountShow(arg_20_0)
	arg_20_0._inputtipnum:SetText(arg_20_0.mo.count)

	if arg_20_0.mo.count <= 1 then
		gohelper.setActive(arg_20_0._gotipsnum, false)
		gohelper.setActive(arg_20_0._txthave, false)
		gohelper.setActive(arg_20_0._txtremain, false)
	else
		gohelper.setActive(arg_20_0._gotipsnum, true)

		if arg_20_0:getItemSource() ~= SurvivalEnum.ItemSource.Search then
			gohelper.setActive(arg_20_0._txthave, true)
			gohelper.setActive(arg_20_0._txtremain, true)
			arg_20_0:updateTipCount()
		else
			gohelper.setActive(arg_20_0._txthave, false)
			gohelper.setActive(arg_20_0._txtremain, false)
		end
	end
end

local var_0_1 = {
	490,
	346,
	313,
	284.9,
	317.9
}

function var_0_0.updateBtnsShow(arg_21_0)
	local var_21_0 = 1

	arg_21_0._inputnum:SetText(arg_21_0.mo.count)
	gohelper.setActive(arg_21_0._btngoequip, false)
	gohelper.setActive(arg_21_0._btnuse, false)
	gohelper.setActive(arg_21_0._btnequip, false)
	gohelper.setActive(arg_21_0._btnunequip, false)
	gohelper.setActive(arg_21_0._btnsearch, false)
	gohelper.setActive(arg_21_0._btnsell, false)
	gohelper.setActive(arg_21_0._btnbuy, false)
	gohelper.setActive(arg_21_0._btnplace, false)
	gohelper.setActive(arg_21_0._btnunplace, false)
	gohelper.setActive(arg_21_0._gonum, false)
	gohelper.setActive(arg_21_0._txtcount, false)
	gohelper.setActive(arg_21_0._goicon1, false)
	gohelper.setActive(arg_21_0._goicon2, false)
	gohelper.setActive(arg_21_0._btnselect, false)

	if arg_21_0:getItemSource() == SurvivalEnum.ItemSource.Search then
		gohelper.setActive(arg_21_0._btnsearch, true)
		gohelper.setActive(arg_21_0._gonum, arg_21_0.mo.count > 1)

		var_21_0 = arg_21_0.mo.count > 1 and 3 or 2
	end

	if arg_21_0:getItemSource() == SurvivalEnum.ItemSource.Map and not SurvivalMapModel.instance:getSceneMo().panel then
		if arg_21_0.mo.equipCo then
			var_21_0 = 2

			gohelper.setActive(arg_21_0._btngoequip, true)
		elseif arg_21_0.mo.co.type == SurvivalEnum.ItemType.Quick then
			var_21_0 = 2

			gohelper.setActive(arg_21_0._btnuse, true)
		end
	end

	if arg_21_0:getItemSource() == SurvivalEnum.ItemSource.Equip then
		var_21_0 = 2

		gohelper.setActive(arg_21_0._btnunequip, true)
	end

	if arg_21_0:getItemSource() == SurvivalEnum.ItemSource.EquipBag then
		var_21_0 = 2

		gohelper.setActive(arg_21_0._btnequip, true)
	end

	if arg_21_0:getItemSource() == SurvivalEnum.ItemSource.Commit then
		gohelper.setActive(arg_21_0._txtcount, true)
		gohelper.setActive(arg_21_0._goicon1, true)
		gohelper.setActive(arg_21_0._gonum, arg_21_0.mo.count > 1)
		gohelper.setActive(arg_21_0._btnplace, true)

		var_21_0 = arg_21_0.mo.count > 1 and 4 or 5

		arg_21_0._inputnum:SetText("1")
	end

	if arg_21_0:getItemSource() == SurvivalEnum.ItemSource.Commited then
		gohelper.setActive(arg_21_0._txtcount, true)
		gohelper.setActive(arg_21_0._goicon1, true)
		gohelper.setActive(arg_21_0._gonum, arg_21_0.mo.count > 1)
		gohelper.setActive(arg_21_0._btnunplace, true)

		var_21_0 = arg_21_0.mo.count > 1 and 4 or 5
	end

	if arg_21_0:getItemSource() == SurvivalEnum.ItemSource.Composite then
		var_21_0 = 2

		gohelper.setActive(arg_21_0._btnselect, true)
	end

	if arg_21_0:getItemSource() == SurvivalEnum.ItemSource.ShopBag then
		var_21_0 = 4

		gohelper.setActive(arg_21_0._txtcount, true)
		gohelper.setActive(arg_21_0._goicon2, true)
		gohelper.setActive(arg_21_0._gonum, true)
		gohelper.setActive(arg_21_0._btnsell, true)
	end

	if arg_21_0:getItemSource() == SurvivalEnum.ItemSource.ShopItem then
		var_21_0 = 4

		gohelper.setActive(arg_21_0._txtcount, true)
		gohelper.setActive(arg_21_0._goicon2, true)
		gohelper.setActive(arg_21_0._gonum, true)
		gohelper.setActive(arg_21_0._btnbuy, true)
		arg_21_0._inputnum:SetText("1")
	end

	recthelper.setHeight(arg_21_0._goscroll.transform, var_0_1[var_21_0])
	arg_21_0:onInputValueChange()
end

function var_0_0.updateCenterShow(arg_22_0)
	gohelper.setActive(arg_22_0._goscore, arg_22_0.mo.co.type == SurvivalEnum.ItemType.Equip)

	local var_22_0 = {}

	gohelper.setActive(arg_22_0._goFrequency, false)

	if arg_22_0.mo.equipCo then
		local var_22_1, var_22_2 = arg_22_0.mo:getEquipScoreLevel()

		UISpriteSetMgr.instance:setSurvivalSprite(arg_22_0._imagescore, "survivalequip_scoreicon_" .. var_22_1)

		arg_22_0._txtscore.text = string.format("<color=%s>%s</color>", var_22_2, arg_22_0.mo.equipCo.score + arg_22_0.mo.exScore)

		if arg_22_0.mo.slotMo then
			local var_22_3 = arg_22_0.mo.slotMo.parent.maxTagId
			local var_22_4 = lua_survival_equip_found.configDict[var_22_3]

			if var_22_4 then
				gohelper.setActive(arg_22_0._goFrequency, true)
				UISpriteSetMgr.instance:setSurvivalSprite(arg_22_0._imageFrequency, var_22_4.value)

				arg_22_0._txtFrequency.text = arg_22_0.mo.equipValues and arg_22_0.mo.equipValues[var_22_4.value] or 0

				local var_22_5 = lua_survival_attr.configDict[var_22_4.value]

				arg_22_0._txtFrequencyName.text = var_22_5 and var_22_5.name or ""
			end
		end

		local var_22_6 = arg_22_0.mo:getEquipEffectDesc()

		var_22_0[1] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_effect"),
			list2 = var_22_6
		}
		var_22_0[2] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_info"),
			list = {
				arg_22_0.mo.equipCo.desc
			}
		}
	elseif arg_22_0.mo.npcCo then
		local var_22_7 = string.splitToNumber(arg_22_0.mo.npcCo.tag, "#")

		if var_22_7 then
			for iter_22_0, iter_22_1 in ipairs(var_22_7) do
				local var_22_8 = lua_survival_tag.configDict[iter_22_1]

				table.insert(var_22_0, {
					icon = "survival_bag_title0" .. var_22_8.color,
					desc = var_22_8.name,
					list = {
						var_22_8.desc
					}
				})
			end
		end
	else
		var_22_0[1] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_effect"),
			list = {
				arg_22_0.mo.co.desc1
			}
		}
		var_22_0[2] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_info"),
			list = {
				arg_22_0.mo.co.desc2
			}
		}
	end

	gohelper.CreateObjList(arg_22_0, arg_22_0._createDescItems, var_22_0, nil, arg_22_0._goattritem)
end

function var_0_0._createDescItems(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = gohelper.findChildImage(arg_23_1, "#image_title")
	local var_23_1 = gohelper.findChildTextMesh(arg_23_1, "#image_title/#txt_title")
	local var_23_2 = gohelper.findChild(arg_23_1, "layout/#go_decitem")
	local var_23_3 = gohelper.findChild(arg_23_1, "layout/#go_decitem2")
	local var_23_4 = gohelper.findChild(arg_23_1, "layout/#go_decitem/#txt_desc")
	local var_23_5 = gohelper.findChild(arg_23_1, "layout/#go_decitem2/#txt_desc")

	UISpriteSetMgr.instance:setSurvivalSprite(var_23_0, arg_23_2.icon)

	var_23_1.text = arg_23_2.desc

	gohelper.setActive(var_23_2, arg_23_2.list)
	gohelper.setActive(var_23_3, arg_23_2.list2)

	if arg_23_2.list then
		gohelper.CreateObjList(arg_23_0, arg_23_0._createSubDescItems, arg_23_2.list, nil, var_23_4)
	end

	if arg_23_2.list2 then
		gohelper.CreateObjList(arg_23_0, arg_23_0._createSubDescItems2, arg_23_2.list2, nil, var_23_5)
	end
end

function var_0_0._createSubDescItems(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	gohelper.findChildTextMesh(arg_24_1, "").text = arg_24_2
end

function var_0_0._createSubDescItems2(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = gohelper.findChildTextMesh(arg_25_1, "")
	local var_25_1 = gohelper.findChildImage(arg_25_1, "point")

	MonoHelper.addNoUpdateLuaComOnceToGo(var_25_0.gameObject, SurvivalSkillDescComp):updateInfo(var_25_0, arg_25_2[1], 3028)

	local var_25_2 = arg_25_2[2]

	if arg_25_0:getItemSource() == SurvivalEnum.ItemSource.EquipBag then
		var_25_2 = false
	elseif arg_25_0:getItemSource() ~= SurvivalEnum.ItemSource.Equip then
		var_25_2 = true
	end

	ZProj.UGUIHelper.SetColorAlpha(var_25_0, var_25_2 and 1 or 0.5)

	if var_25_2 then
		var_25_1.color = GameUtil.parseColor("#000000")
	else
		var_25_1.color = GameUtil.parseColor("#808080")
	end
end

function var_0_0._removeItem(arg_26_0)
	local var_26_0 = tonumber(arg_26_0._inputtipnum:GetText()) or 0
	local var_26_1 = Mathf.Clamp(var_26_0, 1, arg_26_0.mo.count)

	if arg_26_0:getItemSource() == SurvivalEnum.ItemSource.Search then
		SurvivalMapModel.instance.isSearchRemove = true

		SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "2#" .. arg_26_0.mo.uid .. "#" .. var_26_1)
	else
		SurvivalWeekRpc.instance:sendSurvivalRemoveBagItem(arg_26_0.mo.source, arg_26_0.mo.uid, var_26_1)
	end

	gohelper.setActive(arg_26_0._goTips, false)
end

function var_0_0._ontipnuminputChange(arg_27_0)
	local var_27_0 = tonumber(arg_27_0._inputtipnum:GetText()) or 0
	local var_27_1 = Mathf.Clamp(var_27_0, 1, arg_27_0.mo.count)

	if tostring(var_27_1) ~= arg_27_0._inputtipnum:GetText() then
		arg_27_0._inputtipnum:SetText(tostring(var_27_1))
		arg_27_0:updateTipCount()
	end
end

function var_0_0._addtipnum(arg_28_0, arg_28_1)
	local var_28_0 = (tonumber(arg_28_0._inputtipnum:GetText()) or 0) + arg_28_1
	local var_28_1 = Mathf.Clamp(var_28_0, 1, arg_28_0.mo.count)

	arg_28_0._inputtipnum:SetText(tostring(var_28_1))
	arg_28_0:updateTipCount()
end

function var_0_0.updateTipCount(arg_29_0)
	if arg_29_0:getItemSource() == SurvivalEnum.ItemSource.Search then
		return
	end

	local var_29_0 = tonumber(arg_29_0._inputtipnum:GetText()) or 0

	arg_29_0._txthave.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_have"), arg_29_0.mo.count)
	arg_29_0._txtremain.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_remain"), arg_29_0.mo.count - var_29_0)
end

function var_0_0.setCurEquipSlot(arg_30_0, arg_30_1)
	arg_30_0._slotId = arg_30_1
end

function var_0_0._onEquipClick(arg_31_0)
	if SurvivalShelterModel.instance:getWeekInfo().equipBox.slots[arg_31_0._slotId].level < arg_31_0.mo.equipLevel then
		GameFacade.showToast(ToastEnum.SurvivalEquipLevelLimit)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalEquipWear(arg_31_0._slotId or 1, arg_31_0.mo.uid)
end

function var_0_0._onUnEquipClick(arg_32_0)
	SurvivalWeekRpc.instance:sendSurvivalEquipDemount(arg_32_0._slotId or 1)
end

function var_0_0._onSearchClick(arg_33_0)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "1#" .. arg_33_0.mo.uid .. "#" .. arg_33_0._inputnum:GetText())
end

function var_0_0._onSellClick(arg_34_0)
	SurvivalWeekRpc.instance:sendSurvivalShopSellRequest(arg_34_0.mo.uid, tonumber(arg_34_0._inputnum:GetText()))
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "SellItem", arg_34_0.mo)
end

function var_0_0._onBuyClick(arg_35_0)
	if not arg_35_0._canBuy then
		GameFacade.showToast(ToastEnum.SurvivalNoMoney)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalShopBuyRequest(arg_35_0.mo.uid, tonumber(arg_35_0._inputnum:GetText()))
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "BuyItem", arg_35_0.mo)
end

function var_0_0._onGoEquipClick(arg_36_0)
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

function var_0_0._onUseClick(arg_37_0)
	if SurvivalMapHelper.instance:isInFlow() then
		GameFacade.showToast(ToastEnum.SurvivalCantUseItem)

		return
	end

	if SurvivalEnum.CustomUseItemSubType[arg_37_0.mo.co.subType] then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnUseQuickItem, arg_37_0.mo)
		ViewMgr.instance:closeAllPopupViews()
	else
		SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(arg_37_0.mo.uid, "")
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "Use", arg_37_0.mo)
end

function var_0_0._onPlaceClick(arg_38_0)
	local var_38_0 = tonumber(arg_38_0._inputnum:GetText()) or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "Place", arg_38_0.mo, var_38_0)
end

function var_0_0._onUnPlaceClick(arg_39_0)
	local var_39_0 = tonumber(arg_39_0._inputnum:GetText()) or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "UnPlace", arg_39_0.mo, var_39_0)
end

function var_0_0._ontnuminputChange(arg_40_0)
	local var_40_0 = tonumber(arg_40_0._inputnum:GetText()) or 0
	local var_40_1 = Mathf.Clamp(var_40_0, 1, arg_40_0.mo.count)

	if tostring(var_40_1) ~= arg_40_0._inputnum:GetText() then
		arg_40_0._inputnum:SetText(tostring(var_40_1))
	end

	arg_40_0:onInputValueChange()
end

function var_0_0._onAddNumClick(arg_41_0, arg_41_1)
	local var_41_0 = (tonumber(arg_41_0._inputnum:GetText()) or 0) + arg_41_1
	local var_41_1 = Mathf.Clamp(var_41_0, 1, arg_41_0.mo.count)

	arg_41_0._inputnum:SetText(tostring(var_41_1))
	arg_41_0:onInputValueChange()
end

function var_0_0.onInputValueChange(arg_42_0)
	local var_42_0 = tonumber(arg_42_0._inputnum:GetText()) or 0
	local var_42_1 = arg_42_0:getItemSource()

	if var_42_1 == SurvivalEnum.ItemSource.Commit or var_42_1 == SurvivalEnum.ItemSource.Commited then
		local var_42_2 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.NpcRecruitment, arg_42_0.mo.co.worth)

		arg_42_0._txtcount.text = var_42_0 * var_42_2
	end

	if var_42_1 == SurvivalEnum.ItemSource.ShopBag then
		arg_42_0._txtcount.text = var_42_0 * arg_42_0.mo:getSellPrice()
	end

	if var_42_1 == SurvivalEnum.ItemSource.ShopItem then
		local var_42_3 = SurvivalShelterModel.instance:getWeekInfo()
		local var_42_4 = var_42_3.bag

		if var_42_3.inSurvival then
			var_42_4 = SurvivalMapModel.instance:getSceneMo().bag
		end

		local var_42_5 = var_42_4:getCurrencyNum(SurvivalEnum.CurrencyType.Gold)
		local var_42_6 = var_42_0 * arg_42_0.mo:getBuyPrice()

		arg_42_0._canBuy = var_42_6 <= var_42_5

		if var_42_6 <= var_42_5 then
			arg_42_0._txtcount.text = string.format("%d/%d", var_42_5, var_42_6)
		else
			arg_42_0._txtcount.text = string.format("<color=#ec4747>%d</color>/%d", var_42_5, var_42_6)
		end
	end
end

function var_0_0._onMaxNumClick(arg_43_0)
	arg_43_0._inputnum:SetText(arg_43_0.mo.count)
	arg_43_0:onInputValueChange()
end

function var_0_0._onMinNumClick(arg_44_0)
	arg_44_0._inputnum:SetText(1)
	arg_44_0:onInputValueChange()
end

function var_0_0.onDestroy(arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0._refreshAll, arg_45_0)
end

return var_0_0
