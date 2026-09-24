-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightQuitTipView.lua

module("modules.logic.matchgame.fight.view.MatchGameFightQuitTipView", package.seeall)

local MatchGameFightQuitTipView = class("MatchGameFightQuitTipView", BaseView)

function MatchGameFightQuitTipView:onInitView()
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "center/btn/#btn_quitgame")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "center/btn/#btn_cancel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameFightQuitTipView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function MatchGameFightQuitTipView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function MatchGameFightQuitTipView:_btnquitgameOnClick()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.QuitGame)
	self:closeThis()
end

function MatchGameFightQuitTipView:_btncancelOnClick()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.ContinueGame)
	self:closeThis()
end

function MatchGameFightQuitTipView:_editableInitView()
	NavigateMgr.instance:addEscape(ViewName.MatchGameFightQuitTipView, self._btncancelOnClick, self)
end

function MatchGameFightQuitTipView:onUpdateParam()
	return
end

function MatchGameFightQuitTipView:onOpen()
	return
end

function MatchGameFightQuitTipView:onClose()
	return
end

function MatchGameFightQuitTipView:onDestroyView()
	return
end

return MatchGameFightQuitTipView
