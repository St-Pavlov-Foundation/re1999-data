-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_LevelDetailView.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_LevelDetailView", package.seeall)

local V4a1_BossRush_LevelDetailView = class("V4a1_BossRush_LevelDetailView", BaseView)

function V4a1_BossRush_LevelDetailView:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._gospines = gohelper.findChild(self.viewGO, "#go_spines")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._simageFrame = gohelper.findChildSingleImage(self.viewGO, "#simage_Frame")
	self._gostrategy = gohelper.findChild(self.viewGO, "Left/#go_strategy")
	self._goweakicon = gohelper.findChildImage(self.viewGO, "Left/#go_strategy/type/vertical/title/cn/icon/#image_icon")
	self._gridstrategy = gohelper.findChild(self.viewGO, "Left/#go_strategy/type/vertical/#grid")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "Left/#go_strategy/type/vertical/#scroll_desc")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Left/#go_strategy/type/vertical/#scroll_desc/Viewport/#txt_Descr")
	self._btnDescrArrow = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_strategy/type/vertical/#scroll_desc/go_arrow")
	self._goDescrArrow = gohelper.findChild(self.viewGO, "Left/#go_strategy/type/vertical/#scroll_desc/go_arrow/arrow")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Left/score/#go_AssessIcon")
	self._txtScoreNum = gohelper.findChildText(self.viewGO, "Left/score/#txt_ScoreNum")
	self._btnbonus = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_bonus")
	self._goRedPoint1 = gohelper.findChild(self.viewGO, "#btn_bonus/#go_RedPoint1")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "DetailPanel/Title/title/#simage_Title")
	self._imageIssxIcon = gohelper.findChildImage(self.viewGO, "DetailPanel/Title/title/#simage_Title/#image_IssxIcon")
	self._txtName = gohelper.findChildText(self.viewGO, "DetailPanel/Title/title/#simage_Title/#txt_Name")
	self._txtEn = gohelper.findChildText(self.viewGO, "DetailPanel/Title/title/#simage_Title/#txt_Name/#txt_En")
	self._btnSearchIcon = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/Title/title/#btn_SearchIcon")
	self._godanger = gohelper.findChild(self.viewGO, "DetailPanel/#go_danger")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#go_danger/Info/#btn_Info")
	self._scrollBuff = gohelper.findChildScrollRect(self.viewGO, "DetailPanel/#scroll_Buff")
	self._gobuff = gohelper.findChild(self.viewGO, "DetailPanel/#scroll_Buff/Viewport/Content/#go_buff")
	self._gotips = gohelper.findChild(self.viewGO, "DetailPanel/#go_tips")
	self._txtdesc = gohelper.findChildText(self.viewGO, "DetailPanel/#go_tips/tipsbg/#txt_desc")
	self._btntipClose = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#go_tips/#btn_tipClose")
	self._btnGo = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#btn_Go")
	self._txtDoubleTimes = gohelper.findChildText(self.viewGO, "DetailPanel/#btn_Go/#txt_DoubleTimes")
	self._gorank = gohelper.findChild(self.viewGO, "DetailPanel/#go_rank")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_BossRush_LevelDetailView:addEvents()
	self._btnbonus:AddClickListener(self._btnbonusOnClick, self)
	self._btnSearchIcon:AddClickListener(self._btnSearchIconOnClick, self)
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btntipClose:AddClickListener(self._btntipCloseOnClick, self)
	self._btnGo:AddClickListener(self._btnGoOnClick, self)
	self._btnDescrArrow:AddClickListener(self._btnDescrArrowOnClick, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.OnReceiveGet128InfosReply, self.refreshScore, self)
end

function V4a1_BossRush_LevelDetailView:removeEvents()
	self._btnbonus:RemoveClickListener()
	self._btnSearchIcon:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btntipClose:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._btnDescrArrow:RemoveClickListener()
	self:removeEventCb(BossRushController.instance, BossRushEvent.OnReceiveGet128InfosReply, self.refreshScore, self)
end

function V4a1_BossRush_LevelDetailView:_btnDescrArrowOnClick()
	self._openDesc = not self._openDesc

	self:_refreshDesc()
end

function V4a1_BossRush_LevelDetailView:_btntipCloseOnClick()
	self:_showResilienceTip(false)
end

function V4a1_BossRush_LevelDetailView:_btnInfoOnClick()
	self:_showResilienceTip(true)
end

function V4a1_BossRush_LevelDetailView:_btnbonusOnClick()
	BossRushController.instance:openBonusView(self.viewParam)
end

function V4a1_BossRush_LevelDetailView:_btnSearchIconOnClick()
	EnemyInfoController.instance:openBossRushEnemyInfoView(self._activityId, self._stage, self._layer)
end

function V4a1_BossRush_LevelDetailView:_btnGoOnClick()
	self:_enterFightScene()
end

