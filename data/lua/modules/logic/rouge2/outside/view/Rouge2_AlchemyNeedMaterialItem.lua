-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemyNeedMaterialItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemyNeedMaterialItem", package.seeall)

local Rouge2_AlchemyNeedMaterialItem = class("Rouge2_AlchemyNeedMaterialItem", LuaCompBase)

function Rouge2_AlchemyNeedMaterialItem:init(go)
	self.go = go
	self._gounknown = gohelper.findChild(self.go, "#go_unknown")
	self._gohas = gohelper.findChild(self.go, "#go_has")
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._btnclick = gohelper.findChildButton(self.go, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AlchemyNeedMaterialItem:addEventListeners()
	self._btnclick:AddClickListener(self.onclick, self)
end

function Rouge2_AlchemyNeedMaterialItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function Rouge2_AlchemyNeedMaterialItem:onclick()
	local param = {}

	param.selectMaterialId = self.materialId

	Rouge2_OutsideController.instance:openMaterialListView(param)
end

function Rouge2_AlchemyNeedMaterialItem:_editableInitView()
	self._simageIcon = gohelper.findChildSingleImage(self.go, "#go_has/go_icon")
	self._txtnum = gohelper.findChildTextMesh(self.go, "#go_has/txt_num")
end

function Rouge2_AlchemyNeedMaterialItem:setInfo(materialId, needCount)
	self.materialId = materialId

	local isEmpty = materialId == nil

	gohelper.setActive(self._gounknown, isEmpty)
	gohelper.setActive(self._gohas, not isEmpty)

	if not isEmpty then
		Rouge2_IconHelper.setMaterialIcon(materialId, self._simageIcon)

		local showNum = needCount ~= nil

		gohelper.setActive(self._txtnum, showNum)

		if showNum then
			local haveCount = Rouge2_AlchemyModel.instance:getMaterialNum(materialId)
			local colorStr = needCount <= haveCount and Rouge2_OutsideEnum.MaterialNumColor.Enough or Rouge2_OutsideEnum.MaterialNumColor.NotEnough

			self._txtnum.text = string.format("<color=%s>%s</color>/%s", colorStr, haveCount, needCount)
		end
	end
end

function Rouge2_AlchemyNeedMaterialItem:onDestroy()
	return
end

return Rouge2_AlchemyNeedMaterialItem
