module("modules.logic.survival.view.map.SurvivalNPCSelectView", package.seeall)

local var_0_0 = class("SurvivalNPCSelectView", BaseView)
local var_0_1 = true

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Close")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "root/go_empty")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_List")
	arg_1_0._gonpcitem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_List/Viewport/Content/#go_SmallItem")
	arg_1_0._gofilter = gohelper.findChild(arg_1_0.viewGO, "root/#btn_filter")
	arg_1_0._btnSelect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Select")
	arg_1_0._gonpcinfo = gohelper.findChild(arg_1_0.viewGO, "root/go_manageinfo")
	arg_1_0._btnCloseInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/go_manageinfo/#btn_close")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSelect:AddClickListener(arg_2_0.changeQuickSelect, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnCloseInfo:AddClickListener(arg_2_0.closeInfo, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnNPCInTeamChange, arg_2_0._refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnSelect:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnCloseInfo:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnNPCInTeamChange, arg_3_0._refreshView, arg_3_0)
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0._gonpcitem, false)

	arg_5_0._npcSelects = arg_5_0:getUserDataTb_()
	arg_5_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._goscroll, SurvivalSimpleListPart)

	arg_5_0._simpleList:setCellUpdateCallBack(arg_5_0._createNPCItem, arg_5_0, nil, arg_5_0._gonpcitem)
	arg_5_0._simpleList:setRecycleCallBack(arg_5_0._onCellRecycle, arg_5_0)
	ZProj.UGUIHelper.SetGrayscale(arg_5_0._btnSelect.gameObject, not var_0_1)
	gohelper.setActive(arg_5_0._gonpcinfo, false)

	local var_5_0 = arg_5_0.viewContainer._viewSetting.otherRes.infoView
	local var_5_1 = arg_5_0:getResInst(var_5_0, arg_5_0._gonpcinfo)

	arg_5_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_1, SurvivalSelectNPCInfoPart)

	arg_5_0:initNPCData()

	local var_5_2 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._gofilter, SurvivalFilterPart)
	local var_5_3 = {}
	local var_5_4 = lua_survival_tag_type.configList

	for iter_5_0, iter_5_1 in ipairs(var_5_4) do
		table.insert(var_5_3, {
			desc = iter_5_1.name,
			type = iter_5_1.id
		})
	end

	var_5_2:setOptionChangeCallback(arg_5_0._onFilterChange, arg_5_0)
	var_5_2:setOptions(var_5_3)
end

function var_0_0.changeQuickSelect(arg_6_0)
	var_0_1 = not var_0_1

	ZProj.UGUIHelper.SetGrayscale(arg_6_0._btnSelect.gameObject, not var_0_1)
	arg_6_0:closeInfo()
end

function var_0_0.initNPCData(arg_7_0)
	local var_7_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_7_1 = {}
	local var_7_2 = {}
	local var_7_3 = SurvivalMapModel.instance:getInitGroup()
	local var_7_4 = var_7_0:getNormalNpcList()

	for iter_7_0, iter_7_1 in ipairs(var_7_4) do
		local var_7_5 = var_7_0:getNpcInfo(iter_7_1)

		if var_7_5 then
			if tabletool.indexOf(var_7_3.allSelectNpcs, var_7_5) then
				table.insert(var_7_1, var_7_5)
			else
				table.insert(var_7_2, var_7_5)
			end
		end
	end

	tabletool.addValues(var_7_1, var_7_2)

	arg_7_0._allNpcs = var_7_1
	arg_7_0._initGroupMo = var_7_3
end

function var_0_0._onFilterChange(arg_8_0, arg_8_1)
	arg_8_0._filterList = arg_8_1

	arg_8_0:_refreshView()
end

