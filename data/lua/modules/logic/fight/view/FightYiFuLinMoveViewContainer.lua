-- chunkname: @modules/logic/fight/view/FightYiFuLinMoveViewContainer.lua

module("modules.logic.fight.view.FightYiFuLinMoveViewContainer", package.seeall)

local FightYiFuLinMoveViewContainer = class("FightYiFuLinMoveViewContainer", BaseViewContainer)

function FightYiFuLinMoveViewContainer:buildViews()
	local views = {}

	table.insert(views, FightYiFuLinMoveView.New())

	return views
end

return FightYiFuLinMoveViewContainer
