-- chunkname: @modules/logic/versionactivity4_1/common/ActivityLiveMgr4_1.lua

module("modules.logic.versionactivity4_1.common.ActivityLiveMgr4_1", package.seeall)

local ActivityLiveMgr4_1 = class("ActivityLiveMgr4_1")

function ActivityLiveMgr4_1:init()
	return
end

function ActivityLiveMgr4_1:getActId2ViewList()
	return {
		[VersionActivity4_1Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity4_1EnterView
		},
		[VersionActivity4_1Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity4_1StoreView
		},
		[VersionActivity4_1Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity4_1TaskView,
			ViewName.VersionActivity4_1DungeonMapView
		},
		[VersionActivity4_1Enum.ActivityId.Evelyn] = {
			ViewName.EvelynLevelView,
			ViewName.EvelynTaskView
		},
		[VersionActivity4_1Enum.ActivityId.PeiShiTa] = {
			ViewName.PeiShiTaLevelView,
			ViewName.PeiShiTaTaskView
		},
		[VersionActivity4_1Enum.ActivityId.ArcadeSurvivor] = {
			ViewName.ArcadeSurvivorHallView,
			ViewName.ArcadeSurvivorGameView,
			ViewName.ArcadeSurvivorGameResultView
		},
		[VersionActivity4_1Enum.ActivityId.Act248] = {
			ViewName.Act248EnterView,
			ViewName.Act248FileView,
			ViewName.Act248ClueMainView,
			ViewName.Act248ReportView,
			ViewName.Act248DecryptionMainView
		}
	}
end

ActivityLiveMgr4_1.instance = ActivityLiveMgr4_1.New()

return ActivityLiveMgr4_1
