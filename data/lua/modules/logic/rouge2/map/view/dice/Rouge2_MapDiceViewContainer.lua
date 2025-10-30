-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapDiceViewContainer.lua

module("modules.logic.rouge2.map.view.dice.Rouge2_MapDiceViewContainer", package.seeall)

local Rouge2_MapDiceViewContainer = class("Rouge2_MapDiceViewContainer", BaseViewContainer)

function Rouge2_MapDiceViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapDiceView.New())
	table.insert(views, Rouge2_MapDiceAnimView.New())

	return views
end

function Rouge2_MapDiceViewContainer:playOpenTransition()
	local animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animator:Play("open", self.onPlayOpenTransitionFinish, self)
end

function Rouge2_MapDiceViewContainer:playCloseTransition()
	local animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animator:Play("close", self.onPlayCloseTransitionFinish, self)
end

return Rouge2_MapDiceViewContainer
