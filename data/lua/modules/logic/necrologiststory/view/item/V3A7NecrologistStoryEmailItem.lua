-- chunkname: @modules/logic/necrologiststory/view/item/V3A7NecrologistStoryEmailItem.lua

module("modules.logic.necrologiststory.view.item.V3A7NecrologistStoryEmailItem", package.seeall)

local V3A7NecrologistStoryEmailItem = class("V3A7NecrologistStoryEmailItem", NecrologistStoryControlItem)

function V3A7NecrologistStoryEmailItem:onInit()
	self._btnOpen = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_open")
	self._click = gohelper.getClick(self.viewGO)
end

function V3A7NecrologistStoryEmailItem:addEventListeners()
	self._btnOpen:AddClickListener(self._clickOpen, self)
	self._click:AddClickListener(self._clickOpen, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function V3A7NecrologistStoryEmailItem:removeEventListeners()
	self._btnOpen:RemoveClickListener()
	self._click:RemoveClickListener()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function V3A7NecrologistStoryEmailItem:_clickOpen()
	local storyConfig = self:getStoryConfig()

	ViewMgr.instance:openView(ViewName.V3A7_RoleStoryEmailView, {
		tagId = storyConfig.param
	})
end

function V3A7NecrologistStoryEmailItem:onCloseView(viewName)
	if viewName == ViewName.NecrologistStoryTipView then
		self._isFinish = true

		self:onPlayFinish(true)
	end
end

function V3A7NecrologistStoryEmailItem:onPlayStory()
	return
end

function V3A7NecrologistStoryEmailItem:isDone()
	return self._isFinish
end

function V3A7NecrologistStoryEmailItem:caleHeight()
	return 400
end

function V3A7NecrologistStoryEmailItem:onDestroy()
	return
end

function V3A7NecrologistStoryEmailItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/v3a7_rolestoryinteractitem.prefab"
end

return V3A7NecrologistStoryEmailItem
