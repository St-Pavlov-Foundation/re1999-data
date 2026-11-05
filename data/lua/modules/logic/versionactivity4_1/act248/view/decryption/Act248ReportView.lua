-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248ReportView.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248ReportView", package.seeall)

local Act248ReportView = class("Act248ReportView", BaseView)

function Act248ReportView:onInitView()
	self._goleft = gohelper.findChild(self.viewGO, "root/left")
	self._scrollRoleList = gohelper.findChildScrollRect(self.viewGO, "root/left/#scroll_RoleList")
	self._goroleitem = gohelper.findChild(self.viewGO, "root/left/#scroll_RoleList/Viewport/Content/#go_roleitem")
	self._gopaper = gohelper.findChild(self.viewGO, "root/#go_paper")
	self._gopaper1 = gohelper.findChild(self.viewGO, "root/#go_paper/#go_paper1")
	self._txtLeftDesc = gohelper.findChildText(self.viewGO, "root/#go_paper/#go_paper1/#txt_Desc")
	self._scrollRight = gohelper.findChildScrollRect(self.viewGO, "root/#go_paper/#go_paper1/Scroll_right")
	self._goRight = gohelper.findChild(self.viewGO, "root/#go_paper/#go_paper1/Scroll_right/ViewPort/Content")
	self._txtRightDesc = gohelper.findChildText(self.viewGO, "root/#go_paper/#go_paper1/Scroll_right/ViewPort/Content/#txt_Desc")
	self._imagepicture = gohelper.findChildImage(self.viewGO, "root/#go_paper/#go_paper1/Scroll_right/ViewPort/Content/#image_picture")
	self._go = gohelper.findChild(self.viewGO, "root/#go_paper/#go_paper1/Scroll_right/ViewPort/Content/#grid_head")
	self._gorole = gohelper.findChild(self.viewGO, "root/#go_paper/#go_paper1/Scroll_right/ViewPort/Content/#grid_head")
	self._rolePrefab = gohelper.findChild(self.viewGO, "root/#go_paper/#go_paper1/Scroll_right/ViewPort/Content/#grid_head/#go_heroitem")
	self._gofinish = gohelper.findChild(self.viewGO, "root/#btn_finish")
	self._gocompleted = gohelper.findChild(self.viewGO, "root/#go_completed")
	self._btnMask = gohelper.getClickWithDefaultAudio(self.viewGO, "root/mask")
	self._gomask = gohelper.findChild(self.viewGO, "root/#go_paper/#go_mask")
	self._goleftMask = gohelper.findChild(self.viewGO, "root/#go_paper/#go_paper1/desc_mark")
	self._goRightMask = gohelper.findChild(self.viewGO, "root/#go_paper/#go_paper1/Scroll_right/ViewPort/Content/desc_mark")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248ReportView:addEvents()
	self:addEventCb(Act248Controller.instance, Act248Event.onClickRoleItem, self._onClickRoleItem, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onFinishReport, self._onFinishReport, self)
end

function Act248ReportView:removeEvents()
	self:removeEventCb(Act248Controller.instance, Act248Event.onClickRoleItem, self._onClickRoleItem, self)
	self:removeEventCb(Act248Controller.instance, Act248Event.onFinishReport, self._onFinishReport, self)
end

local fillMark = "{MARK001}"
local fillMark1 = "{MARK002}"
local pattern = "{(%d+)}"
local transparent = "<color=#FFFFFF00>%s</color>"
local defalutMarkWidth = 180
local roleOffset = 20

function Act248ReportView:_btnCloseOnClick()
	if self._isClosing then
		return
	end

	self._isClosing = true

	self._animatorPlayer:Play(Act248Enum.AniName.close, self.closeThis, self)
	AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_lvhu_notebook_get)
end

function Act248ReportView:_onClickRoleItem(roleId)
	local isCorrectFill = self:_isCorrectFill(roleId)

	if isCorrectFill then
		self:_onCorrectFill(roleId)
	else
		self:_onFailFill(roleId)
	end

	Act248Controller.instance:dispatchEvent(Act248Event.onCorrectRole, roleId, isCorrectFill)
end

