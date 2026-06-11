-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongGameExploreItem.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongGameExploreItem", package.seeall)

local V3a8EchoSongGameExploreItem = class("V3a8EchoSongGameExploreItem", LuaCompBase)

function V3a8EchoSongGameExploreItem:init(go)
	self.viewGO = go

	self:_editableInitView()
end

function V3a8EchoSongGameExploreItem:_editableInitView()
	self._pos = self._pos or Vector3.zero
	self._moveSpeed = V3a8EchoSongEnum.ExploreConst.MoveSpeed
	self._lifeTime = V3a8EchoSongEnum.ParticleLifeTime.Explore
	self._startTime = 0
end

function V3a8EchoSongGameExploreItem:getPos()
	return self._pos
end

function V3a8EchoSongGameExploreItem:update(deltaTime)
	local time = Time.time - self._startTime

	if time > self._lifeTime then
		return
	end

	if not self._moveDir or not self.viewGO then
		return
	end

	local moveDis = self._moveDir * self._moveSpeed * deltaTime
	local hit = UnityEngine.Physics2D.Raycast(self._pos, self._moveDir, V3a8EchoSongEnum.ExploreConst.RaycastDist, V3a8EchoSongEnum.ColliderLayer)

	if hit and hit.collider ~= nil then
		local deltaPos = hit.point - self._pos

		if Vector2.Magnitude(deltaPos) < Vector2.Magnitude(moveDis) then
			V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.EmittedParticle, self._pos, V3a8EchoSongEnum.ParticleType.Explore)

			self._isHit = true

			return
		end
	end

	self._pos.x = self._pos.x + moveDis.x
	self._pos.y = self._pos.y + moveDis.y

	transformhelper.setPosXY(self.viewGO.transform, self._pos.x, self._pos.y)
end

function V3a8EchoSongGameExploreItem:onUpdateMO(angle)
	self._pos.x, self._pos.y = transformhelper.getPos(self.viewGO.transform)
	self._moveDir = Vector2.New(Mathf.Cos(angle), Mathf.Sin(angle))

	self._moveDir:SetNormalize()

	self._startTime = Time.time
	self._isHit = false

	gohelper.setActive(self.viewGO, true)
end

function V3a8EchoSongGameExploreItem:isDead()
	if self._isHit then
		return true
	end

	return self._startTime and self._startTime + self._lifeTime < Time.time
end

function V3a8EchoSongGameExploreItem:reset()
	self._isHit = true
	self._moveDir = nil

	transformhelper.setPosXY(self.viewGO.transform, 10000, 10000)
end

return V3a8EchoSongGameExploreItem
