﻿-- chunkname: @modules/logic/survival/model/shelter/SurvivalEquipSlotMo.lua

module("modules.logic.survival.model.shelter.SurvivalEquipSlotMo", package.seeall)

local SurvivalEquipSlotMo = pureTable("SurvivalEquipSlotMo")

function SurvivalEquipSlotMo:init(data, parent)
	self.parent = parent or self.parent
	self.slotId = data.slotId
	self.level = data.level
	self.item = SurvivalBagItemMo.New()

	self.item:init(data.item)

	self.item.source = SurvivalEnum.ItemSource.Equip
	self.item.slotMo = self
	self.item.index = self.slotId
	self.values = {}

	for _, v in ipairs(data.values) do
		self.values[v.id] = v.value
	end

	self.item.equipValues = self.values
	self.unlock = data.unlock
	self.newFlag = data.newFlag

	local exScore = 0

	if self.item.equipCo and not string.nilorempty(self.item.equipCo.effect) then
		local arr = string.splitToNumber(self.item.equipCo.effect, "#")

		for _, effectId in ipairs(arr) do
			local effectCo = lua_survival_equip_effect.configDict[effectId]
			local dictMax = {}

			if effectCo and not string.nilorempty(effectCo.effect_score) then
				local dict = GameUtil.splitString2(effectCo.effect_score, true)

				for _, v in ipairs(dict) do
					local attrId = v[1] or 0
					local needNum = v[2] or 0
					local score = v[3] or 0

					if self.values[attrId] and needNum <= self.values[attrId] and (not dictMax[attrId] or score > dictMax[attrId]) then
						dictMax[attrId] = score
					end
				end

				for _, score in pairs(dictMax) do
					exScore = exScore + score
				end
			end
		end
	end

	self.item.exScore = exScore
end

function SurvivalEquipSlotMo:getScore()
	if not self.item.equipCo then
		return 0
	end

	return self.item.equipCo.score + self.item.exScore
end

return SurvivalEquipSlotMo
