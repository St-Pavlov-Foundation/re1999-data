﻿-- chunkname: @modules/logic/season/view3_0/Season3_0HeroFightViewLevel.lua

module("modules.logic.season.view3_0.Season3_0HeroFightViewLevel", package.seeall)

local Season3_0HeroFightViewLevel = class("Season3_0HeroFightViewLevel", BaseView)

function Season3_0HeroFightViewLevel:onInitView()
	self._goTarget = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain")
	self._gonormalcondition = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition")
	self._txtnormalcondition = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#txt_normalcondition")
	self._gonormalfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalfinish")
	self._gonormalunfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalunfinish")
	self._goplatinumcondition = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition")
	self._txtplatinumcondition = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#txt_platinumcondition")
	self._goplatinumfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumfinish")
	self._goplatinumunfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumunfinish")
	self._goplatinumcondition2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2")
	self._txtplatinumcondition2 = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#txt_platinumcondition")
	self._goplatinumfinish2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumfinish")
	self._goplatinumunfinish2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumunfinish")
	self._gotargetlist = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList")
	self._goplace = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_place")
	self._gostar3 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star3")
	self._gostar2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0HeroFightViewLevel:addEvents()
	return
end

function Season3_0HeroFightViewLevel:removeEvents()
	return
end

function Season3_0HeroFightViewLevel:_editableInitView()
	self._monsterGroupItemList = {}
end

function Season3_0HeroFightViewLevel:_refreshUI()
	self._episodeId = HeroGroupModel.instance.episodeId
	self._battleId = HeroGroupModel.instance.battleId

	self:_refreshTarget()
end

function Season3_0HeroFightViewLevel:_refreshTarget()
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local episodeType = episodeConfig.type

	if episodeType == DungeonEnum.EpisodeType.SeasonRetail then
		gohelper.setActive(self._goTarget, false)

		return
	end

	gohelper.setActive(self._goTarget, true)

	local normalEpisodeId = self._episodeId
	local normalEpisodeInfo = normalEpisodeId and DungeonModel.instance:getEpisodeInfo(normalEpisodeId)
	local passStory = normalEpisodeId and DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)
	local advancedConditionText = normalEpisodeId and DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)

	gohelper.setActive(self._gonormalcondition, true)

	self._txtnormalcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(normalEpisodeId)

	local passNormal = normalEpisodeInfo and normalEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory
	local passAdvanced = normalEpisodeInfo and normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and passStory
	local passUltra = false

	gohelper.setActive(self._gonormalfinish, passNormal)
	gohelper.setActive(self._gonormalunfinish, not passNormal)
	ZProj.UGUIHelper.SetColorAlpha(self._txtnormalcondition, passNormal and 1 or 0.63)
	gohelper.setActive(self._goplatinumcondition, not string.nilorempty(advancedConditionText))

	if not string.nilorempty(advancedConditionText) then
		self._txtplatinumcondition.text = advancedConditionText

		gohelper.setActive(self._goplatinumfinish, passAdvanced)
		gohelper.setActive(self._goplatinumunfinish, not passAdvanced)
		ZProj.UGUIHelper.SetColorAlpha(self._txtplatinumcondition, passAdvanced and 1 or 0.63)
	end

	gohelper.setActive(self._goplace, false)
	self:_showStar(normalEpisodeInfo, advancedConditionText, passNormal, passAdvanced, passUltra)
end

function Season3_0HeroFightViewLevel:_initStars()
	if self._starList then
		return
	end

	local starNum = 2
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if episodeConfig.type == DungeonEnum.EpisodeType.WeekWalk then
		local mapInfo = WeekWalkModel.instance:getCurMapInfo()

		starNum = mapInfo:getStarNumConfig()
	end

	gohelper.setActive(self._gostar2, starNum == 2)
	gohelper.setActive(self._gostar3, starNum == 3)

	local starGo = starNum == 2 and self._gostar2 or self._gostar3

	self._starList = self:getUserDataTb_()

	for i = 1, starNum do
		local star = gohelper.findChildImage(starGo, "star" .. i)

		table.insert(self._starList, star)
	end
end

function Season3_0HeroFightViewLevel:_showStar(episodeInfo, advancedConditionText, passNormal, passAdvanced, passUltra)
	self:_initStars()
	gohelper.setActive(self._starList[1].gameObject, true)
	self:_setStar(self._starList[1], passNormal)

	if string.nilorempty(advancedConditionText) then
		gohelper.setActive(self._starList[2].gameObject, false)
	else
		gohelper.setActive(self._starList[2].gameObject, true)
		self:_setStar(self._starList[2], passAdvanced)

		if self._starList[3] then
			gohelper.setActive(self._starList[3].gameObject, true)
			self:_setStar(self._starList[3], passUltra)
		end
	end
end

function Season3_0HeroFightViewLevel:_setStar(image, light, double)
	local star = "zhuxianditu_pt_xingxing_001"
	local color = light and "#F77040" or "#87898C"

	UISpriteSetMgr.instance:setCommonSprite(image, star, true)
	SLFramework.UGUI.GuiHelper.SetColor(image, color)
end

function Season3_0HeroFightViewLevel:onOpen()
	self:_refreshUI()
end

function Season3_0HeroFightViewLevel:onClose()
	return
end

function Season3_0HeroFightViewLevel:onDestroyView()
	return
end

return Season3_0HeroFightViewLevel
