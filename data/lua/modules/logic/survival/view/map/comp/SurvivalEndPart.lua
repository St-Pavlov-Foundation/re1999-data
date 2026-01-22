-- chunkname: @modules/logic/survival/view/map/comp/SurvivalEndPart.lua

module("modules.logic.survival.view.map.comp.SurvivalEndPart", package.seeall)

local SurvivalEndPart = class("SurvivalEndPart", LuaCompBase)

function SurvivalEndPart:ctor(param)
	self.view = param.view
end

function SurvivalEndPart:init(go)
	self.go = go
	self.goDefaultBg = gohelper.findChild(go, "#simage_FullBG")
	self.goEndBg = gohelper.findChild(go, "#simage_FullBG2")
	self.simage_Character1 = gohelper.findChild(go, "#simage_Character1")
	self.simage_Character2 = gohelper.findChild(go, "#simage_Character2")
	self.simage_Character1_1 = gohelper.findChild(go, "#simage_Character1_1")
	self.simage_Character2_1 = gohelper.findChild(go, "##simage_Character2_1")
	self.txtDefaultTime = gohelper.findChildTextMesh(self.goDefaultBg, "image_LimitTimeBG/#txt_LimitTime")
	self.txtEndTime = gohelper.findChildTextMesh(self.goEndBg, "image_LimitTimeBG/#txt_LimitTime")
end

function SurvivalEndPart:refreshView()
	local outSideInfo = SurvivalModel.instance:getOutSideInfo()
	local haveRole1 = outSideInfo:isEndUnLock(3001)
	local haveRole2 = outSideInfo:isEndUnLock(3002)
	local isDefaultBg = not haveRole1 and not haveRole2
	local isEndBg = haveRole1 or haveRole2

	gohelper.setActive(self.goDefaultBg, isDefaultBg)
	gohelper.setActive(self.goEndBg, isEndBg)
	gohelper.setActive(self.simage_Character1, haveRole1)
	gohelper.setActive(self.simage_Character1_1, haveRole1)
	gohelper.setActive(self.simage_Character2, haveRole2)
	gohelper.setActive(self.simage_Character2_1, haveRole2)

	if isDefaultBg then
		self.view._txtLimitTime = self.txtDefaultTime
	elseif isEndBg then
		self.view._txtLimitTime = self.txtEndTime
	end
end

function SurvivalEndPart:onDestroy()
	return
end

return SurvivalEndPart
