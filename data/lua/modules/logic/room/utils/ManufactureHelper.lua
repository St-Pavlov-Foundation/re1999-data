module("modules.logic.room.utils.ManufactureHelper", package.seeall)

return {
	findItemIdListByBUid = function (slot0)
		if not ManufactureModel.instance:getManufactureMOById(slot0) then
			return {}
		end

		for slot7, slot8 in ipairs(slot2:getAllUnlockedSlotMOList()) do
			if (slot8:getSlotState() == RoomManufactureEnum.SlotState.Running or slot9 == RoomManufactureEnum.SlotState.Wait or slot9 == RoomManufactureEnum.SlotState.Stop or slot9 == RoomManufactureEnum.SlotState.Complete) and not tabletool.indexOf(slot1, ManufactureConfig.instance:getItemId(slot8:getSlotManufactureItemId())) then
				table.insert(slot1, slot11)
			end
		end

		return slot1
	end
}
