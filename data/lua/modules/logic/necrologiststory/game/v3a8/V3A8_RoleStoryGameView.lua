-- chunkname: @modules/logic/necrologiststory/game/v3a8/V3A8_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v3a8.V3A8_RoleStoryGameView", package.seeall)

local V3A8_RoleStoryGameView = class("V3A8_RoleStoryGameView", BaseView)

function V3A8_RoleStoryGameView:onInitView()
	self.txtChapterName = gohelper.findChildTextMesh(self.viewGO, "Middle/#go_chapter/#txt_chapterName")
	self.txtCurIndex = gohelper.findChildTextMesh(self.viewGO, "Middle/#go_chapter/#txt_currency")
	self.txtTotal = gohelper.findChildTextMesh(self.viewGO, "Middle/#go_chapter/#txt_total")
	self.imgWeather = gohelper.findChildImage(self.viewGO, "Middle/#go_date/#image_weather")
	self.txtWeather = gohelper.findChildTextMesh(self.viewGO, "Middle/#go_date/#txt_weather")
	self.txtDate = gohelper.findChildText(self.viewGO, "Middle/#go_date/#txt_date")
	self.txtYear = gohelper.findChildText(self.viewGO, "Middle/#go_date/#txt_year")
	self.btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_goto")
	self.goEnd = gohelper.findChild(self.viewGO, "Middle/#go_end")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A8_RoleStoryGameView:addEvents()
	self:addClickCb(self.btnStart, self.onClickBtnStart, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A8_RoleStoryGameView:removeEvents()
	self:removeClickCb(self.btnStart)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A8_RoleStoryGameView:_editableInitView()
	return
end

function V3A8_RoleStoryGameView:onClickBtnStart()
	if not self.curPlotConfig then
		return
	end

	NecrologistStoryController.instance:openStoryView(self.curPlotConfig.id, self.curPlotConfig.storyId)
end

function V3A8_RoleStoryGameView:_onCloseViewFinish(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		return
	end

	self:refreshView()
end

function V3A8_RoleStoryGameView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function V3A8_RoleStoryGameView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A8_RoleStoryGameView:refreshParam()
	local viewParam = self.viewParam or {}
	local storyId = viewParam.roleStoryId

	self.heroStoryId = storyId

	if storyId then
		self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
	end
end

function V3A8_RoleStoryGameView:refreshData()
	local plotList = NecrologistStoryConfig.instance:getPlotListByStoryId(self.heroStoryId)

	self.curIndex = 0
	self.totalIndex = #plotList
	self.curPlotConfig = nil
	self.isFinish = true

	for i, config in ipairs(plotList) do
		if not self.gameBaseMO:isStoryFinish(config.id) then
			self.curIndex = i
			self.curPlotConfig = config
			self.isFinish = false

			break
		end
	end

	if self.curPlotConfig == nil then
		self.curPlotConfig = plotList[self.totalIndex]
	end
end

function V3A8_RoleStoryGameView:refreshView()
	self:refreshData()
	gohelper.setActive(self.goEnd, self.isFinish)
	gohelper.setActive(self.btnStart, not self.isFinish)

	if not self.isFinish then
		self.txtCurIndex.text = string.format("%02d", self.curIndex)
		self.txtTotal.text = string.format("%02d", self.totalIndex)
		self.txtChapterName.text = self.curPlotConfig.storyName
	end

	local weather = self.curPlotConfig.weather

	NecrologistStoryHelper.setWeatherWihteIcon(self.imgWeather, weather, true)
	NecrologistStoryHelper.setWeatherTxt(self.txtWeather, weather)

	local success, y, m1, d = NecrologistStoryHelper.stringTotimeData(self.curPlotConfig.date)

	if success then
		self.txtDate.text = string.format("%02d.%02d", m1, d)
		self.txtYear.text = y
	else
		self.txtDate.text = ""
		self.txtYear.text = ""
	end
end

function V3A8_RoleStoryGameView:onDestroyView()
	return
end

return V3A8_RoleStoryGameView
