module("modules.logic.gm.model.GMCommandHistoryModel", package.seeall)

slot0 = class("GMCommandHistoryModel")
slot1 = "|@|"
slot2 = 30

function slot0._initCommandList(slot0)
	if slot0._commandList then
		return
	end

	slot0._commandList = string.split(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewHistory, ""), uv0) or {}
end

function slot0.getCommandHistory(slot0)
	slot0:_initCommandList()

	return slot0._commandList
end

function slot0.addCommandHistory(slot0, slot1)
	slot0:_initCommandList()
	tabletool.removeValue(slot0._commandList, slot1)
	table.insert(slot0._commandList, 1, slot1)
	slot0:_saveCommandList()
end

function slot0.removeCommandHistory(slot0, slot1)
	slot0:_initCommandList()
	tabletool.removeValue(slot0._commandList, slot1)
	slot0:_saveCommandList()
end

function slot0._saveCommandList(slot0)
	while uv0 < #slot0._commandList do
		table.remove(slot0._commandList, #slot0._commandList)
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewHistory, table.concat(slot0._commandList, uv1))
end

slot0.instance = slot0.New()

return slot0
