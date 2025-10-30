-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapEntrustInfoItem.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapEntrustInfoItem", package.seeall)

local Rouge2_MapEntrustInfoItem = class("Rouge2_MapEntrustInfoItem", LuaCompBase)

function Rouge2_MapEntrustInfoItem:init(go)
	self.go = go
	self._txtdesc = gohelper.findChildText(self.go, "txt_desc")
	self._txtdesc2 = gohelper.findChildText(self.go, "txt_desc2")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
end

function Rouge2_MapEntrustInfoItem:onUpdateMO(index, entrustMo)
	self._index = index
	self._entrustMo = entrustMo
	self._entrustId = entrustMo:getEntrustId()
	self._entrustCo = lua_rouge2_entrust.configDict[self._entrustId]
	self._txtdesc.text = Rouge2_MapEntrustHelper.getEntrustDesc(self._entrustMo) or ""
	self._txtdesc2.text = Rouge2_MapEntrustHelper.getEntrustDesc(self._entrustMo) or ""

	local isFinish = Rouge2_MapModel.instance:isEntrustFinish(self._entrustId)

	gohelper.setActive(self._txtdesc.gameObject, not isFinish)
	gohelper.setActive(self._txtdesc2.gameObject, isFinish)

	local animName = isFinish and "finish" or "normal"

	self._animator:Play(animName, 0, 0)
end

return Rouge2_MapEntrustInfoItem
