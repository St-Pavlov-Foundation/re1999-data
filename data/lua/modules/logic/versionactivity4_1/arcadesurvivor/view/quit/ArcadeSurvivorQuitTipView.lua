-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/quit/ArcadeSurvivorQuitTipView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.quit.ArcadeSurvivorQuitTipView", package.seeall)

local ArcadeSurvivorQuitTipView = class("ArcadeSurvivorQuitTipView", BaseView)

function ArcadeSurvivorQuitTipView:onInitView()
	self._goquitshowview = gohelper.findChild(self.viewGO, "#go_quitshowview")
	self._btnquitgame = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_quitshowview/center/btn/#btn_quitgame")
	self._btnrestart = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_quitshowview/center/btn/#btn_restart")
	self._btnhome = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_quitshowview/center/btn/#btn_home")
	self._btncancel = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_quitshowview/center/btn/#btn_cancel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorQuitTipView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnhome:AddClickListener(self._btnhomeOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function ArcadeSurvivorQuitTipView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnhome:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function ArcadeSurvivorQuitTipView:_btnquitgameOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.ExitArcadeGame, MsgBoxEnum.BoxType.Yes_No, self._confirmQuitGame, nil, nil, self, nil, nil)
end

function ArcadeSurvivorQuitTipView:_confirmQuitGame()
	ArcadeSurvivorController.instance:closeGameView()
	self:closeThis()
end

function ArcadeSurvivorQuitTipView:_btnrestartOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.ResetArcadeGame, MsgBoxEnum.BoxType.Yes_No, self._confirmRestart, nil, nil, self, nil, nil)
end

function ArcadeSurvivorQuitTipView:_confirmRestart()
	ArcadeSurvivorGameController.instance:endGame(ArcadeSurvivorGameEnum.SettleType.Abandon, false, true)
	self:closeThis()
end

function ArcadeSurvivorQuitTipView:_btnhomeOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.AbandonArcadeGame, MsgBoxEnum.BoxType.Yes_No, self._confirmAbandon, nil, nil, self, nil, nil)
end

function ArcadeSurvivorQuitTipView:_confirmAbandon()
	ArcadeSurvivorGameController.instance:endGame(ArcadeSurvivorGameEnum.SettleType.Abandon, false)
	self:closeThis()
end

function ArcadeSurvivorQuitTipView:_btncancelOnClick()
	self:closeThis()
end

function ArcadeSurvivorQuitTipView:onClickModalMask()
	self:closeThis()
end

function ArcadeSurvivorQuitTipView:_editableInitView()
	return
end

function ArcadeSurvivorQuitTipView:onUpdateParam()
	return
end

function ArcadeSurvivorQuitTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)
	self:_refreshBtn()
end

function ArcadeSurvivorQuitTipView:_refreshBtn()
	local isInGuideLevel = ArcadeSurvivorGameModel.instance:getIsInGuideLevel()
	local isShow = not isInGuideLevel

	gohelper.setActive(self._btnrestart.gameObject, isShow)
	gohelper.setActive(self._btnhome.gameObject, isShow)
end

function ArcadeSurvivorQuitTipView:onClose()
	ArcadeSurvivorGameController.instance:resumeGame(ArcadeSurvivorGameEnum.StopSource.QuitTip)
end

function ArcadeSurvivorQuitTipView:onDestroyView()
	return
end

return ArcadeSurvivorQuitTipView
