module("modules.logic.tips.view.stress.FightFocusStressCompBase", package.seeall)

slot0 = class("FightFocusStressCompBase", UserDataDispose)
slot0.PrefabPath = FightNameUIStressMgr.PrefabPath

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.goStress = slot1

	slot0:loadPrefab()
end

function slot0.getUiType(slot0)
	return FightNameUIStressMgr.UiType.Normal
end

function slot0.loadPrefab(slot0)
	slot0.loader = PrefabInstantiate.Create(slot0.goStress)

	slot0.loader:startLoad(FightNameUIStressMgr.UiType2PrefabPath[slot0:getUiType()] or FightNameUIStressMgr.UiType2PrefabPath[FightNameUIStressMgr.UiType.Normal], slot0.onLoadFinish, slot0)
end

function slot0.onLoadFinish(slot0)
	slot0.instanceGo = slot0.loader:getInstGO()
	slot0.loaded = true

	slot0:initUI()
	slot0:refreshStress(slot0.cacheEntityMo)

	slot0.cacheEntityMo = nil
end

function slot0.initUI(slot0)
end

function slot0.show(slot0)
	gohelper.setActive(slot0.instanceGo, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.instanceGo, false)
end

function slot0.refreshStress(slot0, slot1)
	if not slot0.loaded then
		slot0.cacheEntityMo = slot1

		return
	end

	slot0.entityMo = slot1

	if not slot1 then
		slot0:hide()

		return
	end

	if not slot1:hasStress() then
		slot0:hide()

		return
	end

	slot0.entityMo = slot1
end

function slot0.destroy(slot0)
	slot0.loader:dispose()

	slot0.loader = nil

	slot0:__onDispose()
end

return slot0
