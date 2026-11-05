-- chunkname: @modules/logic/versionactivity4_1/evelyn/view/EvelynNodeItem.lua

module("modules.logic.versionactivity4_1.evelyn.view.EvelynNodeItem", package.seeall)

local EvelynNodeItem = class("EvelynNodeItem", LuaCompBase)

function EvelynNodeItem:init(go)
	self.viewGO = go
	self.transform = go.transform
end

function EvelynNodeItem:setNodeCo(nodeCo)
	self._nodeCo = nodeCo
	self._goLinkL = nil
	self._goLinkR = nil

	self:_refreshView()
end

function EvelynNodeItem:getLinkGoL()
	return self._goLinkL
end

function EvelynNodeItem:getLinkGoR()
	return self._goLinkR
end

function EvelynNodeItem:_refreshView()
	local nodeCo = self._nodeCo

	if not nodeCo then
		return
	end

	local pointType = EvelynEnum.PointType

	if nodeCo.type == pointType.Tool then
		self._txtName = gohelper.findChildText(self.viewGO, "root/has/#txt_tools")

		self:_setNodeIcon(gohelper.findChildImage(self.viewGO, "root/has/#txt_tools/#image_icon"))

		self._goLinkL = gohelper.findChild(self.viewGO, "root/has/#go_linkpointL")
		self._goLinkR = gohelper.findChild(self.viewGO, "root/has/#go_linkpointR")

		gohelper.setActive(self._goLinkL, true)
		gohelper.setActive(self._goLinkR, true)

		self._goHighLight = gohelper.findChild(self.viewGO, "root/has/#go_linkLight")

		gohelper.setActive(self._goHighLight, false)

		self._goSelect = gohelper.findChild(self.viewGO, "root/#go_Select")

		gohelper.setActive(self._goSelect, false)
	elseif nodeCo.type == pointType.Origin then
		gohelper.setActive(gohelper.findChild(self.viewGO, "root/#go_HighLight"), false)
		gohelper.setActive(gohelper.findChild(self.viewGO, "root/#go_Select"), false)

		self._txtName = gohelper.findChildText(self.viewGO, "root/#go_Normal/#txt_name")

		self:_setNodeIcon(gohelper.findChildImage(self.viewGO, "root/#go_Normal/#image_icon"))

		self._goLinkR = gohelper.findChild(self.viewGO, "root/#go_Normal/#go_linkLiftRight")
		self._goDetail = gohelper.findChild(self.viewGO, "root/#go_Detail")
		self._txtDetail = gohelper.findChildText(self.viewGO, "root/#go_Detail/go_scroll/viewport/content/#txt_Detail")

		gohelper.setActive(self._goDetail, false)
	elseif nodeCo.type == pointType.Res then
		gohelper.setActive(gohelper.findChild(self.viewGO, "root/#go_HighLight"), false)

		self._txtName = gohelper.findChildText(self.viewGO, "root/#go_Normal/#txt_ending")
		self._goLinkL = gohelper.findChild(self.viewGO, "root/#go_Normal/#go_linkLeft")
		self._goLinkR = gohelper.findChild(self.viewGO, "root/#go_Normal/#go_linkRight")

		gohelper.setActive(self._goLinkL, false)
		gohelper.setActive(self._goLinkR, false)

		self._goSelect = gohelper.findChild(self.viewGO, "root/#go_Select")

		gohelper.setActive(self._goSelect, false)
	elseif nodeCo.type == pointType.End then
		self._txtName = gohelper.findChildText(self.viewGO, "root/txt_truth")
		self._goLinkL = gohelper.findChild(self.viewGO, "root/#go_linkLeft")
		self._goHighLight = gohelper.findChild(self.viewGO, "root/#go_HighLight")

		gohelper.setActive(self._goHighLight, false)

		self._goSelect = gohelper.findChild(self.viewGO, "root/#go_Select")

		gohelper.setActive(self._goSelect, false)
	end

	if self._txtName then
		self._txtName.text = nodeCo.name
	end
end

function EvelynNodeItem:hideLinkR()
	local nodeCo = self._nodeCo

	if not nodeCo then
		return
	end

	local pointType = EvelynEnum.PointType

	if nodeCo.type == pointType.Tool then
		gohelper.setActive(gohelper.findChild(self.viewGO, "root/has/#go_linkpointR"), false)
	elseif nodeCo.type == pointType.Res then
		gohelper.setActive(gohelper.findChild(self.viewGO, "root/#go_Normal/#go_linkRight"), false)
	end

	self._goLinkR = nil
end

function EvelynNodeItem:_setNodeIcon(imageIcon)
	if not imageIcon then
		return
	end

	local showImage = not string.nilorempty(self._nodeCo.icon)

	gohelper.setActive(imageIcon, showImage)

	if showImage then
		UISpriteSetMgr.instance:setV4a1YifulinSprite(imageIcon, self._nodeCo.icon)
	end
end

return EvelynNodeItem
