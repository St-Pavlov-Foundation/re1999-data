-- chunkname: @modules/logic/college/model/CollegeRoleListModel.lua

module("modules.logic.college.model.CollegeRoleListModel", package.seeall)

local CollegeRoleListModel = class("CollegeRoleListModel", ListScrollModel)
local DefaultSelectIndex = 1

function CollegeRoleListModel:initList(selectMo)
	local characterBox = CollegeModel.instance:getSceneMo().characterBox
	local characters = {}

	tabletool.addValues(characters, characterBox and characterBox.characters)
	table.sort(characters, self._characterSortFunc)
	self:setList(characters)

	local selectIndex = self:getIndex(selectMo) or DefaultSelectIndex

	self:selectCell(selectIndex, true)
end

function CollegeRoleListModel:refreshList()
	local selectMo = self:getByIndex(self._selectIndex) or self:getByIndex(DefaultSelectIndex)

	self:initList(selectMo)
	self:onModelUpdate()
end

function CollegeRoleListModel._characterSortFunc(aRoleMo, bRoleMo)
	local aCo = aRoleMo.co
	local bCo = bRoleMo.co
	local aRarity = aCo and aCo.rarity or 0
	local bRarity = bCo and bCo.rarity or 0

	if aRarity ~= bRarity then
		return bRarity < aRarity
	end

	local aLevel = aRoleMo.level
	local bLevel = bRoleMo.level

	if aLevel ~= bLevel then
		return bLevel < aLevel
	end

	local aId = aCo and aCo.id or 0
	local bId = bCo and bCo.id or 0

	if aId ~= bId then
		return aId < bId
	end

	return aRoleMo.uid < bRoleMo.uid
end

function CollegeRoleListModel:addList(list)
	tabletool.addValues(self._list, list)
end

function CollegeRoleListModel:getById(id)
	logError("废弃方法，不可使用！！！")
end

function CollegeRoleListModel:selectCell(index, isSelect)
	self._selectIndex = isSelect and index or nil

	CollegeRoleListModel.super.selectCell(self, index, isSelect)
end

CollegeRoleListModel.instance = CollegeRoleListModel.New()

return CollegeRoleListModel
