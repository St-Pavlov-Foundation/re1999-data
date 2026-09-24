-- chunkname: @modules/logic/matchgame/defines/MatchGameEnum.lua

module("modules.logic.matchgame.defines.MatchGameEnum", package.seeall)

local MatchGameEnum = _M

MatchGameEnum.MapStatus = {
	Lock = 1,
	Unlock = 2
}
MatchGameEnum.LevelType = {
	Challenge = 2,
	Normal = 1
}
MatchGameEnum.EpisodeStatus = {
	Finish = 3,
	Lock = 1,
	Unlock = 2
}
MatchGameEnum.EpisodeTargetType = {
	KillAttr = 3,
	KillAll = 1,
	Round = 2
}
MatchGameEnum.RewardType = {
	Challenge = 2,
	Normal = 1
}
MatchGameEnum.RewardItemStatus = {
	Gained = 2,
	CanGet = 1,
	Normal = 0
}
MatchGameEnum.TalentNodeStatus = {
	Lock = 1,
	Active = 3,
	Unlock = 2
}
MatchGameEnum.CharacterTabType = {
	Develop = 1,
	Talent = 2
}
MatchGameEnum.CharacterAttrType = {
	Heal = 4,
	Def = 2,
	Hp = 3,
	Atk = 1
}
MatchGameEnum.CharacterStatus = {
	Lock = 1,
	Active = 3,
	Unlock = 2
}
MatchGameEnum.TalentNodeSpaceWidth = 217
MatchGameEnum.TalentNodeStartSpace = 133
MatchGameEnum.TalentNodePosY_Odd = 153
MatchGameEnum.TalentNodePosY_Even = -88
MatchGameEnum.ItemEnoughColor = "#53482F"
MatchGameEnum.ItemNotEnoughColor = "#C7390F"
MatchGameEnum.CurrencyPrefabPath = "modules/matchgame/ui/viewres/matchgame/matchgamecurrencyview.prefab"
MatchGameEnum.CostItemPrefabPath = "modules/matchgame/ui/viewres/matchgame/matchgame_costitem.prefab"
MatchGameEnum.MapRewardItemPrefabPath = "modules/matchgame/ui/viewres/matchgame/matchgame_rewarditem.prefab"
MatchGameEnum.NormalEpisodeItemPrefabPath = "modules/matchgame/ui/viewres/matchgame/matchgame_map_floor_"
MatchGameEnum.CommonHeroCardItemPrefabPath = "modules/matchgame/ui/viewres/matchgame/matchgameherogroupitem.prefab"
MatchGameEnum.ConstId = {
	TeamNum = 3,
	NormalRewardSkinId = 13,
	EpisodeStarNum = 9,
	TalentCurrency = 8,
	Currency = 7
}
MatchGameEnum.UnlockType = {
	StarNum = "star",
	PassEpisode = "episode"
}
MatchGameEnum.ItemIconType = {
	Large = 2,
	Small = 1
}
MatchGameEnum.HeroGroupMaxHeroCount = 4
MatchGameEnum.DelaySwitchTime = 0.5

return MatchGameEnum
