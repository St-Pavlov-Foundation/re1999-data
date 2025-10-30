﻿-- chunkname: @modules/logic/activity/view/V2a3_Special_BaseView.lua

module("modules.logic.activity.view.V2a3_Special_BaseView", package.seeall)

local V2a3_Special_BaseView = class("V2a3_Special_BaseView", Activity101SignViewBase)

function V2a3_Special_BaseView:ctor(...)
	V2a3_Special_BaseView.super.ctor(self, ...)
end

function V2a3_Special_BaseView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
end

function V2a3_Special_BaseView:internal_onOpen()
	local M = self:openMode()
	local E = Activity101SignViewBase.eOpenMode

	if M == E.ActivityBeginnerView then
		local actId = self.viewParam.actId
		local parentGO = self.viewParam.parent

		self:internal_set_actId(actId)
		gohelper.addChild(parentGO, self.viewGO)
		self:_internal_onOpen()
		self:_refresh()
	elseif M == E.PaiLian then
		self:_internal_onOpen()
		self:_refresh()
	else
		assert(false)
	end
end

function V2a3_Special_BaseView:addEvents()
	V2a3_Special_BaseView.super.addEvents(self)
end

function V2a3_Special_BaseView:removeEvents()
	V2a3_Special_BaseView.super.removeEvents(self)
end

function V2a3_Special_BaseView:addReward(index, go, clsDefine)
	local item = clsDefine.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)
	table.insert(self.__itemList, item)

	return item
end

function V2a3_Special_BaseView:_createList()
	if self.__itemList then
		return
	end

	self.__itemList = {}

	local dataList = self:getDataList()

	for i, mo in ipairs(dataList) do
		local go = self:onFindChind_RewardGo(i)
		local item = self:addReward(i, go, V2a3_Special_SignItem)

		item:onUpdateMO(mo)
	end
end

function V2a3_Special_BaseView:_refreshList(isUseCache)
	local dataList

	if isUseCache then
		dataList = self:getTempDataList()
	else
		dataList = self:getDataList()
	end

	self:onRefreshList(dataList)
end

function V2a3_Special_BaseView:onRefreshList(dataList)
	if not dataList then
		return
	end

	local itemList = self.__itemList

	for i, mo in ipairs(dataList) do
		local item = itemList[i]

		if item then
			item:onUpdateMO(mo)
			item:setActive(true)
		end
	end

	for i = #dataList + 1, #itemList do
		local item = itemList[i]

		item:setActive(false)
	end
end

function V2a3_Special_BaseView:onUpdateParam()
	self:_refresh()
end

function V2a3_Special_BaseView:onFindChind_RewardGo(i)
	assert(false, "please override this function")
end

function V2a3_Special_BaseView:onStart()
	self:_createList()
end

return V2a3_Special_BaseView
