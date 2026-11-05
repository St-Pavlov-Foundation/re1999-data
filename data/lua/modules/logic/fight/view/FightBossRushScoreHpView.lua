-- chunkname: @modules/logic/fight/view/FightBossRushScoreHpView.lua

module("modules.logic.fight.view.FightBossRushScoreHpView", package.seeall)

local FightBossRushScoreHpView = class("FightBossRushScoreHpView", FightBaseView)

FightBossRushScoreHpView.OneBarScore = 100000
FightBossRushScoreHpView.ScoreDuration = 0.5
FightBossRushScoreHpView.BossHitEffPath = "Alpha/bossHp/uieff_bosshit"

local Color = {
	{
		"#B33E2D",
		"#6F2216"
	},
	{
		"#D9852B",
		"#693700"
	},
	{
		"#69995E",
		"#243B1E"
	},
	{
		"#69995E",
		"#243B1E"
	},
	{
		"#69995E",
		"#243B1E"
	}
}
local HpCountColorNormal = "#FFFFFF"

function FightBossRushScoreHpView:onInitView()
	self.vector3 = Vector3()

	self:_initNodes()
	self:_hideUnusedNodes()

	local battleId = FightDataHelper.fieldMgr.battleId
	local battleCo = lua_battle.configDict[battleId]
	local bossHpType = battleCo and battleCo.bossHpType
	local typeArr = not string.nilorempty(bossHpType) and FightStrUtil.instance:getSplitCache(bossHpType, "#")

	self.oneMaxHp = typeArr and tonumber(typeArr[2]) or FightBossRushScoreHpView.OneBarScore
	self.tweenHp = 0
	self.targetHp = 0

	self:_cachePhaseScoreList()
end

function FightBossRushScoreHpView:addEvents()
	self:com_registFightEvent(FightEvent.OnIndicatorChange, self._onIndicatorChange)
	self:com_registFightEvent(FightEvent.RespBeginRound, self._checkBossAndUpdate)
	self:com_registFightEvent(FightEvent.OnChangeEntity, self._checkBossAndUpdate)
	self:com_registFightEvent(FightEvent.OnSummon, self._checkBossAndUpdate)
	self:com_registFightEvent(FightEvent.GMHideFightView, self._checkBossAndUpdate)
	self:com_registFightEvent(FightEvent.OnEntityDead, self._onEntityDead)
	self:com_registFightEvent(FightEvent.OnBeginWave, self._onBeginWave)
	self:com_registFightEvent(FightEvent.OnMonsterChange, self._onMonsterChange)
	self:com_registFightEvent(FightEvent.PushTeamInfo, self._onMonsterChange)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self._onRestartStage)
	self:com_registFightEvent(FightEvent.ChangeCareer, self._onChangeCareer)
end

function FightBossRushScoreHpView:onOpen()
	self._btnpassiveSkill:AddClickListener(self._onClickPassiveSkill, self)
	self:_openLevelBar()
	self:_checkBossAndUpdate()
end

function FightBossRushScoreHpView:onClose()
	self._btnpassiveSkill:RemoveClickListener()
end

function FightBossRushScoreHpView:onDestroyView()
	self:clearHpTween()
end

function FightBossRushScoreHpView:_initNodes()
	self._bossHpGO = gohelper.findChild(self.viewGO, "Alpha/bossHp")
	self._hp_container_tran = gohelper.findChild(self.viewGO, "Alpha/bossHp/mask/container").transform
	self.hp = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/mask/container/imgHp")

	gohelper.setActive(self.hp.gameObject, true)

	self.bgHp = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/mask/container/unlimitedhp")
	self.bgHpGo = self.bgHp.gameObject

	gohelper.setActive(self.bgHpGo, true)

	self.txtSurvivalHpCount = gohelper.findChildText(self.viewGO, "Alpha/bossHp/mask/container/#txt_survival_hp_count")

	gohelper.setActive(self.txtSurvivalHpCount.gameObject, true)

	self._txtHp = gohelper.findChildText(self.viewGO, "Alpha/bossHp/mask/container/imgHp/txtHp")
	self._imgHead = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/headbg/imgHead")
	self._imgHeadIcon = self._imgHead
	self._imgCareer = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/headbg/imgCareer")
	self.toughnessObj = gohelper.findChild(self.viewGO, "toughness")
	self.weakCareerObj = gohelper.findChild(self.viewGO, "Alpha/bossHp/weekness")
	self._passiveSkillPrefab = gohelper.findChild(self.viewGO, "Alpha/bossHp/passiveSkills/item")
	self._btnpassiveSkill = gohelper.findChildButtonWithAudio(self.viewGO, "Alpha/bossHp/passiveSkills/btn_passiveclick")

	gohelper.setActive(self._passiveSkillPrefab, false)

	self._specialSkillGOs = self:getUserDataTb_()
	self._passiveSkillImgs = self:getUserDataTb_()
	self.bossSkillInfos = {}

	self:_initBossHitEffect()
