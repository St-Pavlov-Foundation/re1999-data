-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/controller/SpLilyaGameSceneMgr.lua

module("modules.logic.versionactivity4_0.sp_lilya.controller.SpLilyaGameSceneMgr", package.seeall)

local SpLilyaGameSceneMgr = class("SpLilyaGameSceneMgr")

function SpLilyaGameSceneMgr:ctor()
	self._controller = nil
	self._sceneMo = nil
	self._running = false
	self._waveWaitRemainSecond = nil
end

function SpLilyaGameSceneMgr:init(controller)
	self._controller = controller

	local gameMO = SpLilyaGameModel.instance:getGameMO()

	self._sceneMo = gameMO and gameMO.sceneMo
	self._running = true
	self._waveWaitRemainSecond = nil
end

function SpLilyaGameSceneMgr:loadMonsterTeam(monsterTeamId)
	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	local monsterCos = SpLilyaConfig.instance:getMonsterCos(monsterTeamId)

	if not monsterCos then
		logError(string.format("SpLilyaGameSceneMgr:loadMonsterTeam error, no monster config, monsterTeamId:%s", tostring(monsterTeamId)))

		return
	end

	local spawnList = sceneMo.spawnList
	local maxWave = 0

	for _, co in pairs(monsterCos) do
		table.insert(spawnList, co)

		if co.group and maxWave < co.group then
			maxWave = co.group
		end
	end

	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if gameMO then
		gameMO.maxWave = maxWave
	end

	table.sort(spawnList, function(a, b)
		if a.group == b.group then
			if a.waveTime == b.waveTime then
				return a.monster < b.monster
			end

			return a.waveTime < b.waveTime
		end

		return a.group < b.group
	end)
end

function SpLilyaGameSceneMgr:update(deltaTime)
	if not self._running then
		return
	end

	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	sceneMo.elapsedTime = sceneMo.elapsedTime + deltaTime

	self:updateDestroy()
	self:updateBulletDestroy()
	self:updateBulletDying(deltaTime)
	self:updateMove(deltaTime)
	self:updateBulletAim()
	self:updateBulletMove(deltaTime)
	self:updateBulletHit()
	self:updateSpawn()
	self:_updateWaveWaitTip()
	self:updateState(deltaTime)
	self:updatePlayerState(deltaTime)

	local destroyList = sceneMo.destroyList

	if next(destroyList) ~= nil then
		self._controller:dispatchEvent(SpLilyaEvent.EnemyDestroy, destroyList)
	end

	local movedList = sceneMo.movedList

	if next(movedList) ~= nil then
		self._controller:dispatchEvent(SpLilyaEvent.EnemyMove, movedList)
	end

	local createdList = sceneMo.createdList

	if next(createdList) ~= nil then
		self._controller:dispatchEvent(SpLilyaEvent.EnemyCreate, createdList)
	end

	local bulletCreatedList = sceneMo.bulletCreatedList

	if next(bulletCreatedList) ~= nil then
		self._controller:dispatchEvent(SpLilyaEvent.BulletCreate, bulletCreatedList)
	end

	local bulletExplodeList = sceneMo.bulletExplodeList

	if next(bulletExplodeList) ~= nil then
		self._controller:dispatchEvent(SpLilyaEvent.BulletExplode, bulletExplodeList)
	end

	local bulletDestroyList = sceneMo.bulletDestroyList

	if next(bulletDestroyList) ~= nil then
		self._controller:dispatchEvent(SpLilyaEvent.BulletDestroy, bulletDestroyList)
	end

	local bulletMovedList = sceneMo.bulletMovedList

	if next(bulletMovedList) ~= nil then
		self._controller:dispatchEvent(SpLilyaEvent.BulletMove, bulletMovedList)
	end

	local stateChangedList = sceneMo.stateChangedList

	if next(stateChangedList) ~= nil then
		self._controller:dispatchEvent(SpLilyaEvent.EnemyStateChange, stateChangedList)
	end

	local enemyHurtList = sceneMo.enemyHurtList

	if next(enemyHurtList) ~= nil then
		self._controller:dispatchEvent(SpLilyaEvent.EnemyLifeChange, enemyHurtList)
	end

	tabletool.clear(sceneMo.destroyList)
	tabletool.clear(sceneMo.movedList)
	tabletool.clear(sceneMo.createdList)
	tabletool.clear(sceneMo.bulletExplodeList)
	tabletool.clear(sceneMo.bulletDestroyList)
	tabletool.clear(sceneMo.bulletMovedList)
	tabletool.clear(sceneMo.bulletCreatedList)
	tabletool.clear(sceneMo.stateChangedList)
	tabletool.clear(sceneMo.enemyHurtList)
