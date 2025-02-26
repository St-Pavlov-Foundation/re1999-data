module("modules.logic.versionactivity2_6.dicehero.controller.work.DiceHeroFirstStepWork", package.seeall)

slot0 = class("DiceHeroFirstStepWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0:onDone(true)
end

return slot0
