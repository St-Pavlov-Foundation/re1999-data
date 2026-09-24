-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeGameResultView.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeGameResultView", package.seeall)

local DeleikeGameResultView = class("DeleikeGameResultView", BaseView)

function DeleikeGameResultView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goSuccess = gohelper.findChild(self.viewGO, "#go_Success")
	self._goFail = gohelper.findChild(self.viewGO, "#go_Fail")
	self._txtTarget = gohelper.findChildText(self.viewGO, "targets/TargetItem/#txt_Target")
	self._goFinish = gohelper.findChild(self.viewGO, "targets/TargetItem/result/#go_Finish")
	self._btnQuit = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_Quit")
	self._btnRestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_Restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DeleikeGameResultView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnQuit:AddClickListener(self._btnQuitOnClick, self)
	self._btnRestart:AddClickListener(self._btnRestartOnClick, self)
end

function DeleikeGameResultView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnQuit:RemoveClickListener()
	self._btnRestart:RemoveClickListener()
end

function DeleikeGameResultView:_btnCloseOnClick()
	self:closeThis()
	DeleikeGameMgr.instance:endGame()
end

function DeleikeGameResultView:_btnQuitOnClick()
	self:closeThis()
	DeleikeGameMgr.instance:endGame()
end

function DeleikeGameResultView:_btnRestartOnClick()
	self:closeThis()
	DeleikeController.instance:dispatchEvent(DeleikeEvent.RestartGame)
end

function DeleikeGameResultView:onOpen()
	DeleikeGameMgr.instance:setInputLocked(true)

	local gameCfg = DeleikeGameMgr.instance.gameCfg

	self._txtTarget.text = gameCfg.targetDesc
end

return DeleikeGameResultView
