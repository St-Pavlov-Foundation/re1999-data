module("modules.logic.settings.view.SettingsKeyMapView", package.seeall)

local var_0_0 = class("SettingsKeyMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#txt_dec")
	arg_1_0._btnshortcuts = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#btn_shortcuts")
	arg_1_0._txtshortcuts = gohelper.findChildText(arg_1_0.viewGO, "pcScroll/Viewport/Content/shortcutsitem/#btn_shortcuts/#txt_shortcuts")
	arg_1_0._gotopitem = gohelper.findChild(arg_1_0.viewGO, "topScroll/Viewport/Content/#go_topitem")
	arg_1_0._gounchoose = gohelper.findChild(arg_1_0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_unchoose")
	arg_1_0._txtunchoose = gohelper.findChildText(arg_1_0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_unchoose/#txt_unchoose")
	arg_1_0._gochoose = gohelper.findChild(arg_1_0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_choose")
	arg_1_0._txtchoose = gohelper.findChildText(arg_1_0.viewGO, "topScroll/Viewport/Content/#go_topitem/#go_choose/#txt_choose")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")
	arg_1_0._tipsBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn")
	arg_1_0._tipsOn = gohelper.findChild(arg_1_0.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn/on")
	arg_1_0._tipsoff = gohelper.findChild(arg_1_0.viewGO, "pcScroll/Viewport/Content/shortcutstips/switch/btn/off")
	arg_1_0._tipsStatue = PlayerPrefsHelper.getNumber("keyTips", 0)
	arg_1_0._exitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_exit")

	arg_1_0:refreshTips()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshortcuts:AddClickListener(arg_2_0._btnshortcutsOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._tipsBtn:AddClickListener(arg_2_0._tipsSwtich, arg_2_0)
	arg_2_0._exitgame:AddClickListener(arg_2_0.exitgame, arg_2_0)
	arg_2_0:addEventCb(SettingsController.instance, SettingsEvent.OnKeyMapChange, arg_2_0.onSelectChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshortcuts:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._tipsBtn:RemoveClickListener()
	arg_3_0._exitgame:RemoveClickListener()
	arg_3_0:removeEventCb(SettingsController.instance, SettingsEvent.OnKeyMapChange, arg_3_0.onSelectChange, arg_3_0)
end

function var_0_0._btnshortcutsOnClick(arg_4_0)
	return
end

function var_0_0._tipsSwtich(arg_5_0)
	if arg_5_0._tipsStatue == 1 then
		arg_5_0._tipsStatue = 0
	else
		arg_5_0._tipsStatue = 1
	end

	arg_5_0:refreshTips()
	PlayerPrefsHelper.setNumber("keyTips", arg_5_0._tipsStatue)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyTipsChange)
end

function var_0_0.refreshTips(arg_6_0)
	arg_6_0._tipsOn:SetActive(arg_6_0._tipsStatue == 1)
	arg_6_0._tipsoff:SetActive(arg_6_0._tipsStatue ~= 1)
end

function var_0_0._btnresetOnClick(arg_7_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.PCInputReset, MsgBoxEnum.BoxType.Yes_No, arg_7_0._ResetByIndex, nil, nil, arg_7_0, nil, nil, arg_7_0:getSelectTopMo().name)
end

function var_0_0._ResetByIndex(arg_8_0)
	SettingsKeyListModel.instance:Reset(arg_8_0._index)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0:createTopScroll()
	arg_9_0:createPCScroll()
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	return
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

function var_0_0.onSelectChange(arg_14_0, arg_14_1)
	if arg_14_0._index ~= arg_14_1 then
		arg_14_0._index = arg_14_1

		SettingsKeyListModel.instance:SetActivity(arg_14_0._index)
	end
end

function var_0_0.createTopScroll(arg_15_0)
	local var_15_0 = ListScrollParam.New()

	var_15_0.scrollGOPath = "topScroll"
	var_15_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_15_0.prefabUrl = "topScroll/Viewport/Content/#go_topitem"
	var_15_0.cellClass = SettingsKeyTopItem
	var_15_0.scrollDir = ScrollEnum.ScrollDirH
	var_15_0.lineCount = 1
	var_15_0.cellWidth = 240
	var_15_0.cellHeight = 68
	var_15_0.cellSpaceH = 0
	var_15_0.cellSpaceV = 0
	arg_15_0._topScroll = LuaListScrollView.New(SettingsKeyTopListModel.instance, var_15_0)

	arg_15_0:addChildView(arg_15_0._topScroll)
	SettingsKeyTopListModel.instance:InitList()

	arg_15_0._index = 1

	arg_15_0._topScroll:selectCell(arg_15_0._index, true)
end

function var_0_0.createPCScroll(arg_16_0)
	local var_16_0 = ListScrollParam.New()

	var_16_0.scrollGOPath = "pcScroll"
	var_16_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_16_0.prefabUrl = "pcScroll/Viewport/Content/shortcutsitem"
	var_16_0.cellClass = SettingsKeyItem
	var_16_0.scrollDir = ScrollEnum.ScrollDirV
	var_16_0.lineCount = 1
	var_16_0.cellWidth = 1190
	var_16_0.cellHeight = 90
	var_16_0.cellSpaceH = 0
	var_16_0.cellSpaceV = 0
	var_16_0.startSpace = 230
	arg_16_0._pcScroll = LuaListScrollView.New(SettingsKeyListModel.instance, var_16_0)

	arg_16_0:addChildView(arg_16_0._pcScroll)
	SettingsKeyListModel.instance:Init()
	SettingsKeyListModel.instance:SetActivity(arg_16_0._index)
end

function var_0_0.getSelectTopMo(arg_17_0)
	return arg_17_0._topScroll:getFirstSelect()
end

function var_0_0.exitgame(arg_18_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.exitGame, MsgBoxEnum.BoxType.Yes_No, function()
		ProjBooter.instance:quitGame()
	end)
end

return var_0_0
