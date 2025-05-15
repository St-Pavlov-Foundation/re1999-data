module("modules.logic.survival.view.shelter.SurvivalDecreeView", package.seeall)

local var_0_0 = class("SurvivalDecreeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goLayout = gohelper.findChild(arg_1_0.viewGO, "#go_Leader/LayoutGroup")
	arg_1_0.layout = arg_1_0.goLayout:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	arg_1_0.itemList = {}
	arg_1_0.goInfoRoot = gohelper.findChild(arg_1_0.viewGO, "Left/go_info")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_2_0.onBuildingInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnDecreeDataUpdate, arg_2_0.onDecreeDataUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_3_0.onBuildingInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnDecreeDataUpdate, arg_3_0.onDecreeDataUpdate, arg_3_0)
end

function var_0_0.onShelterBagUpdate(arg_4_0)
	arg_4_0:refreshInfoView()
end

function var_0_0.onBuildingInfoUpdate(arg_5_0)
	arg_5_0:refreshInfoView()
end

function var_0_0.onDecreeDataUpdate(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshView()
	arg_7_0:playOpenAnim()
end

function var_0_0.refreshView(arg_8_0)
	for iter_8_0 = 1, 2 do
		arg_8_0:getItem(iter_8_0):updateItem(iter_8_0)
	end

	arg_8_0:refreshInfoView()
end

function var_0_0.getItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.itemList[arg_9_1]

	if not var_9_0 then
		local var_9_1 = arg_9_0.viewContainer:getResInst(arg_9_0.viewContainer:getSetting().otherRes.itemRes, arg_9_0.goLayout, tostring(arg_9_1))

		var_9_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, SurvivalDecreeItem)
		arg_9_0.itemList[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0.playOpenAnim(arg_10_0)
	ZProj.UGUIHelper.RebuildLayout(arg_10_0.goLayout.transform)

	arg_10_0.layout.enabled = false

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.itemList) do
		gohelper.setActive(iter_10_1.viewGO, false)
	end

	arg_10_0._animIndex = 0

	TaskDispatcher.runRepeat(arg_10_0._playItemOpenAnim, arg_10_0, 0.1, #arg_10_0.itemList)
end

function var_0_0._playItemOpenAnim(arg_11_0)
	arg_11_0._animIndex = arg_11_0._animIndex + 1

	local var_11_0 = arg_11_0.itemList[arg_11_0._animIndex]

	if var_11_0 then
		gohelper.setActive(var_11_0.viewGO, true)
	end

	if arg_11_0._animIndex >= #arg_11_0.itemList then
		TaskDispatcher.cancelTask(arg_11_0._playItemOpenAnim, arg_11_0)
		TaskDispatcher.runDelay(arg_11_0.playSwitchAnim, arg_11_0, 0.4)
	end
end

function var_0_0.playSwitchAnim(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.itemList) do
		iter_12_1:playSwitchAnim()
	end
end

function var_0_0.refreshInfoView(arg_13_0)
	local var_13_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Decree)

	if not arg_13_0.infoView then
		local var_13_1 = arg_13_0.viewContainer:getRes(arg_13_0.viewContainer:getSetting().otherRes.infoView)

		arg_13_0.infoView = ShelterManagerInfoView.getView(var_13_1, arg_13_0.goInfoRoot, "infoView")
	end

	local var_13_2 = {
		showType = SurvivalEnum.InfoShowType.Building,
		showId = var_13_0 and var_13_0.id or 0
	}

	arg_13_0.infoView:refreshParam(var_13_2)
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.playSwitchAnim, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._playItemOpenAnim, arg_14_0)

	if PopupController.instance:isPause() then
		PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, false)
	end
end

return var_0_0
