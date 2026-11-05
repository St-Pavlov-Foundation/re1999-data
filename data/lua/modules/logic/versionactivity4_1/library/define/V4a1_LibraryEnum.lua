-- chunkname: @modules/logic/versionactivity4_1/library/define/V4a1_LibraryEnum.lua

module("modules.logic.versionactivity4_1.library.define.V4a1_LibraryEnum", package.seeall)

local V4a1_LibraryEnum = _M

V4a1_LibraryEnum.ResPath = {
	v4a1_m_s22_dytsg_icon = "scenes/v4a1_m_s22_dytsg/prefab/v4a1_m_s22_dytsg_icon.prefab",
	v4a1_library_bubble_desc = "ui/viewres/versionactivity_4_1/v4a1_library/v4a1_library_bubble_desc.prefab"
}
V4a1_LibraryEnum.Entry = {
	GoldenMilletPresent = 4,
	Investigation_GuessView = 1,
	GuessGame = 2,
	LinkGift = 5,
	__End = 6,
	DeepDive = 3
}
V4a1_LibraryEnum.State = {
	Idle = "Idle",
	Walk = "Walk"
}
V4a1_LibraryEnum.Event = {
	WalkFinish = "WalkFinish",
	BeginWalk = "BeginWalk"
}
V4a1_LibraryEnum.SpineAnim = {
	Idle = SpineAnimState.idle1,
	Walk = SpineAnimState.run
}
V4a1_LibraryEnum.SceneGoName = {
	CharsRoot = "V4a1_LibraryCharRoot"
}

return V4a1_LibraryEnum
