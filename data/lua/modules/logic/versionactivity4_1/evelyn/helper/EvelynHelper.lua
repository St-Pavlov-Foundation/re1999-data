-- chunkname: @modules/logic/versionactivity4_1/evelyn/helper/EvelynHelper.lua

module("modules.logic.versionactivity4_1.evelyn.helper.EvelynHelper", package.seeall)

local EvelynHelper = _M

function EvelynHelper.ConvertOriginPos(x, y, halfWidth, halfHeight)
	halfWidth = halfWidth or 0
	halfHeight = halfHeight or 0

	return x - halfWidth, y - halfHeight
end

function EvelynHelper.lockScreen(key, lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(key)
	else
		UIBlockMgr.instance:endBlock(key)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return EvelynHelper
