-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayResultView.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayResultView", package.seeall)

local GuessGameNewPlayResultView = class("GuessGameNewPlayResultView", BaseView)

function GuessGameNewPlayResultView:onInitView()
	self._goclick = gohelper.findChild(self.viewGO, "root/bg/#go_click")
	self._gobtns = gohelper.findChild(self.viewGO, "root/#go_btns")
	self._btnquit = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_quit")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_restart")
	self._gotask = gohelper.findChild(self.viewGO, "root/#go_task")
	self._gotaskitem1 = gohelper.findChild(self.viewGO, "root/#go_task/go_taskItem1")
	self._txttaskitem1num = gohelper.findChildText(self.viewGO, "root/#go_task/go_taskItem1/#txt_num")
	self._gotaskitem2 = gohelper.findChild(self.viewGO, "root/#go_task/go_taskItem2")
	self._txttaskitem2num = gohelper.findChildText(self.viewGO, "root/#go_task/go_taskItem2/#txt_num")
	self._gotaskitem3 = gohelper.findChild(self.viewGO, "root/#go_task/go_taskItem3")
	self._gohp = gohelper.findChild(self.viewGO, "root/#go_task/go_taskItem3/#go_hp")
	self._gohpitem = gohelper.findChild(self.viewGO, "root/#go_task/go_taskItem3/#go_hp/go_hpitem")
	self._goscore = gohelper.findChild(self.viewGO, "root/#go_score")
	self._txtscore = gohelper.findChildText(self.viewGO, "root/#go_score/#txt_score")
	self._goeffect = gohelper.findChild(self.viewGO, "root/#go_score/#go_effect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameNewPlayResultView:addEvents()
	self._btnquit:AddClickListener(self._btnquitOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function GuessGameNewPlayResultView:removeEvents()
	self._btnquit:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function GuessGameNewPlayResultView:_btnquitOnClick()
	GuessGameNewController.instance:exitGame()
end

function GuessGameNewPlayResultView:_btnrestartOnClick()
	GuessGameNewController.instance:restartGame()
end

function GuessGameNewPlayResultView:_onEscapelick()
	self:_btnquitOnClick()
end

function GuessGameNewPlayResultView:_addEvents()
	self._btnclose:AddClickListener(self._btnquitOnClick, self)
end

function GuessGameNewPlayResultView:_removeEvents()
	self._btnclose:RemoveClickListener()
end

function GuessGameNewPlayResultView:_editableInitView()
	self._actId = VersionActivity4_1Enum.ActivityId.GuessGameNew

	self:_initView()
	self:_addEvents()
end

function GuessGameNewPlayResultView:_initView()
	NavigateMgr.instance:addEscape(self.viewName, self._onEscapelick, self)

	self._btnclose = gohelper.getClick(self._goclick)
	self._hpItems = {}

	gohelper.setActive(self._gohpitem, false)
end

function GuessGameNewPlayResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_settlement_bonus)
	self:_refreshUI()
end

function GuessGameNewPlayResultView:_refreshUI()
	local isFirstShow = self.viewParam
	local multi = 1

	if isFirstShow then
		local ctrlCo = GuessGameNewConfig.instance:getCtrlCo(self._actId)

		multi = ctrlCo and ctrlCo.magnificationRate or 1
	end

	local resultScore = GuessGameNewModel.instance:getGameScore()

	self._txtscore.text = multi * resultScore

	gohelper.setActive(self._goeffect, isFirstShow)

	local playerRoleMo = GuessGameNewModel.instance:getRoleData(GuessGameNewEnum.RoleType.Player)
	local bluffSuccessTimes = playerRoleMo.bluffSuccessTimes

	self._txttaskitem1num.text = bluffSuccessTimes

	local guessSuccessTimes = playerRoleMo.guessSuccessTimes

	self._txttaskitem2num.text = guessSuccessTimes

	self:_refreshHp()
end

function GuessGameNewPlayResultView:_refreshHp()
	local initHp = GuessGameNewConfig.instance:getConstNumberValue(GuessGameNewEnum.ConstId.LifeValue)

	for i = 1, initHp do
		if not self._hpItems[i] then
			self._hpItems[i] = GuessGameNewPlayHpItem.New()

			local go = gohelper.clone(self._gohpitem, self._gohp)

			self._hpItems[i]:init(go, i, GuessGameNewEnum.RoleType.Player)
		end

		self._hpItems[i]:refresh()
	end
end

function GuessGameNewPlayResultView:onClose()
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnFinishGameBackToMain)
end

function GuessGameNewPlayResultView:onDestroyView()
	self:_removeEvents()
end

return GuessGameNewPlayResultView
