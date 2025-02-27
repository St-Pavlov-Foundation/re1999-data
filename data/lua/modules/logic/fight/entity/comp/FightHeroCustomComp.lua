module("modules.logic.fight.entity.comp.FightHeroCustomComp", package.seeall)

slot0 = class("FightHeroCustomComp", LuaCompBase)
slot0.HeroId2CustomComp = {
	[3113] = FightHeroALFComp
}

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1

	if uv0.HeroId2CustomComp[slot0.entity:getMO().modelId] then
		slot0.customComp = slot3.New(slot0.entity)

		slot0.customComp:init(slot1)
	end
end

function slot0.addEventListeners(slot0)
	if slot0.customComp then
		slot0.customComp:addEventListeners()
	end
end

function slot0.removeEventListeners(slot0)
	if slot0.customComp then
		slot0.customComp:removeEventListeners()
	end
end

function slot0.getCustomComp(slot0)
	return slot0.customComp
end

function slot0.onDestroy(slot0)
	if slot0.customComp then
		slot0.customComp:onDestroy()

		slot0.customComp = nil
	end
end

return slot0
