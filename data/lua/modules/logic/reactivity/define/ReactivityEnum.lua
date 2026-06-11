-- chunkname: @modules/logic/reactivity/define/ReactivityEnum.lua

module("modules.logic.reactivity.define.ReactivityEnum", package.seeall)

local ReactivityEnum = _M

ReactivityEnum.ActivityDefine = {
	[VersionActivity3_8Enum.ActivityId.Reactivity] = {
		storeCurrency = CurrencyEnum.CurrencyType.V3a1Dungeon,
		storeActId = VersionActivity3_8Enum.ActivityId.ReactivityStore
	}
}

return ReactivityEnum
