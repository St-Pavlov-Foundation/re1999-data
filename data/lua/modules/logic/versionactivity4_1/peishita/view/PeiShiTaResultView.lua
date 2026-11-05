-- chunkname: @modules/logic/versionactivity4_1/peishita/view/PeiShiTaResultView.lua

module("modules.logic.versionactivity4_1.peishita.view.PeiShiTaResultView", package.seeall)

local PeiShiTaResultView = class("PeiShiTaResultView", BaseView)

function PeiShiTaResultView:onInitView()
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._btnquitgame2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_quitgame2")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "targets/#go_targetitem/txt_taskdesc")
	self._gofinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/go_finish")
	self._gounfinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/go_unfinish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PeiShiTaResultView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnquitgame2:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function PeiShiTaResultView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnquitgame2:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function PeiShiTaResultView:_btnquitgameOnClick()
	PeiShiTaGameController.instance:endGame()
	self:closeThis()
end

function PeiShiTaResultView:_btnrestartOnClick()
	PeiShiTaGameModel.instance:restartGame()
	self:closeThis()
end

function PeiShiTaResultView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self._btnquitgameOnClick, self)
end

function PeiShiTaResultView:onUpdateParam()
	return
end

function PeiShiTaResultView:onOpen()
	self._actId = PeiShiTaController.instance:getActId()
	self._gameMo = PeiShiTaGameModel.instance:getGameMo()
	self._gameId = self._gameMo and self._gameMo.gameId
	self._gameCo = PeiShiTaGameConfig.instance:getGame(self._actId, self._gameId)
	self._isSuccess = self._gameMo and self._gameMo.isSuccess

	gohelper.setActive(self._gosuccess, self._isSuccess)
	gohelper.setActive(self._gofail, not self._isSuccess)
	gohelper.setActive(self._gofinish, self._isSuccess)
	gohelper.setActive(self._gounfinish, not self._isSuccess)
	gohelper.setActive(self._btnrestart.gameObject, not self._isSuccess)
	gohelper.setActive(self._btnquitgame.gameObject, not self._isSuccess)
	gohelper.setActive(self._btnquitgame2.gameObject, self._isSuccess)

	local desc = self._gameCo and self._gameCo.targetDesc or ""

	self._txttaskdesc.text = SkillHelper.buildDesc(desc)

	local audioId = self._isSuccess and AudioEnum4_1.PeiShiTa.play_ui_beiai_kapai_win or AudioEnum4_1.PeiShiTa.play_ui_activity_2_8_fuleyuan_nuodika

	AudioMgr.instance:trigger(audioId)
end

function PeiShiTaResultView:onClose()
	return
end

function PeiShiTaResultView:onDestroyView()
	return
end

return PeiShiTaResultView
