﻿-- chunkname: @modules/logic/mainuiswitch/view/SwitchMainUIReddotIcon.lua

module("modules.logic.mainuiswitch.view.SwitchMainUIReddotIcon", package.seeall)

local SwitchMainUIReddotIcon = class("SwitchMainUIReddotIcon", ListScrollCell)

function SwitchMainUIReddotIcon:init(go)
	self.go = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, go)
	self._txtCount = gohelper.findChildText(self.go, "type2/#txt_count")
	self.typeGoDict = self:getUserDataTb_()

	for _, v in pairs(RedDotEnum.Style) do
		self.typeGoDict[v] = gohelper.findChild(self.go, "type" .. v)

		gohelper.setActive(self.typeGoDict[v], false)
	end
end

function SwitchMainUIReddotIcon:addEventListeners()
	MainUISwitchController.instance:registerCallback(MainUISwitchEvent.SwitchMainUI, self._onSwitchMainUI, self)
end

function SwitchMainUIReddotIcon:removeEventListeners()
	MainUISwitchController.instance:unregisterCallback(MainUISwitchEvent.SwitchMainUI, self._onSwitchMainUI, self)
end

function SwitchMainUIReddotIcon:_onSwitchMainUI(id)
	self._curMainUIId = id

	self:defaultRefreshDot()
end

function SwitchMainUIReddotIcon:setId(id, uid, skinId)
	self:setMultiId({
		{
			id = id,
			uid = uid
		}
	})

	self._curMainUIId = skinId
end

function SwitchMainUIReddotIcon:setMultiId(infoList)
	self.infoDict = {}

	if infoList then
		for i, info in ipairs(infoList) do
			info.uid = info.uid or 0
			self.infoDict[info.id] = info.uid
		end
	end

	self.infoList = infoList
end

function SwitchMainUIReddotIcon:defaultRefreshDot()
	self.show = false

	if self.infoList then
		for i, info in ipairs(self.infoList) do
			self.show = RedDotModel.instance:isDotShow(info.id, info.uid)

			if self.show then
				local count = RedDotModel.instance:getDotInfoCount(info.id, info.uid)

				self._txtCount.text = count

				local type = RedDotConfig.instance:getRedDotCO(info.id).style
				local switchReddotCo = MainUISwitchConfig.instance:getUIReddotStyle(self._curMainUIId, info.id)

				if switchReddotCo then
					type = switchReddotCo.style
				end

				self:showRedDot(type)

				return
			end
		end
	end
end

function SwitchMainUIReddotIcon:showRedDot(type)
	gohelper.setActive(self.go, self.show)

	if self.show then
		for _, v in pairs(RedDotEnum.Style) do
			gohelper.setActive(self.typeGoDict[v], type == v)
		end
	end
end

return SwitchMainUIReddotIcon
