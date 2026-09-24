-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessRepleaceSkillWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessRepleaceSkillWork", package.seeall)

local AutoChessRepleaceSkillWork = class("AutoChessRepleaceSkillWork", AutoChessBaseWork)

function AutoChessRepleaceSkillWork:onStart()
	local sceneMo = AutoChessModel.instance:getSceneMo()

	if sceneMo then
		local chessPos = sceneMo.fight:getChessPosition1(self.effect.fromId)

		if chessPos then
			local chessIds = string.splitToNumber(self.effect.effectString, "#")

			chessPos.chess.replaceSkillChessIds = chessIds
		end
	end

	self:finishWork()
end

return AutoChessRepleaceSkillWork
