-- chunkname: @modules/logic/versionactivity4_1/act248/view/enter/Act248EnterView.lua

module("modules.logic.versionactivity4_1.act248.view.enter.Act248EnterView", package.seeall)

local Act248EnterView = class("Act248EnterView", BaseView)

function Act248EnterView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg/#simage_mask")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._txttime = gohelper.findChildText(self.viewGO, "#txt_time")
	self._godesc = gohelper.findChild(self.viewGO, "descbg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._btnclue = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_clue")
	self._gocluereddot = gohelper.findChild(self.viewGO, "#btn_clue/reddot")
	self._btnclueinfo = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_clueinfo")
	self._goclueinforeddot = gohelper.findChild(self.viewGO, "#btn_clueinfo/reddot")
	self._txtcluenum = gohelper.findChildText(self.viewGO, "#btn_clue/#txt_num")
	self._txtfilenum = gohelper.findChildText(self.viewGO, "#btn_clueinfo/#txt_num")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248EnterView:addEvents()
	self._btnclue:AddClickListener(self._btnclueOnClick, self)
	self._btnclueinfo:AddClickListener(self._btnclueinfoOnClick, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onFinishReport, self._refreshUI, self)
end

function Act248EnterView:removeEvents()
	self._btnclue:RemoveClickListener()
	self._btnclueinfo:RemoveClickListener()
	self:removeEventCb(Act248Controller.instance, Act248Event.onFinishReport, self._refreshUI, self)
end

function Act248EnterView:_btnclueOnClick()
	Act248Controller.instance:openAct248ClueMainView(false)
end

function Act248EnterView:_btnclueinfoOnClick()
	Act248Controller.instance:openAct248FileView()
end

function Act248EnterView:_editableInitView()
	RedDotController.instance:addRedDot(self._gocluereddot, RedDotEnum.DotNode.Act248Clue)
	RedDotController.instance:addRedDot(self._goclueinforeddot, RedDotEnum.DotNode.Act248File)
end

function Act248EnterView:onUpdateParam()
	return
end

function Act248EnterView:onOpen()
	self:_refreshUI()
	self:_refreshRemainTime()
	TaskDispatcher.runRepeat(self._refreshRemainTime, self, TimeUtil.OneMinuteSecond)
end

function Act248EnterView:_refreshUI()
	local fileFinishCount, fileCount = Act248Model.instance:getFinishFileCount()
	local clueHasCount, clueTotalCount = Act248Model.instance:getHasClueCount()
	local lang = luaLang("act248_progress")

	self._txtcluenum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, clueHasCount, clueTotalCount)
	self._txtfilenum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, fileFinishCount, fileCount)
	self.actId = Act248Model.instance:getActId()

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self._txtdesc.text = actCo.actDesc

	gohelper.setActive(self._godesc, not string.nilorempty(actCo.actDesc))
	AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_leimi_theft_open)
end

function Act248EnterView:_refreshRemainTime()
	if not self._txttime then
		return
	end

	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		self._txttime.text = dateStr

		gohelper.setActive(self._txttime, true)
	else
		gohelper.setActive(self._txttime, false)
	end
end

function Act248EnterView:onClose()
	TaskDispatcher.cancelTask(self._refreshRemainTime, self)
end

function Act248EnterView:onDestroyView()
	return
end

return Act248EnterView
