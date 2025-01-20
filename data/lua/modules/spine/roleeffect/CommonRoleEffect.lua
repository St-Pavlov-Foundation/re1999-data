module("modules.spine.roleeffect.CommonRoleEffect", package.seeall)

slot0 = class("CommonRoleEffect", BaseSpineRoleEffect)

function slot0.init(slot0, slot1)
	slot0._roleEffectConfig = slot1
	slot0._spineGo = slot0._spine._spineGo
	slot0._motionList = string.split(slot1.motion, "|")
	slot0._nodeList = GameUtil.splitString2(slot1.node, false, "|", "#")
	slot0._firstShow = false
end

function slot0.showBodyEffect(slot0, slot1, slot2, slot3)
	slot0._effectVisible = false

	slot0:_setNodeVisible(slot0._index, false)

	slot0._index = tabletool.indexOf(slot0._motionList, slot1)

	slot0:_setNodeVisible(slot0._index, true)

	if not slot0._firstShow then
		slot0._firstShow = true

		slot0:showEverNodes(true)
	end

	if slot2 and slot3 then
		slot2(slot3, slot0._effectVisible)
	end
end

function slot0.showEverNodes(slot0, slot1)
	if string.nilorempty(slot0._roleEffectConfig.everNode) then
		return
	end

	for slot6, slot7 in ipairs(string.split(slot0._roleEffectConfig.everNode, "#")) do
		slot8 = gohelper.findChild(slot0._spineGo, slot7)

		gohelper.setActive(slot8, slot1)

		if not slot8 and SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("找不到特效节点：%s,请检查路径", slot7))
		end
	end
end

function slot0._setNodeVisible(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	for slot7, slot8 in ipairs(slot0._nodeList[slot1]) do
		slot9 = gohelper.findChild(slot0._spineGo, slot8)

		gohelper.setActive(slot9, slot2)

		if not slot9 and SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("找不到特效节点：%s,请检查路径", slot8))
		end

		if slot2 then
			slot0._effectVisible = true
		end
	end
end

function slot0.playBodyEffect(slot0, slot1, slot2, slot3)
end

function slot0.onDestroy(slot0)
	slot0._spineGo = nil
end

return slot0