end

function FightBossRushScoreHpView:_hideUnusedNodes()
	local unusedPaths = {
		"Alpha/bossHp/mask/container/reducehp",
		"Alpha/bossHp/mask/container/imgProtect",
		"Alpha/bossHp/choushi",
		"Alpha/bossHp/#hpeffect",
		"Alpha/bossHp/mask/container/imgHp/imgSignHpContainer",
		"Alpha/bossHp/image_HPBG",
		"Alpha/bossHp/exPoint",
		"Alpha/bossHp/#go_assisthpbar",
		"Alpha/bossHp/actionbar"
	}

	for _, path in ipairs(unusedPaths) do
		local obj = gohelper.findChild(self.viewGO, path)

		if obj then
			gohelper.setActive(obj, false)
		end
	end

	if self._txtHp then
		self._txtHp.text = ""
	end
end

function FightBossRushScoreHpView:_checkBossAndUpdate()
	if self._bossHasDead then
		gohelper.setActive(self._bossHpGO, false)
		self:_setLevelBarVisible(false)

		self._bossEntityMO = nil

		self:clearHpTween()

		return
	end

	if self._bossEntityMO and not FightDataHelper.entityMgr:getById(self._bossEntityMO.id) then
		self._bossEntityMO = nil
	end

	if not self._bossEntityMO then
		self._bossEntityMO = self:_getBossEntityMO()

		if self._bossEntityMO then
			self:newClass(FightBossHpToughness, self.toughnessObj, self._bossEntityMO)
			self:newClass(FightBossHpWeakCareers, self.weakCareerObj, self._bossEntityMO)
		end
	end

	local visible = self._bossEntityMO and GMFightShowState.bossHp

	gohelper.setActive(self._bossHpGO, visible)
	self:_setLevelBarVisible(visible)

	if self._bossEntityMO then
		self:_refreshBossHead()
		self:_updatePassiveSkill()
		self:_updateScoreImmediately()
	else
		self:clearHpTween()
	end
end

function FightBossRushScoreHpView:_getBossEntityMO()
	local bossId = self:_getBossId()

	if not bossId then
		return
	end

	local enemyEntityMOList = FightDataHelper.entityMgr:getEnemyNormalList()

	for _, entityMO in ipairs(enemyEntityMOList) do
		if FightHelper.isBossId(bossId, entityMO.modelId) then
			return entityMO
		end
	end
end

function FightBossRushScoreHpView:_getBossId()
	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]

	return monsterGroupCO and not string.nilorempty(monsterGroupCO.bossId) and monsterGroupCO.bossId or nil
end

function FightBossRushScoreHpView:_onBeginWave()
	self._bossHasDead = nil

	self:_checkBossAndUpdate()
end

function FightBossRushScoreHpView:_onEntityDead(entityId)
	if self._bossEntityMO and self._bossEntityMO.id == entityId then
		self._bossHasDead = true

		self:_checkBossAndUpdate()
	end
end

function FightBossRushScoreHpView:_onMonsterChange()
	self._bossEntityMO = nil

	self:_checkBossAndUpdate()
end

function FightBossRushScoreHpView:_onRestartStage()
	gohelper.setActive(self._bossHpGO, false)
	self:_setLevelBarVisible(false)

	self._bossEntityMO = nil
end

function FightBossRushScoreHpView:_onChangeCareer(entityId)
	if self._bossEntityMO and entityId == self._bossEntityMO.id then
		self:_refreshCareer()
	end
