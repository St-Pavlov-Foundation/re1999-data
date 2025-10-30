﻿-- chunkname: @modules/logic/necrologiststory/controller/NecrologistStoryEvent.lua

module("modules.logic.necrologiststory.controller.NecrologistStoryEvent", package.seeall)

local NecrologistStoryEvent = _M

NecrologistStoryEvent.UpdateStoryGameInfo = GameUtil.getEventId()
NecrologistStoryEvent.OnStoryStart = GameUtil.getEventId()
NecrologistStoryEvent.OnStoryNextStep = GameUtil.getEventId()
NecrologistStoryEvent.OnStoryEnd = GameUtil.getEventId()
NecrologistStoryEvent.OnClickNext = GameUtil.getEventId()
NecrologistStoryEvent.OnAutoChange = GameUtil.getEventId()
NecrologistStoryEvent.OnClickSkip = GameUtil.getEventId()
NecrologistStoryEvent.OnSelectSection = GameUtil.getEventId()
NecrologistStoryEvent.OnSectionEnd = GameUtil.getEventId()
NecrologistStoryEvent.OnStoryStateChange = GameUtil.getEventId()
NecrologistStoryEvent.OnStoryItemFinish = GameUtil.getEventId()
NecrologistStoryEvent.OnChangeWeather = GameUtil.getEventId()
NecrologistStoryEvent.OnChangePic = GameUtil.getEventId()
NecrologistStoryEvent.OnStoryItemClickNext = GameUtil.getEventId()
NecrologistStoryEvent.V3A1_MoveToBase = GameUtil.getEventId()
NecrologistStoryEvent.V3A1_UnlockArea = GameUtil.getEventId()
NecrologistStoryEvent.V3A1_GameReset = GameUtil.getEventId()
NecrologistStoryEvent.StartDragPic = GameUtil.getEventId()
NecrologistStoryEvent.StartMagic = GameUtil.getEventId()
NecrologistStoryEvent.StartErasePic = GameUtil.getEventId()
NecrologistStoryEvent.OnPlayStory = GameUtil.getEventId()
NecrologistStoryEvent.OnSituationValue = GameUtil.getEventId()
NecrologistStoryEvent.OnLinkText = GameUtil.getEventId()

return NecrologistStoryEvent
