-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/scene/comp/show/ArcadeSurvivorAfterimageShow.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.scene.comp.show.ArcadeSurvivorAfterimageShow", package.seeall)

local ArcadeSurvivorAfterimageShow = class("ArcadeSurvivorAfterimageShow")
local MainColorId = UnityEngine.Shader.PropertyToID("_MainCol")
local BlendColId = UnityEngine.Shader.PropertyToID("_BlendCol")
local BlendColor = Color.New(0.27, 0.88, 0.93, 1)

function ArcadeSurvivorAfterimageShow:ctor(go)
	self._go = go
	self._alphaColor = Color.New(1, 1, 1, 1)
	self._offsetVec = Vector3.New(0, 0, 0)
	self._emitters = {}
	self._items = {}
	self._pool = {}
end

function ArcadeSurvivorAfterimageShow:start(entity, showId)
	self:stop(entity)

	if not entity:getCurPrefabItem() then
		return
	end

	local param = ArcadeSurvivorConfig.instance:getShowTriggerShowModeParam(showId)
	local values = string.splitToNumber(param, "#")

	if not values or #values < 4 or values[1] <= 0 then
		logError(string.format("ArcadeSurvivorAfterimageShow:start error, showId:%s param:%s", tostring(showId), tostring(param)))

		return
	end

	local x, y = entity:getPosition(true)
	local emitter = {
		remainder = 0,
		entity = entity,
		x = x,
		y = y,
		spacing = values[1] * ArcadeSurvivorConfig.instance:getGameBaseGridSize(),
		fadeIn = values[2],
		hold = values[3],
		fadeOut = values[4]
	}

	self._emitters[entity] = emitter

	self:_spawn(emitter, x, y)
end

