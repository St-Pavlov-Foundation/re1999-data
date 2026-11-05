-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_ResultView.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_ResultView", package.seeall)

local V4a1_BossRush_ResultView = class("V4a1_BossRush_ResultView", V3a2_BossRush_ResultView)

function V4a1_BossRush_ResultView:_editableInitView()
	V4a1_BossRush_ResultView.super._editableInitView(self)

	self._godanger = gohelper.findChild(self.viewGO, "#go_danger")
	self._simaggBoss = gohelper.findChildSingleImage(self.viewGO, "boss_topbg1/resultsmallbg")
	self._imaggBoss = gohelper.findChildImage(self.viewGO, "boss_topbg1/resultsmallbg")

	local go = gohelper.findChild(self.viewGO, "#go_danger/dangerrankview")

	self._skillBuffItem = MonoHelper.addLuaComOnceToGo(go, V4a1_BossRush_DangerPanel)

	self._skillBuffItem:setViewContainer(self.viewContainer)
end

function V4a1_BossRush_ResultView:_initBoss()
	if self._curStage then
		self._simageFullBG:LoadImage(BossRushConfig.instance:getBossDetailFullPath(self._curStage, self._actId))
		self._simageTitle:LoadImage(BossRushConfig.instance:getBossDetailTitlePath(self._curStage, self._actId))

		local bossRes = BossRushConfig.instance:getResultViewBossSImage(self._curStage, self._actId)

		if not string.nilorempty(bossRes) then
			self._simaggBoss:LoadImage(bossRes, function()
				self._imaggBoss:SetNativeSize()
			end)
		end

		local stageCO = BossRushConfig.instance:getStageCO(self._curStage, self._actId)

		self._txtName.text = stageCO.name
		self._txtEn.text = stageCO.name_en

		local bossOffset = stageCO.resultViewBossOffset
		local x, y = 0, 0

		if not string.nilorempty(bossOffset) then
			local offsets = string.splitToNumber(bossOffset, "#")

			x = offsets[1]
			y = offsets[2]
		end

		recthelper.setAnchor(self._simaggBoss.transform, x, y)
	end
end

function V4a1_BossRush_ResultView:onOpen()
	local stage, layer, actId = BossRushModel.instance:getBattleStageAndLayer()
	local isCurSeason = V4a1_BossRushModel.instance:isCurSeason(actId)

	self._isCurSeason = isCurSeason

	V4a1_BossRush_ResultView.super.onOpen(self)

	local isShow = false

	if isCurSeason then
		if not self._skillBuffItem then
			local go = self:getResInst(self.viewContainer:getSetting().otherRes.dangerPanel, self._godanger.gameObject)

			self._skillBuffItem = MonoHelper.addLuaComOnceToGo(go, V4a1_BossRush_DangerPanel)

			self._skillBuffItem:setViewContainer(self.viewContainer)
		end

		local layerCo = BossRushConfig.instance:getEpisodeCO(stage, layer, actId)

		isShow = self._skillBuffItem:onUpdateMO(self.fightScore, layerCo.episodeId, nil, nil, true)
	end

	gohelper.setActive(self._godanger, isShow)
end

function V4a1_BossRush_ResultView:_refreshScore()
	local score = V3a2_BossRushModel.instance:getScore()

	self._scoreItems = self:getUserDataTb_()

	if self._isCurSeason then
		local lang = "v3a2BossRush_Result_TotalScore"

		self._txtdesc.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(lang), self.fightScore or 0)

		gohelper.setActive(self._txtdesc.gameObject, true)
	else
		gohelper.setActive(self._txtdesc.gameObject, false)

		for i = 1, 3 do
			local item = self._scoreItems[i]

			if not item then
				item = self:getUserDataTb_()

				local go = gohelper.cloneInPlace(self._txtdesc.gameObject)
				local txt = go:GetComponent(gohelper.Type_TextMesh)

				item.go = go
				item.txt = txt
				self._scoreItems[i] = item
			end

			local lang, scoreTxt

			if i == 1 then
				lang = "v3a2BossRush_Result_BaseScore"
				scoreTxt = score and score.baseScore or 0
			elseif i == 2 then
				lang = "v3a2BossRush_Result_RuleScore"
				scoreTxt = score and score.ruleScore or 0
			else
				lang = "v3a2BossRush_Result_TotalScore"
				scoreTxt = self.fightScore
			end

			item.txt.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(lang), scoreTxt or 0)

			gohelper.setActive(item.go, true)
		end
	end
end

return V4a1_BossRush_ResultView
