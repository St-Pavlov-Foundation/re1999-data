-- chunkname: @modules/logic/character/model/HeroDeviceMO.lua

module("modules.logic.character.model.HeroDeviceMO", package.seeall)

local HeroDeviceMO = class("HeroDeviceMO")

function HeroDeviceMO:ctor(heroId)
	self._heroId = heroId
end

function HeroDeviceMO:refreshDevice(deviceId)
	if self._deviceId == deviceId then
		return
	end

	self._deviceId = deviceId
	self._config = lua_fight_device.configDict[self._deviceId]
	self._powerSkill = GameUtil.splitString2(self._config.powerSkill, true, "|", "#")
	self._specialPowerSkill = GameUtil.splitString2(self._config.specialPowerSkill, true, "|", "#")
	self._skills = {}
	self._skill1 = string.splitToNumber(self._config.skill1, "#")
	self._skill2 = string.splitToNumber(self._config.skill2, "#")
	self._uniqueSkill = string.splitToNumber(self._config.uniqueSkill, "#")
end

function HeroDeviceMO:setHeroMo(heroMo)
	self._heroMo = heroMo
end

function HeroDeviceMO:getSkillIdsStr()
	local str = string.format("1#%s|2#%s", self:getSkillId(1), self:getSkillId(2))

	return str, self:getSkillId(3)
end

function HeroDeviceMO:getSkillId(skillIndex)
	if skillIndex == 1 then
		return self._skill1[1]
	end

	if skillIndex == 2 then
		return self._skill2[1]
	end

	if skillIndex == 3 then
		return self._uniqueSkill[1]
	end
end

function HeroDeviceMO:getSkillInfo(skillIndex)
	if skillIndex == 1 then
		return self._skill1
	end

	if skillIndex == 2 then
		return self._skill2
	end

	if skillIndex == 3 then
		return self._uniqueSkill
	end
end

function HeroDeviceMO:getPowerSkills()
	return self._powerSkill, self._specialPowerSkill
end

function HeroDeviceMO:getUniqueSkillPoint()
	local heroMo = self:getHeroMo()

	if heroMo then
		local destinyStoneMo = heroMo:getHeroDestinyStoneMo()

		if destinyStoneMo then
			local stoenCo = destinyStoneMo:getCurUseStoneCo()

			if stoenCo and not string.nilorempty(stoenCo.uniqueSkill_point) then
				local uniqueSkill_point = string.splitToNumber(stoenCo.uniqueSkill_point, "#")

				return uniqueSkill_point[2] or 0
			end
		end
	end

	if not self._heroId then
		return 0
	end

	local heroCo = HeroConfig.instance:getHeroCO(self._heroId)

	if heroCo and not string.nilorempty(heroCo.uniqueSkill_point) then
		local uniqueSkill_point = string.splitToNumber(heroCo.uniqueSkill_point, "#")

		return uniqueSkill_point[2] or 0
	end

	return 0
end

function HeroDeviceMO:getHeroMo()
	return self._heroMo or self._heroId and HeroModel.instance:getByHeroId(self._heroId)
end

return HeroDeviceMO