end

function SpLilyaGameSceneMgr:_getWaveWaitRemainTime()
	local sceneMo = self._sceneMo
	local spawnList = sceneMo and sceneMo.spawnList

	if not sceneMo or not sceneMo.clearWaveTime or next(sceneMo.useMoDic) ~= nil or not spawnList or next(spawnList) == nil then
		return nil
	end

	local nextCo = spawnList[1]

	if nextCo.group == sceneMo.activeWaveId then
		return nil
	end

	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local elapsedTime = sceneMo.elapsedTime

	return math.max((gameMO and gameMO.waveTime or 0) - (elapsedTime - sceneMo.clearWaveTime), 0)
end

function SpLilyaGameSceneMgr:_updateWaveWaitTip()
	local remainTime = self:_getWaveWaitRemainTime()
	local remainSecond = remainTime and math.max(math.ceil(remainTime), 1) or nil

	if remainSecond == self._waveWaitRemainSecond then
		return
	end

	self._waveWaitRemainSecond = remainSecond

	self._controller:dispatchEvent(SpLilyaEvent.WaveWaitUpdate, remainSecond)
end

function SpLilyaGameSceneMgr:updateSpawn()
	if not self._running then
		return
	end

	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local oldWave = gameMO and gameMO.curWave or 0
	local spawnList = sceneMo.spawnList

	if not spawnList or next(spawnList) == nil then
		return
	end

	local elapsedTime = sceneMo.elapsedTime
	local nextCo = spawnList[1]

	if sceneMo.activeWaveId == nil then
		sceneMo.activeWaveId = nextCo.group
		sceneMo.activeWaveStartTime = elapsedTime
	elseif nextCo.group ~= sceneMo.activeWaveId then
		if next(sceneMo.useMoDic) ~= nil or not sceneMo.clearWaveTime then
			return
		end

		local waveTime = gameMO and gameMO.waveTime or 0

		if waveTime > elapsedTime - sceneMo.clearWaveTime then
			return
		end

		sceneMo.activeWaveId = nextCo.group
		sceneMo.activeWaveStartTime = elapsedTime
		sceneMo.clearWaveTime = nil
	end

	while next(spawnList) ~= nil do
		local co = spawnList[1]

		if co.group ~= sceneMo.activeWaveId then
			break
		end

		local inWaveTime = co.waveTime

		if inWaveTime > elapsedTime - sceneMo.activeWaveStartTime then
			break
		end

		table.remove(spawnList, 1)

		local mo = sceneMo:addEnemy(co)

		if mo and gameMO and mo.waveId and mo.waveId > gameMO.curWave then
			gameMO.curWave = mo.waveId
		end
	end

	if gameMO and gameMO.curWave ~= oldWave then
		self._controller:dispatchEvent(SpLilyaEvent.WaveUpdate, gameMO.curWave)
	end
end

function SpLilyaGameSceneMgr:updateDestroy()
	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	for _, mo in pairs(sceneMo.useMoDic) do
		if mo then
			if mo:isStateLocked() then
				if mo:isStateExpired() then
					self:destroyEnemy(mo)
				end
			elseif mo:isMoveFinish() then
				if self:_changeEnemyState(mo, SpLilyaEnum.EnemyState.Enter) then
					self:_damagePlayer(mo)
				end
			elseif mo:isDead() then
				self:_changeEnemyState(mo, SpLilyaEnum.EnemyState.Die)
			end
		end
	end

	local nextCo = sceneMo.spawnList and sceneMo.spawnList[1]
	local currentWaveFullySpawned = not nextCo or nextCo.group ~= sceneMo.activeWaveId

	if currentWaveFullySpawned and next(sceneMo.useMoDic) == nil and next(sceneMo.destroyList) ~= nil and not sceneMo.clearWaveTime then
		sceneMo.clearWaveTime = sceneMo.elapsedTime
	end
end

function SpLilyaGameSceneMgr:updateMove(deltaTime)
	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	for _, mo in pairs(sceneMo.useMoDic) do
		if mo then
			local moved = mo:updateMove(deltaTime)

			if moved then
				table.insert(sceneMo.movedList, mo)
			end
		end
	end
