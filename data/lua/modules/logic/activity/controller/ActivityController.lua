module("modules.logic.activity.controller.ActivityController", package.seeall)

slot0 = class("ActivityController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._getGroupSuccess = false
	slot0._getActSuccess = false
end

function slot0.addConstEvents(slot0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnGetHeroGroupList, slot0._onGetHeroGroupSuccess, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0._onGetHeroGroupSuccess(slot0)
	slot0._getGroupSuccess = true
	slot1 = Activity104Model.instance:getCurSeasonId()

	if slot0._getActSuccess and ActivityModel.instance:isActOnLine(slot1) then
		Activity104Rpc.instance:sendGet104InfosRequest(slot1)
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Season
		})
	end
end

function slot0.openActivityNormalView(slot0)
	if next(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Normal)) then
		ViewMgr.instance:openView(ViewName.ActivityNormalView)
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

function slot0.openActivityBeginnerView(slot0, slot1)
	if next(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.ActivityShow
		}, function ()
			ViewMgr.instance:openView(ViewName.ActivityBeginnerView, uv0)
		end)
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

function slot0.openActivityWelfareView(slot0)
	if next(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)) then
		ViewMgr.instance:openView(ViewName.ActivityWelfareView)
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

slot1 = {
	ActivityEnum.Activity.NorSign,
	ActivityEnum.Activity.NoviceSign,
	ActivityEnum.Activity.SummerSignPart1_1_2,
	ActivityEnum.Activity.SummerSignPart2_1_2,
	ActivityEnum.Activity.DoubleFestivalSign_1_3,
	ActivityEnum.Activity.StarLightSignPart1_1_3,
	ActivityEnum.Activity.StarLightSignPart2_1_3,
	ActivityEnum.Activity.RoleSignViewPart1_1_5,
	ActivityEnum.Activity.RoleSignViewPart2_1_5,
	ActivityEnum.Activity.DoubleFestivalSign_1_5,
	ActivityEnum.Activity.DecalogPresent,
	ActivityEnum.Activity.GoldenMilletPresent,
	ActivityEnum.Activity.RoleSignViewPart1_1_7,
	ActivityEnum.Activity.RoleSignViewPart2_1_7,
	ActivityEnum.Activity.RoleSignViewPart1_1_8,
	ActivityEnum.Activity.RoleSignViewPart2_1_8,
	ActivityEnum.Activity.Work_SignView_1_8,
	ActivityEnum.Activity.RoleSignViewPart1_1_9,
	ActivityEnum.Activity.RoleSignViewPart2_1_9,
	ActivityEnum.Activity.DragonBoatFestival,
	ActivityEnum.Activity.AnniversarySignView_1_9,
	ActivityEnum.Activity.V2a0_SummerSign,
	ActivityEnum.Activity.V2a0_Role_SignView_Part1,
	ActivityEnum.Activity.V2a0_Role_SignView_Part2,
	ActivityEnum.Activity.V2a1_Role_SignView_Part1,
	ActivityEnum.Activity.V2a1_Role_SignView_Part2,
	ActivityEnum.Activity.V2a1_MoonFestival,
	ActivityEnum.Activity.V2a2_Role_SignView_Part1,
	ActivityEnum.Activity.V2a2_Role_SignView_Part2,
	ActivityEnum.Activity.v2a2_RedLeafFestival,
	ActivityEnum.Activity.V2a3_Role_SignView_Part1,
	ActivityEnum.Activity.V2a3_Role_SignView_Part2,
	ActivityEnum.Activity.LinkageActivity_FullView,
	ActivityEnum.Activity.V2a3_Special,
	ActivityEnum.Activity.V2a4_Role_SignView_Part1,
	ActivityEnum.Activity.V2a4_Role_SignView_Part2,
	ActivityEnum.Activity.V2a5_Role_SignView_Part1,
	ActivityEnum.Activity.V2a5_Role_SignView_Part2,
	ActivityEnum.Activity.V2a5_DecorateStore,
	ActivityEnum.Activity.V2a5_Act186Sign,
	ActivityEnum.Activity.V2a7_Labor_Sign
}
slot2 = {
	ActivityEnum.Activity.VersionActivity1_3Radio,
	ActivityEnum.Activity.Activity1_6WarmUp,
	ActivityEnum.Activity.Activity1_7WarmUp,
	ActivityEnum.Activity.Activity1_8WarmUp,
	ActivityEnum.Activity.Activity1_9WarmUp,
	ActivityEnum.Activity.V2a0_WarmUp,
	ActivityEnum.Activity.V2a1_WarmUp,
	ActivityEnum.Activity.RoomSign,
	ActivityEnum.Activity.V2a2_WarmUp,
	ActivityEnum.Activity.V2a3_WarmUp,
	ActivityEnum.Activity.V2a4_WarmUp,
	ActivityEnum.Activity.V2a5_WarmUp,
	ActivityEnum.Activity.V2a7_WarmUp
}

