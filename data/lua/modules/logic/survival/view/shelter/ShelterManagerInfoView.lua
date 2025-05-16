module("modules.logic.survival.view.shelter.ShelterManagerInfoView", package.seeall)

local var_0_0 = class("ShelterManagerInfoView", LuaCompBase)

function var_0_0.getView(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = gohelper.clone(arg_1_0, arg_1_1, arg_1_2)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0.transform = arg_2_1.transform
	arg_2_0.goRoot = gohelper.findChild(arg_2_0.viewGO, "root")
	arg_2_0.btnClose = gohelper.findChildButtonWithAudio(arg_2_0.goRoot, "#btn_close")

	gohelper.setActive(arg_2_0.btnClose, false)
	arg_2_0:initNpc()
	arg_2_0:initbuild()

	arg_2_0.goEmpty = gohelper.findChild(arg_2_0.goRoot, "#go_empty")
	arg_2_0.animator = arg_2_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.initNpc(arg_3_0)
	arg_3_0.goNpc = gohelper.findChild(arg_3_0.goRoot, "#go_npc")
	arg_3_0.imgNpcQuality = gohelper.findChildImage(arg_3_0.goNpc, "top/middle/npc/#image_quality")
	arg_3_0.imgNpcChess = gohelper.findChildImage(arg_3_0.goNpc, "top/middle/npc/#image_chess")
	arg_3_0.txtNpcName = gohelper.findChildTextMesh(arg_3_0.goNpc, "top/middle/npc/#txt_name")
	arg_3_0.goNpcReset = gohelper.findChild(arg_3_0.goNpc, "top/left/rest")
	arg_3_0.btnNpcLeave = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_leave")
	arg_3_0.btnNpcGoto = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_goto")
	arg_3_0.btnNpcReset = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_rest")
	arg_3_0.btnNpcJoin = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_join")
	arg_3_0.btnNpcSelect = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_select")
	arg_3_0.btnNpcUnSelect = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_unSelect")
	arg_3_0.goNpcAttrItem = gohelper.findChild(arg_3_0.goNpc, "scroll_base/Viewport/Content/#go_attrs/#go_baseitem")

	gohelper.setActive(arg_3_0.goNpcAttrItem, false)

	arg_3_0.txtNpcInfo = gohelper.findChildTextMesh(arg_3_0.goNpc, "scroll_base/Viewport/Content/#txt_info")
	arg_3_0.npcAttrList = {}
	arg_3_0.goNpcCost = gohelper.findChild(arg_3_0.goNpc, "right/tips")
	arg_3_0.txtNpcCostTips = gohelper.findChildTextMesh(arg_3_0.goNpcCost, "#txt_tips")
end

function var_0_0.initbuild(arg_4_0)
	arg_4_0.goBuild = gohelper.findChild(arg_4_0.goRoot, "#go_build")
	arg_4_0.imageBuild = gohelper.findChildImage(arg_4_0.goBuild, "top/middle/build/#image_build")
	arg_4_0.simageBuild = gohelper.findChildSingleImage(arg_4_0.goBuild, "top/middle/build/#image_build")
	arg_4_0.goImageBuild = gohelper.findChild(arg_4_0.goBuild, "top/middle/build/#image_build")
	arg_4_0.txtBuildName = gohelper.findChildTextMesh(arg_4_0.goBuild, "top/middle/build/#txt_name")
	arg_4_0.goBuildDestroyed = gohelper.findChild(arg_4_0.goBuild, "top/middle/build/#go_Destroyed")
	arg_4_0.goBuildLocked = gohelper.findChild(arg_4_0.goBuild, "top/middle/build/#go_Locked")
	arg_4_0.btnBuildLevup = gohelper.findChildButtonWithAudio(arg_4_0.goBuild, "bottom/#btn_LevelUp")
	arg_4_0.btnBuild = gohelper.findChildButtonWithAudio(arg_4_0.goBuild, "bottom/#btn_build")
	arg_4_0.btnBuildRepair = gohelper.findChildButtonWithAudio(arg_4_0.goBuild, "bottom/#btn_repair")
	arg_4_0.goBuildLock = gohelper.findChild(arg_4_0.goBuild, "bottom/#go_lock")
	arg_4_0.goBuildLockBuild = gohelper.findChild(arg_4_0.goBuild, "bottom/#go_lock/txt_build")
	arg_4_0.goBuildLockLevup = gohelper.findChild(arg_4_0.goBuild, "bottom/#go_lock/txt_levup")
	arg_4_0.txtBuildLock = gohelper.findChildTextMesh(arg_4_0.goBuild, "bottom/#go_lock/#txt_lock")
	arg_4_0.goBuildCost = gohelper.findChild(arg_4_0.goBuild, "bottom/#go_num")
	arg_4_0.txtBuildCost = gohelper.findChildTextMesh(arg_4_0.goBuild, "bottom/#go_num/#txt_count")
	arg_4_0.goBuildAttrLevelup = gohelper.findChild(arg_4_0.goBuild, "scroll_base/Viewport/Content/#go_attrs/#go_LevelUp")
	arg_4_0.txtBuildLevel1 = gohelper.findChildTextMesh(arg_4_0.goBuildAttrLevelup, "#image_title/#txt_level1")
	arg_4_0.txtBuildLevel2 = gohelper.findChildTextMesh(arg_4_0.goBuildAttrLevelup, "#image_title/#txt_level2")
	arg_4_0.goBuildAttrLevel = gohelper.findChild(arg_4_0.goBuild, "scroll_base/Viewport/Content/#go_attrs/#go_Level")
	arg_4_0.txtBuildLevel = gohelper.findChildTextMesh(arg_4_0.goBuildAttrLevel, "#image_title/#txt_level")
	arg_4_0.txtBuildAttrCurrentItem = gohelper.findChildTextMesh(arg_4_0.goBuild, "scroll_base/Viewport/Content/#go_current/#txt_current")
	arg_4_0.goBuildAttrNext = gohelper.findChild(arg_4_0.goBuild, "scroll_base/Viewport/Content/#go_next")
	arg_4_0.txtBuildAttrNextItem = gohelper.findChildTextMesh(arg_4_0.goBuild, "scroll_base/Viewport/Content/#go_next/#txt_next")
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnClose, arg_5_0.onClickBtnClose, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcGoto, arg_5_0.onClickBtnNpcGoto, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcReset, arg_5_0.onClickBtnNpcReset, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcJoin, arg_5_0.onClickBtnNpcJoin, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnBuildLevup, arg_5_0.onClickBtnBuildLevup, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnBuildRepair, arg_5_0.onClickBtnBuildRepair, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnBuild, arg_5_0.onClickBtnBuild, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcSelect, arg_5_0.onClickBtnNpcSelect, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcLeave, arg_5_0.onClickBtnNpcLeave, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcUnSelect, arg_5_0.onClickBtnNpcUnSelect, arg_5_0)
	arg_5_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_5_0.onShelterBagUpdate, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0:removeClickCb(arg_6_0.btnClose)
	arg_6_0:removeClickCb(arg_6_0.btnNpcGoto)
	arg_6_0:removeClickCb(arg_6_0.btnNpcReset)
	arg_6_0:removeClickCb(arg_6_0.btnNpcJoin)
	arg_6_0:removeClickCb(arg_6_0.btnBuildLevup)
	arg_6_0:removeClickCb(arg_6_0.btnBuildRepair)
	arg_6_0:removeClickCb(arg_6_0.btnBuild)
	arg_6_0:removeClickCb(arg_6_0.btnNpcSelect)
	arg_6_0:removeClickCb(arg_6_0.btnNpcLeave)
	arg_6_0:removeClickCb(arg_6_0.btnNpcUnSelect)
	arg_6_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_6_0.onShelterBagUpdate, arg_6_0)
