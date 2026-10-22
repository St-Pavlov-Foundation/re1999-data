-- chunkname: @modules/logic/tips/view/HeroRecoveryWindowViewContainer.lua

module("modules.logic.tips.view.HeroRecoveryWindowViewContainer", package.seeall)

local HeroRecoveryWindowViewContainer = class("HeroRecoveryWindowViewContainer", BaseViewContainer)

function HeroRecoveryWindowViewContainer:buildViews()
	local views = {}

	table.insert(views, HeroRecoveryWindowView.New())

	return views
end

return HeroRecoveryWindowViewContainer
