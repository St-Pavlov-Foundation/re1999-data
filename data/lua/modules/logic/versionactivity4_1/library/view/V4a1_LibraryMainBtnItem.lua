-- chunkname: @modules/logic/versionactivity4_1/library/view/V4a1_LibraryMainBtnItem.lua

module("modules.logic.versionactivity4_1.library.view.V4a1_LibraryMainBtnItem", package.seeall)

local V4a1_LibraryMainBtnItem = class("V4a1_LibraryMainBtnItem", ActCenterItemBase)

function V4a1_LibraryMainBtnItem:init(go)
	V4a1_LibraryMainBtnItem.super.init(self, gohelper.cloneInPlace(go))
end

function V4a1_LibraryMainBtnItem:onInit(go)
	local rGo = gohelper.findChild(self.go, "go_activityreddot")

	self._redDot = RedDotController.instance:addRedDot(rGo, RedDotEnum.DotNode.V4a1LibarayMainViewEntry)
end

function V4a1_LibraryMainBtnItem:onDestroyView()
	V4a1_LibraryMainBtnItem.super.onDestroyView(self)
end

function V4a1_LibraryMainBtnItem:onClick()
	V4a1_LibraryController.instance:enterScene()
end

function V4a1_LibraryMainBtnItem:isShowRedDot()
	return self._redDot.show
end

function V4a1_LibraryMainBtnItem:_actId()
	local data = self:getCustomData()

	return data.actId
end

function V4a1_LibraryMainBtnItem:_gm_ActIds()
	return {
		self:_actId()
	}
end

function V4a1_LibraryMainBtnItem:_isOpen()
	return ActivityType101Model.instance:isOpen(self:_actId())
end

function V4a1_LibraryMainBtnItem:onRefresh()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_12")

	self:_setMainSprite(spriteName, true)
	self:setFestival(isShow)
	self._redDot:refreshDot()
end

return V4a1_LibraryMainBtnItem
