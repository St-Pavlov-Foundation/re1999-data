module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonResetBtnComp", package.seeall)

slot0 = class("Act183DungeonResetBtnComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._btnresetepisode = gohelper.getClickWithDefaultAudio(slot0.go)
end

function slot0.addEventListeners(slot0)
	slot0._btnresetepisode:AddClickListener(slot0._btnresetepisodeOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnresetepisode:RemoveClickListener()
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)

	slot0._isCanReset = slot0._groupEpisodeMo:isEpisodeCanReset(slot0._episodeId)
end

function slot0._btnresetepisodeOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act183ResetEpisode, MsgBoxEnum.BoxType.Yes_No, slot0._startResetEpisode, nil, , slot0)
end

function slot0._startResetEpisode(slot0)
	Act183Controller.instance:resetEpisode(slot0._activityId, slot0._episodeId)
end

function slot0.checkIsVisible(slot0)
	return slot0._isCanReset
end

function slot0.show(slot0)
	uv0.super.show(slot0)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
