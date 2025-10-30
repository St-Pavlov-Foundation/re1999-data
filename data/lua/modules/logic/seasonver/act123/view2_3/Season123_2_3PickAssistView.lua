﻿-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3PickAssistView.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3PickAssistView", package.seeall)

local Season123_2_3PickAssistView = class("Season123_2_3PickAssistView", BaseView)

function Season123_2_3PickAssistView:onInitView()
	self._gofilter = gohelper.findChild(self.viewGO, "#go_filter")
	self._goattrItem = gohelper.findChild(self.viewGO, "#go_filter/#go_attrItem")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gorecommendAttr = gohelper.findChild(self.viewGO, "#go_recommendAttr")
	self._txtrecommendAttrDesc = gohelper.findChildText(self.viewGO, "#go_recommendAttr/txt_recommend")
	self._goattrlist = gohelper.findChild(self.viewGO, "#go_recommendAttr/txt_recommend/#go_attrlist")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_recommendAttr/txt_recommend/#go_attrlist/#go_recommendAttrItem")
	self._btnrefresh = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_refresh")
	self._simageprogress = gohelper.findChildImage(self.viewGO, "bottom/#btn_refresh/#simage_progress")
	self._godetail = gohelper.findChild(self.viewGO, "bottom/#btn_detail")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_detail")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_3PickAssistView:addEvents()
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
	self._btndetail:AddClickListener(self._onHeroDetailClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self:addEventCb(Season123Controller.instance, Season123Event.BeforeRefreshAssistList, self.onBeforeRefreshAssistList, self)
	self:addEventCb(Season123Controller.instance, Season123Event.SetCareer, self.refreshIsEmpty, self)
	self:addEventCb(Season123Controller.instance, Season123Event.RefreshSelectAssistHero, self.refreshBtnDetail, self)
end

function Season123_2_3PickAssistView:removeEvents()
	self._btnrefresh:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self:addEventCb(Season123Controller.instance, Season123Event.BeforeRefreshAssistList, self.onBeforeRefreshAssistList, self)
	self:removeEventCb(Season123Controller.instance, Season123Event.SetCareer, self.refreshIsEmpty, self)
	self:removeEventCb(Season123Controller.instance, Season123Event.RefreshSelectAssistHero, self.refreshBtnDetail, self)
end

function Season123_2_3PickAssistView:onBeforeRefreshAssistList()
	if self.scrollView then
		self.scrollView._firstUpdate = true

		if not self.hasChangedItemDelayTime then
			self.scrollView:changeDelayTime(-self.viewContainer.viewOpenAnimTime)

			self.hasChangedItemDelayTime = true
		end
	end
end

function Season123_2_3PickAssistView:_btnrefreshOnClick()
	Season123PickAssistController.instance:manualRefreshList()
end

function Season123_2_3PickAssistView:_onHeroDetailClick()
	local selectedMO = Season123PickAssistListModel.instance:getSelectedMO()

	if selectedMO then
		CharacterController.instance:openCharacterView(selectedMO.heroMO)
	end
end

function Season123_2_3PickAssistView:_btnconfirmOnClick()
	Season123PickAssistController.instance:pickOver()
	self:closeThis()
end

function Season123_2_3PickAssistView:_btnCareerFilterOnClick(career)
	local isDirty = Season123PickAssistController.instance:setCareer(career)

	if isDirty then
		self:refreshCareerFilterItems()
	end
end

function Season123_2_3PickAssistView:_editableInitView()
	self:_setFilterBtn()
end

function Season123_2_3PickAssistView:_setFilterBtn()
	self._career2FilterItemDict = {}

	local careerValueList = {
		CharacterEnum.CareerType.Yan,
		CharacterEnum.CareerType.Xing,
		CharacterEnum.CareerType.Mu,
		CharacterEnum.CareerType.Shou,
		CharacterEnum.CareerType.Ling,
		CharacterEnum.CareerType.Zhi
	}

	self.careerTypeCount = #careerValueList

	gohelper.CreateObjList(self, self._onInitFilterBtn, careerValueList, self._gofilter, self._goattrItem)
end

function Season123_2_3PickAssistView:_onInitFilterBtn(obj, careerValue, index)
	local careerFilterBtnItem = self:getUserDataTb_()

	careerFilterBtnItem.goSelected = gohelper.findChild(obj, "#go_selected")
	careerFilterBtnItem.attrIcon = gohelper.findChildImage(obj, "#image_attrIcon")
	careerFilterBtnItem.goLine = gohelper.findChild(obj, "#go_line")
	careerFilterBtnItem.btnClick = gohelper.findChildButtonWithAudio(obj, "#btn_click")

	local isLast = index ~= self.careerTypeCount

	gohelper.setActive(careerFilterBtnItem.goLine, isLast)
	gohelper.setActive(careerFilterBtnItem.goSelected, false)
	UISpriteSetMgr.instance:setHeroGroupSprite(careerFilterBtnItem.attrIcon, "career_" .. careerValue)
	careerFilterBtnItem.btnClick:AddClickListener(self._btnCareerFilterOnClick, self, careerValue)

	self._career2FilterItemDict[careerValue] = careerFilterBtnItem
end

function Season123_2_3PickAssistView:onOpen()
	self.scrollView = self.viewContainer and self.viewContainer.scrollView

	Season123PickAssistController.instance:onOpenView(self.viewParam.actId, self.viewParam.finishCall, self.viewParam.finishCallObj, self.viewParam.selectedHeroUid)
	self:refreshUI()
	TaskDispatcher.runRepeat(self.refreshCD, self, 0.01)
	self:showRecommendCareer()
end

function Season123_2_3PickAssistView:showRecommendCareer()
	local recommendCareers = Season123Config.instance:getRecommendCareers(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage)

	if not recommendCareers then
		gohelper.setActive(self._gorecommendAttr, false)

		return
	end

	local hasRecommendCareers = #recommendCareers ~= 0
	local recommendText = hasRecommendCareers and luaLang("herogroupeditview_recommend") or luaLang("herogroupeditview_notrecommend")

	self._txtrecommendAttrDesc.text = recommendText

	if hasRecommendCareers then
		gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommendCareers, self._goattrlist, self._goattritem)
	end

	gohelper.setActive(self._goattrlist, hasRecommendCareers)
	gohelper.setActive(self._gorecommendAttr, true)
