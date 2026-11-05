-- chunkname: @modules/logic/versionactivity4_1/peishita/view/comp/PeiShiTaCellComp.lua

module("modules.logic.versionactivity4_1.peishita.view.comp.PeiShiTaCellComp", package.seeall)

local PeiShiTaCellComp = class("PeiShiTaCellComp", LuaCompBase)

function PeiShiTaCellComp:init(go)
	self.go = go
	self.transform = go.transform
	self._image = gohelper.onceAddComponent(go, gohelper.Type_Image)
	self._animator = gohelper.onceAddComponent(go, gohelper.Type_Animator)
	self._animator.keepAnimatorStateOnDisable = true
end

function PeiShiTaCellComp:setUnitData(x, y)
	self._cellX = x
	self._cellY = y

	local localX, localY = PeiShiTaGameHelper.gridToLocalPos(x, y)

	recthelper.setAnchor(self.transform, localX, localY)
end

function PeiShiTaCellComp:refreshColor(cellTypeMap)
	local cellType = cellTypeMap[PeiShiTaCellHelper.cellKey(self._cellX, self._cellY)] or PeiShiTaEnum.CellType.Default
	local iconName = PeiShiTaEnum.CellTypeIcon[cellType] or PeiShiTaEnum.CellTypeIcon[PeiShiTaEnum.CellType.Default]

	UISpriteSetMgr.instance:setV4a1PeiShiTaSprite(self._image, iconName)

	local animName = cellType == PeiShiTaEnum.CellType.Default and "idle" or "celltemplate_loop"

	self._animator:Play(animName, 0, 0)
end

function PeiShiTaCellComp:onDestroy()
	return
end

return PeiShiTaCellComp
