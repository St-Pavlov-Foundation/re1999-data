module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonCompMgr", package.seeall)

slot0 = class("Act183DungeonCompMgr", LuaCompBase)
slot1 = {
	Running = 3,
	Idle = 2,
	Init = 1
}

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.compInstMap = {}
	slot0.compInstList = {}
	slot0.layoutCompInstMap = {}
	slot0.layoutCompInstList = {}
	slot0._scrolldetail = gohelper.findChildScrollRect(slot0.go, "#scroll_detail")
	slot0._goScrollContent = gohelper.findChild(slot0.go, "#scroll_detail/Viewport/Content")
	slot0._status = uv0.Init
end

function slot0.addComp(slot0, slot1, slot2, slot3)
	if slot0.compInstMap[slot2] then
		logError(string.format("重复挂载 clsDefine = %s", slot2))

		return
	end

	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot1, slot2)
	slot4.mgr = slot0
	slot0.compInstMap[slot2] = slot4

	table.insert(slot0.compInstList, slot4)

	if slot3 then
		slot0.layoutCompInstMap[slot2] = slot4

		table.insert(slot0.layoutCompInstList, slot4)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._status = uv0.Running

	for slot5, slot6 in ipairs(slot0.compInstList) do
		slot6:onUpdateMO(slot1)
	end

	slot0._status = uv0.Idle

	slot0:_reallyFocus()
end

function slot0.getComp(slot0, slot1)
	if not slot0.compInstMap[slot1] then
		logError("组件不存在" .. slot1.__cname)
	end

	return slot2
end

function slot0.getFuncValue(slot0, slot1, slot2, ...)
	if slot0:getComp(slot1) then
		if not slot3[slot2] then
			logError(string.format("方法不存在 clsDefine = %s, funcName = %s", slot1.__cname, slot2))

			return
		end

		return slot4(slot3, ...)
	end
end

function slot0.getFieldValue(slot0, slot1, slot2)
	return slot0:getComp(slot1) and slot3[slot2]
end

function slot0.isCompVisible(slot0, slot1)
	return slot0:getComp(slot1) and slot2:checkIsVisible()
end

function slot0.focus(slot0, slot1, ...)
	if not slot0.layoutCompInstMap[slot1] then
		logError(string.format("定位失败, 定位目标组件不存在!!! cls = %s", slot1 and slot1.__cname))

		return
	end

	slot0._focusTargetInst = slot2
	slot0._focusParams = {
		...
	}
	slot0._waitFocus = true

	if slot0._status ~= uv0.Idle then
		return
	end

	slot0:_reallyFocus()
end

function slot0._reallyFocus(slot0)
	if not slot0._waitFocus then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._goScrollContent.transform)

	slot2 = false

	for slot6, slot7 in ipairs(slot0.layoutCompInstList) do
		if slot7 == slot0._focusTargetInst then
			slot1 = 0 + (slot7:focus(unpack(slot0._focusParams)) or 0)
			slot2 = true

			break
		end

		slot1 = slot1 + (slot7:getHeight() or 0)
	end

	slot0._scrolldetail.verticalNormalizedPosition = 1 - math.abs(slot2 and slot1 or 0) / (recthelper.getHeight(slot0._goScrollContent.transform) - recthelper.getHeight(slot0._scrolldetail.transform))
	slot0._waitFocus = false
	slot0._focusTargetInst = nil
	slot0._focusParams = nil
end

function slot0.onDestroy(slot0)
	slot0:__onDispose()
end

return slot0
