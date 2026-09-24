-- chunkname: @modules/logic/custompickchoice/model/SummonCustomPickHeroModel.lua

module("modules.logic.custompickchoice.model.SummonCustomPickHeroModel", package.seeall)

local SummonCustomPickHeroModel = class("SummonCustomPickHeroModel", ListScrollModel)

function SummonCustomPickHeroModel:onInit()
	self:reInit()
end

function SummonCustomPickHeroModel:reInit()
	self._selectIdList = {}
	self._allHeroList = {}
	self._notOwnList = {}
	self._ownList = {}
	self._maxCount = 0
end

local function sortFunc(a, b)
	local aHeroMo = HeroModel.instance:getByHeroId(a.id)
	local bHeroMo = HeroModel.instance:getByHeroId(b.id)
	local aHasHero = aHeroMo ~= nil
	local bHasHero = bHeroMo ~= nil

	if aHasHero ~= bHasHero then
		return bHasHero
	end

	local aSkillLevel = aHeroMo and aHeroMo.exSkillLevel or -1
	local bSkillLevel = bHeroMo and bHeroMo.exSkillLevel or -1

	if aSkillLevel ~= bSkillLevel then
		if aSkillLevel == 5 or bSkillLevel == 5 then
			return aSkillLevel ~= 5
		end

		return bSkillLevel < aSkillLevel
	end

	return a.id > b.id
end

function SummonCustomPickHeroModel:initData(bePickChoiceHeroIdList, maxCount)
	self._maxCount = maxCount
	self._notOwnList = {}
	self._ownList = {}
	self._allHeroList = {}

	if not bePickChoiceHeroIdList then
		return
	end

	for _, heroId in ipairs(bePickChoiceHeroIdList) do
		local mo = SummonCustomPickChoiceMO.New()

		mo:init(heroId)

		if mo:hasHero() then
			table.insert(self._ownList, mo)
		else
			table.insert(self._notOwnList, mo)
		end

		table.insert(self._allHeroList, mo)
	end

	table.sort(self._ownList, sortFunc)
end

function SummonCustomPickHeroModel:haveAllRole()
	return self._notOwnList and #self._notOwnList <= 0
end

function SummonCustomPickHeroModel:getOwnList()
	return self._ownList
end

function SummonCustomPickHeroModel:getNotOwnList()
	return self._notOwnList
end

function SummonCustomPickHeroModel:getAllHeroList()
	return self._allHeroList
end

function SummonCustomPickHeroModel:setSelectId(heroId)
	if not self._selectIdList then
		self._selectIdList = {}
	end

	if LuaUtil.tableContains(self._selectIdList, heroId) then
		tabletool.removeValue(self._selectIdList, heroId)
	else
		table.insert(self._selectIdList, heroId)

		if #self._selectIdList > self._maxCount then
			table.remove(self._selectIdList, 1)
		end
	end
end

function SummonCustomPickHeroModel:clearSelectIds()
	self._selectIdList = {}
end

function SummonCustomPickHeroModel:getSelectIds()
	return self._selectIdList
end

function SummonCustomPickHeroModel:getSelectCount()
	return #self._selectIdList
end

function SummonCustomPickHeroModel:getMaxSelectCount()
	return self._maxCount
end

function SummonCustomPickHeroModel:isHeroIdSelected(heroId)
	for _, id in ipairs(self._selectIdList) do
		if id == heroId then
			return true
		end
	end

	return false
end

SummonCustomPickHeroModel.instance = SummonCustomPickHeroModel.New()

return SummonCustomPickHeroModel
