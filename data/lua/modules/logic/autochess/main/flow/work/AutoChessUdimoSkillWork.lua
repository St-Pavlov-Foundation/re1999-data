-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessUdimoSkillWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessUdimoSkillWork", package.seeall)

local AutoChessUdimoSkillWork = class("AutoChessUdimoSkillWork", AutoChessBaseWork)

function AutoChessUdimoSkillWork:onStart()
	local sceneMo = AutoChessModel.instance:getSceneMo()

	if sceneMo then
		sceneMo.mall:updateSvrMallRegion(self.effect.region, true)
	end

	self:finishWork()
end

return AutoChessUdimoSkillWork