end

function FightBossRushScoreHpView:_refreshBossHead()
	if not self._bossEntityMO then
		return
	end

	self:_refreshHeadIcon()
	self:_refreshCareer()
end

function FightBossRushScoreHpView:_refreshHeadIcon()
	if not self._bossEntityMO then
		return
	end

	local monsterCO = lua_monster.configDict[self._bossEntityMO.modelId]
	local skinCO = monsterCO and FightConfig.instance:getSkinCO(monsterCO.skinId)
	local headIcon = skinCO and skinCO.headIcon

	if not string.nilorempty(headIcon) then
		gohelper.setActive(self._imgHead.gameObject, true)
		gohelper.getSingleImage(self._imgHead.gameObject):LoadImage(ResUrl.monsterHeadIcon(headIcon))

		if monsterCO.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(monsterCO.heartVariantId), self._imgHeadIcon)
		end
	else
		gohelper.setActive(self._imgHead.gameObject, false)
	end
end

function FightBossRushScoreHpView:_refreshCareer()
	if not self._bossEntityMO or not self._imgCareer then
		return
	end

	local version = FightModel.instance:getVersion()

	if version >= 2 then
		UISpriteSetMgr.instance:setCommonSprite(self._imgCareer, "sx_icon_" .. tostring(self._bossEntityMO.career))
	else
		local monsterCO = lua_monster.configDict[self._bossEntityMO.modelId]

		UISpriteSetMgr.instance:setCommonSprite(self._imgCareer, "sx_icon_" .. tostring(monsterCO.career))
	end
end

function FightBossRushScoreHpView:_updatePassiveSkill()
	if not self._bossEntityMO then
		return
	end

	local monsterCO = lua_monster.configDict[self._bossEntityMO.modelId]
	local skills = FightConfig.instance:getPassiveSkillsAfterUIFilter(monsterCO.id)

	skills = FightConfig.instance:_filterSpeicalSkillIds(skills, true)
	self.bossSkillInfos = {}

	for i = 1, #skills do
		local skillId = skills[i]
		local specialCO = lua_skill_specialbuff.configDict[skillId]

		if specialCO then
			local specialSkillTable = self._specialSkillGOs[i]

			if not specialSkillTable then
				specialSkillTable = self:getUserDataTb_()
				specialSkillTable.go = gohelper.cloneInPlace(self._passiveSkillPrefab, "item" .. i)
				specialSkillTable._gotag = gohelper.findChild(specialSkillTable.go, "tag")
				specialSkillTable._txttag = gohelper.findChildText(specialSkillTable.go, "tag/#txt_tag")

				table.insert(self._specialSkillGOs, specialSkillTable)

				local img = gohelper.findChildImage(specialSkillTable.go, "icon")

				table.insert(self._passiveSkillImgs, img)
			end

			if not string.nilorempty(specialCO.lv) then
				gohelper.setActive(specialSkillTable._gotag, true)

				specialSkillTable._txttag.text = specialCO.lv
			else
				gohelper.setActive(specialSkillTable._gotag, false)
			end

			if specialCO.icon == 0 then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. specialCO.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(self._passiveSkillImgs[i], specialCO.icon)
			gohelper.setActive(specialSkillTable.go, true)
			table.insert(self.bossSkillInfos, {
				skillId = skillId,
				icon = specialCO.icon
			})
		end
	end

	gohelper.setAsLastSibling(self._btnpassiveSkill.gameObject)

	for i = #skills + 1, #self._specialSkillGOs do
		gohelper.setActive(self._specialSkillGOs[i].go, false)
	end
end

function FightBossRushScoreHpView:_onClickPassiveSkill()
	if not FightModel.instance:isStartFinish() then
		return
	end

	if not self.bossSkillInfos then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.OnPassiveSkillClick, self.bossSkillInfos, self._btnpassiveSkill.transform, -509.5, -29, self._bossEntityMO.id)
end

function FightBossRushScoreHpView:_getScore()
	return math.max(0, FightDataHelper.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips))
end

function FightBossRushScoreHpView:_onIndicatorChange(indicatorId)
	if indicatorId ~= FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips then
		return
	end

	self:_refreshScoreBar()
