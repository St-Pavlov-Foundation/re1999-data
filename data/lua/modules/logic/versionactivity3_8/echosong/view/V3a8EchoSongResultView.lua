-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongResultView.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongResultView", package.seeall)

local V3a8EchoSongResultView = class("V3a8EchoSongResultView", BaseView)

function V3a8EchoSongResultView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8EchoSongResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function V3a8EchoSongResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function V3a8EchoSongResultView:_btncloseOnClick()
	if self._isWin then
		self:closeThis()
	end
end

function V3a8EchoSongResultView:_btnquitgameOnClick()
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.V3a8EchoSongGameView)
end

function V3a8EchoSongResultView:_btnrestartOnClick()
	V3a8EchoSongController.instance:statGameStart()
	self:closeThis()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.RestartGame)
end

function V3a8EchoSongResultView:_editableInitView()
	self._goBtn = gohelper.findChild(self.viewGO, "btn")
end

function V3a8EchoSongResultView:onUpdateParam()
	return
end

function V3a8EchoSongResultView:onOpen()
	self._isWin = self.viewParam and self.viewParam.isSuccess
	self._episodeId = V3a8EchoSongModel.instance:getGameEpisodeId()

	gohelper.setActive(self._gosuccess, self._isWin)
	gohelper.setActive(self._gofail, not self._isWin)
	gohelper.setActive(self._goBtn, not self._isWin)
end

function V3a8EchoSongResultView:onClose()
	if self._isWin and self._episodeId then
		ViewMgr.instance:closeView(ViewName.V3a8EchoSongGameView)
		V3a8EchoSongController.instance:finishEpisodeLevel(self._episodeId)
	end
end

function V3a8EchoSongResultView:onDestroyView()
	return
end

return V3a8EchoSongResultView
