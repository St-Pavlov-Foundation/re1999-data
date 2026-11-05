-- chunkname: @modules/logic/versionactivity4_1/library/config/V4a1_LibraryConfig.lua

module("modules.logic.versionactivity4_1.library.config.V4a1_LibraryConfig", package.seeall)

local V4a1_LibraryConfig = class("V4a1_LibraryConfig", BaseConfig)

local function _splitNumbers(value)
	if string.nilorempty(value) then
		return {}
	end

	return string.splitToNumber(value, "#")
end

local function _splitIds(value)
	local result = {}

	for _, id in ipairs(_splitNumbers(value)) do
		if id and id ~= 0 then
			table.insert(result, id)
		end
	end

	return result
end

local function _constCO(id)
	return lua_v4a1_library_const.configDict[id]
end

function V4a1_LibraryConfig:actId()
	return ActivityConfig.instance:getConstAsNum(41000, 14034)
end

function V4a1_LibraryConfig:sceneType()
	return SceneType.Library
end

function V4a1_LibraryConfig:isLibraryScene(sceneType)
	return sceneType == self:sceneType()
end

function V4a1_LibraryConfig:reqConfigNames()
	return {
		"v4a1_library_const",
		"v4a1_library_const_mlstring",
		"v4a1_library_show",
		"v4a1_library_char",
		"v4a1_library_chat",
		"v4a1_library_chat_desc",
		"v4a1_library_chat_emoji"
	}
end

function V4a1_LibraryConfig:onConfigLoaded(configName, configTable)
	if configName == "v4a1_library_show" then
		self:__init_v4a1_library_show(configTable)
	end
end

local kV4ZeroTable = {
	0,
	0,
	0,
	0
}

function V4a1_LibraryConfig:getConstAsNum(id, fallback)
	local co = _constCO(id)

	if not co then
		return fallback
	end

	return tonumber(co.strValue) or fallback
end

function V4a1_LibraryConfig:getConstAsListNum(id, fallback)
	local co = _constCO(id)

	if not co then
		return fallback
	end

	if string.nilorempty(co.strValue) then
		return fallback
	end

	return _splitNumbers(co.strValue)
end

function V4a1_LibraryConfig:getSceneId()
	return self:getConstAsNum(1, 801)
end

function V4a1_LibraryConfig:getSceneLevelId()
	return self:getConstAsNum(2, 80101)
end

function V4a1_LibraryConfig:getCharSortingLayerName()
	return self:getConstAsNum(3, SortingLayers.Unit)
end

function V4a1_LibraryConfig:getFallbackScale()
	return self:getConstAsNum(4, 1)
end

function V4a1_LibraryConfig:getFallbackCollider2DSize()
	return self:getConstAsListNum(5, kV4ZeroTable)
end

function V4a1_LibraryConfig:getFallbackCollider2DOffset()
	return self:getConstAsListNum(6, kV4ZeroTable)
end

function V4a1_LibraryConfig:getFallbackSortingOrder()
	return self:getConstAsNum(7, 100)
end

function V4a1_LibraryConfig:getCharFallbackSpeed()
	return self:getConstAsNum(8, 5)
end

function V4a1_LibraryConfig:getCharSpeedScale()
	return self:getConstAsNum(9, 0.1)
end

function V4a1_LibraryConfig:getFallbackChatPos()
	return self:getConstAsListNum(10, kV4ZeroTable)
end

function V4a1_LibraryConfig:getFallbackEmojiPos()
	return self:getConstAsListNum(11, kV4ZeroTable)
end

function V4a1_LibraryConfig:getFallbackWalkArea()
	return self:getConstAsListNum(12, kV4ZeroTable)
end

function V4a1_LibraryConfig:getCharClickCooldown()
	return self:getConstAsNum(13, 5)
end

function V4a1_LibraryConfig:getFallbackIdleDurationRange()
	return self:getConstAsListNum(14, kV4ZeroTable)
end

function V4a1_LibraryConfig:getBubbleIntervalSec()
	return self:getConstAsNum(15, 2)
end

function V4a1_LibraryConfig:getFovRange()
	return self:getConstAsListNum(16, {
		25,
		120
	})
end

function V4a1_LibraryConfig:__init_v4a1_library_show(configTable)
	local list = configTable.configList or {}

	table.sort(list, function(a, b)
		return a.days < b.days
	end)
end

function V4a1_LibraryConfig:lua_v4a1_library_showCOList()
	return lua_v4a1_library_show.configList
end

