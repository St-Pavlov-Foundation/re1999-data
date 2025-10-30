﻿-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_MainView.lua

module("modules.logic.rouge2.outside.view.Rouge2_MainView", package.seeall)

local Rouge2_MainView = class("Rouge2_MainView", BaseView)

function Rouge2_MainView:onInitView()
	self._btnEventHandbook = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_EventHandbook")
	self._btnFormula = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Formula")
	self._btnRoleHandbook = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_RoleHandbook")
	self._gohandbookRedDot = gohelper.findChild(self.viewGO, "Left/#btn_RoleHandbook/#go_handbookRedDot")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_start", AudioEnum.Rouge2.EnterRouge)
	self._goimagestart = gohelper.findChild(self.viewGO, "Middle/#btn_start/#go_image_start")
	self._goprogress = gohelper.findChild(self.viewGO, "Middle/#go_progress")
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "Middle/#go_progress/#txt_difficulty")
	self._txtname = gohelper.findChildText(self.viewGO, "Middle/#go_progress/#txt_name")
	self._btnend = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_end")
	self._golocked = gohelper.findChild(self.viewGO, "Middle/#go_locked")
	self._txttime = gohelper.findChildText(self.viewGO, "Middle/#go_locked/#txt_time")
	self._btnAlchemy = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Alchemy")
	self._goalchemyRedDot = gohelper.findChild(self.viewGO, "Right/#btn_Alchemy/#go_alchemyRedDot")
	self._btnProp = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Prop")
	self._btnMedicine = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Medicine")
	self._btnTalent = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Talent")
	self._btnReview = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Review")
	self._goreviewRedDot = gohelper.findChild(self.viewGO, "Right/#btn_Review/#go_reviewRedDot")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MainView:addEvents()
	self._btnEventHandbook:AddClickListener(self._btnEventHandbookOnClick, self)
	self._btnFormula:AddClickListener(self._btnFormulaOnClick, self)
	self._btnRoleHandbook:AddClickListener(self._btnRoleHandbookOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnend:AddClickListener(self._btnendOnClick, self)
	self._btnAlchemy:AddClickListener(self._btnAlchemyOnClick, self)
	self._btnProp:AddClickListener(self._btnPropOnClick, self)
	self._btnMedicine:AddClickListener(self._btnMedicineOnClick, self)
	self._btnTalent:AddClickListener(self._btnTalentOnClick, self)
	self._btnReview:AddClickListener(self._btnReviewOnClick, self)
	Rouge2_Controller.instance:registerCallback(Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.onAlchemyInfoUpdate, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.OnUpdateRougeOutsideInfo, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.EnterGame, self.enterGame, self)
end

function Rouge2_MainView:removeEvents()
	self._btnEventHandbook:RemoveClickListener()
	self._btnFormula:RemoveClickListener()
	self._btnRoleHandbook:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnend:RemoveClickListener()
	self._btnAlchemy:RemoveClickListener()
	self._btnProp:RemoveClickListener()
	self._btnMedicine:RemoveClickListener()
	self._btnTalent:RemoveClickListener()
	self._btnReview:RemoveClickListener()
	Rouge2_Controller.instance:unregisterCallback(Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.onAlchemyInfoUpdate, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.OnUpdateRougeOutsideInfo, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.EnterGame, self.enterGame, self)
end

function Rouge2_MainView:_btnEventHandbookOnClick()
	local actId = Rouge2_Model.instance:getCurActId()

	if not Rouge2_Controller.instance:checkIsOpen(actId, true) then
		return
	end

	logNormal("点击事件图鉴")
	Rouge2_ViewHelper.openIllustrationMainView()
end

function Rouge2_MainView:_btnFormulaOnClick()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	logNormal("点击配方图鉴")
	Rouge2_OutsideController.instance:openFavoriteMainView()
end

function Rouge2_MainView:_btnRoleHandbookOnClick()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	logNormal("点击领路人图鉴")
	Rouge2_ViewHelper.openRougeCareerHandBookView()
end

function Rouge2_MainView:_btnstartOnClick()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	self:enterGame()
end

function Rouge2_MainView:enterGame()
	if Rouge2_Model.instance:isStarted() then
		self:closeThis()
		Rouge2_Controller.instance:startRouge()
	else
		self.animator:Play("close")
		AudioMgr.instance:trigger(AudioEnum.Rouge2.EnterDifficulty)

		local sceneIndex = Rouge2_Model.instance:isFinishedDifficulty() and Rouge2_OutsideEnum.SceneIndex.CareerScene or Rouge2_OutsideEnum.SceneIndex.DifficultyScene

		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.SceneSwitch, sceneIndex)
		Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
	end

	Rouge2_StatController.instance:statStart()
end

function Rouge2_MainView:onSceneSwitchFinish()
	self:closeThis()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
	Rouge2_Controller.instance:startRouge()
end

function Rouge2_MainView:_btnendOnClick()
	local actId = Rouge2_Model.instance:getCurActId()

	if not Rouge2_Controller.instance:checkIsOpen(actId, true) then
		return
	end

	self:_end()
end

function Rouge2_MainView:_btnAlchemyOnClick()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_alchemy)

	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	if Rouge2_Model.instance:isStarted() then
		GameFacade.showToast(ToastEnum.Rouge2GameStartFormulaTip)

		return
	end

	logNormal("点击炼金台")
	Rouge2_OutsideController.instance:openAlchemyView()
