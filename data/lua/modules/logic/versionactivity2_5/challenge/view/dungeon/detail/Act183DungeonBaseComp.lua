module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBaseComp", package.seeall)

slot0 = class("Act183DungeonBaseComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.tran = slot1.transform
end

function slot0.checkIsVisible(slot0)
	return true
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:updateInfo(slot1)
	slot0:refresh()
end

function slot0.updateInfo(slot0, slot1)
	slot0._episodeMo = slot1
	slot0._status = slot0._episodeMo:getStatus()
	slot0._episodeCo = slot0._episodeMo:getConfig()
	slot0._episodeId = slot0._episodeMo:getEpisodeId()
	slot0._episodeType = slot0._episodeMo:getEpisodeType()
	slot0._passOrder = slot0._episodeMo:getPassOrder()
	slot0._groupId = slot0._episodeCo.groupId
	slot0._activityId = slot0._episodeCo.activityId
	slot0._groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(slot0._groupId)
	slot0._groupType = slot0._groupEpisodeMo:getGroupType()
end

function slot0.refresh(slot0)
	slot0._isVisible = slot0:checkIsVisible()

	gohelper.setActive(slot0.go, slot0._isVisible)

	if not slot0._isVisible then
		return
	end

	slot0:show()
end

function slot0.show(slot0)
end

function slot0.createObjList(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot1 or not slot2 or not slot3 or not slot4 or not slot5 or not slot6 then
		logError("缺失参数")

		return
	end

	slot7 = {
		[slot13] = true
	}

	for slot11, slot12 in ipairs(slot1) do
		slot13 = slot0:_getOrCreateItem(slot11, slot2, slot3, slot4)

		gohelper.setActive(slot13.go, true)
		slot5(slot0, slot13, slot12, slot11)
	end

	for slot11, slot12 in pairs(slot2) do
		if not slot7[slot12] then
			slot6(slot0, slot12)
		end
	end

	gohelper.setActive(slot3, false)
end

function slot0.createObjListNum(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot1 or not slot2 or not slot3 or not slot4 or not slot5 or not slot6 then
		logError("缺失参数")

		return
	end

	slot7 = {
		[slot12] = true
	}

	for slot11 = 1, slot1 do
		slot12 = slot0:_getOrCreateItem(slot11, slot2, slot3, slot4)

		slot5(slot0, slot12, nil, slot11)
		gohelper.setActive(slot12.go, true)
	end

	for slot11, slot12 in pairs(slot2) do
		if not slot7[slot12] then
			slot6(slot0, slot12)
		end
	end

	gohelper.setActive(slot3, false)
end

function slot0._getOrCreateItem(slot0, slot1, slot2, slot3, slot4)
	if not slot2[slot1] then
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.cloneInPlace(slot3, "item_" .. slot1)
		slot5.index = slot1

		slot4(slot0, slot5, slot1)

		slot2[slot1] = slot5
	end

	return slot5
end

function slot0._defaultItemFreeFunc(slot0, slot1)
	gohelper.setActive(slot1.go, false)
end

function slot0.getHeight(slot0)
	if not slot0.tran then
		logError(string.format("Transform组件不存在 cls = %s", slot0.__cname))

		return 0
	end

	if not slot0._isVisible then
		return 0
	end

	ZProj.UGUIHelper.RebuildLayout(slot0.tran)

	return recthelper.getHeight(slot0.tran)
end

function slot0.focus(slot0, slot1)
	return 0
end

function slot0.onDestroy(slot0)
	slot0:__onDispose()
end

return slot0