function V4a1_LibraryConfig:getCharCO(skinId)
	return lua_v4a1_library_char.configDict[skinId]
end

function V4a1_LibraryConfig:getCharChatIds(charId)
	local co = self:getCharCO(charId)

	return co and co.chatIds or {}
end

function V4a1_LibraryConfig:getCharIdsByCO(co)
	return co and co.charIds or {}
end

function V4a1_LibraryConfig:getSortingOrderByCO(co)
	local sortingOrder = co and co.sortingOrder or 0

	if sortingOrder == 0 then
		sortingOrder = self:getFallbackSortingOrder()
	end

	return sortingOrder
end

function V4a1_LibraryConfig:getScaleByCO(co)
	local scale = co and co.scale or nil

	if string.nilorempty(scale) then
		scale = self:getFallbackScale()
	end

	return tonumber(scale) or 1
end

function V4a1_LibraryConfig:getCollider2DSizeByCO(co)
	local xy = co and co.collider2DSize or nil

	if not xy or #xy == 0 then
		xy = self:getFallbackCollider2DSize()
	end

	return Vector2(xy[1] or 0, xy[2] or 0)
end

function V4a1_LibraryConfig:getCollider2DOffsetByCO(co)
	local xy = co and co.collider2DOffset or nil

	if not xy or #xy == 0 then
		xy = self:getFallbackCollider2DOffset()
	end

	return Vector2(xy[1] or 0, xy[2] or 0)
end

function V4a1_LibraryConfig:getChatPosByCO(co)
	local xy = co and co.chatPos or nil

	if not xy or #xy == 0 then
		xy = self:getFallbackChatPos()
	end

	xy[1] = xy[1] or 0
	xy[2] = xy[2] or 0

	return xy
end

function V4a1_LibraryConfig:getEmojiPosByCO(co)
	local xy = co and co.emojiPos or nil

	if not xy or #xy == 0 then
		xy = self:getFallbackEmojiPos()
	end

	xy[1] = xy[1] or 0
	xy[2] = xy[2] or 0

	return xy
end

function V4a1_LibraryConfig:getCharSpeedByCO(co)
	local speed = co and co.speed or nil

	if speed == nil or speed == 0 then
		speed = self:getCharFallbackSpeed()
	end

	return speed * self:getCharSpeedScale()
end

function V4a1_LibraryConfig:getCharWalkableAreaByCO(co)
	local xxzz = co and co.walkableArea or nil

	if not xxzz or #xxzz == 0 then
		xxzz = self:getFallbackWalkArea()
	end

	local minX, maxX = xxzz[1], xxzz[2]
	local minZ, maxZ = xxzz[3], xxzz[4]
	local width = maxX - minX
	local depth = maxZ - minZ
	local cx = (minX + maxX) * 0.5
	local cz = (minZ + maxZ) * 0.5

	return {
		minX = minX,
		maxX = maxX,
		width = width,
		cx = cx,
		minZ = minZ,
		maxZ = maxZ,
		depth = depth,
		cz = cz
	}
end

function V4a1_LibraryConfig:getCharIdleDurationRangeByCO(co)
	local rangeMinMax = co and co.idleDurationRange or nil

	if not rangeMinMax or #rangeMinMax == 0 then
		rangeMinMax = self:getFallbackIdleDurationRange()
	end

	local min = math.max(0, rangeMinMax[1])
	local max = math.max(rangeMinMax[2], min)

	return {
		min = min,
		max = max
	}
end

function V4a1_LibraryConfig:getChatCO(chatId)
	return lua_v4a1_library_chat.configDict[chatId]
end

function V4a1_LibraryConfig:getChatBubbleIds(chatId)
	local co = self:getChatCO(chatId)

	if not co then
		return {}
	end

	local list = {}

	local function _addId(bubbleId)
		if bubbleId and bubbleId > 0 then
			table.insert(list, bubbleId)
		end
	end

	_addId(co.bubble1)
	_addId(co.bubble2)
	_addId(co.bubble3)
	_addId(co.bubble4)
	_addId(co.bubble5)
	_addId(co.bubble6)

	return list
end

function V4a1_LibraryConfig:getChatDescCO(descId)
	return lua_v4a1_library_chat_desc.configDict[descId]
end

function V4a1_LibraryConfig:getChatEmojiCO(emojiId)
	return lua_v4a1_library_chat_emoji.configDict[emojiId]
end

V4a1_LibraryConfig.instance = V4a1_LibraryConfig.New()

return V4a1_LibraryConfig