function Act248ReportView:_onFinishReport()
	self._isFinish = self._fileMo:isFinish()

	self:_refreshStatus()
	self._completeAnimatorPlayer:Play(Act248Enum.AniName.finish, nil, self)
	self._animatorPlayer:Play(Act248Enum.AniName.finish, nil, self)
end

function Act248ReportView:_killTween()
	ZProj.TweenHelper.KillByObj(self._imgbtncheck)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function Act248ReportView:_onClickCheckDown()
	if self._isAutoFill then
		return
	end

	self._isFinish = self._fileMo:isFinish()

	if self._isFinish then
		return
	end

	self:_killTween()
	ZProj.TweenHelper.DOFillAmount(self._imgbtncheck, 1, self._longClickTime, self._onAutoFillAnswer, self, nil, EaseType.Linear)

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._longClickTime, self._frameCallback, nil, self)
	self._btnAudioId = AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_atlantis_jiean)
end

function Act248ReportView:_onClickCheckUp()
	if self._isAutoFill then
		return
	end

	self:_killTween()

	self._imgbtncheck.fillAmount = 0
	self._txtcheckprogress.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), 0)

	self:_onStopBtnAudio()
end

function Act248ReportView:_onStopBtnAudio()
	if self._btnAudioId then
		AudioMgr.instance:stopPlayingID(self._btnAudioId)

		self._btnAudioId = nil
	end

	AudioMgr.instance:trigger(AudioEnum4_1.Act248.stop_ui_atlantis_jiean)
end

function Act248ReportView:_onAutoFillAnswer()
	gohelper.setActive(self._gocheck, false)

	self._isAutoFill = true

	self:_autoFillAnswer()
	self:_onStopBtnAudio()
end

function Act248ReportView:_frameCallback()
	local progress = math.floor(self._imgbtncheck.fillAmount * 100)

	self._txtcheckprogress.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), progress)
end

function Act248ReportView:_autoFillAnswer()
	local index = self._selectVacancy or 1

	if not self._blankAnswerList or index > #self._blankAnswerList then
		return
	end

	if string.nilorempty(self._fillAnswerList[index]) then
		self:_onCorrectFill(self._blankAnswerList[index])
		TaskDispatcher.runDelay(self._autoFillAnswer, self, 1)

		return
	end

	self._selectVacancy = self._selectVacancy + 1

	self:_autoFillAnswer()
end

function Act248ReportView:_editableInitView()
	self._fillMarkItems = self:getUserDataTb_()
	self._extraMarkItems = self:getUserDataTb_()

	gohelper.setActive(self._imagepicture.gameObject, false)
	gohelper.setActive(self._rolePrefab.gameObject, false)

	self._gocheck = gohelper.findChild(self.viewGO, "root/#btn_finish")
	self._imgbtncheck = gohelper.findChildImage(self._gocheck, "image_finish")
	self._txtcheckprogress = gohelper.findChildText(self._gocheck, "image_finish/txt_finish")
	self._imgbtncheck.fillAmount = 0
	self._txtcheckprogress.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), 0)
	self._clickCheck = SLFramework.UGUI.UIClickListener.Get(self._gocheck)

	self._clickCheck:AddClickDownListener(self._onClickCheckDown, self)
	self._clickCheck:AddClickUpListener(self._onClickCheckUp, self)

	self._longClickTime = Act248Config.instance:getConstValue(Act248Enum.Const.ReportCheckBtnLongClickTime, true)
	self._blankAnswerList = {}
	self._fillAnswerList = {}
	self._fillPosList = {}
	self._roleItemDict = {}
	self._singleLineHeight = GameUtil.getPreferredHeight(self._txtLeftDesc, " ")

	local leftHeight = recthelper.getHeight(self._txtLeftDesc.transform)

	self._leftMaxLineCount = math.floor(leftHeight / self._singleLineHeight)
	self._rightTextAnchorY = recthelper.getAnchorY(self._txtRightDesc.transform)

	recthelper.setAnchorY(self._goleftMask.transform, recthelper.getAnchorY(self._txtLeftDesc.transform))
	recthelper.setAnchorY(self._goRightMask.transform, self._rightTextAnchorY)

	self._leftTextHeight = recthelper.getHeight(self._txtLeftDesc.transform)
	self._roleRootHeight = recthelper.getHeight(self._gorole.transform)

	gohelper.setActive(self._gomask, false)

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._completeAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self._gocompleted)
end