end

function var_0_0.onShelterBagUpdate(arg_7_0)
	arg_7_0:refreshView()
end

function var_0_0.onClickBtnClose(arg_8_0)
	return
end

function var_0_0.onClickBtnNpcLeave(arg_9_0)
	SurvivalShelterTentListModel.instance:quickSelectNpc(arg_9_0.showId)
end

function var_0_0.onClickBtnNpcJoin(arg_10_0)
	SurvivalShelterTentListModel.instance:quickSelectNpc(arg_10_0.showId)
end

function var_0_0.onClickBtnNpcSelect(arg_11_0)
	SurvivalShelterChooseNpcListModel.instance:setSelectNpcToPos(arg_11_0.showId)
end

function var_0_0.onClickBtnNpcUnSelect(arg_12_0)
	local var_12_0 = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(arg_12_0.showId)

	SurvivalShelterChooseNpcListModel.instance:setSelectNpcToPos(nil, var_12_0)
end

function var_0_0.onClickBtnNpcReset(arg_13_0)
	ViewMgr.instance:openView(ViewName.ShelterTentManagerView)
end

function var_0_0.onClickBtnNpcGoto(arg_14_0)
	SurvivalMapHelper.instance:gotoNpc(arg_14_0.showId)
end

function var_0_0.onClickBtnBuildLevup(arg_15_0)
	local var_15_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_15_1 = var_15_0:getBuildingInfo(arg_15_0.showId)

	if not var_15_1 then
		return
	end

	local var_15_2 = SurvivalConfig.instance:getBuildingConfig(var_15_1.buildingId, var_15_1.level + 1, true)
	local var_15_3, var_15_4, var_15_5, var_15_6 = var_15_0.bag:costIsEnough(var_15_2.lvUpCost, var_15_1, SurvivalEnum.AttrType.BuildCost)

	if not var_15_3 then
		local var_15_7 = lua_survival_item.configDict[var_15_4]

		GameFacade.showToast(ToastEnum.DiamondBuy, var_15_7.name)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalUpgradeRequest(var_15_1.id)