function var_0_0._refreshView(arg_9_0)
	arg_9_0:closeInfo()

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._allNpcs) do
		if SurvivalBagSortHelper.filterNpc(arg_9_0._filterList, iter_9_1) then
			table.insert(var_9_0, iter_9_1)
		end
	end

	arg_9_0._showMos = var_9_0

	tabletool.clear(arg_9_0._npcSelects)
	arg_9_0._simpleList:setList(var_9_0)
	gohelper.setActive(arg_9_0._goempty, #var_9_0 == 0)
	gohelper.setActive(arg_9_0._goscroll, #var_9_0 > 0)
end

function var_0_0._createNPCItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.findChildImage(arg_10_1, "#image_Chess")
	local var_10_1 = gohelper.findChildTextMesh(arg_10_1, "#txt_PartnerName")
	local var_10_2 = gohelper.findChild(arg_10_1, "#go_Selected")
	local var_10_3 = gohelper.findChild(arg_10_1, "#go_Tips")
	local var_10_4 = gohelper.findChildTextMesh(arg_10_1, "#go_Tips/#txt_TentName")
	local var_10_5 = gohelper.findButtonWithAudio(arg_10_1)

	arg_10_0._npcSelects[arg_10_3] = var_10_2
	var_10_1.text = arg_10_2.co.name

	if arg_10_2:getShelterNpcStatus() == SurvivalEnum.ShelterNpcStatus.InBuild then
		var_10_4.text = luaLang("survival_npcselectview_inteam")
	else
		var_10_4.text = luaLang("survival_npcselectview_cantuse")
	end

	UISpriteSetMgr.instance:setV2a2ChessSprite(var_10_0, arg_10_2.co.headIcon)
	gohelper.setActive(var_10_3, arg_10_2:getShelterNpcStatus() ~= SurvivalEnum.ShelterNpcStatus.InBuild or tabletool.indexOf(arg_10_0._initGroupMo.allSelectNpcs, arg_10_2))
	arg_10_0:removeClickCb(var_10_5)
	arg_10_0:addClickCb(var_10_5, arg_10_0._onClickNpc, arg_10_0, arg_10_3)
	gohelper.setActive(var_10_2, arg_10_0._curSelectIndex == arg_10_3)
end

function var_0_0._onCellRecycle(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._npcSelects[arg_11_2] = nil
end

function var_0_0._onClickNpc(arg_12_0, arg_12_1)
	if var_0_1 then
		local var_12_0 = arg_12_0._showMos[arg_12_1]
		local var_12_1 = SurvivalMapModel.instance:getInitGroup()
		local var_12_2 = tabletool.indexOf(var_12_1.allSelectNpcs, var_12_0)
		local var_12_3 = tabletool.len(var_12_1.allSelectNpcs) == var_12_1:getCarryNPCCount()

		if not (var_12_0:getShelterNpcStatus() == SurvivalEnum.ShelterNpcStatus.InBuild) then
			GameFacade.showToast(ToastEnum.SurvivalCantSelectNpc)

			return
		end

		if var_12_2 then
			tabletool.removeValue(var_12_1.allSelectNpcs, var_12_0)
			arg_12_0:_refreshView()
		elseif not var_12_3 then
			table.insert(var_12_1.allSelectNpcs, var_12_0)
			arg_12_0:_refreshView()
		else
			GameFacade.showToast(ToastEnum.SurvivalNpcFull)
		end
	end

	gohelper.setActive(arg_12_0._npcSelects[arg_12_0._curSelectIndex], false)

	arg_12_0._curSelectIndex = arg_12_1

	gohelper.setActive(arg_12_0._npcSelects[arg_12_0._curSelectIndex], true)
	gohelper.setActive(arg_12_0._gonpcinfo, true)
	arg_12_0._infoPanel:updateMo(arg_12_0._showMos[arg_12_1])
end

function var_0_0.closeInfo(arg_13_0)
	gohelper.setActive(arg_13_0._npcSelects[arg_13_0._curSelectIndex], false)

	arg_13_0._curSelectIndex = nil

	gohelper.setActive(arg_13_0._gonpcinfo, false)

	arg_13_0._curSelect = false
end

return var_0_0
