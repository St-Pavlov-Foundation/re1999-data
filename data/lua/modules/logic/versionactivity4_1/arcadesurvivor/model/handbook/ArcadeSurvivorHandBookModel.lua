-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/handbook/ArcadeSurvivorHandBookModel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.handbook.ArcadeSurvivorHandBookModel", package.seeall)

local ArcadeSurvivorHandBookModel = class("ArcadeSurvivorHandBookModel", BaseModel)

function ArcadeSurvivorHandBookModel:onInit()
	self:reInit()
end

function ArcadeSurvivorHandBookModel:reInit()
	self._moDict = nil

	ArcadeSurvivorHandBookListModel.instance:clearTypeDict()
end

function ArcadeSurvivorHandBookModel:_initMODict()
	self._moDict = {}

	for _, cfg in ipairs(arcade_survivor_handbook.configList) do
		local category = cfg.category
		local cls = ArcadeSurvivorHallEnum.HandBookTypeCls[category]

		if cls then
			local categoryModel = self._moDict[category]

			if not categoryModel then
				categoryModel = BaseModel.New()
				self._moDict[category] = categoryModel
			end

			local mo = cls.New(cfg.eleId, category)

			categoryModel:addAtLast(mo)
		else
			logError(string.format("ArcadeSurvivorHandBookModel:_initMODict error, category:%s no cls", category))
		end
	end

	for _, v in pairs(self._moDict) do
		local list = v:getList()

		table.sort(list, function(a, b)
			return a.id < b.id
		end)
	end

	ArcadeSurvivorHandBookListModel.instance:clearTypeDict()
end

function ArcadeSurvivorHandBookModel:refreshInfo(bookInfo)
	local booksInfo = bookInfo and bookInfo.books

	if not booksInfo then
		return
	end

	local eleTypeDict = {}
	local newEleTypeDict = {}

	for i = 1, #booksInfo do
		local info = booksInfo[i]
		local type = info.type
		local eleDict = GameUtil.tabletool_checkDictTable(eleTypeDict, type)

		for j = 1, #info.eleId do
			local id = info.eleId[j]

			eleDict[id] = (eleDict[id] or 0) + 1
		end

		local newEleDict = GameUtil.tabletool_checkDictTable(newEleTypeDict, type)

		for j = 1, #info.newEleId do
			local id = info.newEleId[j]

			newEleDict[id] = true
		end
	end

	local moDict = self:getMODict()

	for type, model in pairs(moDict) do
		local eleDict = eleTypeDict[type]
		local newEleDict = newEleTypeDict[type]
		local moList = model:getList()

		for _, mo in pairs(moList) do
			local id = mo:getId()
			local count = eleDict and eleDict[id] or 0

			mo:setCount(count)

			local isLock = count <= 0

			mo:setLock(isLock)

			local isNew = newEleDict and newEleDict[id] and not isLock

			mo:setNew(isNew)
		end
	end
end

function ArcadeSurvivorHandBookModel:setShowCategoryType(type, id)
	self._showType = type or ArcadeSurvivorHallEnum.HandBookType.Character
	self._curId = id or self:getDefaultId(self._showType)

	ArcadeSurvivorHandBookListModel.instance:setMOList(self._showType)
end

function ArcadeSurvivorHandBookModel:getMODict()
	if not self._moDict then
		self:_initMODict()
	end

	return self._moDict
end

function ArcadeSurvivorHandBookModel:getMOListByType(type)
	local moDict = self:getMODict()
	local categoryModel = moDict[type]

	if categoryModel then
		return categoryModel:getList()
	end
end

function ArcadeSurvivorHandBookModel:getMOByTypeId(type, id)
	local moDict = self:getMODict()
	local categoryModel = moDict[type]
	local dict = categoryModel and categoryModel:getDict()

	return dict and dict[id]
end

function ArcadeSurvivorHandBookModel:getDefaultId(type)
	local moList = self:getMOListByType(type)

	return moList and moList[1] and moList[1].id
end

function ArcadeSurvivorHandBookModel:getShowCategoryType()
	return self._showType, self._curId
end

function ArcadeSurvivorHandBookModel:getCurShowMO()
	return self:getMOByTypeId(self._showType, self._curId)
end

function ArcadeSurvivorHandBookModel:hasReddotByType(type)
	local moList = self:getMOListByType(type)

	if moList then
		for _, mo in ipairs(moList) do
			local isNew = mo:isNew()

			if isNew then
				return true
			end
		end
	end
end

function ArcadeSurvivorHandBookModel:hasReddot()
	for _, type in pairs(ArcadeSurvivorHallEnum.HandBookType) do
		local hasReddot = self:hasReddotByType(type)

		if hasReddot then
			return true
		end
	end
end

ArcadeSurvivorHandBookModel.instance = ArcadeSurvivorHandBookModel.New()

return ArcadeSurvivorHandBookModel