end

function var_0_0.onClickBtnBuild(arg_16_0)
	local var_16_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_16_1 = var_16_0:getBuildingInfo(arg_16_0.showId)

	if not var_16_1 then
		return
	end

	local var_16_2 = SurvivalConfig.instance:getBuildingConfig(var_16_1.buildingId, var_16_1.level + 1, true)
	local var_16_3, var_16_4, var_16_5, var_16_6 = var_16_0.bag:costIsEnough(var_16_2.lvUpCost, var_16_1, SurvivalEnum.AttrType.BuildCost)

	if not var_16_3 then
		local var_16_7 = lua_survival_item.configDict[var_16_4]

		GameFacade.showToast(ToastEnum.DiamondBuy, var_16_7.name)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalBuildRequest(var_16_1.id)
end

function var_0_0.onClickBtnBuildRepair(arg_17_0)
	local var_17_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_17_1 = var_17_0:getBuildingInfo(arg_17_0.showId)

	if not var_17_1 then
		return
	end

	local var_17_2 = SurvivalConfig.instance:getBuildingConfig(var_17_1.buildingId, var_17_1.level, true)
	local var_17_3, var_17_4, var_17_5, var_17_6 = var_17_0.bag:costIsEnough(var_17_2.repairCost, var_17_1, SurvivalEnum.AttrType.RepairCost)

	if not var_17_3 then
		local var_17_7 = lua_survival_item.configDict[var_17_4]

		GameFacade.showToast(ToastEnum.DiamondBuy, var_17_7.name)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalRepairRequest(var_17_1.id)
end

function var_0_0.refreshParam(arg_18_0, arg_18_1)
	arg_18_0.viewParam = arg_18_1 or {}
	arg_18_0.showType = arg_18_0.viewParam.showType or SurvivalEnum.InfoShowType.None
	arg_18_0.showId = arg_18_0.viewParam.showId or 0
	arg_18_0.otherParam = arg_18_0.viewParam.otherParam or {}

	arg_18_0:refreshAnimName()
	arg_18_0:refreshView()
end

function var_0_0.refreshAnimName(arg_19_0)
	local var_19_0 = not arg_19_0.showId

	arg_19_0.animName = nil

	if var_19_0 then
		arg_19_0.animName = UIAnimationName.Open
	elseif arg_19_0.showId ~= arg_19_0.lastShowId or arg_19_0.showType ~= arg_19_0.lastShowType then
		arg_19_0.animName = UIAnimationName.Switch
		arg_19_0.delayRefreshTime = 0.167
	end

	arg_19_0.lastShowId = arg_19_0.showId
	arg_19_0.lastShowType = arg_19_0.showType
end

function var_0_0.refreshView(arg_20_0)
	if arg_20_0.animName then
		arg_20_0.animator:Play(arg_20_0.animName, 0, 0)
	end

	arg_20_0.animName = nil

	TaskDispatcher.cancelTask(arg_20_0.delayRefreshTime, arg_20_0)

	if arg_20_0.delayRefreshTime then
		TaskDispatcher.runDelay(arg_20_0.refreshInfo, arg_20_0, arg_20_0.delayRefreshTime)
	else
		arg_20_0:refreshInfo()
	end

	arg_20_0.delayRefreshTime = nil
