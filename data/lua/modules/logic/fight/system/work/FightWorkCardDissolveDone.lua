module("modules.logic.fight.system.work.FightWorkCardDissolveDone", package.seeall)

slot0 = class("FightWorkCardDissolveDone", BaseWork)

function slot0.onStart(slot0)
	slot0:onDone(true)
end

return slot0
