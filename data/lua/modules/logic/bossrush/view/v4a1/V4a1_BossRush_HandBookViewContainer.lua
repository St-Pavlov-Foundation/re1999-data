-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_HandBookViewContainer.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_HandBookViewContainer", package.seeall)

local V4a1_BossRush_HandBookViewContainer = class("V4a1_BossRush_HandBookViewContainer", BaseViewContainer)

function V4a1_BossRush_HandBookViewContainer:buildViews()
	local views = {}
	local handbookMo = self.viewParam.handbookMo

	if handbookMo then
		self.viewParam.season = handbookMo.config.season
	end

	table.insert(views, V4a1_BossRush_HandBookView.New())
	table.insert(views, V4a1_BossRush_HandBookEnemyInfoView.New())
	table.insert(views, V4a1_BossRush_HandBookLeftView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function V4a1_BossRush_HandBookViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.V4a1BossuRush)

		return {
			self.navigateView
		}
	end
end

function V4a1_BossRush_HandBookViewContainer:getInitOpenHandBookMo()
	local mos = V4a1_BossRushModel.instance:getSeasonMos()
	local claimGroupIndex, canCliamBossMo

	if mos then
		for i in ipairs(mos) do
			for _, v in pairs(V3a2_BossRushModel.instance:getHandBookGroupMos(i)) do
				local isCanCliam, canCliamMo = self:_hasClaimBounsGroup(v.bossGroup)

				if isCanCliam and (i < claimGroupIndex or claimGroupIndex == 0) then
					claimGroupIndex = i
					canCliamBossMo = canCliamMo
				end
			end

			if claimGroupIndex then
				return claimGroupIndex, canCliamBossMo, i
			end
		end
	end
end

function V4a1_BossRush_HandBookViewContainer:_hasClaimBounsGroup(bossGroup)
	if bossGroup then
		for _, mo in ipairs(bossGroup) do
			if mo:hasClaimBonus() then
				return true, mo
			end
		end
	end
end

return V4a1_BossRush_HandBookViewContainer
