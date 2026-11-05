-- chunkname: @modules/logic/fight/view/FightBossRushScoreLevelBarTipsView.lua

module("modules.logic.fight.view.FightBossRushScoreLevelBarTipsView", package.seeall)

local FightBossRushScoreLevelBarTipsView = class("FightBossRushScoreLevelBarTipsView", FightBaseView)

function FightBossRushScoreLevelBarTipsView:onInitView()
	self._btnClose = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/#btn_close")
	self._content = gohelper.findChild(self.viewGO, "root/#scroll_Buff/Viewport/Content")
	self._itemTemplate = gohelper.findChild(self.viewGO, "root/#scroll_Buff/Viewport/Content/#go_buff")

	gohelper.setActive(self._itemTemplate, false)
end

function FightBossRushScoreLevelBarTipsView:addEvents()
	self:com_registClick(self._btnClose, self._onBtnClose)
end

function FightBossRushScoreLevelBarTipsView:removeEvents()
	return
end

function FightBossRushScoreLevelBarTipsView:onOpen()
	local param = self.viewParam or {}

	self._phaseList = param.phaseList or {}
	self._curPhase = param.curPhase or 0
	self._buffItemsByPhase = {}

	local dataList = self:_buildDataList()

	gohelper.CreateObjList(self, self._onItemShow, dataList, self._content, self._itemTemplate)
end

function FightBossRushScoreLevelBarTipsView:_onBtnClose()
	self:closeThis()
end

function FightBossRushScoreLevelBarTipsView:_buildDataList()
	local dataList = {}
	local episodeId = FightDataHelper.fieldMgr.episodeId
	local phaseDict = episodeId and lua_activity128_score_skill.configDict[episodeId]

	if not phaseDict then
		return dataList
	end

	for phase, monsterDict in pairs(phaseDict) do
		local buffList = {}
		local score = 0

		for _, co in pairs(monsterDict) do
			score = co.score or score

			if co.hidden ~= 1 then
				table.insert(buffList, {
					spDesc = co.spDesc or "",
					icon = co.icon or ""
				})
			end
		end

		table.insert(dataList, {
			phase = phase,
			score = score,
			buffList = buffList
		})
	end

	table.sort(dataList, function(a, b)
		return a.score < b.score
	end)

	return dataList
end

function FightBossRushScoreLevelBarTipsView:_onItemShow(obj, data, index)
	local txtTitle = gohelper.findChildText(obj, "#txt_title")

	if txtTitle then
		local lang = luaLang("bossrush_danger_score_title")

		txtTitle.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, "#C66030", data.score)
	end

	local goRank = gohelper.findChild(obj, "#txt_title/#go_rank")
	local isNormal, isArrived, isNow

	if goRank then
		local imgNormal = gohelper.findChildImage(goRank, "#go_normal")
		local imgArrived = gohelper.findChildImage(goRank, "#go_arrived")
		local imgNow = gohelper.findChildImage(goRank, "#go_now")

		if self._curPhase > 0 then
			if data.phase == self._curPhase then
				isNow = true

				UISpriteSetMgr.instance:setV4a1BossRushSprite(imgNow, "v4a1_bossrush_score_light_lv_" .. index)
			else
				isArrived = data.phase < self._curPhase

				UISpriteSetMgr.instance:setV4a1BossRushSprite(imgArrived, "v4a1_bossrush_score_light_lv_" .. index)
			end
		else
			isNormal = true

			UISpriteSetMgr.instance:setV4a1BossRushSprite(imgNormal, "v4a1_bossrush_score_lv_" .. index)
		end

		gohelper.setActive(imgArrived.gameObject, isArrived)
		gohelper.setActive(imgNow.gameObject, isNow)
		gohelper.setActive(imgNormal.gameObject, isNormal)
	end

	local goItemTemplate = gohelper.findChild(obj, "#go_item")

	if goItemTemplate then
		gohelper.setActive(goItemTemplate, false)

		local buffItems = self._buffItemsByPhase[index]

		if not buffItems then
			buffItems = {}
			self._buffItemsByPhase[index] = buffItems
		end

		local buffList = data.buffList or {}

		for i, buff in ipairs(buffList) do
			local goBuff = buffItems[i]

			if not goBuff then
				goBuff = gohelper.cloneInPlace(goItemTemplate, "buff" .. i)
				buffItems[i] = goBuff
			end

			gohelper.setActive(goBuff, true)

			local txtBuff = gohelper.findChildText(goBuff, "#txt_buff")

			if txtBuff then
				txtBuff.text = buff.spDesc
			end

			local imageIcon = gohelper.findChildImage(goBuff, "#txt_buff/#image_icon")

			if imageIcon and not string.nilorempty(buff.icon) then
				-- block empty
			end

			local isActive = isArrived or isNow

			gohelper.setActive(gohelper.findChild(goBuff, "#image_activedbg"), isActive)
			gohelper.setActive(gohelper.findChild(goBuff, "#image_normalbg"), isNormal)
			gohelper.setActive(gohelper.findChild(goBuff, "#image_notactivedbg"), not isNormal and not isActive)
		end

		for i = #buffList + 1, #buffItems do
			gohelper.setActive(buffItems[i], false)
		end
	end
end

function FightBossRushScoreLevelBarTipsView:onClose()
	return
end

function FightBossRushScoreLevelBarTipsView:onDestroyView()
	return
end

return FightBossRushScoreLevelBarTipsView
