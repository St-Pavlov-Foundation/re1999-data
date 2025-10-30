-- chunkname: @modules/logic/reactivity/define/ReactivityEnum.lua

module("modules.logic.reactivity.define.ReactivityEnum", package.seeall)

local ReactivityEnum = _M

ReactivityEnum.ActivityDefine = {
	[VersionActivity3_1Enum.ActivityId.Reactivity] = {
		storeCurrency = CurrencyEnum.CurrencyType.V2a4Dungeon,
		storeActId = VersionActivity3_1Enum.ActivityId.ReactivityStore
	}
}

return ReactivityEnum
