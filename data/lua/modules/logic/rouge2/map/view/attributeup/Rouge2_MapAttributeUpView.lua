-- chunkname: @modules/logic/rouge2/map/view/attributeup/Rouge2_MapAttributeUpView.lua

module("modules.logic.rouge2.map.view.attributeup.Rouge2_MapAttributeUpView", package.seeall)

local Rouge2_MapAttributeUpView = class("Rouge2_MapAttributeUpView", BaseView)
local DefalutSelectIndex = 1
local AddAttributeDuration = 1
local SpecialAddAttrDuration = 3
local DelayPlayAttrUpAnim = 0.1
local DelayDoneAttrUpAnim = 1
local DelayCheckAttrUpAnim = 0.2

function Rouge2_MapAttributeUpView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goAttributeMapPos = gohelper.findChild(self.viewGO, "#go_Root/#go_AttributeMapPos")
	self._goContainer = gohelper.findChild(self.viewGO, "#go_Root/#go_Container")
	self._imageAttributeIcon = gohelper.findChildImage(self.viewGO, "#go_Root/#go_Container/Base/#image_AttributeIcon")
	self._txtAttributeName = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_AttributeName")
	self._txtWorldDesc = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_worldDesc")
	self._txtCurAttribute = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_CurAttribute")
	self._txtNextAttribute = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_NextAttribute")
	self._goToast = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Base/#go_Toast")
	self._txtCurAttribute2 = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#go_Toast/#txt_CurAttribute")
	self._txtNextAttribute2 = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#go_Toast/#txt_NextAttribute")
	self._goCurviewContent = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_CurviewList")
	self._goCurviewItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_CurviewList/#go_CurviewItem")
	self._scrollPreview = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#go_Container/#scroll_Preview")
	self._goPreviewContent = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_Preview/#go_PreviewList")
	self._goPreviewItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_Preview/#go_PreviewList/#go_PreviewItem")
	self._txtRemainAttribute = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Remain/#txt_RemainAttribute")
	self._goRemain = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Remain")
	self._btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_Container/Remain/#btn_Add", AudioEnum.Rouge2.AddAttr)
	self._imageAttributeIcon2 = gohelper.findChildImage(self.viewGO, "#go_Root/#go_Container/Remain/#btn_Add/#image_AttributeIcon")
	self._txtUp = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Remain/#btn_Add/#txt_Up")
	self._goPassiveSkill = gohelper.findChild(self.viewGO, "#go_Root/#go_PassiveSkill")
	self._txtPassiveDesc = gohelper.findChildText(self.viewGO, "#go_Root/#go_PassiveSkill/#txt_PassiveDesc")
	self._goToastContainer = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer")
	self._goBigToast = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer/#go_BigToast")
	self._txtBigToast = gohelper.findChildText(self.viewGO, "#go_Root/#go_ToastContainer/#go_BigToast/root/#txt_BigToast")
	self._goToastList = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer/#go_ToastList")
	self._goToastItem = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer/#go_ToastList/#go_ToastItem")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")
	self._goBlock = gohelper.findChild(self.viewGO, "#go_Root/#go_Block")
	self._goEffectTips = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Base/#go_effectTips")
	self._txtEffect = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#go_effectTips/#txt_effect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapAttributeUpView:addEvents()
	self._btnAdd:AddClickListener(self._btnAddOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateAttrInfo, self._onUpdateAttrInfo, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSelectCareerAttribute, self._onSelectCareerAttribute, self)
end

function Rouge2_MapAttributeUpView:removeEvents()
	self._btnAdd:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function Rouge2_MapAttributeUpView:_btnAddOnClick()
	if not self._addAttrPoint or self._addAttrPoint <= 0 or not self._selectAttrId then
		return
	end

	self._isPlayingLightAnim = true

	self._remainAnimator:Play("light", self._onLightAnimDone, self)

	self._waitRpc = true

	Rouge2_Rpc.instance:sendRouge2AddCareerAttrPointRequest(self._selectAttrId, Rouge2_MapEnum.AddAttrStep, function(__, resultCode)
		if resultCode ~= 0 then
			return
		end

		self._waitRpc = false
		self._addAttrPoint = self._addAttrPoint - Rouge2_MapEnum.AddAttrStep

		self:_onUpdateAttributeInfo()
	end)
