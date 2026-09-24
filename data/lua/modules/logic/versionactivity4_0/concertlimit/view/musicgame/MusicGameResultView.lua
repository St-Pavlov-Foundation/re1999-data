-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/musicgame/MusicGameResultView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.musicgame.MusicGameResultView", package.seeall)

local MusicGameResultView = class("MusicGameResultView", BaseView)

function MusicGameResultView:onInitView()
	self._gosing = gohelper.findChild(self.viewGO, "root/#go_sing")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_sing/#btn_skip")
	self._goresult = gohelper.findChild(self.viewGO, "root/#go_result")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#go_result/#txt_desc")
	self._txtscore = gohelper.findChildText(self.viewGO, "root/#go_result/#txt_score")
	self._btnquit = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_result/btn/#btn_quit")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_result/btn/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MusicGameResultView:addEvents()
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._btnquit:AddClickListener(self._btnquitOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function MusicGameResultView:removeEvents()
	self._btnskip:RemoveClickListener()
	self._btnquit:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function MusicGameResultView:_btnskipOnClick()
	self._type = MusicGameEnum.ResultType.Score

	if self._audioId then
		AudioMgr.instance:stopPlayingID(self._audioId)
	end

	self._viewAnim:Play("switch")
	self:_refresh()
end

function MusicGameResultView:_btnquitOnClick()
	MusicGameController.instance:exitGame()
end

function MusicGameResultView:_btnrestartOnClick()
	MusicGameController.instance:restartGame()
end

function MusicGameResultView:_editableInitView()
	self._type = MusicGameEnum.ResultType.Sing
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function MusicGameResultView:onOpen()
	self:_refresh()
end

function MusicGameResultView:_refresh()
	gohelper.setActive(self._goresult, self._type == MusicGameEnum.ResultType.Score)
	gohelper.setActive(self._gosing, self._type == MusicGameEnum.ResultType.Sing)

	if self._type == MusicGameEnum.ResultType.Sing then
		self:_refreshSing()
	else
		self:_refreshScore()
	end
end

function MusicGameResultView:_refreshSing()
	local settlementCos = MusicGameConfig.instance:getSettlementCos()
	local index = math.random(1, #settlementCos)
	local settlementCo = settlementCos[index]
	local audioId = settlementCo and settlementCo.audioId or 0

	if audioId and audioId > 0 then
		self._audioId = audioId

		AudioMgr.instance:trigger(self._audioId)
	end
end

function MusicGameResultView:_refreshScore()
	local score = self.viewParam or MusicGameModel.instance:getCurScore()

	self._txtscore.text = score

	local scorelv = MusicGameModel.instance:getGameScoreLv(score)
	local lvCo = MusicGameConfig.instance:getLevelCo(scorelv)

	self._txtdesc.text = lvCo and lvCo.strValue or ""
end

function MusicGameResultView:onClose()
	return
end

function MusicGameResultView:onDestroyView()
	return
end

return MusicGameResultView