function V4a1_BossRush_LevelDetailView:_enterFightScene()
	BossRushController.instance:enterFightScene(self._stage, self._layer, self._activityId)
end

function V4a1_BossRush_LevelDetailView:_editableInitView()
	self._lurkInfoItems = self:getUserDataTb_()
	self._weakItems = self:getUserDataTb_()
	self._buffItems = self:getUserDataTb_()
	self._gomask = gohelper.findChild(self.viewGO, "mask")

	gohelper.setActive(self._gomask, false)
	gohelper.setActive(self._goweakicon, false)
	gohelper.setActive(self._gobuff, false)
	self:_initAssessIcon()

	self._txtdesc.text = luaLang("p_v4a1_bossrushdangertips_txt_title")
	self._layoutscrolldesc = self._scrolldesc:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	self._openDesc = true
end

function V4a1_BossRush_LevelDetailView:onUpdateParam()
	return
end

function V4a1_BossRush_LevelDetailView:onOpen()
	self._stage = self.viewParam.stage
	self._layer = 1
	self._stageCO = self.viewParam.stageCO
	self._activityId = self._stageCO.activityId
	self._handBookMo = V3a2_BossRushModel.instance:getHandBookMoByStage(self._stage, self._activityId)
	self._stageLayerInfos = BossRushModel.instance:getStageLayersInfo(self._stage, self._activityId)
	self._layerCO = self._stageLayerInfos[self._layer].layerCO

	self:_refreshMonster()
	self:_refreshRedDot()
	self:_refreshContent()
	self:_refreshBuff()
	self:_showResilienceTip(false)
end

function V4a1_BossRush_LevelDetailView:_initAssessIcon()
	local itemClass = V1a4_BossRush_AssessIcon
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_leveldetail_assessicon, self._goAssessIcon, itemClass.__cname)

	self._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._assessIcon:initData(self, false)
end

function V4a1_BossRush_LevelDetailView:_refreshMonster()
	local skinIdList = BossRushConfig.instance:getMonsterSkinIdList(self._stage, self._activityId)
	local skinScaleList = BossRushConfig.instance:getMonsterSkinScaleList(self._stage, self._activityId)
	local skinOffsetXYs = BossRushConfig.instance:getMonsterSkinOffsetXYs(self._stage, self._activityId)
	local heartVariantId = self._stageCO.heartVariantId

	self:_initMonsterSpines(#skinIdList)
	self:_refreshStrategy()

	for i, item in ipairs(self._uiSpineList) do
		local skinId = skinIdList[i]
		local scale = skinScaleList[i]
		local offsetXY = skinOffsetXYs[i]

		item:setData(skinId)
		item:setScale(scale)
		item:setOffsetXY(offsetXY[1], offsetXY[2])

		if heartVariantId and heartVariantId ~= 0 then
			item:settVariant(heartVariantId)
		end
	end
end

function V4a1_BossRush_LevelDetailView:_refreshStrategy()
	local strategy = BossRushConfig.instance:getBossRecommendStrategy(self._stageCO.type) or {}
	local resPath = BossRushEnum.ResPath.v3a2_bossrush_strategyitem
	local res = self.viewContainer:getRes(resPath)

	gohelper.CreateObjList(self, self._createStrategyCB, strategy, self._gridstrategy, res, V3a2_BossRush_StrategyItem)
end

function V4a1_BossRush_LevelDetailView:_createStrategyCB(obj, data, index)
	obj:refreshUI(data)
end

function V4a1_BossRush_LevelDetailView:_initMonsterSpines(skinCount)
	local itemClass = V1a4_BossRushLevelDetail_Spine

	if not self._uiSpineList or skinCount > #self._uiSpineList then
		self._uiSpineList = self._uiSpineList or {}

		local st = #self._uiSpineList + 1

		for i = st, skinCount do
			local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrushleveldetail_spine, self._gospines)

			self._uiSpineList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
		end

		gohelper.setActive(self._gospines, true)
	end
end

function V4a1_BossRush_LevelDetailView:_refreshRedDot()
	local defineId = RedDotEnum.DotNode.BossRushBossReward
	local uid = BossRushRedModel.instance:getUId(defineId, self._stage)

	RedDotController.instance:addRedDot(self._goRedPoint1, defineId, uid)
end

function V4a1_BossRush_LevelDetailView:_refreshContent()
	local layer = self._layerCO.layer
	local issxIconName = BossRushConfig.instance:getIssxIconName(self._stage, layer)

	UISpriteSetMgr.instance:setCommonSprite(self._imageIssxIcon, issxIconName)
	self._simagefull:LoadImage(BossRushConfig.instance:getBossDetailFullPath(self._stage, self._activityId))
	self:refreshScore()

	self._txtName.text = self._stageCO.name
	self._txtEn.text = self._stageCO.name_en

	if self._scrolldesc then
		self._scrolldesc.verticalNormalizedPosition = 1
	end

	self._txtDescr.text = self._layerCO.desc

	ZProj.UGUIHelper.RebuildLayout(self._txtDescr.transform)
	self._simageTitle:LoadImage(BossRushConfig.instance:getBossDetailTitlePath(self._stage, self._activityId))
	self:_refreshLurk()
	self:_refreshDesc()