end

function FightBossRushScoreHpView:_refreshScoreBar()
	local score = self:_getScore()

	self:_updatePhase(score)
	self:_updateLevelBarProgress(score)

	if not self._bossEntityMO then
		return
	end

	self:_playBossHitEffect()
	self:_tweenScore(score)
end

function FightBossRushScoreHpView:_updateScoreImmediately()
	if not self._bossEntityMO then
		return
	end

	local score = self:_getScore()

	self:_updatePhase(score)
	self:_updateLevelBarProgress(score)
	self:clearHpTween()

	self.tweenHp = score
	self.targetHp = score

	self:_refreshBarVisual()
end

function FightBossRushScoreHpView:_tweenScore(score)
	self:clearHpTween()

	self.targetHp = math.max(0, score)
	self.hpTweenId = ZProj.TweenHelper.DOTweenFloat(self.tweenHp, self.targetHp, FightBossRushScoreHpView.ScoreDuration, self.frameSetHp, self.onHpTweenDone, self)
end

function FightBossRushScoreHpView:frameSetHp(value)
	self.tweenHp = value

	self:_refreshBarVisual()
end

function FightBossRushScoreHpView:onHpTweenDone()
	self.tweenHp = self.targetHp

	self:_refreshBarVisual()
end

function FightBossRushScoreHpView:clearHpTween()
	if self.hpTweenId then
		ZProj.TweenHelper.KillById(self.hpTweenId)

		self.hpTweenId = nil
	end
end

function FightBossRushScoreHpView:_refreshBarVisual()
	local fillAmount = self:_getFillAmount()

	self.hp.fillAmount = fillAmount

	self:_updateBossHitEffect(fillAmount)
	self:refreshHpCount()
	self:refreshHpColor()
end

function FightBossRushScoreHpView:_getFillAmount()
	local oneMaxScore = self.oneMaxHp

	if not oneMaxScore or oneMaxScore <= 0 then
		return 0
	end

	local curScore = self.tweenHp % oneMaxScore

	if curScore == 0 and self.tweenHp > 0 then
		curScore = oneMaxScore
	end

	recthelper.setAnchorX(self._hp_container_tran, 0)

	return 1 - curScore / oneMaxScore
end

function FightBossRushScoreHpView:refreshHpCount()
	local score = math.max(0, self.tweenHp or 0)

	if self._txtHp then
		self._txtHp.text = ""
	end

	if self.txtSurvivalHpCount then
		local remainBars = self:_getBarsToNextPhase(score)

		self.txtSurvivalHpCount.text = "×" .. tostring(remainBars)

		SLFramework.UGUI.GuiHelper.SetColor(self.txtSurvivalHpCount, HpCountColorNormal)
	end
end

function FightBossRushScoreHpView:_getBarsToNextPhase(score)
	for _, phaseInfo in ipairs(self._phaseScoreList or {}) do
		if score < phaseInfo.score then
			return math.ceil((phaseInfo.score - score) / self.oneMaxHp)
		end
	end

	return 0
end

function FightBossRushScoreHpView:refreshHpColor()
	local score = math.max(0, self.tweenHp or 0)
	local barIndex = math.max(1, math.ceil(score / self.oneMaxHp))
	local colorIndex = (barIndex - 1) % #Color + 1
	local color = Color[colorIndex]

	if self.hp then
		SLFramework.UGUI.GuiHelper.SetColor(self.hp, color[1])
	end

	if self.bgHpGo then
		gohelper.setActive(self.bgHpGo, true)
		SLFramework.UGUI.GuiHelper.SetColor(self.bgHp, color[2])
	end
end

function FightBossRushScoreHpView:_initBossHitEffect()
	self._bossHitEffGO = gohelper.findChild(self.viewGO, FightBossRushScoreHpView.BossHitEffPath)

	if not self._bossHitEffGO then
		return
	end

	self._bossHitEffTran = self._bossHitEffGO.transform

	if self.hp then
		self._barFullWidth = recthelper.getWidth(self.hp.transform)
	end

	local highlightGO = gohelper.findChild(self._bossHitEffGO, "hightlight")

	if highlightGO then
		self._bossHitHighlightTran = highlightGO.transform
		self._highlightFullWidth = recthelper.getWidth(self._bossHitHighlightTran)
	end

	local particleGO = gohelper.findChild(self._bossHitEffGO, "particle_dot")

	if particleGO then
		local ps = particleGO:GetComponent(typeof(UnityEngine.ParticleSystem))

		if ps then
			self._bossHitParticle = ps
			self._particleFullScaleX = ps.shape.scale.x
		end
	end

	gohelper.setActive(self._bossHitEffGO, false)
