-- chunkname: @modules/logic/versionactivity3_8/echosong/define/V3a8EchoSongEnum.lua

module("modules.logic.versionactivity3_8.echosong.define.V3a8EchoSongEnum", package.seeall)

local V3a8EchoSongEnum = _M

V3a8EchoSongEnum.ScenePath = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/scene/%s.prefab"
V3a8EchoSongEnum.ColliderLayer = LayerMask.GetMask("Default")
V3a8EchoSongEnum.DragLength = 240
V3a8EchoSongEnum.MainPlayerId = -1
V3a8EchoSongEnum.LongPressTime = 0.5
V3a8EchoSongEnum.LongClickTime = 0.5
V3a8EchoSongEnum.BallConst = {
	ReflectEpsilon = 0.01,
	MaxReflectCount = 8,
	TrailChaseStartRatio = 0.2,
	TrailChaseEndRatio = 1,
	Speed = 4,
	Num = 20,
	TrailChaseMaxRatio = 0.8
}
V3a8EchoSongEnum.BallRandom = {
	Angle = 0,
	Num = 0,
	Speed = 0,
	LifeTime = 0
}
V3a8EchoSongEnum.ParticleLifeTime = {
	Explore = 1.5,
	Short = 0.4,
	Enemy2 = 0.6,
	Long = 1.5,
	StandLong = 2.5,
	HitTime = 1
}
V3a8EchoSongEnum.UnitType = {
	SpawnPoint = 101,
	Event3 = 107,
	Enemy1 = 201,
	Tip = 301,
	Wall = 103,
	Trap = 104,
	MainPlayer = 100,
	Enemy2WayPoint = 203,
	SavePoint = 302,
	EndPoint = 102,
	Story = 303,
	Event2 = 106,
	Event1 = 105,
	Enemy2 = 202
}
V3a8EchoSongEnum.ParticleType = {
	MainPlayer = 1,
	Explore = 5,
	Enemy2 = 6,
	Event2 = 4,
	Tip = 3,
	MainPlayerShort = 2
}
V3a8EchoSongEnum.TrapTriggerType = {
	Auto = 1,
	Close = 3,
	Open = 2
}
V3a8EchoSongEnum.SaveType = {
	Progress = 1
}
V3a8EchoSongEnum.BgType = {
	Purple = 2,
	Green = 1
}
V3a8EchoSongEnum.MainPlayerConst = {
	MoveSpeed = 1,
	MaxFootprint = 2,
	StrengthThreshold = 0.95,
	CircleCastRadius = 0.1,
	CircleCastDist = 0.1,
	StandFootprintIndex = 3,
	StandFootprintInterval = 1,
	EmitInterval = 0.8,
	FootprintLifeTime = 2
}
V3a8EchoSongEnum.EnemyConst = {
	Enemy1WaitTime = 0.5,
	Enemy1Speed = 110,
	Enemy2Speed = 150,
	Enemy2HurtDistance = 100,
	Enemy1HurtDistance = 110
}
V3a8EchoSongEnum.ExploreConst = {
	RaycastDist = 0.5,
	MoveSpeed = 8
}
V3a8EchoSongEnum.TouchEmittedType = {
	Long = 2,
	Short = 1
}
V3a8EchoSongEnum.ScaleRange = {
	Max = 1,
	Min = 0.5
}
V3a8EchoSongEnum.SceneScale = 1

return V3a8EchoSongEnum
