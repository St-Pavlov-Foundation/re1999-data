module("modules.logic.herogrouppreset.view.HeroGroupPresetTeamHeroItem", package.seeall)

local var_0_0 = class("HeroGroupPresetTeamHeroItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclickequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_equipicon/#btn_clickequip")
	arg_1_0._btnclickhero = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_clickhero")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclickequip:AddClickListener(arg_2_0._btnclickequipOnClick, arg_2_0)
	arg_2_0._btnclickhero:AddClickListener(arg_2_0._btnclickheroOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclickequip:RemoveClickListener()
	arg_3_0._btnclickhero:RemoveClickListener()
end

function var_0_0._btnclickheroOnClick(arg_4_0)
	if not arg_4_0._unLock then
		local var_4_0, var_4_1 = HeroGroupModel.instance:getPositionLockDesc(arg_4_0._index)

		GameFacade.showToast(var_4_0, var_4_1)

		return
	end

	if HeroGroupPresetController.instance:isFightScene() then
		GameFacade.showToast(ToastEnum.HeroGroupPresetCannotEditTip)

		return
	end

	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.ClickHero, arg_4_0._heroGroupMo, arg_4_0._index)
end

function var_0_0._btnclickequipOnClick(arg_5_0)
	if not arg_5_0._unLock then
		local var_5_0, var_5_1 = HeroGroupModel.instance:getPositionLockDesc(arg_5_0._index)

		GameFacade.showToast(var_5_0, var_5_1)

		return
	end

	if HeroGroupPresetController.instance:isFightScene() then
		GameFacade.showToast(ToastEnum.HeroGroupPresetCannotEditTip)

		return
	end

	local var_5_2 = {
		heroMo = arg_5_0._heroMO,
		equipMo = arg_5_0._equipMO,
		posIndex = arg_5_0._index - 1,
		fromView = EquipEnum.FromViewEnum.FromPresetPreviewView
	}

	if arg_5_0.trialCO then
		var_5_2.heroMo = HeroGroupTrialModel.instance:getHeroMo(arg_5_0.trialCO)

		if arg_5_0.trialCO.equipId > 0 then
			var_5_2.equipMo = var_5_2.heroMo.trialEquipMo
		end
	end

	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.ClickEquip, arg_5_0._heroGroupMo, var_5_2)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.gocontainer = gohelper.findChild(arg_6_0.viewGO, "go_container")
	arg_6_0.simageheroicon = gohelper.findChildSingleImage(arg_6_0.viewGO, "go_container/simage_heroicon")
	arg_6_0.imagecareer = gohelper.findChildImage(arg_6_0.viewGO, "go_container/image_career")
	arg_6_0.goaidtag = gohelper.findChild(arg_6_0.viewGO, "go_container/go_aidtag")
	arg_6_0.gostorytag = gohelper.findChild(arg_6_0.viewGO, "go_container/go_storytag")
	arg_6_0.imageinsight = gohelper.findChildImage(arg_6_0.viewGO, "go_container/level/layout/image_insight")
	arg_6_0.txtlevel = gohelper.findChildText(arg_6_0.viewGO, "go_container/level/layout/txt_level")
	arg_6_0.goempty = gohelper.findChild(arg_6_0.viewGO, "go_empty")
	arg_6_0.golock = gohelper.findChild(arg_6_0.viewGO, "go_lock")
	arg_6_0.goleader = gohelper.findChild(arg_6_0.viewGO, "go_container/go_leader")
	arg_6_0.goequip = gohelper.findChild(arg_6_0.viewGO, "go_equipicon")
	arg_6_0.goequipempty = gohelper.findChild(arg_6_0.viewGO, "go_equipicon/empty")
	arg_6_0.equipicon = gohelper.findChildSingleImage(arg_6_0.viewGO, "go_equipicon/equipicon")

	gohelper.setActive(arg_6_0.goleader, false)
end

function var_0_0._editableAddEvents(arg_7_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_7_0._onCloseViewFinish, arg_7_0)
end

function var_0_0._editableRemoveEvents(arg_8_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_8_0._onCloseViewFinish, arg_8_0)
end