end

function Rouge2_MapAttributeUpView:_onLightAnimDone()
	self._isPlayingLightAnim = false

	self:refreshFreeUI()
end

function Rouge2_MapAttributeUpView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_MapAttributeUpView:_editableInitView()
	local goAttributeMap = self:getResInst(Rouge2_Enum.ResPath.AttributeMap, self._goAttributeMapPos)

	self._comAttrMap = Rouge2_CareerAttributeMap.Get(goAttributeMap, Rouge2_Enum.AttrMapUsage.MapAttributeUpView)

	self._comAttrMap:setCanClickDetail(false)

	self._remainAnimator = SLFramework.AnimatorPlayer.Get(self._goRemain)
	self._addAttrPoint = 0
	self._first = true

	gohelper.setActive(self._goBlock, false)
	gohelper.setActive(self._goToast, false)
	gohelper.setActive(self._goPassiveSkill, false)
	gohelper.setActive(self._goToastContainer, false)
	gohelper.setActive(self._btnClose.gameObject, false)
	self:initCustomAttrList()
end

function Rouge2_MapAttributeUpView:onUpdateParam()
	return
end

function Rouge2_MapAttributeUpView:onOpen()
	self._careerId = Rouge2_Model.instance:getCareerId()

	self:initInfo()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:initInfo()
	self._addAttrPoint = self.viewParam and self.viewParam.addAttrPoint or 0

	self:initCustomAttrValue()
	self:initAttrMap()
	self:buildAttrUpFlow()
end

function Rouge2_MapAttributeUpView:initCustomAttrList()
	local curAttrList = Rouge2_Model.instance:getAttrInfoList(Rouge2_MapEnum.AttrType.CareerAttr)

	self._customAttrList = {}
	self._customAttrMap = {}

	for _, attributeMo in ipairs(curAttrList) do
		local customAttrMo = tabletool.copy(attributeMo)
		local attrId = customAttrMo.attrId

		self._customAttrMap[attrId] = customAttrMo

		table.insert(self._customAttrList, customAttrMo)
	end
end

function Rouge2_MapAttributeUpView:initCustomAttrValue()
	local updateAttrMap = Rouge2_Model.instance:getUpdateAttrMap() or {}

	self._updateAttrMap = tabletool.copy(updateAttrMap)
	self._show = self._addAttrPoint > 0
	self._hasUpdateAttr = false

	for attrId, updateValue in pairs(self._updateAttrMap) do
		if self._customAttrMap[attrId] then
			local customAttrValue = self._customAttrMap[attrId].value

			self._customAttrMap[attrId].value = customAttrValue - updateValue
			self._hasUpdateAttr = self._hasUpdateAttr or updateValue > 0
			self._show = self._show or self._hasUpdateAttr
		end
	end

	Rouge2_Model.instance:clearUpdateAttrMap()
end

function Rouge2_MapAttributeUpView:initAttrMap()
	self._comAttrMap:onUpdateMO(self._careerId, Rouge2_Enum.AttributeData.Custom, self._customAttrList)

	if not self._comAttrMap:getCurSelectAttrId() then
		self._comAttrMap:selectAttribute(DefalutSelectIndex)
	end
end

function Rouge2_MapAttributeUpView:buildAttrUpFlow()
	if not self._show then
		self:destroyFlow()
		self:closeThis()

		return
	end

	if not self._hasUpdateAttr then
		return
	end

	self:destroyFlow()
	self:_lockScreen(true)
	gohelper.setActive(self._btnClose.gameObject, false)

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._lockScreen, self, true))
	self._flow:addWork(FunctionWork.New(self._selectFirstAttr, self))
	self._flow:addWork(WorkWaitSeconds.New(self._first and DelayPlayAttrUpAnim or 0))

	for _, attrMo in ipairs(self._customAttrList) do
		self:_buildUpAttributeFlow(self._flow, attrMo)
	end

	local waitSec = self._addAttrPoint > 0 and DelayCheckAttrUpAnim or DelayDoneAttrUpAnim

	self._flow:addWork(WorkWaitSeconds.New(waitSec))
	self._flow:addWork(FunctionWork.New(self._lockScreen, self, false))
	self._flow:registerDoneListener(self._onAttrUpFlowDone, self)
	self._flow:start()

	self._first = false
