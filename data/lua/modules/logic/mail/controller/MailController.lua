module("modules.logic.mail.controller.MailController", package.seeall)

local var_0_0 = class("MailController", BaseController)

function var_0_0.open(arg_1_0)
	ViewMgr.instance:openView(ViewName.MailView)
end

function var_0_0.onInit(arg_2_0)
	arg_2_0.showTitles = {}
	arg_2_0.maxCacheMailToast = 3
	arg_2_0.delayShowViews = nil
	arg_2_0.recordedMailIdKey = "recordedMailIdKey"
	arg_2_0.recordedIdDelimiter = ";"
	arg_2_0.showedMailIds = {}
end

function var_0_0.onInitFinish(arg_3_0)
	arg_3_0:initShowedMailIds()
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.reInit(arg_5_0)
	return
end

function var_0_0.initInfo(arg_6_0)
	arg_6_0.showTitles = {}

	local var_6_0 = MailModel.instance:getMailList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1.state == MailEnum.ReadStatus.Unread and iter_6_1.needShowToast == 1 and not arg_6_0:isShowedMail(iter_6_1.id) then
			if #arg_6_0.showTitles >= arg_6_0.maxCacheMailToast then
				arg_6_0:recordShowedMailId(iter_6_1.id)
			else
				table.insert(arg_6_0.showTitles, 1, {
					id = iter_6_1.id,
					title = iter_6_1.title
				})
			end
		end
	end

	arg_6_0:logNormal("init info, show mail length is " .. tostring(#arg_6_0.showTitles))
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_6_0._onCheckFuncUnlock, arg_6_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_6_0._onFinishGuide, arg_6_0)
end

function var_0_0.addShowToastMail(arg_7_0, arg_7_1, arg_7_2)
	table.insert(arg_7_0.showTitles, {
		id = arg_7_1,
		title = arg_7_2
	})

	if #arg_7_0.showTitles > arg_7_0.maxCacheMailToast then
		local var_7_0 = table.remove(arg_7_0.showTitles, 1)

		arg_7_0:recordShowedMailId(var_7_0.id)
	end
end

function var_0_0.initShowedMailIds(arg_8_0)
	local var_8_0 = PlayerPrefsHelper.getString(arg_8_0.recordedMailIdKey, "")

	arg_8_0.showedMailIds = {}

	if not string.nilorempty(var_8_0) then
		for iter_8_0, iter_8_1 in ipairs(string.split(var_8_0, arg_8_0.recordedIdDelimiter)) do
			local var_8_1 = tonumber(iter_8_1)

			if var_8_1 then
				table.insert(arg_8_0.showedMailIds, var_8_1)
			end
		end
	end
end

function var_0_0.isShowedMail(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.showedMailIds) do
		if iter_9_1 == arg_9_1 then
			return true
		end
	end

	return false
end

function var_0_0.isDelayShow(arg_10_0)
	if not arg_10_0.delayShowViews then
		arg_10_0.delayShowViews = {
			ViewName.LoadingView,
			ViewName.FightView,
			ViewName.FightSuccView,
			ViewName.FightFailView,
			ViewName.StoryView,
			ViewName.SummonView,
			ViewName.LoginView,
			ViewName.SignInView
		}
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.delayShowViews) do
		if ViewMgr.instance:isOpen(iter_10_1) then
			arg_10_0:logNormal("current view is " .. iter_10_1)

			return true
		end
	end

	if not GuideController.instance:isForbidGuides() then
		arg_10_0:logNormal("not forbid guide , check guide")

		local var_10_0 = GuideModel.instance:getDoingGuideId()

		if var_10_0 then
			arg_10_0:logNormal("get doing guide Id is " .. tostring(var_10_0))

			return true
		end

		if not GuideModel.instance:isGuideFinish(GuideModel.instance:lastForceGuideId()) then
			arg_10_0:logNormal("last force guide Id not finish")

			return true
		end
	else
		arg_10_0:logNormal("forbid guide, skip check guide, check next")
	end

	return false
