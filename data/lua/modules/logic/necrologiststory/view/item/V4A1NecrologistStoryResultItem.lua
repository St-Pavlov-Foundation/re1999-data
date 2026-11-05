-- chunkname: @modules/logic/necrologiststory/view/item/V4A1NecrologistStoryResultItem.lua

module("modules.logic.necrologiststory.view.item.V4A1NecrologistStoryResultItem", package.seeall)

local V4A1NecrologistStoryResultItem = class("V4A1NecrologistStoryResultItem", NecrologistStoryTextItem)

function V4A1NecrologistStoryResultItem.getResPath()
	return "ui/viewres/dungeon/rolestory/v4a1/v4a1_rolestoryresultitem.prefab"
end

return V4A1NecrologistStoryResultItem