end

function SpLilyaGameSceneMgr:_damagePlayer(mo)
	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local playerMo = gameMO and gameMO.playerMo

	if not playerMo then
		return
	end

	local damage = mo.atk or 0

	playerMo.life = math.max((playerMo.life or 0) - damage, 0)

	if playerMo:changeState(SpLilyaEnum.PlayerState.Hit) then
		self._controller:dispatchEvent(SpLilyaEvent.PlayerStateChange, playerMo.state)
	end

	self._controller:dispatchEvent(SpLilyaEvent.HpUpdate, playerMo.life, playerMo.maxLife)
	self._controller:dispatchEvent(SpLilyaEvent.DamageNumUpdate, damage, playerMo.posX, playerMo.posY, true)
	self._controller:checkPlayerLife()
end

function SpLilyaGameSceneMgr:updatePlayerState(deltaTime)
	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local playerMo = gameMO and gameMO.playerMo

	if not playerMo then
		return
	end

	playerMo.stateTime = (playerMo.stateTime or 0) + deltaTime

	if playerMo:isStateExpired() and playerMo:changeState(SpLilyaEnum.PlayerState.Normal) then
		self._controller:dispatchEvent(SpLilyaEvent.PlayerStateChange, playerMo.state)
	end
end

function SpLilyaGameSceneMgr:_gainEnergy(energy)
	if not energy or energy <= 0 then
		return
	end

	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local playerMo = gameMO and gameMO.playerMo

	if not playerMo then
		return
	end

	playerMo.curEnergy = math.min((playerMo.curEnergy or 0) + energy, playerMo.energyMax or math.huge)

	self._controller:dispatchEvent(SpLilyaEvent.EnergyUpdate, playerMo.curEnergy, playerMo.energyMax)
end

function SpLilyaGameSceneMgr:destroyEnemy(mo)
	if not mo then
		return
	end

	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	sceneMo:removeEnemy(mo)
	sceneMo:removeAimEnemy(mo)
	table.insert(sceneMo.destroyList, mo)
	self._controller:checkEnemyCleared()
end

function SpLilyaGameSceneMgr:_changeEnemyState(mo, state)
	if not mo then
		return false
	end

	if mo:changeState(state) then
		table.insert(self._sceneMo.stateChangedList, mo)

		return true
	end

	return false
end

function SpLilyaGameSceneMgr:updateBulletDestroy()
	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	local deadEnemyList = {}

	for _, mo in pairs(sceneMo.useBulletMoDic) do
		if mo and not mo.dying then
			if mo:isGrounded() then
				self:_damageArea(mo, mo.posX, mo.posY, mo.explodeRadius, deadEnemyList)
				self:explodeBullet(mo, "落地爆炸")
			elseif mo:isConsume() then
				self:destroyBullet(mo, "出界销毁")
			end
		end
	end

	for _, enemyMo in ipairs(deadEnemyList) do
		self:_changeEnemyState(enemyMo, SpLilyaEnum.EnemyState.Die)
	end
end

function SpLilyaGameSceneMgr:updateBulletDying(deltaTime)
	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	local expireList

	for _, bulletMo in pairs(sceneMo.useBulletMoDic) do
		if bulletMo and bulletMo.dying then
			bulletMo.dyingElapsedTime = (bulletMo.dyingElapsedTime or 0) + deltaTime

			if bulletMo.dyingElapsedTime >= SpLilyaEnum.BulletExplodeDelayTime then
				expireList = expireList or {}

				table.insert(expireList, bulletMo)
			end
		end
	end

	for _, bulletMo in ipairs(expireList or {}) do
		self:destroyBullet(bulletMo, "爆炸延迟到期")
	end
end

function SpLilyaGameSceneMgr:updateBulletAim()
	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	self:_updatePendingAim(sceneMo)
end

