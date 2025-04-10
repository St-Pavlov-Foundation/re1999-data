module("modules.logic.versionactivity2_7.lengzhou6.model.buff.StiffBuff", package.seeall)

slot0 = class("StiffBuff", BuffBase)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)
end

function slot0.execute(slot0, slot1)
	if slot1 == nil then
		return false
	end

	if slot0._layerCount == 0 then
		return false
	end

	slot0:addCount(-1)

	return true
end

return slot0
