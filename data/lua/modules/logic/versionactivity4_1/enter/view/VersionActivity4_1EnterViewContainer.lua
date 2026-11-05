-- chunkname: @modules/logic/versionactivity4_1/enter/view/VersionActivity4_1EnterViewContainer.lua

module("modules.logic.versionactivity4_1.enter.view.VersionActivity4_1EnterViewContainer", package.seeall)

local VersionActivity4_1EnterViewContainer = class("VersionActivity4_1EnterViewContainer", VersionActivityFixedEnterViewContainer)

function VersionActivity4_1EnterViewContainer:getViews()
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity4_1EnterBgmView.New()
	}
end

function VersionActivity4_1EnterViewContainer:getMultiViews()
	local dungeonEnterView = VersionActivityFixedHelper.getVersionActivityDungeonEnterView(4, 1)

	return {
		dungeonEnterView.New(),
		V4a1_BossRush_EnterView.New(),
		VersionActivity4_1ArcadeSurvivorEnterView.New(),
		VersionActivity4_1EvelynEnterView.New(),
		VersionActivity4_1PeiShiTaEnterView.New(),
		V3a5_Season123EnterView.New(),
		RoleStoryEnterView.New()
	}
end

return VersionActivity4_1EnterViewContainer
