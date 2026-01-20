-- chunkname: @modules/logic/partycloth/view/PartyClothView.lua

module("modules.logic.partycloth.view.PartyClothView", package.seeall)

local PartyClothView = class("PartyClothView", BaseView)

function PartyClothView:onInitView()
	self._goUI = gohelper.findChild(self.viewGO, "#go_UI")
	self._btnHideUI = gohelper.findChildButtonWithAudio(self.viewGO, "#go_UI/Left/#btn_HideUI")
	self._btnLottery = gohelper.findChildButtonWithAudio(self.viewGO, "#go_UI/Left/#btn_Lottery")
	self._btnWear = gohelper.findChildButtonWithAudio(self.viewGO, "#go_UI/Left/#btn_Wear")
	self._goHasWear = gohelper.findChild(self.viewGO, "#go_UI/Left/#go_HasWear")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_UI/Right/Title/#txt_Title")
	self._txtTitle1 = gohelper.findChildText(self.viewGO, "#go_UI/Right/Title/Image_Dec/#txt_Title1")
	self._scrollCloth = gohelper.findChildScrollRect(self.viewGO, "#go_UI/Right/#scroll_Cloth")
	self._scrollSuit = gohelper.findChildScrollRect(self.viewGO, "#go_UI/Right/#scroll_Suit")
	self._btnRare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_UI/Right/#btn_Rare")
	self._goArrowUp = gohelper.findChild(self.viewGO, "#go_UI/Right/#btn_Rare/#go_ArrowUp")
	self._goArrowDown = gohelper.findChild(self.viewGO, "#go_UI/Right/#btn_Rare/#go_ArrowDown")
	self._goSwitchBtns = gohelper.findChild(self.viewGO, "#go_UI/Right/#go_SwitchBtns")
	self._btnSuit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_UI/Right/#go_SwitchBtns/#btn_Suit")
	self._goSuitSelect = gohelper.findChild(self.viewGO, "#go_UI/Right/#go_SwitchBtns/#btn_Suit/#go_SuitSelect")
	self._btnShowUI = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ShowUI")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyClothView:addEvents()
	self._btnHideUI:AddClickListener(self._btnHideUIOnClick, self)
	self._btnLottery:AddClickListener(self._btnLotteryOnClick, self)
	self._btnWear:AddClickListener(self._btnWearOnClick, self)
	self._btnRare:AddClickListener(self._btnRareOnClick, self)
	self._btnSuit:AddClickListener(self._btnSuitOnClick, self)
	self._btnShowUI:AddClickListener(self._btnShowUIOnClick, self)
end

function PartyClothView:removeEvents()
	self._btnHideUI:RemoveClickListener()
	self._btnLottery:RemoveClickListener()
	self._btnWear:RemoveClickListener()
	self._btnRare:RemoveClickListener()
	self._btnSuit:RemoveClickListener()
	self._btnShowUI:RemoveClickListener()
end