function SpLilyaGameSceneMgr:_updatePendingAim(sceneMo)
	local aimMoDic = sceneMo.aimMoDic
	local addedList, removedList
	local checkInAim = self:_getPendingAimChecker()

	for uid, enemyMo in pairs(aimMoDic) do
		local valid = sceneMo.useMoDic[uid] ~= nil and enemyMo:isHittable()

		valid = valid and checkInAim ~= nil and checkInAim(enemyMo)

		if not valid then
			sceneMo:removeAimEnemy(enemyMo)

			removedList = removedList or {}

			table.insert(removedList, enemyMo)
		end
	end

	if checkInAim ~= nil then
		for uid, enemyMo in pairs(sceneMo.useMoDic) do
			if enemyMo and enemyMo:isHittable() and not aimMoDic[uid] and checkInAim(enemyMo) then
				sceneMo:addAimEnemy(enemyMo)

				addedList = addedList or {}

				table.insert(addedList, enemyMo)
			end
		end
	end

	if addedList or removedList then
		self._controller:dispatchEvent(SpLilyaEvent.EnemyAimChange, addedList or {}, removedList or {})
	end

	SpLilyaGameController.instance:setPlayerAimState(next(aimMoDic) ~= nil and SpLilyaEnum.AimState.Aim or SpLilyaEnum.AimState.Normal)
end

function SpLilyaGameSceneMgr:_getPendingAimChecker()
	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local playerMo = gameMO and gameMO.playerMo

	if not playerMo then
		return nil
	end

	if gameMO.isGravity == SpLilyaEnum.UseGravity.Use then
		local samples = self:_getPendingParabolaSamples(playerMo)

		if not samples then
			return nil
		end

		local radius = playerMo.bulletRadius or 0

		return function(enemyMo)
			return self:_isInParabolaAimRange(enemyMo, samples, radius)
		end
	end

	local rad = math.rad(playerMo.rotation or 0)
	local dirX = math.cos(rad)
	local dirY = math.sin(rad)
	local radius = playerMo.bulletRadius or 0
	local posX = playerMo.bulletPosX or playerMo.posX or 0
	local posY = playerMo.bulletPosY or playerMo.posY or 0

	return function(enemyMo)
		return self:_isInLineAimRange(enemyMo, posX, posY, dirX, dirY, radius)
	end
end

function SpLilyaGameSceneMgr:_isInParabolaAimRange(enemyMo, samples, radius)
	for _, sample in ipairs(samples) do
		if self:_isCircleIntersectEnemy(enemyMo, sample.x, sample.y, radius) then
			return true
		end
	end

	return false
end

function SpLilyaGameSceneMgr:_isInLineAimRange(enemyMo, posX, posY, dirX, dirY, radius)
	local centerX = enemyMo.posX + (enemyMo.collisionOffsetX or 0)
	local centerY = enemyMo.posY + (enemyMo.collisionOffsetY or 0)
	local radiusX = math.max((enemyMo.collisionRadiusX or enemyMo.radius or 0) + (radius or 0), 1)
	local radiusY = math.max((enemyMo.collisionRadiusY or enemyMo.radius or 0) + (radius or 0), 1)
	local originX = (posX - centerX) / radiusX
	local originY = (posY - centerY) / radiusY
	local rayX = dirX / radiusX
	local rayY = dirY / radiusY
	local a = rayX * rayX + rayY * rayY
	local b = 2 * (originX * rayX + originY * rayY)
	local c = originX * originX + originY * originY - 1
	local discriminant = b * b - 4 * a * c

	if discriminant < 0 or a <= 0 then
		return false
	end

	local sqrtDiscriminant = math.sqrt(discriminant)
	local t1 = (-b - sqrtDiscriminant) / (2 * a)
	local t2 = (-b + sqrtDiscriminant) / (2 * a)

	return t1 >= 0 or t2 >= 0
end

function SpLilyaGameSceneMgr:_updateBulletTrack(sceneMo)
	for _, bulletMo in pairs(sceneMo.useBulletMoDic) do
		if bulletMo and bulletMo.type == SpLilyaEnum.BulletType.Gravity then
			local target = bulletMo.targetUid and sceneMo.useMoDic[bulletMo.targetUid]

			if not target or not target:isHittable() then
				local landX, landY = bulletMo:getLandPos()
				local nearestMo, nearestDistSq

				for _, enemyMo in pairs(sceneMo.useMoDic) do
					if enemyMo and enemyMo:isHittable() and self:_isInAimRange(enemyMo, landX, landY, bulletMo.explodeRadius) then
						local dx = enemyMo.posX - landX
						local dy = enemyMo.posY - landY
						local distSq = dx * dx + dy * dy

						if not nearestDistSq or distSq < nearestDistSq then
							nearestMo = enemyMo
							nearestDistSq = distSq
						end
					end
				end

				bulletMo.targetUid = nearestMo and nearestMo.uid or nil
			end
		end
	end
end

