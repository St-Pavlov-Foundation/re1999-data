-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayHpItem.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayHpItem", package.seeall)

local GuessGameNewPlayHpItem = class("GuessGameNewPlayHpItem", LuaCompBase)

function GuessGameNewPlayHpItem:init(go, index, roleType)
	self.go = go
	self._index = index
	self._roleType = roleType
	self._golight = gohelper.findChild(self.go, "light")

	gohelper.setActive(self.go, true)
end

function GuessGameNewPlayHpItem:refresh()
	gohelper.setActive(self.go, true)

	self._roleMo = GuessGameNewModel.instance:getRoleData(self._roleType)

	gohelper.setActive(self._golight, self._roleMo.hp >= self._index)
end

function GuessGameNewPlayHpItem:destroy()
	return
end

return GuessGameNewPlayHpItem
