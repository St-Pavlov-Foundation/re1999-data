-- chunkname: @modules/logic/bossrush/config/V4a1BossRushEnum.lua

module("modules.logic.bossrush.config.V4a1BossRushEnum", package.seeall)

local V4a1BossRushEnum = _M

V4a1BossRushEnum.SeasonParam = {
	{
		RankBtnPath = BossRushEnum.ResPath.v3a2_bossrush_rankbtn
	},
	{
		RankBtnPath = BossRushEnum.ResPath.v4a1_bossrush_rankbtn
	}
}
V4a1BossRushEnum.CurSeasonConst = 16
V4a1BossRushEnum.SeasonUnlockCountConst = 14
V4a1BossRushEnum.ReviewMessageBoxId = 410001

return V4a1BossRushEnum
