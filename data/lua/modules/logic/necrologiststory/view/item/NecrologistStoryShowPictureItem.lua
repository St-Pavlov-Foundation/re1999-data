-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryShowPictureItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryShowPictureItem", package.seeall)

local NecrologistStoryShowPictureItem = class("NecrologistStoryShowPictureItem", NecrologistStoryControlItem)

function NecrologistStoryShowPictureItem:onInit()
	self.simage = gohelper.findChildSingleImage(self.viewGO, "root/simage")
end

function NecrologistStoryShowPictureItem:onPlayStory()
	self._isFinish = false

	local picRes = tostring(self._controlParam)

	self.simage:LoadImage(ResUrl.getNecrologistStoryPicBg(picRes), self.onSimageLoaded, self)
end

function NecrologistStoryShowPictureItem:onSimageLoaded()
	ZProj.UGUIHelper.SetImageSize(self.simage.gameObject)

	self.height = recthelper.getHeight(self.simage.transform)
	self._isFinish = true

	self:onPlayFinish()
end

function NecrologistStoryShowPictureItem:isDone()
	return self._isFinish
end

function NecrologistStoryShowPictureItem:caleHeight()
	return self.height or 400
end

function NecrologistStoryShowPictureItem:onDestroy()
	self.simage:UnLoadImage()
end

function NecrologistStoryShowPictureItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststorypictureitem.prefab"
end

return NecrologistStoryShowPictureItem
