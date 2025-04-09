module("modules.logic.versionactivity2_7.lengzhou6.model.buff.LengZhou6BuffUtils", package.seeall)

slot0 = class("LengZhou6BuffUtils")
slot1 = {
	[1001] = PoisoningBuff,
	[1002] = StiffBuff,
	[1003] = DamageBuff
}

function slot0.createBuff(slot0)
	if uv0[slot0] == nil then
		logError("LengZhou6BuffUtils.createBuff: buffIdToBuff[id] == nil, id = " .. slot0)
	end

	return uv0[slot0]:New()
end

slot0.instance = slot0.New()

return slot0
