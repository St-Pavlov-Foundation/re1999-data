module("modules.logic.fight.entity.comp.FightNameUIStressMgr", package.seeall)

slot0 = class("FightNameUIStressMgr", UserDataDispose)
slot0.HeroDefaultIdentityId = 1001
slot0.UiType = {
	Act183 = 1,
	Normal = 0
}
slot0.UiType2PrefabPath = {
	[slot0.UiType.Normal] = "ui/viewres/fight/fightstressitem.prefab",
	[slot0.UiType.Act183] = "ui/viewres/fight/fightstressitem2.prefab"
}
slot0.UiType2Behaviour = {
	[slot0.UiType.Normal] = StressNormalBehavior,
	[slot0.UiType.Act183] = StressAct183Behavior
}

function slot0.initMgr(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.goStress = slot1
	slot0.entity = slot2
	slot0.entityId = slot0.entity.id

	slot0:loadPrefab()
end

function slot0.loadPrefab(slot0)
	slot0.uiType = FightStressHelper.getStressUiType(slot0.entityId)
	slot0.loader = PrefabInstantiate.Create(slot0.goStress)

	slot0.loader:startLoad(uv0.UiType2PrefabPath[slot0.uiType] or uv0.UiType2PrefabPath[uv0.UiType.Normal], slot0.onLoadFinish, slot0)
end

function slot0.onLoadFinish(slot0)
	slot0.instanceGo = slot0.loader:getInstGO()
	slot0.stressBehavior = (uv0.UiType2Behaviour[slot0.uiType] or StressNormalBehavior).New()

	slot0.stressBehavior:init(slot0.instanceGo, slot0.entity)
end

function slot0.beforeDestroy(slot0)
	if slot0.stressBehavior then
		slot0.stressBehavior:beforeDestroy()
	end

	slot0.loader:dispose()

	slot0.loader = nil

	slot0:__onDispose()
end

return slot0
