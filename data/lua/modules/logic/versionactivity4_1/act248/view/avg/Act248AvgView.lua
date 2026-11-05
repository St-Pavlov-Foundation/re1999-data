-- chunkname: @modules/logic/versionactivity4_1/act248/view/avg/Act248AvgView.lua

module("modules.logic.versionactivity4_1.act248.view.avg.Act248AvgView", package.seeall)

local Act248AvgView = class("Act248AvgView", BaseView)

function Act248AvgView:onInitView()
	self._goenter = gohelper.findChild(self.viewGO, "#go_enter")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_enter/#txt_num")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_enter/#go_reddot")
	self._gofinished = gohelper.findChild(self.viewGO, "#go_enter/#go_finished")
	self._btnact248 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_enter/#btn_act248")
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_fullbg")
	self._goclueroot = gohelper.findChild(self.viewGO, "root/#go_clueroot")
	self._simagepaper = gohelper.findChildSingleImage(self.viewGO, "#image_paper")
	self._imagepaper = gohelper.findChildImage(self.viewGO, "#image_paper")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_tips/txt_cluetitle")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#go_tips/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_tips/#scroll_desc/Viewport/Content/#txt_desc")
	self._gopropview = gohelper.findChild(self.viewGO, "#go_propview")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_propview/tipbg/#txt_tips")
	self._btnreturn = gohelper.getClickWithDefaultAudio(self._simagefullbg.gameObject)
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_skip")
	self._txtskip = gohelper.findChildTextMesh(self.viewGO, "#go_btn/#btn_skip/txt_skip")
	self._imageskip = gohelper.findChildImage(self.viewGO, "#go_btn/#btn_skip/#image_skip")
	self._imageskiptxt = gohelper.findChildImage(self.viewGO, "#go_btn/#btn_skip/#image_skiptxt")
	self._puzzleBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_puzzle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248AvgView:addEvents()
	self._btnact248:AddClickListener(self._btnact248OnClick, self)
	self._btnreturn:AddClickListener(self._btnreturnOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._puzzleBtn:AddClickListener(self._btnClueOnClick, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onGenerateReport, self._refreshFileCount, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
end

function Act248AvgView:removeEvents()
	self._btnact248:RemoveClickListener()
	self._btnreturn:RemoveClickListener()
	self._btnskip:RemoveClickListener()
	self._puzzleBtn:RemoveClickListener()
	self:removeEventCb(Act248Controller.instance, Act248Event.onGenerateReport, self._refreshFileCount, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function Act248AvgView:_onOpenViewFinish(viewName)
	if viewName == ViewName.StoryFrontView then
		gohelper.setAsLastSibling(self.viewGO)
		gohelper.setActive(self._goenter, false)

		if self._isCanCloseView then
			self:closeThis()
		end
	end
end

function Act248AvgView:_btnact248OnClick()
	Act248Controller.instance:openAct248EnterView()
end

function Act248AvgView:_btnskipOnClick()
	self:_checkPlayNextStory()
end

function Act248AvgView:_btnClueOnClick()
	Act248Controller.instance:openAct248ClueMainView()
end

function Act248AvgView:_btnreturnOnClick()
	if self._isTweening then
		return
	end

	local clueMo = self._showClueMos and self._showClueMos[self._showClueIndex]

	if clueMo then
		if not clueMo:isUnlock() then
			Act248Rpc.instance:sendAct248UnlockSingleClueRequest(clueMo.id)
		end

		if self._isCollecting then
			local item = self._cluesInfos[self._showClueIndex]

			if not item.isCollected then
				ToastController.instance:showToast(Act248Enum.Toast.CollectClue)
			end
		end
	end

	if self._showClueIndex and self._showClueMos and self._collectClueIndex and self._showClueIndex < #self._showClueMos then
		self:_hideClueInfo()
		TaskDispatcher.runDelay(self._showNextClueInfo, self, 0.167)

		return
	end

	self._isCollecting = false

	self:_onColloct()
end

function Act248AvgView:_btnClickOnClick(i)
	if self._isTweening or self._isCollecting then
		return
	end

	self._isCollecting = true

	self:_onColloct(i)
end

function Act248AvgView:_onColloct(colloctIndex)
	local item = colloctIndex and self._cluesInfos[colloctIndex]

	if not item or item.isCollected then
		self:_onHideClue()

		return
	end

	self:_onShowClue(colloctIndex)
end

function Act248AvgView:_onTweenCollect(x, y, targetScale, duration, cb)
	if self._tweenScaleId then
		ZProj.TweenHelper.KillById(self._tweenScaleId)
	end

	if self._tweenPosId then
		ZProj.TweenHelper.KillById(self._tweenPosId)
	end

	targetScale = targetScale or 1

	local screenWidth, screenHeight = self:_getScreenSize()
	local xBoundary = math.abs(2592 * targetScale - screenWidth) * 0.5
	local yBoundary = math.abs(1080 * targetScale - screenHeight) * 0.5

	x = GameUtil.clamp(x or 0, -xBoundary, xBoundary)
	y = GameUtil.clamp(y or 0, -yBoundary, yBoundary)
	duration = duration or 0.5
	self._isTweening = true
	self._tweenScaleId = ZProj.TweenHelper.DOScale(self._goroot.transform, targetScale, targetScale, targetScale, duration, cb, self, nil, EaseType.Linear)
	self._tweenPosId = ZProj.TweenHelper.DOAnchorPos(self._goroot.transform, x, y, duration, self._onFinishTween, self, nil, EaseType.Linear)
end

function Act248AvgView:_getScreenSize()
	local defalutWidth = 1920
	local defalutHeight = 1080
	local targetRate = defalutWidth / defalutHeight
	local curWidth = UnityEngine.Screen.width
	local curHeight = UnityEngine.Screen.height
	local curRate = curWidth / curHeight

	if curRate - targetRate > 0 then
		local viewHeight = recthelper.getHeight(self.viewGO.transform)
		local widthPx = curRate * viewHeight

		return widthPx, viewHeight
	elseif curRate - targetRate < 0 then
		local viewWidth = recthelper.getWidth(self.viewGO.transform)
		local heightPx = viewWidth / curRate

		return viewWidth, heightPx
	end

	return defalutWidth, defalutHeight
end

function Act248AvgView:_onFinishTween()
	self._isTweening = false
end

local collectScale = 1.5

function Act248AvgView:_onShowClue(colloctIndex)
	local item = colloctIndex and self._cluesInfos[colloctIndex]

	self._collectClueIndex = colloctIndex
	item.isCollected = true

	local x, y = recthelper.getAnchor(item.go.transform)

	self._showClueIndex = 1
	self._showClueMos = self._collectClueIndex and Act248Model.instance:getAvgClueInfosByIndex(self._collectClueIndex)

	self:_refreshClueInfo()
	self:_onTweenCollect(-x * collectScale, -y * collectScale, collectScale, 0.5, self._showClueInfo)
	self._animpropview:Play("select", 0, 0)
	gohelper.setActive(self._goenter, false)
end

function Act248AvgView:_onHideClue()
	if self._collectClueIndex then
		self._animpropview:Play("bake", 0, 0)
		self:_onTweenCollect(0, 0, 1, 0.5, self._refreshCollect)

		if self._collectClueIndex == 2 then
			self._simagefullbg:UnLoadImage()
			self._simagefullbg:LoadImage(ResUrl.getV4a1InvestigationSingleBg("v4a1_investigation_fullbg_4"))
		end

		self:_hideClueInfo()
	end

	self._collectClueIndex = nil

	gohelper.setActive(self._goenter, false)
end

function Act248AvgView:_refreshClueInfo()
	local clueMo = self._showClueMos and self._showClueMos[self._showClueIndex]

	if not clueMo then
		return
	end

	local co = clueMo:getConfig()

	self._txttitle.text = co.name
	self._txtdesc.text = co.desc

	if not string.nilorempty(co.icon) then
		self._simagepaper:LoadImage(ResUrl.getAct248ClueSingleBg(co.icon), function()
			self._imagepaper:SetNativeSize()
		end)
	end
end

function Act248AvgView:_showNextClueInfo()
	self._showClueIndex = self._showClueIndex + 1

	self:_refreshClueInfo()
	self:_showClueInfo()
end

function Act248AvgView:_showClueInfo()
	self._animtips:Play("tips", 0, 0)
	self._animpaper:Play("open", 0, 0)
	AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_wulu_aizila_forward_paper)
end

function Act248AvgView:_hideClueInfo()
	self._animtips:Play("close", 0, 0)
	self._animpaper:Play("close", 0, 0)
end

function Act248AvgView:_editableInitView()
	self._cluesInfos = self:getUserDataTb_()
	self._collectCount = 0
	self._totalCount = 6

	for i = 1, self._totalCount do
		local info = self:getUserDataTb_()

		info.go = gohelper.findChild(self._goclueroot, "#go_prop" .. i)
		info.btn = gohelper.getClickWithDefaultAudio(info.go)

		info.btn:AddClickListener(self._btnClickOnClick, self, i)

		info.isCollected = false
		self._cluesInfos[i] = info
	end

	self._activityId = Act248Model.instance:getActId()
	self._gopaper = self._simagepaper.gameObject
	self._animpropview = self._gopropview:GetComponent(typeof(UnityEngine.Animator))
	self._animtips = self._gotips:GetComponent(typeof(UnityEngine.Animator))
	self._animpaper = self._gopaper:GetComponent(typeof(UnityEngine.Animator))

	local isOverseas = SettingsModel.instance:isOverseas()

	gohelper.setActive(self._txtskip.gameObject, not isOverseas)
	gohelper.setActive(self._imageskiptxt.gameObject, isOverseas)
	self._simagefullbg:LoadImage(ResUrl.getV4a1InvestigationSingleBg("v4a1_investigation_fullbg"))
end

function Act248AvgView:_startGame()
	gohelper.setActive(self._goenter, false)
	gohelper.setActive(self._goroot, true)
	gohelper.setActive(self._gopaper, true)
	gohelper.setActive(self._gotips, true)
	gohelper.setActive(self._gopropview, true)

	local isFinishCollect = Act248Model.instance:isAllFinishCollectAvgClueInfos()

	gohelper.setActive(self._btnskip.gameObject, isFinishCollect)
	self._animtips:Play("close", 0, 1)
	self._animpaper:Play("close", 0, 1)
end

function Act248AvgView:onUpdateParam()
	return
end

function Act248AvgView:onOpen()
	self:_startGame()
	self:_refreshFileCount()
	self:_refreshCollect()
end

function Act248AvgView:_refreshFileCount()
	local fileFinishCount, fileCount = Act248Model.instance:getFinishFileCount()
	local lang = luaLang("act248_progress")

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, fileFinishCount, fileCount)
end

function Act248AvgView:onClose()
	self._simagefullbg:UnLoadImage()
end

function Act248AvgView:_checkPlayNextStory()
	local isFinishCollect = Act248Model.instance:isAllFinishCollectAvgClueInfos()

	if isFinishCollect then
		self:_playNextStory()
	end
end

function Act248AvgView:_playNextStory()
	self._isCanCloseView = true

	local storyId = Act248Model.instance:getAvgAfterStoryId()
	local storyEpisodeId = Act248Model.instance:getNormalEpisodeId()

	StoryController.instance:playStory(storyId, nil, function()
		if not DungeonModel.instance:hasPassLevelAndStory(storyEpisodeId) then
			DungeonRpc.instance:sendEndDungeonRequest(false)
		end
	end, self)
end

function Act248AvgView:_refreshCollect()
	self._collectCount = 0

	for i, info in ipairs(self._cluesInfos) do
		local isShow = false

		if info.isCollected then
			self._collectCount = self._collectCount + 1

			if self._collectClueIndex == i then
				isShow = true
			end
		elseif not self._collectClueIndex then
			isShow = true
		end

		gohelper.setActive(info.go, isShow)
	end

	local lang = luaLang("act248_avg_collect")

	self._txttips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, self._collectCount, self._totalCount)

	if self._collectCount >= self._totalCount then
		self:_playNextStory()
	end
end

function Act248AvgView:onDestroyView()
	for _, item in ipairs(self._cluesInfos) do
		item.btn:RemoveClickListener()
	end

	if self._tweenScaleId then
		ZProj.TweenHelper.KillById(self._tweenScaleId)
	end

	if self._tweenPosId then
		ZProj.TweenHelper.KillById(self._tweenPosId)
	end

	TaskDispatcher.cancelTask(self._showNextClueInfo, self)
	self._simagepaper:UnLoadImage()
end

return Act248AvgView