function ArcadeSurvivorAfterimageShow:_spawn(emitter, x, y)
	local entity = emitter.entity
	local prefabItem = entity:getCurPrefabItem()

	if not prefabItem then
		return
	end

	local model = prefabItem.goScale or prefabItem.go
	local modelName = prefabItem.go.name
	local pool = self._pool[modelName]
	local item = pool and table.remove(pool)

	item = item or {
		go = gohelper.create3d(self._go, "afterimage"),
		parts = {},
		modelName = modelName
	}

	gohelper.setActive(item.go, false)

	item.startTime = Time.time
	item.fadeIn, item.hold, item.fadeOut = emitter.fadeIn, emitter.hold, emitter.fadeOut

	local curX, curY = entity:getPosition(true)
	local offsetVec = self._offsetVec

	offsetVec.x, offsetVec.y, offsetVec.z = x - curX, y - curY, 0

	local offset = entity.trans.parent:TransformVector(offsetVec)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local effectMgr = scene and scene.effectMgr
	local renderers = model:GetComponentsInChildren(gohelper.Type_MeshRender, false)

	for _, part in ipairs(item.parts) do
		part.renderer.enabled = false
	end

	for i = 0, renderers.Length - 1 do
		local source = renderers[i]
		local part = item.parts[i + 1]

		if not part then
			local go = gohelper.create3d(item.go, "mesh")

			part = {
				go = go,
				filter = go:AddComponent(typeof(UnityEngine.MeshFilter)),
				renderer = go:AddComponent(gohelper.Type_MeshRender),
				block = UnityEngine.MaterialPropertyBlock.New()
			}
			item.parts[i + 1] = part
		end

		part.go.layer = source.gameObject.layer
		part.filter.sharedMesh = source:GetComponent(typeof(UnityEngine.MeshFilter)).sharedMesh

		if effectMgr then
			part.renderer.sharedMaterials = effectMgr:getOriginalMaterials(source)
		end

		part.renderer.enabled = source.enabled
		part.renderer.sortingLayerID = source.sortingLayerID
		part.renderer.sortingOrder = source.sortingOrder - 1

		local trans = part.go.transform

		trans:SetParent(source.transform, false)
		transformhelper.setLocalPos(trans, 0, 0, 0)
		transformhelper.setLocalRotation(trans, 0, 0, 0)
		transformhelper.setLocalScale(trans, 1, 1, 1)
		trans:SetParent(item.go.transform, true)

		local worldX, worldY, worldZ = transformhelper.getPos(trans)

		transformhelper.setPos(trans, worldX + offset.x, worldY + offset.y, worldZ + offset.z)
		source:GetPropertyBlock(part.block)
		part.block:SetColor(BlendColId, BlendColor)
		part.block:SetFloat("_BlendSize", 1)
	end

	self:_setAlpha(item, ArcadeSurvivorAfterimageShow.getAlpha(item, Time.time))
	gohelper.setActive(item.go, true)

	self._items[#self._items + 1] = item
end

function ArcadeSurvivorAfterimageShow.getAlpha(item, now)
	local age = now - item.startTime

	if age < item.fadeIn then
		return math.max(0, age / item.fadeIn)
	elseif age < item.fadeIn + item.hold then
		return 1
	elseif item.fadeOut > 0 then
		return math.max(0, 1 - (age - item.fadeIn - item.hold) / item.fadeOut)
	end

	return 0
end

function ArcadeSurvivorAfterimageShow:_setAlpha(item, alpha)
	self._alphaColor.a = alpha

	for _, part in ipairs(item.parts) do
		part.block:SetColor(MainColorId, self._alphaColor)
		part.renderer:SetPropertyBlock(part.block)
	end
end

function ArcadeSurvivorAfterimageShow:update()
	for _, emitter in pairs(self._emitters) do
		self:_sample(emitter)
	end

	local now = Time.time

	for i = #self._items, 1, -1 do
		local item = self._items[i]

		if now - item.startTime >= item.fadeIn + item.hold + item.fadeOut then
			self:_recycle(item)
			table.remove(self._items, i)
		else
			self:_setAlpha(item, ArcadeSurvivorAfterimageShow.getAlpha(item, now))
		end
	end
end

function ArcadeSurvivorAfterimageShow:_sample(emitter)
	local entity = emitter.entity

	if gohelper.isNil(entity.go) then
		self._emitters[entity] = nil

		return
	end

	local x, y = entity:getPosition(true)
	local dx, dy = x - emitter.x, y - emitter.y
	local distance = math.sqrt(dx * dx + dy * dy)

	if distance == 0 then
		return
	end

	local offset = emitter.spacing - emitter.remainder

	while offset <= distance + 1e-06 do
		local t = math.min(offset / distance, 1)

		self:_spawn(emitter, emitter.x + dx * t, emitter.y + dy * t)

		offset = offset + emitter.spacing
	end

	emitter.remainder = math.max(0, distance - (offset - emitter.spacing))
	emitter.x, emitter.y = x, y
end

function ArcadeSurvivorAfterimageShow:_recycle(item)
	gohelper.setActive(item.go, false)

	for _, part in ipairs(item.parts) do
		part.block:Clear()
		part.renderer:SetPropertyBlock(part.block)
	end

	local pool = self._pool[item.modelName]

	if not pool then
		pool = {}
		self._pool[item.modelName] = pool
	end

	pool[#pool + 1] = item
end

function ArcadeSurvivorAfterimageShow:stop(entity)
	local emitter = self._emitters[entity]

	if not emitter then
		return
	end

	self:_sample(emitter)

	self._emitters[entity] = nil
end

function ArcadeSurvivorAfterimageShow:clear()
	self._emitters = {}

	for _, item in ipairs(self._items) do
		gohelper.destroy(item.go)
	end

	for _, pool in pairs(self._pool) do
		for _, item in ipairs(pool) do
			gohelper.destroy(item.go)
		end
	end

	self._items = {}
	self._pool = {}
end

return ArcadeSurvivorAfterimageShow