function SpLilyaGameSceneMgr:_getPendingParabolaSamples(playerMo)
	if not playerMo then
		return nil
	end

	local rad = math.rad(playerMo.rotation or 0)
	local speed = SpLilyaGameController.instance:getShotSpeed()
	local vx = math.cos(rad) * speed
	local vy = math.sin(rad) * speed
	local g = SpLilyaEnum.DefaultGravity
	local landY = self._sceneMo and self._sceneMo.groundHeight or 0
	local posX = playerMo.bulletPosX or playerMo.posX or 0
	local posY = playerMo.bulletPosY or playerMo.posY or 0
	local t = (vy + math.sqrt(math.max(vy * vy + 2 * g * (posY - landY), 0))) / g
	local samples = {}
	local count = SpLilyaEnum.BulletAimSampleCount

	for i = 0, count do
		local ti = t * i / count

		samples[#samples + 1] = {
			x = posX + vx * ti,
			y = posY + vy * ti - 0.5 * g * ti * ti
		}
	end

	return samples
end

function SpLilyaGameSceneMgr:_isInAimRange(enemyMo, landX, landY, explodeRadius)
	return self:_isCircleIntersectEnemy(enemyMo, landX, landY, explodeRadius)
end

function SpLilyaGameSceneMgr:updateBulletMove(deltaTime)
	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	for _, mo in pairs(sceneMo.useBulletMoDic) do
		if mo and not mo.dying then
			local moved = mo:updateMove(deltaTime)

			if moved then
				table.insert(sceneMo.bulletMovedList, mo)
			end
		end
	end
end

function SpLilyaGameSceneMgr:_isCircleIntersectEnemy(enemyMo, posX, posY, radius)
	local centerX = enemyMo.posX + (enemyMo.collisionOffsetX or 0)
	local centerY = enemyMo.posY + (enemyMo.collisionOffsetY or 0)
	local radiusX = math.max((enemyMo.collisionRadiusX or enemyMo.radius or 0) + (radius or 0), 1)
	local radiusY = math.max((enemyMo.collisionRadiusY or enemyMo.radius or 0) + (radius or 0), 1)
	local dx = (posX - centerX) / radiusX
	local dy = (posY - centerY) / radiusY

	return dx * dx + dy * dy <= 1
end

function SpLilyaGameSceneMgr:_findHitEnemy(bulletMo)
	for _, enemyMo in pairs(self._sceneMo.useMoDic) do
		if enemyMo:isHittable() and self:_isCircleIntersectEnemy(enemyMo, bulletMo.posX, bulletMo.posY, bulletMo.radius) then
			return enemyMo
		end
	end
end

function SpLilyaGameSceneMgr:_damageArea(bulletMo, posX, posY, radius, deadEnemyList)
	local isHit = false
	local damage = bulletMo.damage

	for _, enemyMo in pairs(self._sceneMo.useMoDic) do
		if enemyMo:isHittable() and self:_isCircleIntersectEnemy(enemyMo, posX, posY, radius) then
			if not enemyMo:changeLife(damage) then
				table.insert(deadEnemyList, enemyMo)
			end

			table.insert(self._sceneMo.enemyHurtList, enemyMo)
			self._controller:dispatchEvent(SpLilyaEvent.DamageNumUpdate, damage, enemyMo.posX, enemyMo.posY, false)

			isHit = true
		end
	end

	if isHit then
		self:_gainEnergy(bulletMo.energy)
	end

	return isHit
end

function SpLilyaGameSceneMgr:updateBulletHit()
	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	local hitBulletList = {}
	local deadEnemyList = {}

	for _, bulletMo in pairs(sceneMo.useBulletMoDic) do
		if bulletMo and not bulletMo.dying and self:_findHitEnemy(bulletMo) then
			local damageRadius = bulletMo.explodeRadius > 0 and bulletMo.explodeRadius or bulletMo.radius

			self:_damageArea(bulletMo, bulletMo.posX, bulletMo.posY, damageRadius, deadEnemyList)
			table.insert(hitBulletList, bulletMo)
		end
	end

	for _, bulletMo in ipairs(hitBulletList) do
		self:explodeBullet(bulletMo, "碰撞命中")
	end

	for _, enemyMo in ipairs(deadEnemyList) do
		self:_changeEnemyState(enemyMo, SpLilyaEnum.EnemyState.Die)
	end
end

