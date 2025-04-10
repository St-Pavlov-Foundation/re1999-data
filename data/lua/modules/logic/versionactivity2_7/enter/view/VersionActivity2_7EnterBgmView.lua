module("modules.logic.versionactivity2_7.enter.view.VersionActivity2_7EnterBgmView", package.seeall)

slot0 = class("VersionActivity2_7EnterBgmView", VersionActivityFixedEnterBgmView)

function slot0.initActHandle(slot0)
	if not slot0.actHandleDict then
		slot0.actHandleDict = {
			[BossRushConfig.instance:getActivityId()] = slot0._bossrushBgmHandle,
			[VersionActivity2_7Enum.ActivityId.Reactivity] = slot0._reactivityBgmHandle
		}
	end
end

function slot0.defaultBgmHandle(slot0, slot1)
	uv0.super.defaultBgmHandle(slot0, slot1)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.SwitchBGM, slot1)
end

return slot0
