-- chunkname: @modules/logic/versionactivity4_0/deleike/define/DeleikeEnum.lua

module("modules.logic.versionactivity4_0.deleike.define.DeleikeEnum", package.seeall)

local DeleikeEnum = _M

DeleikeEnum.GridUnit = 90
DeleikeEnum.GridColumn = 12
DeleikeEnum.GridRow = 10
DeleikeEnum.PlayerSpeed = 300
DeleikeEnum.PlayerSlowSpeed = DeleikeEnum.PlayerSpeed * 0.25
DeleikeEnum.CubeSize = Vector2.New(92, 116)
DeleikeEnum.NormalTileArtOffsetY = -13
DeleikeEnum.TileType = {
	Line = 3,
	Grid = 5,
	Outer = 1,
	Anchor = 2,
	Bg = 4,
	Normal = 0
}
DeleikeEnum.TileTypeToName = {}

for k, v in pairs(DeleikeEnum.TileType) do
	DeleikeEnum.TileTypeToName[v] = k
end

DeleikeEnum.LineLength = 2048
DeleikeEnum.LineThick = 160
DeleikeEnum.BgWidth = 2592
DeleikeEnum.BgHeight = 1080
DeleikeEnum.GridTileWidth = 1756
DeleikeEnum.GridTileHeight = 1080
DeleikeEnum.CircleShowTime = 2
DeleikeEnum.TriggerType = {
	Skill2 = "技能点2",
	Door = "通关点",
	Skill1 = "技能点"
}
DeleikeEnum.SkillWidth = 5000
DeleikeEnum.Skill1ChargeRate = 240
DeleikeEnum.Skill1MaxLength = DeleikeEnum.LineThick
DeleikeEnum.Skill2ChargePhase1Time = 0.9
DeleikeEnum.Skill2ChargePhase1Max = 2000
DeleikeEnum.Skill2ChargePhase2Time = 1
DeleikeEnum.Skill2WidthMax = 5000
DeleikeEnum.Skill2MaxShift = 225
DeleikeEnum.PlayerRadius = 43
DeleikeEnum.JoyStickInnerRadius = 20
DeleikeEnum.JoyStickOuterRadius = 120
DeleikeEnum.JoyStickSmoothSpeed = 7.5
DeleikeEnum.LineStatus = {
	CanCut = 2,
	UnCut = 3,
	PreCut = 1
}

return DeleikeEnum