end

function Season123_2_3PickAssistView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function Season123_2_3PickAssistView:refreshUI()
	self:refreshCD()
	self:refreshCareerFilterItems()
	self:refreshIsEmpty()
	self:refreshBtnDetail()
end

function Season123_2_3PickAssistView:refreshCD()
	local cdRate = Season123PickAssistController.instance:getRefreshCDRate()

	self._simageprogress.fillAmount = cdRate
end

function Season123_2_3PickAssistView:refreshCareerFilterItems()
	for career, filterItem in pairs(self._career2FilterItemDict) do
		local selectedCareer = Season123PickAssistListModel.instance:getCareer()

		gohelper.setActive(filterItem.goSelected, career == selectedCareer)
	end
end

function Season123_2_3PickAssistView:refreshIsEmpty()
	local isHasAssistList = Season123PickAssistListModel.instance:isHasAssistList()

	gohelper.setActive(self._goempty, not isHasAssistList)
end

function Season123_2_3PickAssistView:refreshBtnDetail()
	local selectedMO = Season123PickAssistListModel.instance:getSelectedMO()

	gohelper.setActive(self._godetail, selectedMO)
end

function Season123_2_3PickAssistView:onClose()
	TaskDispatcher.cancelTask(self.refreshCD, self)
end

function Season123_2_3PickAssistView:onDestroyView()
	self:disposeCareerItems()
	Season123PickAssistController.instance:onCloseView()
end

function Season123_2_3PickAssistView:disposeCareerItems()
	if self._career2FilterItemDict then
		for _, item in pairs(self._career2FilterItemDict) do
			if item.btnClick then
				item.btnClick:RemoveClickListener()
			end
		end

		self._career2FilterItemDict = nil
	end
end

return Season123_2_3PickAssistView
