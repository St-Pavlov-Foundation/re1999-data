﻿-- chunkname: @modules/logic/scene/fight/preloadwork/FightRoundPreloadMonsterWork.lua

module("modules.logic.scene.fight.preloadwork.FightRoundPreloadMonsterWork", package.seeall)

local FightRoundPreloadMonsterWork = class("FightRoundPreloadMonsterWork", BaseWork)

function FightRoundPreloadMonsterWork:onStart(context)
	if FightDataHelper.tempMgr.hasNextWave then
		self:_onFightWavePush()

		FightDataHelper.tempMgr.hasNextWave = false

		return
	end

	if FightModel.instance.hasNextWave then
		self:_onFightWavePush()
	else
		FightController.instance:registerCallback(FightEvent.PushFightWave, self._onFightWavePush, self)
	end
end

function FightRoundPreloadMonsterWork:_onFightWavePush()
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, self._onFightWavePush, self)

	local spineUrlList

	self._spineCountDict = nil
	spineUrlList, self._spineCountDict = self:_getSpineUrlList()
	self._loader = SequenceAbLoader.New()

	self._loader:setPathList(spineUrlList)
	self._loader:setConcurrentCount(1)
	self._loader:setInterval(0.1)
	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function FightRoundPreloadMonsterWork:_onPreloadFinish()
	if not self._loader then
		return
	end

	local assetItemDict = self._loader:getAssetItemDict()

	self._needCreateList = {}
	self._hasCreateList = {}

	for url, assetItem in pairs(assetItemDict) do
		FightSpinePool.setAssetItem(url, assetItem)

		local count = self._spineCountDict[url]

		for i = 1, count do
			table.insert(self._needCreateList, url)
		end

		self.context.callback(self.context.callbackObj, assetItem)
	end

	local needCreateCount = #self._needCreateList

	if needCreateCount > 0 then
		TaskDispatcher.runRepeat(self._createSpineGO, self, 0.1, needCreateCount)
	else
		self:onDone(true)
	end
end

function FightRoundPreloadMonsterWork:_createSpineGO()
	local url = table.remove(self._needCreateList)
	local spineGO = FightSpinePool.getSpine(url)

	gohelper.setActive(spineGO, false)

	local container = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:getEntityContainer()

	gohelper.addChild(container, spineGO)
	table.insert(self._hasCreateList, {
		url,
		spineGO
	})

	if #self._needCreateList == 0 then
		TaskDispatcher.cancelTask(self._createSpineGO, self)
		self:_returnSpineToPool()
		self:onDone(true)
	end
end

function FightRoundPreloadMonsterWork:_returnSpineToPool()
	if self._hasCreateList then
		for _, tb in ipairs(self._hasCreateList) do
			local url = tb[1]
			local spineGO = tb[2]

			tb[1] = nil
			tb[2] = nil

			FightSpinePool.putSpine(url, spineGO)
		end
	end

	self._needCreateList = nil
	self._hasCreateList = nil
end

function FightRoundPreloadMonsterWork:_onPreloadOneFail(loader, assetItem)
	logError("战斗Spine加载失败：" .. assetItem.ResPath)
end

function FightRoundPreloadMonsterWork:clearWork()
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, self._onFightWavePush, self)
	self:_returnSpineToPool()
	TaskDispatcher.cancelTask(self._createSpineGO, self)

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function FightRoundPreloadMonsterWork:_getSpineUrlList()
	local nextWaveId = FightModel.instance:getCurWaveId() + 1
	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam and fightParam.episodeId
	local battleId = fightParam and fightParam.battleId or episodeId and DungeonConfig.instance:getEpisodeBattleId(episodeId)
	local spineUrlDict = {}
	local enemySkinIds = {}
	local battleCO = lua_battle.configDict[battleId]

	if battleCO then
		local monsterGroupIds = string.splitToNumber(battleCO.monsterGroupIds, "#")
		local monsterGroupId = monsterGroupIds and monsterGroupIds[nextWaveId]
		local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
		local monsterIds = monsterGroupCO and string.splitToNumber(monsterGroupCO.monster, "#")

		if monsterIds then
			for _, monsterId in ipairs(monsterIds) do
				self:_calcMonster(monsterId, enemySkinIds)
			end
		end
	end

	for _, skinId in ipairs(enemySkinIds) do
		local skinCO = FightConfig.instance:getSkinCO(skinId)

		if skinCO and not string.nilorempty(skinCO.spine) then
			local url = ResUrl.getSpineFightPrefabBySkin(skinCO)

			spineUrlDict[url] = spineUrlDict[url] and spineUrlDict[url] + 1 or 1
		end
	end

	local ret = {}

	for url, _ in pairs(spineUrlDict) do
		table.insert(ret, url)
	end

	return ret, spineUrlDict
end

function FightRoundPreloadMonsterWork:_calcMonster(monsterId, enemySkinIds)
	local monsterCO = lua_monster.configDict[monsterId]

	table.insert(enemySkinIds, monsterCO and monsterCO.skinId or 0)

	local refMonsterIds = self:_calcRefMonsterIds(monsterId)

	if refMonsterIds then
		for _, refMonsterId in ipairs(refMonsterIds) do
			local refMonsterCO = lua_monster.configDict[refMonsterId]

			if refMonsterCO then
				table.insert(enemySkinIds, refMonsterCO and refMonsterCO.skinId or 0)
			else
				logError("怪物" .. monsterId .. "，引用的怪物" .. refMonsterId .. "不存在")
			end
		end
	end
end

function FightRoundPreloadMonsterWork:_calcRefMonsterIds(monsterId)
	local monsterCO = lua_monster.configDict[monsterId]

	if not monsterCO then
		return
	end

	local ret
	local skillIds = FightHelper._buildMonsterSkills(monsterCO)

	for _, skillId in ipairs(skillIds) do
		local skillCO = lua_skill.configDict[skillId]

		for i = 1, FightEnum.MaxBehavior do
			local behavior = skillCO["behavior" .. i]
			local sp = string.splitToNumber(behavior, "#")
			local behaviorId = sp[1]
			local behaviorCO = behaviorId and lua_skill_behavior.configDict[behaviorId]

			if behaviorCO and behaviorCO.type == "MonsterChange" then
				ret = ret or {}

				table.insert(ret, sp[2])
			end
		end
	end

	return ret
end

return FightRoundPreloadMonsterWork
