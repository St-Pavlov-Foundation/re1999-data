module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroController", package.seeall)

slot0 = class("DiceHeroController", BaseController)

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._onActivityRefresh, slot0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, slot0._onGetOpenInfoSuccess, slot0)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, slot0._onGetOpenInfoSuccess, slot0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, slot0._newFuncUnlock, slot0)
end

function slot0._onActivityRefresh(slot0, slot1)
	if slot1 and slot1 ~= VersionActivity2_6Enum.ActivityId.DiceHero then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DiceHero) then
		slot0:_getInfo()
	end
end

function slot0._onGetOpenInfoSuccess(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DiceHero) then
		slot0:_getInfo()
	end
end

function slot0._newFuncUnlock(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot6 == OpenEnum.UnlockFunc.DiceHero then
			slot0:_getInfo()

			break
		end
	end
end

function slot0._getInfo(slot0)
	if not ActivityHelper.isOpen(VersionActivity2_6Enum.ActivityId.DiceHero) then
		return
	end

	DiceHeroRpc.instance:sendDiceHeroGetInfo()
end

slot0.instance = slot0.New()

return slot0
