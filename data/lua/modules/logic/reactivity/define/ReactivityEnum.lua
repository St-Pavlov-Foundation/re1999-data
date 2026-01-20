-- chunkname: @modules/logic/reactivity/define/ReactivityEnum.lua

module("modules.logic.reactivity.define.ReactivityEnum", package.seeall)

local ReactivityEnum = _M

ReactivityEnum.ActivityDefine = {
	[VersionActivity3_4Enum.ActivityId.Reactivity] = {
		storeCurrency = CurrencyEnum.CurrencyType.V2a5Dungeon,
		storeActId = VersionActivity3_4Enum.ActivityId.ReactivityStore
	}
}

return ReactivityEnum