function SpLilyaGameSceneMgr:updateState(deltaTime)
	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	for _, enemyMo in pairs(sceneMo.useMoDic) do
		if enemyMo then
			if enemyMo.state == nil then
				enemyMo.state = SpLilyaEnum.EnemyState.Normal
				enemyMo.stateTime = 0

				table.insert(sceneMo.stateChangedList, enemyMo)
			else
				enemyMo.stateTime = (enemyMo.stateTime or 0) + deltaTime

				if not enemyMo:isStateLocked() then
					if enemyMo._isHit then
						enemyMo._isHit = false

						self:_changeEnemyState(enemyMo, SpLilyaEnum.EnemyState.Hit)
					elseif enemyMo:isStateExpired() then
						self:_changeEnemyState(enemyMo, SpLilyaEnum.EnemyState.Normal)
					end
				end
			end
		end
	end
end

function SpLilyaGameSceneMgr:explodeBullet(mo, reason)
	if not mo or mo.dying then
		return
	end

	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	local speedX = mo._speedX or 0
	local speedY = mo._speedY or 0
	local speed = math.sqrt(speedX * speedX + speedY * speedY)
	local dirX = speed > 0 and speedX / speed or 0
	local dirY = speed > 0 and speedY / speed or 0

	logWarn(string.format("[SpLilya] 爆炸子弹 uid=%d 原因=%s 方向=(%.2f,%.2f) 速度=%.2f 伤害=%.2f 碰撞半径=%.2f 爆炸半径=%.2f", mo.uid, tostring(reason), dirX, dirY, speed, mo.damage or 0, mo.radius or 0, mo.explodeRadius or 0))

	mo.explodeReason = reason
	mo.dying = true
	mo.dyingElapsedTime = 0

	table.insert(sceneMo.bulletExplodeList, mo)
end

function SpLilyaGameSceneMgr:destroyBullet(mo, reason)
	if not mo then
		return
	end

	local sceneMo = self._sceneMo

	if not sceneMo then
		return
	end

	local speedX = mo._speedX or 0
	local speedY = mo._speedY or 0
	local speed = math.sqrt(speedX * speedX + speedY * speedY)
	local dirX = speed > 0 and speedX / speed or 0
	local dirY = speed > 0 and speedY / speed or 0

	logWarn(string.format("[SpLilya] 销毁子弹 uid=%d 原因=%s 方向=(%.2f,%.2f) 速度=%.2f 伤害=%.2f 碰撞半径=%.2f 爆炸半径=%.2f", mo.uid, tostring(reason), dirX, dirY, speed, mo.damage or 0, mo.radius or 0, mo.explodeRadius or 0))

	sceneMo.useBulletMoDic[mo.uid] = nil

	table.insert(sceneMo.unuseBulletMoList, mo)
	table.insert(sceneMo.bulletDestroyList, mo)
	self._controller:checkBulletLimit()
end

function SpLilyaGameSceneMgr:getEnemyDic()
	return self._sceneMo and self._sceneMo.useMoDic
end

function SpLilyaGameSceneMgr:getAimDic()
	return self._sceneMo and self._sceneMo.aimMoDic
end

function SpLilyaGameSceneMgr:getBulletDic()
	return self._sceneMo and self._sceneMo.useBulletMoDic
end

function SpLilyaGameSceneMgr:hasEnemy()
	local sceneMo = self._sceneMo

	if not sceneMo then
		return false
	end

	local hasSpawn = next(sceneMo.spawnList) ~= nil
	local hasAlive = next(sceneMo.useMoDic) ~= nil

	return hasSpawn or hasAlive
end

function SpLilyaGameSceneMgr:hasKillableEnemy()
	local sceneMo = self._sceneMo

	if not sceneMo then
		return false
	end

	if next(sceneMo.spawnList) ~= nil then
		return true
	end

	for _, enemyMo in pairs(sceneMo.useMoDic) do
		if enemyMo and enemyMo:isHittable() then
			return true
		end
	end

	return false
end

function SpLilyaGameSceneMgr:clear()
	self._sceneMo = nil
	self._waveWaitRemainSecond = nil
end

function SpLilyaGameSceneMgr:stop()
	self._running = false
end

function SpLilyaGameSceneMgr:onDestroy()
	self:stop()
	self:clear()

	self._controller = nil
end

SpLilyaGameSceneMgr.instance = SpLilyaGameSceneMgr.New()

return SpLilyaGameSceneMgr