end

function Rouge2_MapAttributeUpView:_selectFirstAttr()
	for _, attrMo in ipairs(self._customAttrList) do
		self._comAttrMap:selectAttributeById(attrMo.attrId)

		return
	end
end

function Rouge2_MapAttributeUpView:_buildUpAttributeFlow(flow, customAttrMo)
	local attrId = customAttrMo.attrId
	local update = self._updateAttrMap[attrId] or 0

	if update == 0 then
		return
	end

	local from = customAttrMo.value or 0
	local to = from + update

	for i = from + 1, to do
		local skillCo = Rouge2_AttributeConfig.instance:getPassiveSkillCo(self._careerId, self._selectAttrId, i)
		local isSpecial = skillCo and skillCo.isSpecial ~= 0
		local params = {
			type = "DOTweenFloat",
			from = i - 1,
			to = i,
			t = isSpecial and SpecialAddAttrDuration or AddAttributeDuration,
			frameCb = self._attrValueFrameCallback,
			cbObj = self,
			param = attrId
		}
		local stepFlow = FlowSequence.New()

		stepFlow:addWork(FunctionWork.New(self._comAttrMap.selectAttributeById, self._comAttrMap, attrId))
		stepFlow:addWork(TweenWork.New(params))
		stepFlow:addWork(FunctionWork.New(self._hideAllToast, self))
		flow:addWork(stepFlow)
	end
end

function Rouge2_MapAttributeUpView:_attrValueFrameCallback(value, attrId)
	local resultValue = math.ceil(value)
	local curAttrValue = self._customAttrMap[attrId].value

	if not curAttrValue or curAttrValue == resultValue then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Rouge2.AttrUp)

	self._customAttrMap[attrId].value = resultValue

	self._comAttrMap:onUpdateMO(self._careerId, Rouge2_Enum.AttributeData.Custom, self._customAttrList)
	self:updateSelectInfo()
	self:checkPassiveSkill()
	self:checkLevelupToast()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:_onAttrUpFlowDone()
	self._updateAttrMap = {}

	gohelper.setActive(self._btnClose.gameObject, self._addAttrPoint <= 0)
	self:_hideAllToast()
	self:_onUpdateAttributeInfo()
end

function Rouge2_MapAttributeUpView:_hideAllToast()
	gohelper.setActive(self._goToast, false)
	gohelper.setActive(self._goPassiveSkill, false)
	gohelper.setActive(self._goToastContainer, false)
end

function Rouge2_MapAttributeUpView:destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function Rouge2_MapAttributeUpView:_onSelectCareerAttribute(attrId)
	self._selectAttrId = attrId

	self:updateSelectInfo()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:refreshUI()
	self:refreshSelectUI()
	self:refreshFreeUI()
end

function Rouge2_MapAttributeUpView:updateSelectInfo()
	if not self._selectAttrId or not self._customAttrMap[self._selectAttrId] then
		return
	end

	self._selectAttrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._selectAttrId)
	self._curAttrValue = self._customAttrMap and self._customAttrMap[self._selectAttrId].value or 0
	self._nextAttributeValue = self._curAttrValue + Rouge2_MapEnum.AddAttrStep
	self._selectPassiveSkillCo = Rouge2_AttributeConfig.instance:getPassiveSkillCo(self._careerId, self._selectAttrId, self._curAttrValue)
	self._nextSpAttr, self._nextSpSkillCo = Rouge2_AttributeConfig.instance:getNextSpPassiveSkill(self._careerId, self._selectAttrId, self._curAttrValue)
	self._nextSpSkillDesc = self._nextSpSkillCo and self._nextSpSkillCo.imLevelUpDesc or ""
end

