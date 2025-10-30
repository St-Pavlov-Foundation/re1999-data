-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillBoxView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillBoxView", package.seeall)

local Rouge2_BackpackSkillBoxView = class("Rouge2_BackpackSkillBoxView", BaseView)

function Rouge2_BackpackSkillBoxView:onInitView()
	self._goCapacity = gohelper.findChild(self.viewGO, "SkillPanel/Capacity")
	self._goCapacity2 = gohelper.findChild(self.viewGO, "SkilleditPanel/SkillPanel/Capacity")
	self._btnBox = gohelper.findChildButtonWithAudio(self.viewGO, "SkillPanel/#btn_box")
	self._txtProgress = gohelper.findChildText(self.viewGO, "SkillPanel/#btn_box/#txt_progress")
	self._goBoxReddot = gohelper.findChild(self.viewGO, "SkillPanel/#btn_box/#go_boxreddot")
	self._goCanGet = gohelper.findChild(self.viewGO, "SkillPanel/#btn_box/#canget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackSkillBoxView:addEvents()
	self._btnBox:AddClickListener(self._btnBoxOnClick, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
end

function Rouge2_BackpackSkillBoxView:removeEvents()
	self._btnBox:RemoveClickListener()
end

function Rouge2_BackpackSkillBoxView:_btnBoxOnClick()
	ViewMgr.instance:openView(ViewName.Rouge2_BackpackBoxTipsView)
end

function Rouge2_BackpackSkillBoxView:_editableInitView()
	gohelper.setActive(self._btnBox, false)
	RedDotController.instance:addRedDot(self._goBoxReddot, RedDotEnum.DotNode.Rouge2BXSBox)
end

function Rouge2_BackpackSkillBoxView:onOpen()
	self:refreshUI()
end

function Rouge2_BackpackSkillBoxView:refreshUI()
	self._isFit = Rouge2_Model.instance:isUseBXSCareer()

	gohelper.setActive(self._goCapacity, not self._isFit)
	gohelper.setActive(self._goCapacity2, not self._isFit)
	self:refreshBox()
end

function Rouge2_BackpackSkillBoxView:refreshBox()
	gohelper.setActive(self._btnBox.gameObject, self._isFit)

	if not self._isFit then
		return
	end

	local curPoint = Rouge2_BackpackModel.instance:getCurBoxPoint()
	local maxPoint = Rouge2_MapConfig.instance:BXSMaxBoxPoint()

	self._txtProgress.text = string.format("%s/%s", curPoint, maxPoint)

	gohelper.setActive(self._goCanGet, maxPoint <= curPoint)
end

function Rouge2_BackpackSkillBoxView:_onUpdateRougeInfo()
	self:refreshUI()
end

return Rouge2_BackpackSkillBoxView
