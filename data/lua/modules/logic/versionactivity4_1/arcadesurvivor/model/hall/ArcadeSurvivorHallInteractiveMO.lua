-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/hall/ArcadeSurvivorHallInteractiveMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.hall.ArcadeSurvivorHallInteractiveMO", package.seeall)

local ArcadeSurvivorHallInteractiveMO = class("ArcadeSurvivorHallInteractiveMO", ArcadeSurvivorHallEntityMO)

function ArcadeSurvivorHallInteractiveMO:onCtor()
	local cfg = self:getCfg()
	local grid = string.splitToNumber(cfg.grid, "#")

	self:setGridSize(grid[1], grid[2])

	local pos = string.splitToNumber(cfg.pos, "#")

	self:setGridPos(pos[1], pos[2])

	self._showInfoUITypeList = {}

	if not string.nilorempty(cfg.talkGroupIds) then
		table.insert(self._showInfoUITypeList, ArcadeSurvivorHallEnum.ShowInfoUIType.UITalk)
	end

	if not string.nilorempty(cfg.nameOffset) then
		table.insert(self._showInfoUITypeList, ArcadeSurvivorHallEnum.ShowInfoUIType.UIName)
	end

	self:onInitTalk()
end

function ArcadeSurvivorHallInteractiveMO:setReddotType(reddotType)
	self._reddotType = reddotType
end

function ArcadeSurvivorHallInteractiveMO:getId()
	return self.id
end

function ArcadeSurvivorHallInteractiveMO:getCfg()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getHallUnitCfg(id, true)
end

function ArcadeSurvivorHallInteractiveMO:getShowInfoUITypeList()
	return self._showInfoUITypeList
end

function ArcadeSurvivorHallInteractiveMO:getReddotType()
	return self._reddotType
end

function ArcadeSurvivorHallInteractiveMO:isUnlock()
	local isUnlock = true
	local id = self:getId()
	local difficulty = ArcadeSurvivorConfig.instance:getHallUnitDifficulty(id)

	if difficulty > 0 then
		isUnlock = ArcadeSurvivorOutSideModel.instance:isUnlockDifficulty(difficulty)
	end

	return isUnlock
end

function ArcadeSurvivorHallInteractiveMO:onInitTalk()
	return
end

function ArcadeSurvivorHallInteractiveMO:getTalkGroupId(condition)
	local id = self:getId()

	logError(string.format("ArcadeSurvivorHallInteractiveMO:getTalkGroupId not override", id))
end

function ArcadeSurvivorHallInteractiveMO:getStepContentInfo(groupId, stepId)
	local id = self:getId()

	logError(string.format("ArcadeSurvivorHallInteractiveMO:getStepContentInfo not override", id))
end

return ArcadeSurvivorHallInteractiveMO