function Rouge2_MapAttributeUpView:refreshSelectUI()
	gohelper.setActive(self._goContainer, self._selectAttrId and self._selectAttrId ~= 0)

	if not self._selectAttrId then
		return
	end

	self._txtAttributeName.text = self._selectAttrCo and self._selectAttrCo.name
	self._txtWorldDesc.text = self._selectAttrCo and self._selectAttrCo.careerDesc
	self._txtCurAttribute.text = self._curAttrValue
	self._txtCurAttribute2.text = self._curAttrValue
	self._txtNextAttribute.text = self._nextAttributeValue
	self._txtNextAttribute2.text = self._nextAttributeValue
	self._txtEffect.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("rouge2_effecttips"), self._nextSpAttr, self._selectAttrCo.name, self._nextSpSkillDesc)

	local effectDescList = Rouge2_AttributeConfig.instance:getPassiveSkillDescList(self._careerId, self._selectAttrId, self._nextAttributeValue)

	gohelper.CreateObjList(self, self._refreshNextAttrEffectDesc, effectDescList, self._goPreviewContent, self._goPreviewItem)

	local curEffectDescList = Rouge2_AttributeConfig.instance:getPassiveSkillDescList(self._careerId, self._selectAttrId, self._curAttrValue)

	gohelper.CreateObjList(self, self._refreshCurAttrEffectDesc, curEffectDescList, self._goCurviewContent, self._goCurviewItem)
	Rouge2_IconHelper.setAttributeIcon(self._selectAttrId, self._imageAttributeIcon)
	Rouge2_IconHelper.setAttributeIcon(self._selectAttrId, self._imageAttributeIcon2)
end

function Rouge2_MapAttributeUpView:_refreshNextAttrEffectDesc(obj, desc, index)
	local txtEffect = gohelper.findChildText(obj, "txt_Effect")

	txtEffect.text = SkillHelper.buildDesc(desc)
end

function Rouge2_MapAttributeUpView:_refreshCurAttrEffectDesc(obj, desc, index)
	local txtEffect = gohelper.findChildText(obj, "txt_Effect")

	txtEffect.text = SkillHelper.buildDesc(desc)
end

function Rouge2_MapAttributeUpView:refreshFreeUI()
	gohelper.setActive(self._goRemain, self._addAttrPoint > 0 or self._isPlayingLightAnim)

	self._txtRemainAttribute.text = self._addAttrPoint
	self._txtUp.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_attributeupview_up"), Rouge2_MapEnum.AddAttrStep)
end

function Rouge2_MapAttributeUpView:checkLevelupToast()
	local levelUpDesc = self._selectPassiveSkillCo and self._selectPassiveSkillCo.levelUpDesc
	local hasDesc = not string.nilorempty(levelUpDesc)

	gohelper.setActive(self._goToastContainer, hasDesc)

	if not hasDesc then
		return
	end

	local descList = string.split(levelUpDesc, "|")
	local bigDesc = descList and descList[1]
	local hasBigToast = not string.nilorempty(bigDesc)

	gohelper.setActive(self._goBigToast, hasBigToast)

	if hasBigToast then
		self._txtBigToast.text = bigDesc
	end

	local smallDescList = {}

	for i = 2, descList and #descList do
		table.insert(smallDescList, descList[i])
	end

	gohelper.CreateObjList(self, self._refreshLevelUpDesc, smallDescList, self._goToastList, self._goToastItem)
end

function Rouge2_MapAttributeUpView:_refreshLevelUpDesc(obj, desc, index)
	local txtToast = gohelper.findChildText(obj, "root/txt_Toast")

	txtToast.text = desc
end

function Rouge2_MapAttributeUpView:checkPassiveSkill()
	local isSpecial = self._selectPassiveSkillCo and self._selectPassiveSkillCo.isSpecial ~= 0

	gohelper.setActive(self._goToast, true)
	gohelper.setActive(self._goPassiveSkill, isSpecial)

	if not isSpecial then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Rouge2.FeatureUp)

	self._txtPassiveDesc.text = self._selectPassiveSkillCo.imLevelUpDesc
end

function Rouge2_MapAttributeUpView:_onUpdateAttrInfo()
	self:_onUpdateAttributeInfo()
end

function Rouge2_MapAttributeUpView:_onUpdateAttributeInfo()
	if self._waitRpc or self._flow and self._flow.status == WorkStatus.Running then
		return
	end

	self:initCustomAttrList()
	self:initCustomAttrValue()
	self:buildAttrUpFlow()
	self:updateSelectInfo()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:_lockScreen(lock)
	gohelper.setActive(self._goBlock, lock)
end

function Rouge2_MapAttributeUpView:onClose()
	self:_lockScreen(false)
	self:destroyFlow()
end

function Rouge2_MapAttributeUpView:onDestroyView()
	return
end

return Rouge2_MapAttributeUpView
