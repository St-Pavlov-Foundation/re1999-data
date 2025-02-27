module("modules.logic.versionactivity2_6.dicehero.defines.DiceHeroStatEnum", package.seeall)

slot0 = pureTable("DiceHeroStatEnum")

function slot0.initEnum(slot0)
	slot0.EventName.DiceHero_FightEnd = "dicehero_fight_end"
	slot0.EventName.DiceHero_StoryEnd = "dicehero_story_end"
	slot0.EventName.DiceHero_Reset = "dicehero_endless_reset"
	slot0.EventProperties.DiceHero_ActId = "activity_id"
	slot0.EventProperties.DiceHero_EpisodeId = "episodeid"
	slot0.EventProperties.DiceHero_OperTpye = "operation_type"
	slot0.EventProperties.DiceHero_UseTime = "usetime"
	slot0.EventProperties.DiceHero_RoundNum = "round_num"
	slot0.EventProperties.DiceHero_Result = "result"
	slot0.EventProperties.DiceHero_IsFirst = "isfirst"
	slot0.EventProperties.DiceHero_FightObj = "dicehero_fight_obj"
	slot0.EventProperties.DiceHero_SkillInfo = "dicehero_skill_info"
	slot0.EventProperties.DiceHero_TalkId = "guideid"
	slot0.EventProperties.DiceHero_StepId = "stepid"
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_ActId] = slot0.Type.String
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_EpisodeId] = slot0.Type.String
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_OperTpye] = slot0.Type.String
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_UseTime] = slot0.Type.Number
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_RoundNum] = slot0.Type.Number
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_Result] = slot0.Type.String
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_IsFirst] = slot0.Type.Boolean
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_FightObj] = slot0.Type.List
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_SkillInfo] = slot0.Type.Array
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_TalkId] = slot0.Type.Number
	slot0.PropertyTypes[slot0.EventProperties.DiceHero_StepId] = slot0.Type.Number
end

return slot0
