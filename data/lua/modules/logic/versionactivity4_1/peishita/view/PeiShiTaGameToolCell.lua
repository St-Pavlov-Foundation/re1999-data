-- chunkname: @modules/logic/versionactivity4_1/peishita/view/PeiShiTaGameToolCell.lua

module("modules.logic.versionactivity4_1.peishita.view.PeiShiTaGameToolCell", package.seeall)

local PeiShiTaGameToolCell = class("PeiShiTaGameToolCell", ListScrollCellExtend)

function PeiShiTaGameToolCell:onInitView()
	self._goLight = gohelper.findChild(self.viewGO, "#go_Light")
	self._goDisable = gohelper.findChild(self.viewGO, "#go_Disable")
	self._imageIcon1 = gohelper.findChildImage(self.viewGO, "#go_Light/#image_Icon")
	self._imageIcon2 = gohelper.findChildImage(self.viewGO, "#go_Disable/#image_Icon")
	self._txtCount = gohelper.findChildText(self.viewGO, "#txt_Count")
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PeiShiTaGameToolCell:addEvents()
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnToolChanged, self._onToolChanged, self)
end

function PeiShiTaGameToolCell:removeEvents()
	return
end

function PeiShiTaGameToolCell:_editableInitView()
	return
end

function PeiShiTaGameToolCell:onDestroyView()
	return
end

function PeiShiTaGameToolCell:onUpdateMO(config)
	self._config = config

	local toolId = config.id

	self._toolId = toolId

	self:refreshUI()
end

function PeiShiTaGameToolCell:refreshUI()
	local curCount = PeiShiTaGameModel.instance:getToolCount(self._toolId)

	self._lastCount = self._count or curCount
	self._count = curCount
	self._isAddTool = self._count > self._lastCount

	gohelper.setActive(self._goLight, self._count > 0)
	gohelper.setActive(self._goDisable, self._count <= 0)
	UISpriteSetMgr.instance:setV4a1PeiShiTaSprite(self._imageIcon1, self._config.icon)
	UISpriteSetMgr.instance:setV4a1PeiShiTaSprite(self._imageIcon2, self._config.icon)

	self._txtCount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), self._count)

	local animName = self._isAddTool and "get" or "idle"

	self._animator:Play(animName, 0, 0)
end

function PeiShiTaGameToolCell:_onToolChanged(toolId)
	if self._toolId ~= toolId then
		return
	end

	self:refreshUI()
end

return PeiShiTaGameToolCell