end

function var_0_0.refreshInfo(arg_21_0)
	if arg_21_0.showType == SurvivalEnum.InfoShowType.Building then
		arg_21_0:refreshBuilding()
	elseif arg_21_0.showType == SurvivalEnum.InfoShowType.Npc or arg_21_0.showType == SurvivalEnum.InfoShowType.NpcOnlyConfig then
		arg_21_0:refreshNpc()
	else
		arg_21_0:showEmpty()
	end
end

function var_0_0.refreshBuilding(arg_22_0)
	local var_22_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_22_1 = var_22_0:getBuildingInfo(arg_22_0.showId)

	if not var_22_1 then
		arg_22_0:showEmpty()

		return
	end

	gohelper.setActive(arg_22_0.goBuild, true)
	gohelper.setActive(arg_22_0.goNpc, false)
	gohelper.setActive(arg_22_0.goEmpty, false)

	local var_22_2 = var_22_1.level
	local var_22_3 = var_22_2 + 1
	local var_22_4 = SurvivalConfig.instance:getBuildingConfig(var_22_1.buildingId, var_22_2, true)
	local var_22_5 = SurvivalConfig.instance:getBuildingConfig(var_22_1.buildingId, var_22_3, true)

	arg_22_0.txtBuildName.text = var_22_1.baseCo.name

	local var_22_6, var_22_7 = var_22_0:isBuildingUnlock(var_22_1.buildingId, var_22_3, true)
	local var_22_8 = not var_22_1:isBuild()
	local var_22_9 = var_22_1.status == SurvivalEnum.BuildingStatus.Destroy

	gohelper.setActive(arg_22_0.goBuildDestroyed, var_22_9)
	gohelper.setActive(arg_22_0.goBuildLocked, not var_22_6 and var_22_8)
	arg_22_0.simageBuild:LoadImage(var_22_1.baseCo.icon, arg_22_0.onLoadedImage, arg_22_0)
	ZProj.UGUIHelper.SetGrayscale(arg_22_0.goImageBuild, not var_22_6 and var_22_8)
	gohelper.setActive(arg_22_0.btnBuildLevup, false)
	gohelper.setActive(arg_22_0.btnBuild, false)
	gohelper.setActive(arg_22_0.btnBuildRepair, false)
	gohelper.setActive(arg_22_0.goBuildLock, false)
	gohelper.setActive(arg_22_0.goBuildCost, false)

	if var_22_6 then
		if var_22_8 then
			gohelper.setActive(arg_22_0.btnBuild, true)
			arg_22_0:refreshBuildCost(var_22_5 and var_22_5.lvUpCost, var_22_1, SurvivalEnum.AttrType.BuildCost)
		elseif var_22_9 then
			gohelper.setActive(arg_22_0.btnBuildRepair, true)
			arg_22_0:refreshBuildCost(var_22_4 and var_22_4.repairCost, var_22_1, SurvivalEnum.AttrType.RepairCost)
		else
			gohelper.setActive(arg_22_0.btnBuildLevup, var_22_5 ~= nil)
			arg_22_0:refreshBuildCost(var_22_5 and var_22_5.lvUpCost, var_22_1, SurvivalEnum.AttrType.BuildCost)
		end
	else
		gohelper.setActive(arg_22_0.goBuildLock, true)

		arg_22_0.txtBuildLock.text = var_22_7

		gohelper.setActive(arg_22_0.goBuildLockBuild, var_22_8)
		gohelper.setActive(arg_22_0.goBuildLockLevup, not var_22_8)
	end

	local var_22_10 = var_22_1.level > 0 and var_22_5 ~= nil and not var_22_9

	gohelper.setActive(arg_22_0.goBuildAttrLevelup, var_22_10)
	gohelper.setActive(arg_22_0.goBuildAttrLevel, not var_22_10)
	gohelper.setActive(arg_22_0.goBuildAttrNext, var_22_10)

	arg_22_0.txtBuildAttrCurrentItem.text = var_22_4 and var_22_4.desc or var_22_5 and var_22_5.desc or ""

	if var_22_10 then
		arg_22_0.txtBuildAttrNextItem.text = var_22_5.desc
		arg_22_0.txtBuildLevel1.text = string.format("Lv.%s", var_22_2)
		arg_22_0.txtBuildLevel2.text = string.format("Lv.%s", var_22_3)
	else
		arg_22_0.txtBuildLevel.text = string.format("Lv.%s", var_22_2)
	end
