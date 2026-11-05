-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/hall/ArcadeSurvivorHallModel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.hall.ArcadeSurvivorHallModel", package.seeall)

local ArcadeSurvivorHallModel = class("ArcadeSurvivorHallModel", BaseModel)

function ArcadeSurvivorHallModel:onInit()
	self._characterMODict = {}
end

function ArcadeSurvivorHallModel:reInit()
	return
end

function ArcadeSurvivorHallModel:initInteractiveMODict()
	self:setInInteractiveHallUnitId()

	self._interactiveMODict = {}

	local hallUnitIdList = ArcadeSurvivorConfig.instance:getHallUnitIdList()

	for _, unitId in ipairs(hallUnitIdList) do
		local cls = ArcadeSurvivorHallInteractiveMO

		if unitId == ArcadeSurvivorHallEnum.HallInteractiveUnitId.NPC then
			cls = ArcadeSurvivorHallNPCMO
		end

		self._interactiveMODict[unitId] = cls.New(unitId)
	end
end

function ArcadeSurvivorHallModel:saveHeroGrid()
	local characterMO = self:getEquipCharacterMO()

	if characterMO then
		local curGridX, curGridY = characterMO:getGridPos()

		ArcadeSurvivorRpc.instance:sendArcadeSurvivorRoleMoveRequest(curGridX, curGridY)
	end
end

function ArcadeSurvivorHallModel:refreshInteractiveReddot()
	self:refreshHandBookReddot()
	self:refreshDevelopReddot()
	self:refreshTaskReddot()
end

function ArcadeSurvivorHallModel:refreshHandBookReddot()
	local mo = self:getInteractiveMO(ArcadeSurvivorHallEnum.HallInteractiveUnitId.HandBook)

	if not mo then
		return
	end

	local hasReddot = ArcadeSurvivorHandBookModel.instance:hasReddot()
	local type = hasReddot and ArcadeSurvivorHallEnum.ReddotType.Normal or ArcadeSurvivorHallEnum.ReddotType.None

	mo:setReddotType(type)
end

function ArcadeSurvivorHallModel:refreshDevelopReddot()
	local mo = self:getInteractiveMO(ArcadeSurvivorHallEnum.HallInteractiveUnitId.Develop)

	if not mo then
		return
	end

	local type = ArcadeSurvivorHeroModel.instance:getReddotType()

	mo:setReddotType(type)
end

function ArcadeSurvivorHallModel:refreshTaskReddot()
	local mo = self:getInteractiveMO(ArcadeSurvivorHallEnum.HallInteractiveUnitId.Task)

	if not mo then
		return
	end

	local hasReddot = ArcadeSurvivorOutSideModel.instance:hasRewardReddot()
	local type = hasReddot and ArcadeSurvivorHallEnum.ReddotType.Normal or ArcadeSurvivorHallEnum.ReddotType.None

	mo:setReddotType(type)
end

function ArcadeSurvivorHallModel:setHeroGrid(x, y)
	self._heroGridX, self._heroGridY = x, y
end

function ArcadeSurvivorHallModel:setInInteractiveHallUnitId(id)
	self._inInteractiveHallUnitId = id
end

function ArcadeSurvivorHallModel:getInteractiveMODict()
	return self._interactiveMODict
end

function ArcadeSurvivorHallModel:getInteractiveMO(interactiveId)
	return self._interactiveMODict and self._interactiveMODict[interactiveId]
end

function ArcadeSurvivorHallModel:getHeroGrid()
	return self._heroGridX, self._heroGridY
end

function ArcadeSurvivorHallModel:getInInteractiveHallUnitId()
	return self._inInteractiveHallUnitId
end

function ArcadeSurvivorHallModel:getEquipCharacterMO()
	local equipHeroId = ArcadeSurvivorHeroModel.instance:getEquipHeroId()

	return self:getCharacterMOById(equipHeroId)
end

function ArcadeSurvivorHallModel:getCharacterMOById(id)
	if not id then
		return
	end

	local result = self._characterMODict[id]

	if not result then
		result = ArcadeSurvivorHallHeroMO.New(id)
		self._characterMODict[id] = result
	end

	return result
end

function ArcadeSurvivorHallModel:getHallGridSize()
	if not self._hallGridSize then
		self._hallGridSize = ArcadeSurvivorConfig.instance:getConstArray(ArcadeSurvivorEnum.ConstId.HallGridSize, true, "#") or {}
	end

	return self._hallGridSize
end

ArcadeSurvivorHallModel.instance = ArcadeSurvivorHallModel.New()

return ArcadeSurvivorHallModel
