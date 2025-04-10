module("modules.logic.versionactivity2_7.lengzhou6.model.buff.LengZhou6BuffSystem", package.seeall)

slot0 = class("LengZhou6BuffSystem")
slot1 = 0

function slot2()
	uv0 = uv0 + 1

	return uv0
end

function slot0.addBuffToPlayer(slot0, slot1)
	if LengZhou6GameModel.instance:getPlayer() then
		if slot2:getBuffByConfigId(slot1) ~= nil then
			slot3:addCount(1)
		else
			slot4 = LengZhou6BuffUtils.instance.createBuff(slot1)

			slot4:init(uv0(), slot1)
			slot2:addBuff(slot4)
		end
	end

	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.RefreshBuffItem)
end

function slot0.addBuffToEnemy(slot0, slot1)
	if LengZhou6GameModel.instance:getEnemy() then
		if slot2:getBuffByConfigId(slot1) ~= nil then
			slot3:addCount(1)
		else
			slot4 = LengZhou6BuffUtils.instance.createBuff(slot1)

			slot4:init(uv0(), slot1)
			slot2:addBuff(slot4)
		end
	end

	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.RefreshBuffItem)
end

slot0.instance = slot0.New()

return slot0
