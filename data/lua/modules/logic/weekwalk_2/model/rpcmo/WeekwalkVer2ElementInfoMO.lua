module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2ElementInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2ElementInfoMO")

function slot0.init(slot0, slot1)
	slot0.elementId = slot1.elementId
	slot0.finish = slot1.finish
	slot0.index = slot1.index
	slot0.visible = slot1.visible
end

return slot0
