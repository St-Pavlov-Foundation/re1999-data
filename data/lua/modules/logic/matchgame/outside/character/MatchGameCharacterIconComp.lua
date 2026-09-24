-- chunkname: @modules/logic/matchgame/outside/character/MatchGameCharacterIconComp.lua

module("modules.logic.matchgame.outside.character.MatchGameCharacterIconComp", package.seeall)

local MatchGameCharacterIconComp = class("MatchGameCharacterIconComp", LuaCompBase)

function MatchGameCharacterIconComp.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, MatchGameCharacterIconComp)
end

function MatchGameCharacterIconComp:init(go)
	self.go = go
	self._simageRole = gohelper.findChildSingleImage(self.go, "#image_CharacterIcon")
	self._imageRole = gohelper.findChildImage(self.go, "#image_CharacterIcon")
	self._uiMeshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.go, MatchGameFightRoleMesh)
end

function MatchGameCharacterIconComp:setData(characterId)
	self._characterCo = lua_activity244_character.configDict[characterId]
	self._iconUrl = self._characterCo and self._characterCo.image
	self._meshUrl = self._characterCo and self._characterCo.mesh

	self._simageRole:LoadImage(self._iconUrl, self.loadImageCallback, self)
	self._uiMeshComp:refreshMesh(self._meshUrl, false)
end

function MatchGameCharacterIconComp:loadImageCallback(w, h)
	if self._imageRole then
		self._imageRole:SetNativeSize()
	end
end

function MatchGameCharacterIconComp:onDestroy()
	return
end

return MatchGameCharacterIconComp
