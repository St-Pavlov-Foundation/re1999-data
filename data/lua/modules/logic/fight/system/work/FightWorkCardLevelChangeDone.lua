module("modules.logic.fight.system.work.FightWorkCardLevelChangeDone", package.seeall)

slot0 = class("FightWorkCardLevelChangeDone", BaseWork)

function slot0.onStart(slot0)
	slot0:onDone(true)
end

return slot0