function Act248ReportView:onUpdateParam()
	return
end

function Act248ReportView:onOpen()
	self._fileId = self.viewParam.fileId
	self._fileMo = Act248Model.instance:getFileById(self._fileId)
	self._reportCo = self._fileMo:getReportCo()
	self._actId = Act248Model.instance:getActId()

	if self.viewParam.isNotFinish or self.viewParam.isNotFinish == false then
		self._isFinish = not self.viewParam.isNotFinish
	else
		self._isFinish = self._fileMo:isFinish()
	end

	Act248ReportRoleListModel.instance:setModel(self._fileId)

	self._isShowFinishBtn = false

	if not self._isFinish then
		self._selectVacancy = 1
	end

	self:_initContent()
	self:_initOption()
	self:_refreshStatus()
	AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_wulu_paiqian_open)
end

function Act248ReportView:_initOption()
	self._roleList = {}

	for i, id in ipairs(self._blankAnswerList) do
		local mo = Act248RoleMO.New()

		mo:init(id)

		if self._isFinish then
			mo:onFill(true)
		end

		local item = self:_getRoleItem(i)

		item:onUpdateMO(mo)

		self._roleList[id] = i
	end

	local count = self._blankAnswerList and #self._blankAnswerList or 0

	for i, item in ipairs(self._roleItemDict) do
		gohelper.setActive(item.viewGO, i <= count)
	end
end

function Act248ReportView:_getRoleItem(index)
	local item = self._roleItemDict[index]

	if not item then
		local go = gohelper.clone(self._rolePrefab, self._gorole)

		item = MonoHelper.addLuaComOnceToGo(go, Act248AnswerRoleItem)
		self._roleItemDict[index] = item
	end

	return item
end

function Act248ReportView:_initContent()
	local content = self._reportCo.content

	if not string.nilorempty(content) then
		for answerIndex in string.gmatch(content, pattern) do
			local answer = tonumber(answerIndex)

			table.insert(self._blankAnswerList, answer)
		end
	end

	self._reportContent = string.gsub(content, pattern, fillMark)

	local splitContents = string.split(self._reportContent, fillMark)

	self._splitContentLen = {}

	for _, c in ipairs(splitContents) do
		local len = GameUtil.utf8len(c)

		table.insert(self._splitContentLen, len)
	end

	if self._isFinish then
		for i, roleId in ipairs(self._blankAnswerList) do
			self._fillAnswerList[i] = self:_getCorrectFillText(roleId)
		end
	end

	self:_refreshInfo()
end

function Act248ReportView:_getFillMarkItem(index)
	local item = self._fillMarkItems[index]

	if not item then
		item = self:_getMarkItem(item)

		gohelper.setActive(item.go, true)

		self._fillMarkItems[index] = item
	end

	return item
end

function Act248ReportView:_getExtraMarkItem(index)
	local item = self._extraMarkItems[index]

	if not item then
		item = self:_getMarkItem(item, index)

		gohelper.setActive(item.go, true)

		self._extraMarkItems[index] = item
	end

	return item
end

function Act248ReportView:_getMarkItem(item, index)
	item = self:getUserDataTb_()
	item.go = gohelper.cloneInPlace(self._gomask, index)
	item.goselect = gohelper.findChild(item.go, "#select")
	item.gohua = gohelper.findChild(item.go, "hua")
	item.txtdesc = gohelper.findChildText(item.go, "#txt_Desc")
	item.btn = gohelper.getClickWithDefaultAudio(item.gohua)

	item.btn:AddClickListener(self._onClickMark, self, item)

	item.animator = item.go:GetComponent(typeof(UnityEngine.Animator))

	return item
end

function Act248ReportView:_onClickMark(item)
	local index = item.index

	if index and string.nilorempty(self._fillAnswerList[index]) then
		self._selectVacancy = index

		self:_refreshInfo()
	end