end

function V4a1_BossRush_LevelDetailView:refreshScore()
	local stageMo = V3a9_BossRushModel.instance:getStageMo(self._activityId, self._stage)
	local highestPoint = stageMo and stageMo.highestPoint or 0

	self._assessIcon:setData(self._stage, highestPoint, false)

	self._txtScoreNum.text = BossRushConfig.instance:getScoreStr(highestPoint)
end

function V4a1_BossRush_LevelDetailView:_refreshLurk()
	local episodeId = self._layerCO.episodeId
	local concealCo = BossRushConfig.instance:getConcealCo(episodeId)
	local bossTypeParam = BossRushConfig.instance:getBossTypeParams(self._stageCO.type)
	local careerWeak = bossTypeParam and bossTypeParam.careerWeak
	local isConceal = concealCo and concealCo.maxConceal > 0 and (not careerWeak or not (#careerWeak > 0))

	if isConceal then
		self._txtresilienceValue.text = concealCo and concealCo.maxConceal or ""

		local count = 0

		if not string.nilorempty(concealCo.spDesc) then
			local spDesc = string.split(concealCo.spDesc, "|")

			for i, desc in ipairs(spDesc) do
				local item = self:_getLurkInfoItem(i)

				item.txt.text = desc
			end

			count = #spDesc
		end

		for i = 1, #self._lurkInfoItems do
			gohelper.setActive(self._lurkInfoItems[i].go, i <= count)
		end
	else
		if not careerWeak then
			local monsterCO = BossRushConfig.instance:getMonsterCO(self._stage, self._layerCO.layer)

			if monsterCO and not string.nilorempty(monsterCO.career_weak) then
				careerWeak = string.splitToNumber(monsterCO.career_weak, "#")
			end
		end

		if careerWeak then
			for i, weak in ipairs(careerWeak) do
				local item = self:_getWeekItem(i)
				local issxIconName = FightFailView.CareerToImageName[weak]

				UISpriteSetMgr.instance:setCommonSprite(item.icon, issxIconName, true)
			end
		end

		local count = careerWeak and #careerWeak or 0

		for i = 1, #self._weakItems do
			gohelper.setActive(self._weakItems[i].go, i <= count)
		end
	end

	gohelper.setActive(self._txtdesc.gameObject, not isConceal)
	gohelper.setActive(self._goresilience, isConceal)
	gohelper.setActive(self._goweak, not isConceal)
	gohelper.setActive(self._imageIssxIcon.gameObject, isConceal)
end

function V4a1_BossRush_LevelDetailView:_getLurkInfoItem(index)
	local item = self._lurkInfoItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._txtdesc.gameObject)

		item.go = go
		item.txt = go:GetComponent(gohelper.Type_TextMesh)
		self._lurkInfoItems[index] = item
	end

	return item
end

function V4a1_BossRush_LevelDetailView:_getWeekItem(index)
	local item = self._weakItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._goweakicon.gameObject)

		item.go = go
		item.icon = go:GetComponent(gohelper.Type_Image)
		self._weakItems[index] = item
	end

	return item
end

function V4a1_BossRush_LevelDetailView:_showResilienceTip(isShow)
	gohelper.setActive(self._gotips, isShow)
end

function V4a1_BossRush_LevelDetailView:playRankBtnAnim()
	return
end

function V4a1_BossRush_LevelDetailView:_refreshBuff()
	local episodeId = self._layerCO.episodeId

	if not self._skillBuffPanel then
		self._skillBuffPanel = MonoHelper.addLuaComOnceToGo(self._scrollBuff.content.gameObject, V4a1_BossRush_SkillBuffPanel)
	end

	self._skillBuffPanel:onUpdateMO(episodeId)
end

function V4a1_BossRush_LevelDetailView:_getBuffItem(index)
	local item = self._buffItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gobuff.gameObject)

		item = MonoHelper.addLuaComOnceToGo(go, V4a1_BossRush_SkillBuffPanel)
		self._buffItems[index] = item
	end

	return item
end

function V4a1_BossRush_LevelDetailView:_refreshDesc()
	self._layoutscrolldesc.preferredHeight = self._openDesc and 400 or 0

	transformhelper.setLocalScale(self._goDescrArrow.transform, 1, self._openDesc and 1 or -1, 1)
end

function V4a1_BossRush_LevelDetailView:onClose()
	return
end

function V4a1_BossRush_LevelDetailView:onDestroyView()
	return
end

return V4a1_BossRush_LevelDetailView
