-- chunkname: @modules/logic/versionactivity4_1/library/model/V4a1_LibrarySceneModel.lua

module("modules.logic.versionactivity4_1.library.model.V4a1_LibrarySceneModel", package.seeall)

local V4a1_LibrarySceneModel = class("V4a1_LibrarySceneModel", V4a1_LibraryBaseModel)

function V4a1_LibrarySceneModel:ctor(...)
	V4a1_LibrarySceneModel.super.ctor(self, ...)
end

function V4a1_LibrarySceneModel:onInit()
	V4a1_LibrarySceneModel.super.onInit(self)
	self:reInit()
end

function V4a1_LibrarySceneModel:reInit()
	V4a1_LibrarySceneModel.super.reInit(self)
	self:clear()
end

function V4a1_LibrarySceneModel:clear()
	self._curDay = nil
	self._showCharIds = nil
end

function V4a1_LibrarySceneModel:getCurrentDay()
	local actMO = self:getActMO()
	local startTime = actMO and actMO:getRealStartTimeStamp()

	if not startTime or startTime <= 0 then
		return 1
	end

	local day = math.floor((ServerTime.now() - startTime) / TimeUtil.OneDaySecond) + 1

	return math.max(day, 1)
end

function V4a1_LibrarySceneModel:getShowCharIds()
	local lua_v4a1_library_showCOList = self:configInst():lua_v4a1_library_showCOList()

	if #lua_v4a1_library_showCOList <= 0 then
		return {}
	end

	local day = self:getCurrentDay()
	local showIndex = (day - 1) % #lua_v4a1_library_showCOList + 1
	local lua_v4a1_library_showCO = lua_v4a1_library_showCOList[showIndex]

	return self:configInst():getCharIdsByCO(lua_v4a1_library_showCO)
end

function V4a1_LibrarySceneModel:refreshDailyShow()
	self._curDay = self:getCurrentDay()
	self._showCharIds = self:getShowCharIds()

	return self._showCharIds
end

function V4a1_LibrarySceneModel:bInScene()
	return GameSceneMgr.instance:getCurSceneType() == self:configInst():sceneType()
end

function V4a1_LibrarySceneModel:getSceneObj()
	local scene = GameSceneMgr.instance:getCurScene()

	if scene and GameSceneMgr.instance:getCurSceneType() == self:configInst():sceneType() then
		return scene
	end
end

function V4a1_LibrarySceneModel:enterScene()
	self:clear()

	local configInst = self:configInst()

	if not self:bInScene() then
		GameSceneMgr.instance:startScene(configInst:sceneType(), configInst:getSceneId(), configInst:getSceneLevelId())
	else
		logError("重复加载 V4a1_Library 场景")
	end
end

V4a1_LibrarySceneModel.instance = V4a1_LibrarySceneModel.New()

return V4a1_LibrarySceneModel