end

function Rouge2_MainView:_btnPropOnClick()
	local actId = Rouge2_Model.instance:getCurActId()

	if not Rouge2_Controller.instance:checkIsOpen(actId, true) then
		return
	end

	logNormal("点击材料背包")
	Rouge2_OutsideController.instance:openMaterialListView()
end

function Rouge2_MainView:_btnMedicineOnClick()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	if Rouge2_Model.instance:isStarted() then
		GameFacade.showToast(ToastEnum.Rouge2GameStartFormulaTip)

		return
	end

	logNormal("点击炼金药水详情")

	local viewParam = {}

	viewParam.state = Rouge2_OutsideEnum.AlchemySuccessViewState.Detail

	Rouge2_OutsideController.instance:openAlchemySuccessView(viewParam)
end

function Rouge2_MainView:_btnTalentOnClick()
	local actId = Rouge2_Model.instance:getCurActId()

	if not Rouge2_Controller.instance:checkIsOpen(actId, true) then
		return
	end

	logNormal("点击天赋树详情")
	Rouge2_ViewHelper.openTalentTreeView()
end

function Rouge2_MainView:_btnReviewOnClick()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	logNormal("点击回顾")
	Rouge2_OutsideController.instance:openReviewView()
end

function Rouge2_MainView:_editableInitView()
	self._btnstartCanvasGroup = self._btnstart.gameObject:GetComponent(gohelper.Type_CanvasGroup)
	self._btnstartCanvasGroup.alpha = 1
	self._txtdifficulty.text = "0"
	self._txttime.text = ""
	self._simageFormula = gohelper.findChildSingleImage(self.viewGO, "Right/#btn_Medicine/icon")
	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)

	gohelper.setActive(self._golocked, false)
end

function Rouge2_MainView:onUpdateParam()
	return
end

function Rouge2_MainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_start_2_2)
	self:refreshUI()
end

function Rouge2_MainView:onOpenFinish()
	Rouge2_Controller.instance:startEndFlow()
end

function Rouge2_MainView:_onUpdateRougeInfo()
	self:refreshUI()
end

function Rouge2_MainView:refreshUI()
	self:_refreshProgress()
	self:_refreshFormula()
	self:_refreshCDLocked()
end

function Rouge2_MainView:_refreshFormula()
	local haveFormula = Rouge2_AlchemyModel.instance:haveAlchemyInfo()

	gohelper.setActive(self._btnMedicine, haveFormula)

	if not haveFormula then
		return
	end

	local info = Rouge2_AlchemyModel.instance:getHaveAlchemyInfo()

	Rouge2_IconHelper.setFormulaIcon(info.formula, self._simageFormula)
end

function Rouge2_MainView:_refreshCDLocked()
	self:_clearCdTick()
end

function Rouge2_MainView:_isInCdStart()
	return false
end

function Rouge2_MainView:_isContinueLast()
	return RougeModel.instance:isContinueLast()
end

function Rouge2_MainView:_refreshEndBtn()
	local isContinueLast = self:_isContinueLast()
	local inInCdStart = self:_isInCdStart()

	self._btnstartCanvasGroup.alpha = inInCdStart and 0.5 or 1

	gohelper.setActive(self._btnend.gameObject, not inInCdStart and isContinueLast)
end

function Rouge2_MainView:_clearCdTick()
	gohelper.setActive(self._golocked, false)
	TaskDispatcher.cancelTask(self._onRefreshCdTick, self)
end

function Rouge2_MainView:_onRefreshCdTick()
	local leftSec = RougeOutsideModel.instance:leftCdSec()

	if leftSec < 0 then
		self:_onCdTickEnd()

		return
	end

	local h, m, s = TimeUtil.secondToHMS(leftSec)

	self._txttime.text = formatLuaLang("rougemainview_cd_fmt", h, m, s)
end

function Rouge2_MainView:_onCdTickEnd()
	self._txttime.text = ""

	self:_clearCdTick()
	self:_refreshStartBtn()
end

function Rouge2_MainView:_refreshProgress()
	local isInRouge = Rouge2_Model.instance:inRouge()
	local difficulty = Rouge2_Model.instance:getDifficulty()
	local selectDifficulty = difficulty ~= nil and difficulty ~= 0

	gohelper.setActive(self._goprogress, isInRouge and selectDifficulty)
	gohelper.setActive(self._btnend, isInRouge and selectDifficulty)

	if not selectDifficulty then
		return
	end

	local difficultyCO = Rouge2_Config.instance:getDifficultyCoById(difficulty)

	self._txtdifficulty.text = difficultyCO.title
end

function Rouge2_MainView:_end()
	GameFacade.showMessageBox(MessageBoxIdDefine.RougeMainView_AbortRequest, MsgBoxEnum.BoxType.Yes_No, self._endYesCallback, nil, nil, self, nil, nil)
end

function Rouge2_MainView:_endYesCallback()
	Rouge2_Controller.instance:tryEnd()
end

function Rouge2_MainView:onClose()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
end

function Rouge2_MainView:onDestroyView()
	return
end

return Rouge2_MainView
