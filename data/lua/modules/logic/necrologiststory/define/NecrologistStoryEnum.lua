﻿-- chunkname: @modules/logic/necrologiststory/define/NecrologistStoryEnum.lua

module("modules.logic.necrologiststory.define.NecrologistStoryEnum", package.seeall)

local NecrologistStoryEnum = _M

NecrologistStoryEnum.RoleStoryId = {
	V3A1 = 26,
	V3A2 = 27
}
NecrologistStoryEnum.RoleStoryId2MOCls = {
	[NecrologistStoryEnum.RoleStoryId.V3A1] = "NecrologistV3A1MO",
	[NecrologistStoryEnum.RoleStoryId.V3A2] = "NecrologistV3A2MO"
}
NecrologistStoryEnum.StoryId2GameView = {
	[NecrologistStoryEnum.RoleStoryId.V3A1] = ViewName.V3A1_RoleStoryGameView,
	[NecrologistStoryEnum.RoleStoryId.V3A2] = ViewName.V3A2_RoleStoryGameView
}
NecrologistStoryEnum.TaskParam = {
	V3A2ItemUnlockCount = 2701
}
NecrologistStoryEnum.Pivot = {
	Left = Vector2(0, 1),
	Right = Vector2(1, 1),
	Down = Vector2(1, 0)
}
NecrologistStoryEnum.DefaultInterval = 50
NecrologistStoryEnum.BottomMargin = 50
NecrologistStoryEnum.StoryState = {
	Finish = 4,
	Reading = 2,
	Lock = 1,
	Normal = 3
}
NecrologistStoryEnum.StoryControlType = {
	StoryPic = 1,
	DragPic = 7,
	Audio = 3,
	Effect = 4,
	Magic = 5,
	ClickPic = 9,
	Bgm = 2,
	StopAudio = 8,
	SlidePic = 10,
	ErasePic = 6
}
NecrologistStoryEnum.GameState = {
	Win = 3,
	Fail = 2,
	Normal = 1
}
NecrologistStoryEnum.BaseType = {
	InteractiveBase = 3,
	SmallBase = 2,
	BigBase = 1
}
NecrologistStoryEnum.WeatherType = {
	Cloudy = 3,
	Light = 7,
	Snowy = 5,
	Flow = 6,
	Fog = 2,
	Rainy = 4,
	Sunny = 1
}
NecrologistStoryEnum.WeatherType2Name = {
	[NecrologistStoryEnum.WeatherType.Sunny] = "sun",
	[NecrologistStoryEnum.WeatherType.Fog] = "fog",
	[NecrologistStoryEnum.WeatherType.Cloudy] = "cloudy",
	[NecrologistStoryEnum.WeatherType.Rainy] = "rain",
	[NecrologistStoryEnum.WeatherType.Snowy] = "snow",
	[NecrologistStoryEnum.WeatherType.Flow] = "flow",
	[NecrologistStoryEnum.WeatherType.Light] = "light"
}
NecrologistStoryEnum.NeedDelayType = {
	options = 4,
	aside = 2,
	location = 3,
	dialog = 1
}
NecrologistStoryEnum.NeedDelayControlType = {
	[NecrologistStoryEnum.StoryControlType.Magic] = 1,
	[NecrologistStoryEnum.StoryControlType.ErasePic] = 2,
	[NecrologistStoryEnum.StoryControlType.DragPic] = 3
}
NecrologistStoryEnum.DirType = {
	Top = 3,
	Left = 1,
	Right = 2,
	Bottom = 4
}
NecrologistStoryEnum.MagicEffectType = {
	Distort = 1,
	SweepLight = 2
}
NecrologistStoryEnum.V3A2BaseState = {
	Finish = 3,
	Hide = 4,
	Lock = 1,
	Normal = 2
}

return NecrologistStoryEnum
