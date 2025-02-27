module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepOperateNumUpdate", package.seeall)

slot0 = class("XugoujiGameStepOperateNumUpdate", XugoujiGameStepBase)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.start(slot0)
	slot2 = slot0._stepData.isSelf

	Activity188Model.instance:setCurTurnOperateTime(slot0._stepData.remainReverseCount, not slot2)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.OperateTimeUpdated)

	if slot2 then
		Activity188Model.instance:setGameViewState(slot1 == 0 and XugoujiEnum.GameViewState.PlayerOperaDisplay or XugoujiEnum.GameViewState.PlayerOperating)
	else
		Activity188Model.instance:setGameViewState(slot1 == 0 and XugoujiEnum.GameViewState.EnemyOperaDisplay or XugoujiEnum.GameViewState.EnemyOperatingng)
	end

	slot0:finish()
end

return slot0