end

function var_0_0.showGetMailToast(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:addShowToastMail(arg_11_1, arg_11_2)

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		arg_11_0:logNormal("receive new mail, but not unlock MailModel , register OnFuncUnlockRefresh event ")
		OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_11_0._onCheckFuncUnlock, arg_11_0)
		MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_11_0._onCheckFuncUnlock, arg_11_0)

		return
	end

	arg_11_0:showOrRegisterEvent()
end

function var_0_0.tryShowMailToast(arg_12_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_12_0._onCheckFuncUnlock, arg_12_0)
	else
		arg_12_0:showOrRegisterEvent()
	end
end

function var_0_0.showOrRegisterEvent(arg_13_0)
	if arg_13_0:isDelayShow() then
		arg_13_0:logNormal("cat not show mail Toast, register event ...")
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_13_0._onOpenViewFinish, arg_13_0)
	else
		arg_13_0:logNormal("can show mail Toast ...")
		arg_13_0:reallyShowToast()
	end
end

function var_0_0._onCheckFuncUnlock(arg_14_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MainController.instance:unregisterCallback(MainEvent.OnFuncUnlockRefresh, arg_14_0._onCheckFuncUnlock, arg_14_0)
		OpenController.instance:unregisterCallback(OpenEvent.GetOpenInfoSuccess, arg_14_0._onCheckFuncUnlock, arg_14_0)
		arg_14_0:logNormal("unlock mail model callback, check show mail ...")
		arg_14_0:showOrRegisterEvent()
	end
end

function var_0_0._onOpenViewFinish(arg_15_0)
	arg_15_0:logNormal("close finish event ")

	if arg_15_0:isDelayShow() then
		arg_15_0:logNormal("cat not show mail Toast")

		return
	else
		arg_15_0:logNormal("can show mail Toast")
		arg_15_0:reallyShowToast()
	end
end

function var_0_0._onFinishGuide(arg_16_0, arg_16_1)
	arg_16_0:logNormal("receive finish guide push ...")

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		arg_16_0:logNormal("receive finish guide push, but mail model not open , do nothing and return ...")

		return
	end

	arg_16_0:showOrRegisterEvent()
end

function var_0_0.reallyShowToast(arg_17_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_17_0._onOpenViewFinish, arg_17_0)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_17_0._onCheckFuncUnlock, arg_17_0)

	local var_17_0 = MailModel.instance:getReadedMailIds()

	arg_17_0:logNormal("start show ...")

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.showTitles) do
		if var_17_0[iter_17_1.id] then
			arg_17_0:logNormal(string.format("need show mail {id:%s, title:%s}, but it`s been read", iter_17_1.id, iter_17_1.title))
			arg_17_0:recordShowedMailId(iter_17_1.id)
		else
			arg_17_0:logNormal(string.format("need show mail {id:%s, title:%s}, can show", iter_17_1.id, iter_17_1.title))
			arg_17_0:showToast(iter_17_1)
		end
	end

	arg_17_0.showTitles = {}
end

function var_0_0.showToast(arg_18_0, arg_18_1)
	GameFacade.showToast(ToastEnum.MailToast, arg_18_1.title, arg_18_1.id)
	arg_18_0:recordShowedMailId(arg_18_1.id)
end

function var_0_0.recordShowedMailId(arg_19_0, arg_19_1)
	if arg_19_0:isShowedMail(arg_19_1) then
		return
	end

	table.insert(arg_19_0.showedMailIds, arg_19_1)
	PlayerPrefsHelper.setString(arg_19_0.recordedMailIdKey, table.concat(arg_19_0.showedMailIds, arg_19_0.recordedIdDelimiter))
end

function var_0_0.logNormal(arg_20_0, arg_20_1)
	logNormal("【mail toast】" .. arg_20_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