end

function Act248ReportView:_refreshInfo()
	local leftContent, rightContent = self:_getContent()

	self._txtLeftDesc.text = leftContent
	self._txtRightDesc.text = rightContent
end

function Act248ReportView:_getContent()
	local leftContent, rightContent = self:_onAllocationContent()
	local _leftContent, _rightContent
	local leftTextInfo = self._txtLeftDesc:GetTextInfo(leftContent)
	local rightTextInfo = self._txtRightDesc:GetTextInfo(rightContent)
	local leftContentLen = leftTextInfo.characterCount
	local rightContentLen = rightTextInfo.characterCount
	local contentLen = 0
	local leftStart = 1
	local rightStart = 1
	local needExtraMarkItem = {}

	for i = 1, #self._splitContentLen - 1 do
		local len = self._splitContentLen[i]

		contentLen = contentLen + len

		local item = self:_getFillMarkItem(i)

		item.index = i

		local characterInfo, endCharacterInfo
		local fillContent = self:_getFillContent(i)
		local fillWidth, isLeft
		local fillLen = GameUtil.utf8len(fillContent)
		local _contentLen

		if leftContentLen < contentLen then
			_contentLen = contentLen - leftContentLen
			characterInfo = rightTextInfo.characterInfo[_contentLen]
			isLeft = false
			fillWidth = GameUtil.getPreferredWidth(self._txtRightDesc, fillContent)

			local beginContent = LuaUtil.subString(rightContent, rightStart, _contentLen)
			local _fillContent = string.format(transparent, fillContent)

			_rightContent = _rightContent or ""
			rightStart = _contentLen + fillLen + 1
			_rightContent = _rightContent .. beginContent .. _fillContent
			endCharacterInfo = rightTextInfo.characterInfo[_contentLen + fillLen]
		else
			_contentLen = contentLen
			characterInfo = leftTextInfo.characterInfo[contentLen]
			fillWidth = GameUtil.getPreferredWidth(self._txtLeftDesc, fillContent)
			isLeft = true

			local beginContent = LuaUtil.subString(leftContent, leftStart, contentLen)
			local _fillContent = string.format(transparent, fillContent)

			_leftContent = _leftContent or ""
			leftStart = contentLen + fillLen + 1
			_leftContent = _leftContent .. beginContent .. _fillContent
			endCharacterInfo = leftTextInfo.characterInfo[contentLen + fillLen]
		end

		local answer = self._fillAnswerList[i]
		local _fillContent = answer
		local isFinishFill = not string.nilorempty(answer)

		if isFinishFill then
			fillWidth = fillWidth + 10
		end

		local isSelect = not isFinishFill and self._selectVacancy == i

		gohelper.setActive(item.goselect, isSelect)
		gohelper.setActive(item.gohua, not isFinishFill)

		contentLen = contentLen + GameUtil.utf8len(fillContent)

		local maskRoot = isLeft and self._goleftMask or self._goRightMask
		local textCom = isLeft and self._txtLeftDesc or self._txtRightDesc
		local fontSize = textCom.fontSize

		gohelper.addChild(maskRoot, item.go)

		if characterInfo then
			local startBL = characterInfo.bottomLeft
			local endBL = endCharacterInfo.bottomRight
			local x = startBL.x - 10
			local y = startBL.y + fontSize * 0.5

			if isFinishFill then
				x = x - 10
			end

			transformhelper.setLocalPosXY(item.go.transform, x, y)

			local textInfo = isLeft and leftTextInfo or rightTextInfo
			local pos = self:_getFillLineBreakPos(textInfo, fillLen, _contentLen, fontSize)

			if fontSize < startBL.y - endBL.y and pos and pos < fillLen then
				local extraItem = self:_getExtraMarkItem(i)

				needExtraMarkItem[i] = true

				gohelper.addChild(maskRoot, extraItem.go)

				if pos then
					local info = textInfo.characterInfo[_contentLen + pos]
					local bl = info.bottomLeft
					local _x = bl.x
					local _y = bl.y + fontSize * 0.5

					transformhelper.setLocalPosXY(extraItem.go.transform, _x, _y)

					_fillContent = LuaUtil.subString(answer, 1, pos)

					local _fillContent2 = LuaUtil.subString(answer, pos + 1)

					extraItem.txtdesc.text = _fillContent2
					fillWidth = GameUtil.getPreferredWidth(textCom, _fillContent) + 10

					local fillWidth2 = GameUtil.getPreferredWidth(textCom, _fillContent2) + 10

					gohelper.setActive(extraItem.goselect, isSelect)
					gohelper.setActive(extraItem.gohua, not isFinishFill)
					recthelper.setWidth(extraItem.go.transform, fillWidth2)
				end
			end

			local width = isFinishFill and fillWidth or defalutMarkWidth

			recthelper.setWidth(item.go.transform, width)
		end

		item.txtdesc.text = _fillContent
	end

	_leftContent = _leftContent and _leftContent .. LuaUtil.subString(leftContent, leftStart, contentLen) or leftContent
	_rightContent = _rightContent and _rightContent .. LuaUtil.subString(rightContent, rightStart, rightContentLen) or rightContent

	for i, item in pairs(self._extraMarkItems) do
		if not needExtraMarkItem[i] then
			gohelper.setActive(item.go, false)
		end
	end

	return _leftContent, _rightContent
