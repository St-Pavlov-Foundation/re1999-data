-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikePlayerComp.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikePlayerComp", package.seeall)

local DeleikePlayerComp = class("DeleikePlayerComp", LuaCompBase)
local CULL_DIST = math.sqrt(DeleikeEnum.CubeSize.x^2 + DeleikeEnum.CubeSize.y^2) * 0.5 + DeleikeEnum.PlayerRadius

function DeleikePlayerComp:ctor(goJoystick)
	self.joyStick = MonoHelper.addLuaComOnceToGo(goJoystick, CommonJoystick, CommonJoystick.InputType.Dynamic)
end

function DeleikePlayerComp:init(go)
	self.go = go
	self.transform = go.transform
	self.goCircle = gohelper.findChild(go, "circle")
	self.dirUp = gohelper.findChild(go, "back")
	self.dirDown = gohelper.findChild(go, "front")
	self.dirLeft = gohelper.findChild(go, "left")
	self.dirRight = gohelper.findChild(go, "right")
	self.posX, self.posY = 0, 0
	self.curSpeed = DeleikeEnum.PlayerSpeed
	self.skillCntMap = {
		0,
		0
	}
	self.isCharging = false

	gohelper.setActive(self.goCircle, false)

	self._touchingEdge = false

	local dirs = {
		self.dirUp,
		self.dirDown,
		self.dirLeft,
		self.dirRight
	}

	for i = 1, #dirs do
		gohelper.setActive(dirs[i], false)
	end

	self._curDirGo = self.dirDown

	gohelper.setActive(self.dirDown, true)
end

function DeleikePlayerComp:addEventListeners()
	FixedUpdateBeat:Add(self.onFixedUpdate, self)
end

function DeleikePlayerComp:removeEventListeners()
	FixedUpdateBeat:Remove(self.onFixedUpdate, self)
end

function DeleikePlayerComp:onDestroy()
	TaskDispatcher.cancelTask(self._onCircleTimeout, self)

	self.joyStick = nil
end

function DeleikePlayerComp:resetState()
	self.posX, self.posY = 0, 0
	self.skillCntMap = {
		0,
		0
	}
	self.curSpeed = DeleikeEnum.PlayerSpeed
	self.isCharging = false

	TaskDispatcher.cancelTask(self._onCircleTimeout, self)
	gohelper.setActive(self.goCircle, false)

	self._touchingEdge = false

	if self._curDirGo and not gohelper.isNil(self._curDirGo) then
		gohelper.setActive(self._curDirGo, false)
	end

	self._curDirGo = self.dirDown

	gohelper.setActive(self.dirDown, true)
	self:_syncRt()
end

function DeleikePlayerComp:_syncRt()
	recthelper.setAnchor(self.transform, self.posX, self.posY)
end

function DeleikePlayerComp:getLogicPos()
	return self.posX, self.posY
end

function DeleikePlayerComp:setPos(x, y)
	self.posX, self.posY = x, y

	self:_syncRt()
end

function DeleikePlayerComp:setCharging(bool)
	self.isCharging = bool
end

function DeleikePlayerComp:onFixedUpdate()
	if gohelper.isNil(self.go) then
		return
	end

	if DeleikeGameMgr.instance.inputLocked then
		return
	end

	self.curSpeed = self.isCharging and DeleikeEnum.PlayerSlowSpeed or DeleikeEnum.PlayerSpeed

	local inputX, inputY = self.joyStick:getInput()

	self:_updateDirVisual(inputX, inputY)

	local lenSq = inputX * inputX + inputY * inputY

	if lenSq > 0.0001 then
		local len = math.sqrt(lenSq)
		local dt = Time.deltaTime

		self.posX = self.posX + inputX / len * self.curSpeed * dt
		self.posY = self.posY + inputY / len * self.curSpeed * dt
	end

	self:_clampToGridArea()
	self:_resolveCollisions()
	self:_pollPickups()
	self:_syncRt()
end

function DeleikePlayerComp:_updateDirVisual(inputX, inputY)
	local lenSq = inputX * inputX + inputY * inputY

	if lenSq <= 0.0001 then
		return
	end

	local dirGo

	if math.abs(inputX) >= math.abs(inputY) then
		dirGo = inputX > 0 and self.dirRight or self.dirLeft
	else
		dirGo = inputY > 0 and self.dirUp or self.dirDown
	end

	if self._curDirGo ~= dirGo then
		if self._curDirGo and not gohelper.isNil(self._curDirGo) then
			gohelper.setActive(self._curDirGo, false)
		end

		gohelper.setActive(dirGo, true)

		self._curDirGo = dirGo
	end
end

