-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventRevertScene.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventRevertScene", package.seeall)

local FightTLEventRevertScene = class("FightTLEventRevertScene", FightTimelineTrackItem)

function FightTLEventRevertScene:onTrackStart(fightStepData, duration, paramsArr)
	local fightParam = FightModel.instance:getFightParam()

	if fightParam and fightParam.sceneId then
		self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded)
		FightGameMgr.sceneLevelMgr:loadScene(fightParam.sceneId, fightParam.levelId)
	end
end

function FightTLEventRevertScene:_onLevelLoaded()
	local entityDic = FightGameMgr.entityMgr:getAllEntity()

	if entityDic then
		for _, entity in pairs(entityDic) do
			entity:resetStandPos()
		end
	end
end

function FightTLEventRevertScene:onTrackEnd()
	return
end

function FightTLEventRevertScene:onDestructor()
	return
end

return FightTLEventRevertScene