end

function Act248ReportView:_getFillLineBreakPos(textInfo, fillLen, startPos, fontSize)
	for i = 1, fillLen do
		local startCharacterInfo = textInfo.characterInfo[startPos + i - 1]

		if startCharacterInfo then
			local endCharacterInfo = textInfo.characterInfo[startPos + i]
			local startBL = startCharacterInfo.bottomLeft
			local endBL = endCharacterInfo.bottomRight

			if fontSize < startBL.y - endBL.y then
				return i
			end
		end
	end
end

function Act248ReportView:_onAllocationContent()
	local leftContent, rightContent
	local content = self:_getShowContent()
	local leftTextInfo = self._txtLeftDesc:GetTextInfo(content)
	local lineCount = leftTextInfo.lineCount

	if lineCount > self._leftMaxLineCount - 1 then
		local count = math.min(lineCount - 1, self._leftMaxLineCount)
		local overflowLineInfo = leftTextInfo.lineInfo[count]
		local splitPos = overflowLineInfo.lastCharacterIndex

		leftContent = LuaUtil.subString(content, 1, splitPos)
		rightContent = LuaUtil.subString(content, splitPos + 1)
	else
		leftContent = content
		rightContent = ""
	end

	local rightHeight = GameUtil.getPreferredHeight(self._txtRightDesc, rightContent)

	recthelper.setHeight(self._txtRightDesc.transform, rightHeight)
	recthelper.setHeight(self._txtRightDesc.transform.parent.transform, rightHeight)

	if string.nilorempty(rightContent) then
		local leftContentHeight = GameUtil.getPreferredHeight(self._txtLeftDesc, leftContent)

		if leftContentHeight + self._roleRootHeight + roleOffset > self._leftTextHeight then
			gohelper.addChild(self._goRight.gameObject, self._gorole)

			local y = self._rightTextAnchorY

			if rightHeight > 0 then
				y = -(rightHeight + roleOffset) + self._rightTextAnchorY
			end

			recthelper.setAnchor(self._gorole.transform, 0, y)
		else
			gohelper.addChild(self._txtLeftDesc.gameObject, self._gorole)
			recthelper.setAnchor(self._gorole.transform, 0, -(leftContentHeight + roleOffset))
		end
	else
		gohelper.addChild(self._goRight.gameObject, self._gorole)

		local y = self._rightTextAnchorY

		if rightHeight > 0 then
			y = -(rightHeight + roleOffset) + self._rightTextAnchorY
		end

		recthelper.setAnchor(self._gorole.transform, 0, y)
	end

	return leftContent, rightContent
end

function Act248ReportView:_getShowContent()
	local content = self._reportContent
	local startIndex, endIndex = string.find(content, fillMark)
	local fillIndex = 0

	while startIndex do
		fillIndex = fillIndex + 1

		local fillContent = self:_getFillContent(fillIndex)

		content = string.gsub(content, fillMark, fillContent, 1)
		startIndex, endIndex = string.find(content, fillMark)
	end

	return content
