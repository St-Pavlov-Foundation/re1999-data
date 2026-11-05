-- chunkname: @modules/logic/versionactivity4_1/dungeon/view/map/VersionActivity4_1DungeonMapInteractView.lua

module("modules.logic.versionactivity4_1.dungeon.view.map.VersionActivity4_1DungeonMapInteractView", package.seeall)

local VersionActivity4_1DungeonMapInteractView = class("VersionActivity4_1DungeonMapInteractView", VersionActivityFixedDungeonMapInteractView1)

function VersionActivity4_1DungeonMapInteractView:_onClickElement(mapElement)
	local config = mapElement._config
	local elementId = config.id

	if config.type == DungeonEnum.ElementType.V4a1Special then
		DungeonMapModel.instance:addFinishedElement(elementId)
		DungeonMapModel.instance:removeElement(elementId)
		DungeonRpc.instance:sendMapElementRequest(elementId, nil, self._onHideInteractUI, self)

		return
	end

	VersionActivity4_1DungeonMapInteractView.super._onClickElement(self, mapElement)
end

function VersionActivity4_1DungeonMapInteractView:_onHideInteractUI()
	VersionActivityFixedDungeonModel.instance:setShowInteractView(nil)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnHideInteractUI)
end

return VersionActivity4_1DungeonMapInteractView
