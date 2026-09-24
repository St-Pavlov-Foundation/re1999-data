-- chunkname: @modules/logic/versionactivity4_0/common/VersionActivity4_0JumpHandleFunc.lua

module("modules.logic.versionactivity4_0.common.VersionActivity4_0JumpHandleFunc", package.seeall)

local VersionActivity4_0JumpHandleFunc = class("VersionActivity4_0JumpHandleFunc")

function VersionActivity4_0JumpHandleFunc:jumpTo14011(paramsList)
	local actId = paramsList[2]

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		AutoChessController.instance:enterMainView(actId)
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity4_0JumpHandleFunc:jumpTo14012(paramsList)
	local actId = paramsList[2]

	table.insert(self.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		MatchGameController.instance:openEnterView(actId)
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity4_0JumpHandleFunc
