module("modules.logic.common.view.FixTmpBreakLine", package.seeall)

slot0 = class("FixTmpBreakLine", LuaCompBase)

function slot0.initData(slot0, slot1)
	slot0.textMeshPro = slot1.gameObject:GetComponent(typeof(TMPro.TextMeshProUGUI))

	if slot0.textMeshPro then
		slot0.textMeshPro.richText = true
	end
end

function slot0.refreshTmpContent(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:initData(slot1)

	if not slot0:startsWith(slot0.textMeshPro.text, "<nobr>") then
		slot2 = string.format("<nobr>%s", slot2)
	end

	slot0.textMeshPro.text = string.gsub(slot2, " +", function (slot0)
		return "<space=" .. string.len(slot0) * ZProj.GameHelper.GetTmpCharWidth(uv0.textMeshPro, 32) .. ">"
	end)

	slot0.textMeshPro:Rebuild(UnityEngine.UI.CanvasUpdate.PreRender)
end

function slot0.startsWith(slot0, slot1, slot2)
	return string.sub(slot1, 1, string.len(slot2)) == slot2
end

return slot0
