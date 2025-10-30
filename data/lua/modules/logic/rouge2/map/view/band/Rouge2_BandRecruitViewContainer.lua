﻿-- chunkname: @modules/logic/rouge2/map/view/band/Rouge2_BandRecruitViewContainer.lua

module("modules.logic.rouge2.map.view.band.Rouge2_BandRecruitViewContainer", package.seeall)

local Rouge2_BandRecruitViewContainer = class("Rouge2_BandRecruitViewContainer", BaseViewContainer)

function Rouge2_BandRecruitViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, Rouge2_BandRecruitView.New())

	return views
end

function Rouge2_BandRecruitViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navigationView:setOverrideClose(self.overrideCloaseCallback, self)

		return {
			navigationView
		}
	end
end

function Rouge2_BandRecruitViewContainer:overrideCloaseCallback()
	self._rpcCallbackId = Rouge2_Rpc.instance:sendRouge2EndBandRequest(self.closeThis, self)
end

function Rouge2_BandRecruitViewContainer:onContainerClose()
	if self._rpcCallbackId then
		Rouge2_Rpc.instance:removeCallbackById(self._rpcCallbackId)

		self._rpcCallbackId = nil
	end
end

return Rouge2_BandRecruitViewContainer