end

function Act248ReportView:_getFillContent(index)
	local answer = self._fillAnswerList[index]
	local fillContent = string.nilorempty(answer) and fillMark1 or answer

	return fillContent
end

function Act248ReportView:_refreshStatus()
	if not self._gofinish then
		return
	end

	gohelper.setActive(self._gofinish.gameObject, not self._isFinish and self._isShowFinishBtn)
	gohelper.setActive(self._gocompleted.gameObject, self._isFinish)
	gohelper.setActive(self._goleft.gameObject, not self._isFinish)

	if self._isFinish then
		for i in ipairs(self._blankAnswerList) do
			self:_playMarkFillAni(i, true, 1)
		end
	end
end

function Act248ReportView:_showFinishBtn()
	self._isShowFinishBtn = true

	self:_refreshStatus()
	Act248Controller.instance:dispatchEvent(Act248Event.onShowAutoFillReport)
end

function Act248ReportView:_isCorrectFill(roleId)
	local correctAnswer = self._blankAnswerList[self._selectVacancy]

	return correctAnswer == roleId
end

function Act248ReportView:_playMarkFillAni(index, isCorrect, rate)
	local aniName = isCorrect and Act248Enum.AniName.finished or Act248Enum.AniName.wrong
	local markItem = self._fillMarkItems[index]

	rate = rate or 0

	if markItem then
		markItem.animator:Play(aniName, 0, rate)
	end

	local extraItem = self._extraMarkItems[index]

	if extraItem then
		extraItem.animator:Play(aniName, 0, rate)
	end
end

function Act248ReportView:_onCorrectFill(roleId)
	local mo = Act248ReportRoleListModel.instance:getById(roleId)

	if mo then
		mo:onFill(true)
		Act248ReportRoleListModel.instance:onModelUpdate()
	end

	local index = self._roleList[roleId]
	local item = self:_getRoleItem(index)

	if item then
		item:onFill()
	end

	local fillIndex = self._selectVacancy

	self._fillAnswerList[self._selectVacancy] = self:_getCorrectFillText(roleId)
	self._selectVacancy = self:_getVacancy()

	self:_refreshInfo()
	self:_checkAllCorrectFill()
	self:_playMarkFillAni(fillIndex, true)
	AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_lvhu_clue_write_1)
end

function Act248ReportView:_getCorrectFillText(id)
	local co = Act248Config.instance:getReportOptionCo(id)
	local lang = luaLang("act248_report_fill")
	local answer = GameUtil.getSubPlaceholderLuaLangOneParam(lang, co.name)

	return answer
end

function Act248ReportView:_onFailFill(roleId)
	self:_playMarkFillAni(self._selectVacancy, false)
	AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_atlantis_error_fillin)
end

function Act248ReportView:_checkAllCorrectFill()
	if not self:_isAllCorrectFill() then
		return
	end

	if not self._fileMo:isFinish() then
		Act248Rpc.instance:sendAct248FinishReportRequest(self._actId, self._fileId, self._blankAnswerList)
	end
end

function Act248ReportView:_isAllCorrectFill()
	for index in ipairs(self._blankAnswerList) do
		if string.nilorempty(self._fillAnswerList[index]) then
			return false
		end
	end

	return true
end

function Act248ReportView:_getVacancy()
	for index in ipairs(self._blankAnswerList) do
		if string.nilorempty(self._fillAnswerList[index]) then
			return index
		end
	end

	return 1
end

function Act248ReportView:onClose()
	return
end

function Act248ReportView:onDestroyView()
	TaskDispatcher.cancelTask(self._showFinishBtn, self)
	self._clickCheck:RemoveClickDownListener()
	self._clickCheck:RemoveClickUpListener()
	self:_killTween()
	TaskDispatcher.cancelTask(self._autoFillAnswer, self)

	for _, item in pairs(self._fillMarkItems) do
		item.btn:RemoveClickListener()
	end

	for _, item in pairs(self._extraMarkItems) do
		item.btn:RemoveClickListener()
	end
end

return Act248ReportView
