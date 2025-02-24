module("modules.logic.versionactivity2_6.common.ActivityLiveMgr2_6", package.seeall)

slot0 = class("ActivityLiveMgr2_6")

function slot0.init(slot0)
end

function slot0.getActId2ViewList(slot0)
	return {
		[VersionActivity2_6Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_6EnterView
		},
		[VersionActivity2_6Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_6StoreView
		},
		[VersionActivity2_6Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_6TaskView
		},
		[VersionActivity2_6Enum.ActivityId.Season] = {
			ViewName.Season166MainView,
			ViewName.Season166TeachView,
			ViewName.Season166HeroGroupFightView
		}
	}
end

slot0.instance = slot0.New()

return slot0
