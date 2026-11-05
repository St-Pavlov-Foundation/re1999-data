-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorHallInteractiveUIMgr.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorHallInteractiveUIMgr", package.seeall)

local ArcadeSurvivorHallInteractiveUIMgr = class("ArcadeSurvivorHallInteractiveUIMgr", LuaCompBase)

function ArcadeSurvivorHallInteractiveUIMgr:ctor(param)
	self._scene = param.scene
	self._compName = param.compName

	local sceneGO = self._scene.viewGO

	self._gobuildingui = gohelper.findChild(sceneGO, "#go_buildingui")
	self._uiRoot = self:getUserDataTb_()

	local name = gohelper.findChild(sceneGO, "#go_buildingui/name")
	local talk = gohelper.findChild(sceneGO, "#go_buildingui/talk")

	self._uiRoot[ArcadeSurvivorHallEnum.ShowInfoUIType.UIName] = name
	self._uiRoot[ArcadeSurvivorHallEnum.ShowInfoUIType.UITalk] = talk
end

function ArcadeSurvivorHallInteractiveUIMgr:init(go)
	self.go = go
	self.trans = go.transform

	local resList = {}

	for _, res in pairs(ArcadeSurvivorHallEnum.ShowInfoUITypeRes) do
		table.insert(resList, res)
	end

	self._scene.loader:loadResList(resList, self._onLoadUIFinish, self)
end

function ArcadeSurvivorHallInteractiveUIMgr:_onLoadUIFinish()
	self._uiItems = {}
	self._interactiveMODict = ArcadeSurvivorHallModel.instance:getInteractiveMODict()

	for id, mo in pairs(self._interactiveMODict) do
		local infoUITypeList = mo:getShowInfoUITypeList()

		for _, type in ipairs(infoUITypeList) do
			local resPath = ArcadeSurvivorHallEnum.ShowInfoUITypeRes[type]
			local comp = ArcadeSurvivorHallEnum.ShowInfoUITypeComp[type]

			if not string.nilorempty(resPath) and comp then
				local res = self._scene.loader:getResource(resPath)
				local go = gohelper.clone(res, self._uiRoot[type], id)
				local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, comp)

				item:onUpdateMO(mo)

				local typeDict = GameUtil.tabletool_checkDictTable(self._uiItems, id)

				if typeDict then
					typeDict[type] = item
				end
			else
				logError(string.format("ArcadeSurvivorHallInteractiveUIMgr:_onLoadUIFinish error, no res or no comp, type:%s", type))
			end
		end
	end

	self:refreshUIAnchor()
end

function ArcadeSurvivorHallInteractiveUIMgr:refreshUIAnchor()
	for id, mo in pairs(self._interactiveMODict) do
		local infoUITypeList = mo:getShowInfoUITypeList()

		for _, type in ipairs(infoUITypeList) do
			local typeDict = self._uiItems[id]
			local item = typeDict and typeDict[type]

			if item then
				local x, y = mo:getCenterPos()
				local worldPos = self._scene:onTransformPoint(x, y)
				local rectPos = self:_worldPosToAnchorPos(worldPos)

				if rectPos then
					local offsetX, offsetY = ArcadeSurvivorConfig.instance:getHallUnitNameOffset(id)

					recthelper.setAnchor(item.viewGO.transform, rectPos.x + offsetX, rectPos.y + offsetY)
				end
			end
		end
	end
end

function ArcadeSurvivorHallInteractiveUIMgr:_worldPosToAnchorPos(worldPos)
	local camera = CameraMgr.instance:getMainCamera()

	if not worldPos then
		return
	end

	local rectPos = recthelper.worldPosToAnchorPos(worldPos, self._gobuildingui.transform, nil, camera)

	return rectPos
end

function ArcadeSurvivorHallInteractiveUIMgr:getUIItem(buildingId, type)
	return self._uiItems and self._uiItems[buildingId] and self._uiItems[buildingId][type]
end

function ArcadeSurvivorHallInteractiveUIMgr:clear()
	self._scene = nil
end

return ArcadeSurvivorHallInteractiveUIMgr