function DeleikePlayerComp:_clampToGridArea()
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if not unitCoord then
		return
	end

	local unitList = unitCoord.unitList
	local polys = {}

	for i = 1, #unitList do
		local comp = unitList[i]
		local mo = comp.mo

		if mo and mo.tileType == DeleikeEnum.TileType.Grid and not gohelper.isNil(comp.go) then
			polys[#polys + 1] = comp:getWorldPolygon()
		end
	end

	local px, py = self.posX, self.posY
	local r = DeleikeEnum.PlayerRadius
	local hostPoly

	for i = 1, #polys do
		if DeleikeCollision.pointInConvexPoly(px, py, polys[i]) then
			hostPoly = polys[i]

			break
		end
	end

	if not hostPoly then
		local bestX, bestY = px, py
		local bestDSq = math.huge

		for i = 1, #polys do
			local nx, ny = DeleikeCollision.circleClampInsidePoly(px, py, r, polys[i])
			local dx, dy = nx - px, ny - py
			local dSq = dx * dx + dy * dy

			if dSq < bestDSq then
				bestDSq, bestX, bestY = dSq, nx, ny
			end
		end

		self.posX, self.posY = bestX, bestY

		self:_setEdgeTouching(true)

		return
	end

	local pushX, pushY = 0, 0
	local n = #hostPoly

	for i = 1, n do
		local a = hostPoly[i]
		local b = hostPoly[i % n + 1]
		local ex, ey = b.x - a.x, b.y - a.y
		local nx, ny = -ey, ex
		local len = math.sqrt(nx * nx + ny * ny)

		if len > 1e-06 then
			nx, ny = nx / len, ny / len

			local d = nx * (px - a.x) + ny * (py - a.y)

			if d < r then
				local qx, qy = px - nx * r, py - ny * r
				local covered = false

				for oj = 1, #polys do
					if polys[oj] ~= hostPoly and DeleikeCollision.pointInConvexPoly(qx, qy, polys[oj]) then
						covered = true

						break
					end
				end

				if not covered then
					pushX = pushX + nx * (r - d)
					pushY = pushY + ny * (r - d)
				end
			end
		end
	end

	local touching = pushX * pushX + pushY * pushY > 1e-08

	self.posX, self.posY = px + pushX, py + pushY

	self:_setEdgeTouching(touching)
end

function DeleikePlayerComp:_setEdgeTouching(touching)
	if touching then
		if not self._touchingEdge then
			self._touchingEdge = true

			gohelper.setActive(self.goCircle, false)
			gohelper.setActive(self.goCircle, true)
		end

		TaskDispatcher.cancelTask(self._onCircleTimeout, self)
		TaskDispatcher.runDelay(self._onCircleTimeout, self, DeleikeEnum.CircleShowTime)
	else
		self._touchingEdge = false
	end
end

function DeleikePlayerComp:_onCircleTimeout()
	gohelper.setActive(self.goCircle, false)
end

function DeleikePlayerComp:_resolveCollisions()
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if not unitCoord then
		return
	end

	local cullSq = CULL_DIST * CULL_DIST
	local unitList = unitCoord.unitList
	local solids = {}

	for i = 1, #unitList do
		local comp = unitList[i]
		local mo = comp.mo

		if mo and not gohelper.isNil(comp.go) then
			local t = mo.tileType

			if t ~= DeleikeEnum.TileType.Bg and t ~= DeleikeEnum.TileType.Grid and t ~= DeleikeEnum.TileType.Line then
				solids[#solids + 1] = comp
			end
		end
	end

	for _ = 1, 3 do
		local pushed = false

		for i = 1, #solids do
			local comp = solids[i]
			local mo = comp.mo
			local dx = self.posX - mo.pos.x
			local dy = self.posY - mo.pos.y

			if cullSq >= dx * dx + dy * dy then
				local nx, ny = DeleikeCollision.circlePushOutOfPoly(self.posX, self.posY, DeleikeEnum.PlayerRadius, comp:getWorldPolygon())

				if nx ~= self.posX or ny ~= self.posY then
					self.posX, self.posY = nx, ny
					pushed = true
				end
			end
		end

		if not pushed then
			break
		end
	end
end

function DeleikePlayerComp:_pollPickups()
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if not unitCoord then
		return
	end

	local triggers = unitCoord.triggerList

	for i = 1, #triggers do
		local comp = triggers[i]

		if not comp.isCollected and not gohelper.isNil(comp.go) then
			comp:tryPickup(self.posX, self.posY)
		end
	end
end

function DeleikePlayerComp:getSkillCount(skillId)
	return self.skillCntMap[skillId] or 0
end

function DeleikePlayerComp:setSkillCount(skillId, count, isAdd)
	self.skillCntMap[skillId] = count

	DeleikeController.instance:dispatchEvent(DeleikeEvent.SkillCntChange, skillId, isAdd)
end

return DeleikePlayerComp
