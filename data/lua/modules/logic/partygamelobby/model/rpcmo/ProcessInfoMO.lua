-- chunkname: @modules/logic/partygamelobby/model/rpcmo/ProcessInfoMO.lua

module("modules.logic.partygamelobby.model.rpcmo.ProcessInfoMO", package.seeall)

local ProcessInfoMO = pureTable("ProcessInfoMO")

function ProcessInfoMO:init(info)
	self.id = info.id
	self.outerIp = info.outerIp
	self.outerPort = info.outerPort
	self.innerIp = info.innerIp
	self.innerPort = info.innerPort
end

return ProcessInfoMO