function var_0_0._onCloseViewFinish(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.CharacterSkinView then
		arg_9_0:_updateHeroIcon()
	end
end

function var_0_0._updateHeroIcon(arg_10_0)
	local var_10_0
	local var_10_1
	local var_10_2
	local var_10_3 = arg_10_0._heroData

	if var_10_3 then
		local var_10_4 = var_10_3.heroId
		local var_10_5 = HeroConfig.instance:getHeroCO(var_10_4)
		local var_10_6 = HeroModel.instance:getByHeroId(var_10_4)
		local var_10_7 = var_10_6 and var_10_6.skin or var_10_5.skinId
		local var_10_8 = SkinConfig.instance:getSkinCo(var_10_7)

		arg_10_0.simageheroicon:LoadImage(ResUrl.getHeadIconSmall(var_10_8.headIcon))
	end
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_0._heroData = arg_11_2
	arg_11_0._heroGroupMo = arg_11_3
	arg_11_0._index = arg_11_4
	arg_11_0._singleGroupMo = arg_11_1
	arg_11_0._heroMO = arg_11_1:getHeroMO()
	arg_11_0.trialCO = arg_11_1:getTrialCO()
	arg_11_0._unLock = HeroGroupModel.instance:isPositionOpen(arg_11_0._index)

	gohelper.setActive(arg_11_0.golock, not arg_11_0._unLock)
	gohelper.setActive(arg_11_0.goequip, OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip))

	local var_11_0
	local var_11_1
	local var_11_2
	local var_11_3
	local var_11_4

	if arg_11_2 then
		local var_11_5 = arg_11_2.heroId

		var_11_1 = HeroConfig.instance:getHeroCO(var_11_5)

		local var_11_6 = HeroModel.instance:getByHeroId(var_11_5)
		local var_11_7 = var_11_6 and var_11_6.skin or var_11_1.skinId

		var_11_0 = SkinConfig.instance:getSkinCo(var_11_7)
		var_11_2, var_11_3 = HeroConfig.instance:getShowLevel(arg_11_2.level)
	elseif arg_11_0.trialCO then
		local var_11_8 = arg_11_0.trialCO.heroId

		var_11_1 = HeroConfig.instance:getHeroCO(arg_11_0.trialCO.heroId)

		if arg_11_0.trialCO.skin > 0 then
			var_11_0 = SkinConfig.instance:getSkinCo(arg_11_0.trialCO.skin)
		else
			var_11_0 = SkinConfig.instance:getSkinCo(var_11_1.skinId)
		end

		var_11_2, var_11_3 = HeroConfig.instance:getShowLevel(arg_11_0.trialCO.level)
	end

	gohelper.setActive(arg_11_0.gocontainer, var_11_1)
	gohelper.setActive(arg_11_0.goempty, not var_11_1)

	if var_11_1 then
		gohelper.setActive(arg_11_0.gostorytag, false)
		gohelper.setActive(arg_11_0.goaidtag, arg_11_0.trialCO)

		arg_11_0.txtlevel.text = arg_11_0:getShowLevelText(var_11_2)

		if var_11_3 > 1 then
			UISpriteSetMgr.instance:setHeroGroupSprite(arg_11_0.imageinsight, "biandui_dongxi_" .. tostring(var_11_3 - 1))
			gohelper.setActive(arg_11_0.imageinsight.gameObject, true)
		else
			gohelper.setActive(arg_11_0.imageinsight.gameObject, false)
		end

		arg_11_0.simageheroicon:LoadImage(ResUrl.getHeadIconSmall(var_11_0.headIcon))
		UISpriteSetMgr.instance:setCommonSprite(arg_11_0.imagecareer, "lssx_" .. tostring(var_11_1.career))
	end

	local var_11_9 = arg_11_3 and arg_11_3:getPosEquips(arg_11_4 - 1).equipUid
	local var_11_10 = var_11_9 and var_11_9[1]
	local var_11_11 = var_11_10 and EquipModel.instance:getEquip(var_11_10) or var_11_10 and HeroGroupTrialModel.instance:getEquipMo(var_11_10)
	local var_11_12 = var_11_11 ~= nil

	gohelper.setActive(arg_11_0.goequipempty, not var_11_12)
	gohelper.setActive(arg_11_0.equipicon, var_11_12)

	if var_11_12 then
		arg_11_0.equipicon:LoadImage(ResUrl.getEquipIcon(var_11_11.config.icon))
	end

	arg_11_0._equipMo = var_11_11

	local var_11_13

	if arg_11_0.trialCO and arg_11_0.trialCO.equipId > 0 then
		local var_11_14 = EquipConfig.instance:getEquipCo(arg_11_0.trialCO.equipId)
		local var_11_15 = EquipConfig.instance:getEquipCo(arg_11_0.trialCO.equipId)
		local var_11_16 = var_11_15 ~= nil

		gohelper.setActive(arg_11_0.goequipempty, not var_11_16)
		gohelper.setActive(arg_11_0.equipicon, var_11_16)

		if var_11_16 then
			arg_11_0.equipicon:LoadImage(ResUrl.getEquipIcon(var_11_15.icon))
		end
	end
end

function var_0_0.getShowLevelText(arg_12_0, arg_12_1)
	return "<size=12>LV.</size>" .. tostring(arg_12_1)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
