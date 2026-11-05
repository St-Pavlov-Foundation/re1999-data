-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/develop/ArcadeSurvivorHeroModel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.develop.ArcadeSurvivorHeroModel", package.seeall)

local ArcadeSurvivorHeroModel = class("ArcadeSurvivorHeroModel", BaseModel)

function ArcadeSurvivorHeroModel:onInit()
	self:reInit()
end

function ArcadeSurvivorHeroModel:reInit()
	self._selectHeroId = nil
	self._equipHeroId = nil
	self._talentModel = nil
	self._heroModel = nil
end

function ArcadeSurvivorHeroModel:refreshTalentInfo(talentInfo)
	local dict = {}

	if talentInfo.talents then
		for i = 1, #talentInfo.talents do
			local info = talentInfo.talents[i]

			dict[info.id] = info
		end
	end

	local moList = self:getTalentMOList()

	for _, mo in ipairs(moList) do
		local info = dict[mo.id]

		mo:refreshInfo(info)
	end
end

function ArcadeSurvivorHeroModel:refreshPlayerInfo(roleInfo)
	self:setEquipHeroId(roleInfo.id)

	local selectId = self:getSelectHeroId()
	local equipId = self:getEquipHeroId()
	local moList = self:getHeroMOList()

	for _, heroMO in ipairs(moList) do
		heroMO:checkSelect(selectId)
		heroMO:checkEquip(equipId)

		local isLock = heroMO:isLock()
		local prefsKey, key = heroMO:getReddotKey()
		local prefsNew = ArcadeSurvivorHallEnum.Const.PrefsNew
		local prefsValue = ArcadeSurvivorOutSideModel.instance:getPlayerPrefsValue(prefsKey, key, prefsNew, true)
		local isNew = prefsValue == prefsNew

		heroMO:setNew(not isLock and isNew)
	end

	self:setCharacterPos(roleInfo.pos.x, roleInfo.pos.y)
end

function ArcadeSurvivorHeroModel:setTalentLevel(id, level)
	local mos = self:getTalentModel()
	local mo = mos:getById(id)

	if mo then
		mo:setLevel(level)
	end
end

function ArcadeSurvivorHeroModel:setEquipHeroId(id)
	self._equipHeroId = id

	local moList = self:getHeroMOList()

	for _, mo in ipairs(moList) do
		mo:checkEquip(id)
	end
end

function ArcadeSurvivorHeroModel:markHeroRead(id)
	local mo = self:getHeroMOById(id)

	if mo:isLock() or not mo:isNew() then
		return
	end

	mo:setNew(false)

	local prefsKey, key = mo:getReddotKey()

	ArcadeSurvivorOutSideModel.instance:setPlayerPrefsValue(prefsKey, key, ArcadeSurvivorHallEnum.Const.PrefsOld, true)
end

function ArcadeSurvivorHeroModel:setSelectHeroId(id)
	self._selectHeroId = id

	local moList = self:getHeroMOList()

	for _, mo in ipairs(moList) do
		mo:checkSelect(id)
	end
end

function ArcadeSurvivorHeroModel:setCharacterPos(x, y)
	local moDict = ArcadeSurvivorHallModel.instance:getInteractiveMODict()

	if not moDict then
		return
	end

	for _, mo in pairs(moDict) do
		local enterRange = mo:isEnterRange(x, y)

		if enterRange then
			return
		end
	end

	self._characterPosX, self._characterPosY = x, y
end

function ArcadeSurvivorHeroModel:getEquipHeroId()
	if self._equipHeroId then
		return self._equipHeroId
	else
		return ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.DefaultEquipHero, true)
	end
end

function ArcadeSurvivorHeroModel:getSelectHeroId()
	return self._selectHeroId or self:getEquipHeroId()
end

function ArcadeSurvivorHeroModel:getTalentModel()
	if not self._talentModel then
		self._talentModel = BaseModel.New()

		for id, cfgList in pairs(lua_arcade_survivor_talent.configDict) do
			local mo = ArcadeSurvivorTalentMO.New(id, cfgList)

			self._talentModel:addAtLast(mo)
		end
	end

	return self._talentModel
end

function ArcadeSurvivorHeroModel:getTalentMOList()
	local talentModel = self:getTalentModel()

	return talentModel:getList()
end

function ArcadeSurvivorHeroModel:getHeroModel()
	if not self._heroModel then
		self._heroModel = BaseModel.New()

		local moList = ArcadeSurvivorHandBookModel.instance:getMOListByType(ArcadeSurvivorHallEnum.HandBookType.Character)

		for _, mo in ipairs(moList) do
			local heroMO = ArcadeSurvivorHeroMO.New(mo)

			self._heroModel:addAtLast(heroMO)
		end
	end

	return self._heroModel
end

function ArcadeSurvivorHeroModel:getHeroMOList()
	local heroModel = self:getHeroModel()

	return heroModel:getList()
end

function ArcadeSurvivorHeroModel:getHeroMOById(id)
	local heroModel = self:getHeroModel()

	return heroModel:getById(id)
end

function ArcadeSurvivorHeroModel:getCharacterPos()
	if not self._characterPosX or not self._characterPosY then
		self._characterPosX = 0
		self._characterPosY = 0

		local initPosArr = ArcadeSurvivorConfig.instance:getConstArray(ArcadeSurvivorEnum.ConstId.DefaultHallHeroPos, true, "#")

		if initPosArr then
			self._characterPosX, self._characterPosY = initPosArr[1], initPosArr[2]
		end
	end

	return self._characterPosX, self._characterPosY
end

function ArcadeSurvivorHeroModel:hasReddotCharacter()
	local list = self:getHeroMOList()

	for _, mo in ipairs(list) do
		local isNew = not mo:isLock() and mo:isNew()

		if isNew then
			return true
		end
	end
end

function ArcadeSurvivorHeroModel:hasReddotTalent()
	local list = self:getTalentMOList()

	for _, mo in ipairs(list) do
		local canUpLV = mo:canUpLV()

		if canUpLV then
			return true
		end
	end
end

function ArcadeSurvivorHeroModel:getReddotType()
	local haveCharacterReddot = self:hasReddotCharacter()
	local haveTalentReddot = self:hasReddotTalent()

	if haveCharacterReddot or haveTalentReddot then
		return ArcadeSurvivorHallEnum.ReddotType.Normal
	end
end

ArcadeSurvivorHeroModel.instance = ArcadeSurvivorHeroModel.New()

return ArcadeSurvivorHeroModel
