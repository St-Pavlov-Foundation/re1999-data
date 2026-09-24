-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightRoleMesh.lua

module("modules.logic.matchgame.fight.view.MatchGameFightRoleMesh", package.seeall)

local MatchGameFightRoleMesh = class("MatchGameFightRoleMesh", LuaCompBase)

function MatchGameFightRoleMesh:init(go)
	self.go = go
	self._uiMesh = gohelper.onceAddComponent(self.go, typeof(UIMesh))
end

function MatchGameFightRoleMesh:setIndependentMaterial()
	self.independent = true
end

function MatchGameFightRoleMesh:refreshMesh(meshUrl, isEnemy, params)
	if self._meshUrl == meshUrl then
		return
	end

	self._meshUrl = meshUrl
	self.isEnemy = isEnemy
	self.params = params
	self._materialUrl = AutoChessHelper.getMaterialUrl(isEnemy)

	self:loadMesh()
end

function MatchGameFightRoleMesh:loadMesh()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self.loader = MultiAbLoader.New()

	self.loader:addPath(self._meshUrl)
	self.loader:addPath(self._materialUrl)
	self.loader:startLoad(self.loadResFinish, self)
end

function MatchGameFightRoleMesh:loadResFinish()
	local assetItem = self.loader:getAssetItem(self._meshUrl)

	if assetItem then
		local meshAsset = assetItem:GetResource(self._meshUrl)

		self._uiMesh.mesh = meshAsset

		self._uiMesh:SetVerticesDirty()
	else
		gohelper.setActive(self._uiMesh, false)

		return
	end

	assetItem = self.loader:getAssetItem(self._materialUrl)

	if assetItem then
		local mat = assetItem:GetResource(self._materialUrl)

		if self.independent then
			self.matInst = UnityEngine.Object.Instantiate(mat)
			self._uiMesh.material = self.matInst
		else
			self._uiMesh.material = mat
		end

		self._uiMesh:SetMaterialDirty()
	end

	gohelper.setActive(self._uiMesh, true)
end

function MatchGameFightRoleMesh:onDestroy()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.independent then
		UnityEngine.Object.Destroy(self.matInst)
	end
end

return MatchGameFightRoleMesh
