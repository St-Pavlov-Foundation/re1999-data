-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_MainView.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_MainView", package.seeall)

local V4a1_BossRush_MainView = class("V4a1_BossRush_MainView", V3a2_BossRush_MainView)

function V4a1_BossRush_MainView:_editableInitView()
	self._season = 2
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	V4a1_BossRush_MainView.super._editableInitView(self)
end

function V4a1_BossRush_MainView:onOpen()
	self.actId = BossRushConfig.instance:getActivityId()

	if self.viewParam then
		if self.viewParam.isOpenLevelDetail then
			local stage = self.viewParam.stage
			local layer = self.viewParam.layer
			local actId = self.viewParam.actId
			local viewParam = {
				stage = stage,
				layer = layer,
				actId = actId
			}

			V4a1_BossRushController.instance:openLevelDetailView(viewParam)
		end

		if self.viewParam.handbookMo then
			V4a1_BossRushController.instance:openHankBookView(self.viewParam.handbookMo, true)
		end
	end

	self:_refresh()
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_refreshCurrency()
	self:_refreshStoreTag()

	local activityCfg = ActivityConfig.instance:getActivityCo(self.actId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	gohelper.setActive(self._gotopRight, achievementJumpId and achievementJumpId ~= 0)
	self._animator:Play("open", 0, 0)
end

function V4a1_BossRush_MainView:_initRankBtn()
	local itemClass = V3a2_BossRush_RankBtn
	local path = self:_getRankBtnPath()
	local go = self.viewContainer:getResInst(path, self._gorank)

	self._rankBtn = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass, self._season)

	self._rankBtn:refreshUI()
end

function V4a1_BossRush_MainView:_getRankBtnPath()
	local seasonParam = V4a1BossRushEnum.SeasonParam[2]

	return seasonParam.RankBtnPath
end

function V4a1_BossRush_MainView:_btnhandbookOnClick()
	V4a1_BossRushController.instance:openHankBookView()
end

function V4a1_BossRush_MainView:_initItemList(dataList)
	if self._itemList then
		return
	end

	self._itemList = {}

	if not dataList then
		return
	end

	for i, mo in ipairs(dataList) do
		local go = gohelper.findChild(self.viewGO, "BOSS" .. i)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V4a1_BossRush_MainItem, self.viewContainer)

		item._index = i

		item:setData(mo, i)

		item.viewContainer = self.viewContainer

		table.insert(self._itemList, item)
	end
end

return V4a1_BossRush_MainView
