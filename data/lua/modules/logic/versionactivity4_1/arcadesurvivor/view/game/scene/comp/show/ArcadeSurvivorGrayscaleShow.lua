-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/scene/comp/show/ArcadeSurvivorGrayscaleShow.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.scene.comp.show.ArcadeSurvivorGrayscaleShow", package.seeall)

local ArcadeSurvivorGrayscaleShow = class("ArcadeSurvivorGrayscaleShow")

function ArcadeSurvivorGrayscaleShow:ctor()
	self._roots = {}
	self._rendererItemList = {}
	self._active = false
	self._owner = nil
	self._showId = nil
end

function ArcadeSurvivorGrayscaleShow:registerGO(go, excludeTrans)
	if gohelper.isNil(go) then
		return
	end

	self._roots[go] = excludeTrans or false

	if self._active then
		self:_applyGO(go, excludeTrans)
	end
end

function ArcadeSurvivorGrayscaleShow:_applyGO(go, excludeTrans)
	local renderers = go:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, renderers.Length - 1 do
		local renderer = renderers[i]

		if not self._rendererItemList[renderer] and (not excludeTrans or not renderer.transform:IsChildOf(excludeTrans)) then
			local original = renderer.sharedMaterials
			local materials = renderer.sharedMaterials
			local copies = {}

			for j = 0, materials.Length - 1 do
				local source = original[j]

				if not gohelper.isNil(source) then
					local material = self:_createMaterial(source)

					if material then
						materials[j] = material
						copies[#copies + 1] = material
					end
				end
			end

			if #copies > 0 then
				self._rendererItemList[renderer] = {
					root = go,
					original = original,
					copies = copies
				}
				renderer.sharedMaterials = materials
			end
		end
	end
end

function ArcadeSurvivorGrayscaleShow:_createMaterial(source)
	if source.shader.name ~= "shenlan/scene/unlit/unlit_layermode" then
		return
	end

	local material = UnityEngine.Material.New(source)

	material:DisableKeyword("_COVER")
	material:EnableKeyword("_GRAYSCALE")
	material:EnableKeyword("_USEGRAYSCALE")
	material:SetFloat("_LayerBlend", 22)
	material:SetFloat("_UseGrayScale", 1)
	material:SetFloat("_BlendSize", 1)

	local color = material:GetColor("_MainCol")
	local luminance = color.r * 0.2125 + color.g * 0.7154 + color.b * 0.0721

	material:SetColor("_MainCol", Color.New(luminance, luminance, luminance, color.a))

	return material
end

function ArcadeSurvivorGrayscaleShow:unregisterGO(go)
	self._roots[go] = nil

	for renderer, item in pairs(self._rendererItemList) do
		if item.root == go then
			self:_restore(renderer, item)
		end
	end
end

function ArcadeSurvivorGrayscaleShow:_restore(renderer, item)
	if not gohelper.isNil(renderer) then
		renderer.sharedMaterials = item.original
	end

	for _, material in ipairs(item.copies) do
		gohelper.destroy(material)
	end

	self._rendererItemList[renderer] = nil
end

function ArcadeSurvivorGrayscaleShow:setOwnerActive(active, ownerEntity, showId)
	if active then
		self._owner = ownerEntity
		self._showId = showId

		self:_setGrayscaleActive(true)
	elseif self._owner == ownerEntity and self._showId == showId then
		self:checkOwnerClear(ownerEntity)
	end
end

function ArcadeSurvivorGrayscaleShow:_setGrayscaleActive(active)
	if self._active == active then
		return
	end

	self._active = active

	if active then
		for go, excludeTrans in pairs(self._roots) do
			if gohelper.isNil(go) then
				self._roots[go] = nil
			else
				self:_applyGO(go, excludeTrans or nil)
			end
		end
	else
		for renderer, item in pairs(self._rendererItemList) do
			self:_restore(renderer, item)
		end
	end
end

function ArcadeSurvivorGrayscaleShow:getOriginalMaterials(renderer)
	local item = self._rendererItemList[renderer]

	return item and item.original or renderer.sharedMaterials
end

function ArcadeSurvivorGrayscaleShow:checkOwnerClear(entity)
	if self._owner ~= entity then
		return
	end

	self:_setGrayscaleActive(false)

	self._owner = nil
	self._showId = nil
end

function ArcadeSurvivorGrayscaleShow:deactivateGrayscale()
	self:checkOwnerClear(self._owner)
end

function ArcadeSurvivorGrayscaleShow:clear()
	self:deactivateGrayscale()

	self._roots = {}
end

return ArcadeSurvivorGrayscaleShow
