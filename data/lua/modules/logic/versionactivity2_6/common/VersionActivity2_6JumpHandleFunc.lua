module("modules.logic.versionactivity2_6.common.VersionActivity2_6JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity2_6JumpHandleFunc")

function slot0.jumpTo12601(slot0)
	VersionActivity2_6EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12602(slot0, slot1)
	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12605(slot0, slot1)
	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12603(slot0, slot1)
	VersionActivity2_6DungeonController.instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12606(slot0, slot1)
	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12618(slot0, slot1)
	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

return slot0
