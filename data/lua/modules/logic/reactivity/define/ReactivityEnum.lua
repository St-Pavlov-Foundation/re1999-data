-- chunkname: @modules/logic/reactivity/define/ReactivityEnum.lua

module("modules.logic.reactivity.define.ReactivityEnum", package.seeall)

local ReactivityEnum = _M

ReactivityEnum.ActivityDefine = {
	[VersionActivity3_5Enum.ActivityId.Reactivity] = {
		storeCurrency = CurrencyEnum.CurrencyType.V2a7Dungeon,
		storeActId = VersionActivity3_5Enum.ActivityId.ReactivityStore
	}
}

return ReactivityEnum
