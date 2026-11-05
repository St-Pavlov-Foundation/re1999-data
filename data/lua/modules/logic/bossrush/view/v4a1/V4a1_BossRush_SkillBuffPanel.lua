-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_SkillBuffPanel.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_SkillBuffPanel", package.seeall)

local V4a1_BossRush_SkillBuffPanel = class("V4a1_BossRush_SkillBuffPanel", ListScrollCellExtend)

function V4a1_BossRush_SkillBuffPanel:onInitView()
	self._gobuff = gohelper.findChild(self.viewGO, "#go_buff")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_BossRush_SkillBuffPanel:addEvents()
	return
end

function V4a1_BossRush_SkillBuffPanel:removeEvents()
	return
end

function V4a1_BossRush_SkillBuffPanel:_editableInitView()
	gohelper.setActive(self._gobuff, false)

	self._phaseItems = self:getUserDataTb_()
end

function V4a1_BossRush_SkillBuffPanel:_editableAddEvents()
	return
end

function V4a1_BossRush_SkillBuffPanel:_editableRemoveEvents()
	return
end

function V4a1_BossRush_SkillBuffPanel:onUpdateMO(episodeId, score, monsterId)
	local moList = V4a1_BossRushModel.instance:getScoreSkillMos(episodeId)
	local count = 0
	local _moList = {}
	local arrivedPhase = 0

	if moList then
		for i, mo in ipairs(moList) do
			local _mo = mo

			if _mo then
				table.insert(_moList, _mo)

				if score and _mo[1] and score >= _mo[1].score then
					arrivedPhase = i
				end
			end
		end
	end

	for i, mo in ipairs(_moList) do
		local item = self:_getPhaseItem(i)

		item:onUpdateMO(i, mo, score, arrivedPhase)

		count = count + 1
	end

	for i, item in ipairs(self._phaseItems) do
		gohelper.setActive(item.viewGO, i <= count)
	end
end

function V4a1_BossRush_SkillBuffPanel:_isShowItem(moList, monsterId)
	if not monsterId then
		return moList
	end

	for _, v in ipairs(moList) do
		if v.monsterId == monsterId then
			return {
				v
			}
		end
	end
end

function V4a1_BossRush_SkillBuffPanel:_getPhaseItem(index)
	local item = self._phaseItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gobuff.gameObject)

		item = MonoHelper.addLuaComOnceToGo(go, V4a1_BossRush_SkillBuffPhaseItem)
		self._phaseItems[index] = item
	end

	return item
end

function V4a1_BossRush_SkillBuffPanel:onDestroyView()
	return
end

return V4a1_BossRush_SkillBuffPanel