function PartyClothView:_btnWearOnClick()
	local clothIds = {}

	for _, id in pairs(self.previewIdMap) do
		clothIds[#clothIds + 1] = id
	end

	PartyClothRpc.instance:sendWearPartyClothsRequest(clothIds)
	PartyGameLobbyController.instance:sendUploadPartyClothInfo()
end

function PartyClothView:_btnLotteryOnClick()
	PartyClothController.instance:openPartyClothLotteryView()
	self:closeThis()
end

function PartyClothView:_btnHideUIOnClick()
	gohelper.setActive(self._goUI, false)
	gohelper.setActive(self._btnShowUI, true)
	PostProcessingMgr.instance:setViewBlur(self.viewName, 0)
end

function PartyClothView:_btnRareOnClick()
	PartyClothModel.instance:setSortRule()
	self:refreshSortArrow()

	if self.clothType then
		PartyClothPartListModel.instance:sort(PartyClothHelper.SortClothFunc)
	else
		PartyClothSuitListModel.instance:sort(PartyClothHelper.SortSuitFunc)
	end
end

function PartyClothView:_btnSuitOnClick()
	if not self.clothType then
		return
	end

	self:switchClothType()
end

function PartyClothView:_btnClothOnClick(clothType)
	if self.clothType == clothType then
		return
	end

	self:switchClothType(clothType)
end

function PartyClothView:_btnShowUIOnClick()
	gohelper.setActive(self._goUI, true)
	gohelper.setActive(self._btnShowUI, false)
	PostProcessingMgr.instance:setViewBlur(self.viewName, 2)
end

function PartyClothView:_editableInitView()
	self.goSelectList = {}
	self.reddotCompList = {}

	for i = 1, 5 do
		local go = gohelper.findChild(self._goSwitchBtns, "btn" .. i)
		local btn = gohelper.findButtonWithAudio(go)

		self:addClickCb(btn, self._btnClothOnClick, self, i)

		self.goSelectList[i] = gohelper.findChild(go, "select")

		local goReddot = gohelper.findChild(go, "reddot")

		self.reddotCompList[i] = RedDotController.instance:addNotEventRedDot(goReddot, self["checkReddot" .. tostring(i)], self)
	end

	self.goTitleEns = {}

	for i = 1, 6 do
		self.goTitleEns[i] = gohelper.findChild(self._txtTitle.gameObject, "titleEn" .. i)
	end

	self.animLeft = gohelper.findChildAnim(self.viewGO, "#go_UI/Left")
	self.wearClothIdMap = PartyClothModel.instance:getWearClothIdMap()
	self.previewIdMap = PartyClothModel.instance:getPreviewClothIdMap()

	local param = ScrollAudioParam.New()

	param.scrollDir = ScrollEnum.ScrollDirV

	MonoHelper.addLuaComOnceToGo(self._scrollCloth.gameObject, ScrollAudioComp, param)
	MonoHelper.addLuaComOnceToGo(self._scrollSuit.gameObject, ScrollAudioComp, param)
end

function PartyClothView:onOpen()
	self:addEventCb(PartyClothController.instance, PartyClothEvent.ClothInfoUpdate, self.onClothInfoUpdate, self)
	self:addEventCb(PartyClothController.instance, PartyClothEvent.WearClothUpdate, self.onWearUpdate, self)
	self:addEventCb(PartyClothController.instance, PartyClothEvent.ClickClothPartItem, self.onClickPartItem, self)
	self:addEventCb(PartyClothController.instance, PartyClothEvent.ClickClothSuitItem, self.onClickSuitItem, self)
	self:switchClothType(PartyClothEnum.ClothType.Hat)
	self:refreshSortArrow()

	local scene = GameSceneMgr.instance:getCurScene()
	local sceneGo = scene.level:getSceneGo()

	self._goPlayer = gohelper.findChild(sceneGo, "scene/player")
	self.clothAvatar = MonoHelper.addNoUpdateLuaComOnceToGo(self._goPlayer, PartyClothAvatar)

	self:refreshSpine()
end

function PartyClothView:onClothInfoUpdate()
	self:switchClothType(self.clothType)
end

function PartyClothView:onWearUpdate()
	self:refreshSpine()
	self.animLeft:Play("save")

	if self.clothType then
		PartyClothPartListModel.instance:initData(self.clothType, self.previewIdMap[self.clothType])
	else
		PartyClothSuitListModel.instance:initData()
	end
end

function PartyClothView:switchClothType(clothType)
	if self.clothType then
		local list = {}
		local moList = PartyClothModel.instance:getClothMoList(self.clothType)

		for _, mo in ipairs(moList) do
			list[#list + 1] = mo.clothId
		end

		PartyClothModel.instance:setNewTagInvalid(list)
		self.reddotCompList[self.clothType]:refreshRedDot()
	end

	local txt

	if clothType then
		PartyClothPartListModel.instance:initData(clothType, self.previewIdMap[clothType])

		txt = luaLang(PartyClothEnum.ClothLangTxt[clothType])
	else
		PartyClothSuitListModel.instance:initData()

		txt = luaLang("p_partyclothview_txt_Suit")
	end

	for i, go in ipairs(self.goTitleEns) do
		if i == 6 then
			gohelper.setActive(go, not clothType)
		else
			gohelper.setActive(go, i == clothType)
		end
	end

	self._txtTitle.text = txt
	self._txtTitle1.text = txt

	gohelper.setActive(self._scrollCloth, clothType)
	gohelper.setActive(self._scrollSuit, not clothType)

	self.clothType = clothType

	self:refreshClothBtnStatus()
end

function PartyClothView:onClickPartItem(clothId)
	AudioMgr.instance:trigger(AudioEnum3_4.PartyCloth.preview)

	self.previewIdMap[self.clothType] = clothId

	self:refreshWearBtn()
	self:refreshSpine()
	PartyClothPartListModel.instance:selectClothItem(clothId, true)
end

function PartyClothView:onClickSuitItem(suitId)
	AudioMgr.instance:trigger(AudioEnum3_4.PartyCloth.preview)

	local curSuitId = PartyClothHelper.GetWearSuitId()
	local clothCfgs = PartyClothConfig.instance:getClothCfgsBySuit(suitId)

	if curSuitId ~= suitId then
		tabletool.clear(self.previewIdMap)

		for i = 1, #clothCfgs do
			local config = clothCfgs[i]
			local mo = PartyClothModel.instance:getClothMo(config.clothId, true)

			if mo then
				self.previewIdMap[config.partId] = config.clothId
			end
		end

		local initClothIdMap = PartyClothConfig.instance:getInitClothIdMap()

		for i = 1, 5 do
			if not self.previewIdMap[i] and initClothIdMap[i] then
				self.previewIdMap[i] = initClothIdMap[i]
			end
		end

		PartyClothSuitListModel.instance:selectSuitItem(suitId, true)
	end

	self:refreshWearBtn()
	self:refreshSpine()
end

function PartyClothView:refreshWearBtn()
	local isChange = false

	for i = 1, 5 do
		local id = self.wearClothIdMap[i]
		local previewId = self.previewIdMap[i]

		if id ~= previewId then
			isChange = true

			break
		end
	end

	local info = self.animLeft:GetCurrentAnimatorStateInfo(0)

	if isChange then
		if info:IsName("saved") then
			self.animLeft:Play("unsave")
		end
	elseif info:IsName("unsaved") then
		self.animLeft:Play("save")
	end
end

function PartyClothView:refreshSpine()
	local skinResMap = PartyClothConfig.instance:getSkinRes(self.previewIdMap)

	self.clothAvatar:refreshSkin(skinResMap)
end

function PartyClothView:refreshClothBtnStatus()
	for i = 1, 5 do
		gohelper.setActive(self.goSelectList[i], self.clothType == i)
	end

	gohelper.setActive(self._goSuitSelect, not self.clothType)
end

function PartyClothView:refreshSortArrow()
	local isReverse = PartyClothModel.instance.sortReverse

	gohelper.setActive(self._goArrowUp, not isReverse)
	gohelper.setActive(self._goArrowDown, isReverse)
end

function PartyClothView:checkReddot1()
	local moList = PartyClothModel.instance:getClothMoList(PartyClothEnum.ClothType.Hat)

	return self:checkReddot(moList)
end

function PartyClothView:checkReddot2()
	local moList = PartyClothModel.instance:getClothMoList(PartyClothEnum.ClothType.Jacket)

	return self:checkReddot(moList)
end

function PartyClothView:checkReddot3()
	local moList = PartyClothModel.instance:getClothMoList(PartyClothEnum.ClothType.Pant)

	return self:checkReddot(moList)
end

function PartyClothView:checkReddot4()
	local moList = PartyClothModel.instance:getClothMoList(PartyClothEnum.ClothType.Shoes)

	return self:checkReddot(moList)
end

function PartyClothView:checkReddot5()
	local moList = PartyClothModel.instance:getClothMoList(PartyClothEnum.ClothType.Head)

	return self:checkReddot(moList)
end

function PartyClothView:checkReddot(list)
	for _, mo in ipairs(list) do
		local isNew = PartyClothModel.instance:hasNewTag(mo.clothId)

		if isNew then
			return true
		end
	end

	return false
end

return PartyClothView
