-- chunkname: @modules/logic/versionactivity4_1/peishita/view/comp/PeiShiTaUnitComp.lua

module("modules.logic.versionactivity4_1.peishita.view.comp.PeiShiTaUnitComp", package.seeall)

local PeiShiTaUnitComp = class("PeiShiTaUnitComp", LuaCompBase)

function PeiShiTaUnitComp:init(go)
	self.go = go
	self.transform = go.transform
	self._imageIcon = gohelper.findChildImage(go, "#image_Icon")
	self._tranIcon = self._imageIcon.transform
	self._animator = SLFramework.AnimatorPlayer.Get(go)
	self._animComp = gohelper.onceAddComponent(go, gohelper.Type_Animator)
	self._inUse = false
end

function PeiShiTaUnitComp:setUnitData(gameMo, unit)
	self:resetState()

	self._inUse = true
	self._gameMo = gameMo
	self._unit = unit
	self._id = unit.id
	self._config = unit.config
	self._unitId = unit.config.id
	self._unitType = unit.config.type
	self._unitX = unit.pos.x
	self._unitY = unit.pos.y

	self:playOpenAnim()
	self:refreshUI()
end

function PeiShiTaUnitComp:resetState()
	return
end

function PeiShiTaUnitComp:playOpenAnim()
	self._animator:Play("idle", nil, nil)
end

function PeiShiTaUnitComp:refreshUI()
	self:_refreshIcon()
	self:_refreshPos()
end

function PeiShiTaUnitComp:_retire()
	self:_reallyRetire()
end

function PeiShiTaUnitComp:_reallyRetire()
	self._inUse = false

	gohelper.setActive(self.go, false)
	PeiShiTaGameController.instance:dispatchEvent(PeiShiTaEvent.OnUnitDieDone, self._id)
end

function PeiShiTaUnitComp:_refreshIcon()
	local resName = self._config and self._config.resName

	UISpriteSetMgr.instance:setV4a1PeiShiTaSprite(self._imageIcon, resName, true)
end

function PeiShiTaUnitComp:_getGridPos()
	return self._unit.pos.x, self._unit.pos.y
end

function PeiShiTaUnitComp:_refreshPos()
	local localX, localY = PeiShiTaGameHelper.gridToLocalPos(self._unit.pos.x, self._unit.pos.y)

	recthelper.setAnchor(self.transform, localX, localY)
end

function PeiShiTaUnitComp:onDestroy()
	return
end

return PeiShiTaUnitComp
