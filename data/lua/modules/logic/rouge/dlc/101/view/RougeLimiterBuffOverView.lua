﻿-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterBuffOverView.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffOverView", package.seeall)

local RougeLimiterBuffOverView = class("RougeLimiterBuffOverView", BaseView)

function RougeLimiterBuffOverView:onInitView()
	self._scrollviews = gohelper.findChildScrollRect(self.viewGO, "#scroll_views")
	self._gobuffitem = gohelper.findChild(self.viewGO, "#scroll_views/Viewport/Content/#go_buffitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeLimiterBuffOverView:addEvents()
	return
end

function RougeLimiterBuffOverView:removeEvents()
	return
end

function RougeLimiterBuffOverView:_editableInitView()
	self._gobuffcontainer = gohelper.findChild(self.viewGO, "#scroll_views/Viewport/Content")
end

function RougeLimiterBuffOverView:onUpdateParam()
	return
end

function RougeLimiterBuffOverView:onOpen()
	self:initBuffList()
end

function RougeLimiterBuffOverView:initBuffList()
	local buffIds = self.viewParam and self.viewParam.buffIds or {}

	table.sort(buffIds, self._buffMoSortFunc)
	gohelper.CreateObjList(self, self._refreshBuffItem, buffIds, self._gobuffcontainer, self._gobuffitem)
end

function RougeLimiterBuffOverView._buffMoSortFunc(aBuffId, bBuffId)
	local aBuffCo = RougeDLCConfig101.instance:getLimiterBuffCo(aBuffId)
	local bBuffCo = RougeDLCConfig101.instance:getLimiterBuffCo(bBuffId)
	local aBuffType = aBuffCo and aBuffCo.buffType or 0
	local bBuffType = bBuffCo and bBuffCo.buffType or 0

	if aBuffType ~= bBuffType then
		return aBuffType < bBuffType
	end

	return aBuffId < bBuffId
end

function RougeLimiterBuffOverView:_refreshBuffItem(obj, buffId, index)
	local buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)
	local imagebufficon = gohelper.findChildImage(obj, "#image_bufficon")
	local txtdec = gohelper.findChildText(obj, "#txt_dec")
	local txtname = gohelper.findChildText(obj, "#txt_name")

	txtdec.text = buffCo and buffCo.desc
	txtname.text = buffCo and buffCo.title

	UISpriteSetMgr.instance:setRouge4Sprite(imagebufficon, buffCo.icon)
end

function RougeLimiterBuffOverView:onClose()
	return
end

function RougeLimiterBuffOverView:onDestroyView()
	return
end

return RougeLimiterBuffOverView