function slot0.checkGetActivityInfo(slot0)
	for slot4, slot5 in ipairs(uv0) do
		Activity125Controller.instance:getAct125InfoFromServer(slot5)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.Activity1_5WarmUp) then
		Activity146Controller.instance:getAct146InfoFromServer(ActivityEnum.Activity.Activity1_5WarmUp)
	end

	slot0._getActSuccess = true
	slot1 = Activity104Model.instance:getCurSeasonId()

	if slot0._getGroupSuccess and ActivityModel.instance:isActOnLine(slot1) then
		Activity104Rpc.instance:sendGet104InfosRequest(slot1)
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Season
		})
	end

	if ActivityModel.instance:isActOnLine(VersionActivityEnum.ActivityId.Act109) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Activity109
		})
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewWelfare) then
		Activity160Rpc.instance:sendGetAct160InfoRequest(ActivityEnum.Activity.NewWelfare)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.V2a7_NewInsight) then
		Activity172Rpc.instance:sendGetAct172InfoRequest(ActivityEnum.Activity.V2a7_NewInsight)
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Tower
		})
	end

	slot0:requestAct186Info()
end

function slot0.requestAct186Info(slot0)
	if Activity186Model.instance:getActId() and ActivityModel.instance:isActOnLine(slot1) then
		Activity186Rpc.instance:sendGetAct186InfoRequest(slot1)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.V2a5_Act186Sign) and slot1 then
		Activity101Rpc.instance:sendGetAct186SpBonusInfoRequest(ActivityEnum.Activity.V2a5_Act186Sign, slot1)
	end
end

function slot0.updateAct101Infos(slot0, slot1)
	slot0:_initRoleSign_kAct101RedList()
	slot0:_initSpecialSign_kAct101RedList()
	slot0:_initLinkageActivity_kAct101RedList()

	if not slot1 then
		for slot5, slot6 in ipairs(uv0) do
			if ActivityType101Model.instance:isOpen(slot6) then
				Activity101Rpc.instance:sendGet101InfosRequest(slot6)
			end
		end

		return
	end

	for slot5, slot6 in ipairs(uv0) do
		if slot1 == slot6 then
			Activity101Rpc.instance:sendGet101InfosRequest(slot6)

			return
		end
	end
end

function slot0._onDailyRefresh(slot0)
	slot0:updateAct101Infos()
end

slot3 = false

function slot0._initRoleSign_kAct101RedList(slot0)
	if uv0 then
		return
	end

	uv0 = true

	table.insert(uv1, GameBranchMgr.instance:Vxax_ActId("Role_SignView_Part1", ActivityEnum.Activity.V2a6_Role_SignView_Part1))
	table.insert(uv1, GameBranchMgr.instance:Vxax_ActId("Role_SignView_Part2", ActivityEnum.Activity.V2a6_Role_SignView_Part2))
end

function slot0.onModuleViews(slot0, slot1, slot2)
	ActivityType101Model.instance:onModuleViews(slot1, slot2)
end

slot4 = false

function slot0._initSpecialSign_kAct101RedList(slot0)
	if uv0 then
		return
	end

	uv0 = true

	table.insert(uv1, GameBranchMgr.instance:Vxax_ActId("Special", ActivityEnum.Activity.V2a3_Special))
end

slot5 = false

function slot0._initLinkageActivity_kAct101RedList(slot0)
	if uv0 then
		return
	end

	uv0 = true

	table.insert(uv1, GameBranchMgr.instance:Vxax_ActId("LinkageActivity", ActivityEnum.Activity.LinkageActivity_FullView))
end

slot0.instance = slot0.New()

return slot0
