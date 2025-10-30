﻿-- chunkname: @modules/logic/rouge/map/controller/RougeMapDLCResHelper.lua

module("modules.logic.rouge.map.controller.RougeMapDLCResHelper", package.seeall)

local RougeMapDLCResHelper = class("RougeMapDLCResHelper")

function RougeMapDLCResHelper.handleLoadMapDLCRes(version, ...)
	local handle = RougeMapDLCResHelper._getMapDLCResHandle(version)

	if not handle then
		return
	end

	handle(...)
end

function RougeMapDLCResHelper._getMapDLCResHandle(version)
	RougeMapDLCResHelper._initHandleLoadMapDLCRes()

	local handle = RougeMapDLCResHelper._mapDLCResLoadHandleMap[version]

	return handle
end

function RougeMapDLCResHelper._loadMapDLCResHandle_101(loader, map)
	map.fogPrefab = loader:getAssetItem(RougeMapEnum.FogMaterialUrl):GetResource()
end

function RougeMapDLCResHelper._initHandleLoadMapDLCRes()
	if not RougeMapDLCResHelper._mapDLCResLoadHandleMap then
		RougeMapDLCResHelper._mapDLCResLoadHandleMap = {
			[RougeDLCEnum.DLCEnum.DLC_101] = RougeMapDLCResHelper._loadMapDLCResHandle_101
		}
	end
end

function RougeMapDLCResHelper.handleCreateMapDLC(version, ...)
	local handle = RougeMapDLCResHelper._getCreateMapDLCHandle(version)

	if not handle then
		return
	end

	handle(...)
end

function RougeMapDLCResHelper._getCreateMapDLCHandle(version)
	RougeMapDLCResHelper._initHandleCreateMapDLC()

	local handle = RougeMapDLCResHelper._mapDLCHandleMap[version]

	return handle
end

function RougeMapDLCResHelper._createMapDLCHandle_101(map)
	local goBackGround = gohelper.findChild(map.mapGo, "root/BackGround")
	local fogInst = gohelper.clone(map.fogPrefab, goBackGround, "fog")

	MonoHelper.addNoUpdateLuaComOnceToGo(fogInst, RougeMapFogEffect)
end

function RougeMapDLCResHelper._initHandleCreateMapDLC()
	if not RougeMapDLCResHelper._mapDLCHandleMap then
		RougeMapDLCResHelper._mapDLCHandleMap = {
			[RougeDLCEnum.DLCEnum.DLC_101] = RougeMapDLCResHelper._createMapDLCHandle_101
		}
	end
end

function RougeMapDLCResHelper.addMapDLCRes(mapType, versions, loader)
	RougeMapDLCResHelper._initMapDLCResUrl()

	local mapResSet = RougeMapHelper._mapDLCResUrlMap[mapType]
	local resMap = {}

	for _, version in ipairs(versions or {}) do
		local versionResList = mapResSet and mapResSet[version]

		for _, resUrl in ipairs(versionResList or {}) do
			if not resMap[resUrl] then
				loader:addPath(resUrl)

				resMap[resUrl] = true
			end
		end
	end
end

function RougeMapDLCResHelper._initMapDLCResUrl()
	if not RougeMapHelper._mapDLCResUrlMap then
		RougeMapHelper._mapDLCResUrlMap = {
			[RougeMapEnum.MapType.Normal] = {
				[RougeDLCEnum.DLCEnum.DLC_101] = {
					RougeMapEnum.FogMaterialUrl
				}
			}
		}
	end
end

return RougeMapDLCResHelper
