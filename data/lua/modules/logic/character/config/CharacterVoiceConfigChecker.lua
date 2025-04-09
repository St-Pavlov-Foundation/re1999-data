module("modules.logic.character.config.CharacterVoiceConfigChecker", package.seeall)

slot0 = class("CharacterVoiceConfigChecker")
slot1 = 1
slot2 = 5

function slot0.checkConfig(slot0)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	slot1 = {
		[CharacterEnum.VoiceType.HeroGroup] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.EnterFight] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.FightCardStar12] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.FightCardStar3] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.FightCardUnique] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.FightBehit] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.FightResult] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.FightDie] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.GetSkin] = slot0._handlerGetSkin,
		[CharacterEnum.VoiceType.BreakThrough] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.Summon] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.MainViewSpecialTouch] = slot0._handlerMainViewSpecialTouch,
		[CharacterEnum.VoiceType.MainViewNormalTouch] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.WeatherChange] = slot0._handlerWeatherChange,
		[CharacterEnum.VoiceType.MainViewWelcome] = slot0._handlerMainViewWelcome,
		[CharacterEnum.VoiceType.MainViewNoInteraction] = slot0._handlerMainViewNoInteraction,
		[CharacterEnum.VoiceType.Greeting] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.Skill] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.GreetingInThumbnail] = slot0._handlerGreetingInThumbnail,
		[CharacterEnum.VoiceType.SpecialIdle1] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.SpecialIdle2] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.LimitedEntrance] = slot0._handlerSkip,
		[CharacterEnum.VoiceType.MainViewSpecialInteraction] = slot0._handlerMainViewSpecialInteraction,
		[CharacterEnum.VoiceType.MainViewSpecialRespond] = slot0._handlerMainViewSpecialRespond,
		[CharacterEnum.VoiceType.MainViewDragSpecialRespond] = slot0._handlerMainViewDragSpecialRespond,
		[CharacterEnum.VoiceType.MultiVoice] = slot0._handlerMultiVoice
	}

	for slot5, slot6 in ipairs(lua_character_voice.configList) do
		if not callWithCatch(slot0._commonCheck, slot0, slot6) then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s is invalid", slot6.audio, slot6.type))
		end

		if slot1[slot6.type] then
			if not callWithCatch(slot8, slot0, slot6) then
				logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s is invalid", slot6.audio, slot6.type))
			end
		else
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s no handler", slot6.audio, slot6.type))
		end
	end
end

function slot0._commonCheck(slot0, slot1)
	for slot6, slot7 in ipairs(string.splitToNumber(slot1.skins, "#")) do
		if not lua_skin.configDict[slot7] then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s skinId:%s is invalid", slot1.audio, slot1.type, slot7))
		end
	end
end

function slot0._handlerSkip(slot0, slot1)
end

function slot0._handlerGetSkin(slot0, slot1)
	if not lua_skin.configDict[tonumber(slot1.param)] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", slot1.audio, slot1.type, slot1.param))

		return
	end
end

function slot0._handlerMainViewSpecialTouch(slot0, slot1)
	if tonumber(slot1.param) < uv0 or uv1 < slot2 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", slot1.audio, slot1.type, slot1.param))
	end
end

function slot0._handlerWeatherChange(slot0, slot1)
	if #string.splitToNumber(slot1.param, "#") == 0 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", slot1.audio, slot1.type, slot1.param))

		return
	end

	for slot6, slot7 in pairs(slot2) do
		if not lua_weather_report.configDict[slot7] then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", slot1.audio, slot1.type, slot1.param))

			break
		end
	end
end

function slot0._handlerMainViewWelcome(slot0, slot1)
	slot5 = tonumber(string.split(string.split(slot1.time, "#")[1], ":")[1]) < 12
end

function slot0._handlerMainViewNoInteraction(slot0, slot1)
	if #string.splitToNumber(slot1.param, "#") == 0 or not slot2[1] or not slot2[2] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", slot1.audio, slot1.type, slot1.param))

		return
	end
end

function slot0._handlerGreetingInThumbnail(slot0, slot1)
	slot5 = tonumber(string.split(string.split(slot1.time, "#")[1], ":")[1]) < 12
end

function slot0._handlerMainViewSpecialInteraction(slot0, slot1)
	if #string.splitToNumber(slot1.param, "#") == 0 or not slot2[1] or not slot2[2] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", slot1.audio, slot1.type, slot1.param))
	end

	if not tonumber(slot1.param2) or not lua_character_special_interaction_voice.configDict[slot3] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param2:%s is invalid", slot1.audio, slot1.type, slot1.param2))
	end
end

function slot0._handlerMainViewSpecialRespond(slot0, slot1)
	if (tonumber(slot1.param) or 0) == 0 then
		return
	end

	if slot2 < uv0 or uv1 < slot2 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", slot1.audio, slot1.type, slot1.param))
	end
end

function slot0._handlerMainViewDragSpecialRespond(slot0, slot1)
	if not string.nilorempty(slot1.param2) and (#string.split(slot1.param2, "#") == 0 or not slot2[1] or not tonumber(slot2[2]) or not tonumber(slot2[3])) then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param2:%s is invalid", slot1.audio, slot1.type, slot1.param2))
	end

	if (tonumber(slot1.param) or 0) == 0 then
		return
	end

	if slot2 < uv0 or uv1 < slot2 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", slot1.audio, slot1.type, slot1.param))
	end
end

function slot0._handlerMultiVoice(slot0, slot1)
	if not lua_character_voice.configDict[slot1.heroId][tonumber(slot1.param)] or slot2 == slot1 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", slot1.audio, slot1.type, slot1.param))
	end
end

slot0.instance = slot0.New()

return slot0