end

function var_0_0.onLoadedImage(arg_23_0)
	arg_23_0.imageBuild:SetNativeSize()
end

function var_0_0.refreshBuildCost(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if string.nilorempty(arg_24_1) then
		gohelper.setActive(arg_24_0.goBuildCost, false)
	else
		gohelper.setActive(arg_24_0.goBuildCost, true)

		local var_24_0, var_24_1, var_24_2, var_24_3 = SurvivalShelterModel.instance:getWeekInfo().bag:costIsEnough(arg_24_1, arg_24_2, arg_24_3)

		if var_24_0 then
			arg_24_0.txtBuildCost.text = string.format("%s/%s", var_24_3, var_24_2)
		else
			arg_24_0.txtBuildCost.text = string.format("<color=#D74242>%s</color>/%s", var_24_3, var_24_2)
		end
	end
end

function var_0_0.refreshNpc(arg_25_0)
	if arg_25_0.showType == SurvivalEnum.InfoShowType.NpcOnlyConfig then
		arg_25_0:_refreshNpcOnlyConfig()

		return
	end

	local var_25_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_25_1 = var_25_0:getNpcInfo(arg_25_0.showId)

	if not var_25_1 then
		arg_25_0:showEmpty()

		return
	end

	gohelper.setActive(arg_25_0.goBuild, false)
	gohelper.setActive(arg_25_0.goNpc, true)
	gohelper.setActive(arg_25_0.goEmpty, false)

	local var_25_2 = arg_25_0.otherParam.tentBuildingId
	local var_25_3 = arg_25_0.otherParam.tentBuildingPos
	local var_25_4 = var_25_2 ~= nil and var_25_2 ~= 0
	local var_25_5 = var_25_1.co

	arg_25_0.txtNpcName.text = var_25_5.name

	UISpriteSetMgr.instance:setV2a2ChessSprite(arg_25_0.imgNpcChess, var_25_5.headIcon)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_25_0.imgNpcQuality, string.format("survival_bag_itemquality2_%s", var_25_5.rare))

	arg_25_0.txtNpcInfo.text = var_25_5.npcDesc

	local var_25_6, var_25_7 = var_25_0:getNpcPostion(arg_25_0.showId)
	local var_25_8 = var_25_6 ~= nil

	gohelper.setActive(arg_25_0.goNpcReset, not var_25_4 and var_25_8)
	gohelper.setActive(arg_25_0.btnNpcGoto, not var_25_4 and var_25_8)
	gohelper.setActive(arg_25_0.btnNpcReset, not var_25_4 and not var_25_8)

	local var_25_9 = SurvivalConfig.instance:getNpcConfigTag(arg_25_0.showId)

	for iter_25_0 = 1, math.max(#var_25_9, #arg_25_0.npcAttrList) do
		local var_25_10 = arg_25_0:getNpcAttrItem(iter_25_0)

		arg_25_0:refreshNpcAttrItem(var_25_10, var_25_9[iter_25_0])
	end

	gohelper.setActive(arg_25_0.btnNpcJoin, var_25_4 and var_25_2 ~= var_25_6)
	gohelper.setActive(arg_25_0.btnNpcLeave, var_25_4 and var_25_2 == var_25_6)
	arg_25_0:refreshNpcCost(var_25_5)
end

function var_0_0.refreshNpcCost(arg_26_0, arg_26_1)
	if not arg_26_1 then
		gohelper.setActive(arg_26_0.goNpcCost, false)

		return
	end

	gohelper.setActive(arg_26_0.goNpcCost, true)

	local var_26_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_26_1 = string.split(arg_26_1.cost, "#")
	local var_26_2 = string.splitToNumber(var_26_1[2], ":")[2] or 0
	local var_26_3 = var_26_0:getAttr(SurvivalEnum.AttrType.NpcFoodCost, var_26_2)

	arg_26_0.txtNpcCostTips.text = formatLuaLang("ShelterManagerInfoView_npc_foodcost", var_26_3)
end

function var_0_0._refreshNpcOnlyConfig(arg_27_0)
	gohelper.setActive(arg_27_0.goBuild, false)
	gohelper.setActive(arg_27_0.goNpc, true)
	gohelper.setActive(arg_27_0.goEmpty, false)

	local var_27_0 = SurvivalConfig.instance:getNpcConfig(arg_27_0.showId)

	if var_27_0 then
		arg_27_0.txtNpcName.text = var_27_0.name

		if not string.nilorempty(var_27_0.headIcon) then
			UISpriteSetMgr.instance:setV2a2ChessSprite(arg_27_0.imgNpcChess, var_27_0.headIcon)
		end

		UISpriteSetMgr.instance:setSurvivalSprite(arg_27_0.imgNpcQuality, string.format("survival_bag_itemquality2_%s", var_27_0.rare))

		arg_27_0.txtNpcInfo.text = var_27_0.npcDesc
	end

	gohelper.setActive(arg_27_0.goNpcReset, false)
	gohelper.setActive(arg_27_0.btnNpcGoto, false)
	gohelper.setActive(arg_27_0.btnNpcReset, false)
	gohelper.setActive(arg_27_0.btnNpcJoin, false)

	local var_27_1 = SurvivalConfig.instance:getNpcConfigTag(arg_27_0.showId)

	for iter_27_0 = 1, math.max(#var_27_1, #arg_27_0.npcAttrList) do
		local var_27_2 = arg_27_0:getNpcAttrItem(iter_27_0)

		arg_27_0:refreshNpcAttrItem(var_27_2, var_27_1[iter_27_0])
	end

	local var_27_3 = arg_27_0.otherParam and arg_27_0.otherParam.showSelect or true
	local var_27_4 = arg_27_0.otherParam and arg_27_0.otherParam.showUnSelect or true
	local var_27_5 = SurvivalShelterChooseNpcListModel.instance:isQuickSelect()

	if var_27_3 then
		local var_27_6 = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(arg_27_0.showId)

		gohelper.setActive(arg_27_0.btnNpcSelect, var_27_6 == nil and not var_27_5)
	end

	if var_27_4 then
		local var_27_7 = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(arg_27_0.showId)

		gohelper.setActive(arg_27_0.btnNpcUnSelect, var_27_7 ~= nil and not var_27_5)
	end

	arg_27_0:refreshNpcCost()
end

function var_0_0.getNpcAttrItem(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.npcAttrList[arg_28_1]

	if not var_28_0 then
		var_28_0 = arg_28_0:getUserDataTb_()
		var_28_0.go = gohelper.cloneInPlace(arg_28_0.goNpcAttrItem, tostring(arg_28_1))
		var_28_0.imgTitle = gohelper.findChildImage(var_28_0.go, "#image_title")
		var_28_0.txtTitle = gohelper.findChildTextMesh(var_28_0.go, "#image_title/#txt_title")
		var_28_0.txtDesc = gohelper.findChildTextMesh(var_28_0.go, "layout/#go_decitem/#txt_desc")
		arg_28_0.npcAttrList[arg_28_1] = var_28_0
	end

	return var_28_0
end

function var_0_0.refreshNpcAttrItem(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_2 then
		gohelper.setActive(arg_29_1.go, false)

		return
	end

	gohelper.setActive(arg_29_1.go, true)

	local var_29_0 = lua_survival_tag.configDict[arg_29_2]

	if var_29_0 == nil then
		logError("tagId is nil" .. arg_29_2)

		return
	end

	arg_29_1.txtTitle.text = var_29_0.name
	arg_29_1.txtDesc.text = var_29_0.desc

	UISpriteSetMgr.instance:setSurvivalSprite(arg_29_1.imgTitle, string.format("survivalpartnerteam_attrbg%s", var_29_0.color))
end

function var_0_0.showEmpty(arg_30_0)
	gohelper.setActive(arg_30_0.goBuild, false)
	gohelper.setActive(arg_30_0.goNpc, false)
	gohelper.setActive(arg_30_0.goEmpty, true)
end

function var_0_0.onDestroy(arg_31_0)
	arg_31_0.simageBuild:UnLoadImage()
	TaskDispatcher.cancelTask(arg_31_0.delayRefreshTime, arg_31_0)
end

return var_0_0