end

function FightBossRushScoreHpView:_playBossHitEffect()
	if not self._bossHitEffGO then
		return
	end

	gohelper.setActive(self._bossHitEffGO, false)
	gohelper.setActive(self._bossHitEffGO, true)
end

function FightBossRushScoreHpView:_updateBossHitEffect(fillAmount)
	local reduced = 1 - fillAmount

	if self._bossHitHighlightTran and self._highlightFullWidth then
		recthelper.setWidth(self._bossHitHighlightTran, self._highlightFullWidth * reduced)
	end

	if self._bossHitParticle and self._particleFullScaleX then
		local shape = self._bossHitParticle.shape
		local s = shape.scale

		self.vector3:Set(self._particleFullScaleX * reduced, s.y, s.z)

		shape.scale = self.vector3
	end

	if self._bossHitEffTran and self.hp then
		if not self._barFullWidth or self._barFullWidth <= 0 then
			self._barFullWidth = recthelper.getWidth(self.hp.transform)
		end

		recthelper.setAnchorX(self._bossHitEffTran, fillAmount * self._barFullWidth * 0.5)
	end
end

function FightBossRushScoreHpView:_cachePhaseScoreList()
	self._phaseScoreList = {}

	local episodeId = FightDataHelper.fieldMgr.episodeId
	local phaseDict = episodeId and lua_activity128_score_skill.configDict[episodeId]

	if not phaseDict then
		return
	end

	local phase2Score = {}

	for phase, monsterDict in pairs(phaseDict) do
		for _, co in pairs(monsterDict) do
			phase2Score[phase] = co.score or 0
		end
	end

	for phase, score in pairs(phase2Score) do
		table.insert(self._phaseScoreList, {
			phase = phase,
			score = score
		})
	end

	table.sort(self._phaseScoreList, function(a, b)
		return a.score < b.score
	end)
end

function FightBossRushScoreHpView:_getCurPhaseByScore(score)
	local curPhase = 0

	for _, phaseInfo in ipairs(self._phaseScoreList or {}) do
		if score >= phaseInfo.score then
			curPhase = phaseInfo.phase
		else
			break
		end
	end

	return curPhase
end

function FightBossRushScoreHpView:_updatePhase(score)
	local newPhase = self:_getCurPhaseByScore(score)

	if newPhase ~= (self._curPhase or 0) then
		self:_onPhaseChange(self._curPhase or 0, newPhase)
	end
end

function FightBossRushScoreHpView:_onPhaseChange(oldPhase, newPhase)
	self._curPhase = newPhase

	if self._levelBarView then
		self._levelBarView:setCurPhase(newPhase)
	end
end

FightBossRushScoreHpView.LevelBarPrefabPath = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v4a1_bossrush/v4a1_bossrush_danger.prefab"

function FightBossRushScoreHpView:_openLevelBar()
	if self._levelBarView then
		return
	end

	if not self.viewGO then
		return
	end

	local parentRoot = gohelper.findChild(self.viewGO.transform.parent.gameObject, "#go_danger")

	self._levelBarView = self:com_openSubView(FightBossRushScoreLevelBarView, FightBossRushScoreHpView.LevelBarPrefabPath, parentRoot, self._phaseScoreList)
end

function FightBossRushScoreHpView:_setLevelBarVisible(visible)
	self._levelBarVisible = visible

	if self._levelBarView and self._levelBarView.viewGO then
		gohelper.setActive(self._levelBarView.viewGO, visible)
	end
end

function FightBossRushScoreHpView:_updateLevelBarProgress(score)
	if self._levelBarView then
		self._levelBarView:setProgress(score)
	end
end

return FightBossRushScoreHpView
