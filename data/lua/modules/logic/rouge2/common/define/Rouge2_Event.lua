﻿-- chunkname: @modules/logic/rouge2/common/define/Rouge2_Event.lua

module("modules.logic.rouge2.common.define.Rouge2_Event", package.seeall)

local Rouge2_Event = _M
local _uid = 1

local function E(name)
	assert(Rouge2_Event[name] == nil, "[Rouge2_Event] error redefined Rouge2_Event." .. name)

	Rouge2_Event[name] = _uid
	_uid = _uid + 1
end

E("OnSelectDifficulty")
E("OnSwitchDifficultyPage")
E("OnSelectCareerAttribute")
E("OnUpdateAttributeInfo")
E("OnSelectCareer")
E("OnBeginDragSkill")
E("OnEndDragSkill")
E("OnSelectActiveSkillHole")
E("OnUpdateActiveSkillInfo")
E("OnLongPressEditSkill")
E("OnScrollRelicsBag")
E("OnScrollBuffBag")
E("OnSwitchAttrTabItem")
E("OnSwitchItemDescMode")
E("OnSwitchSkillViewType")
E("OnUpdateAttrInfo")
E("OnUpdateRougeInfo")
E("OnUpdateRougeInfoCoin")
E("OnUpdateRevivalCoin")
E("SwitchCollectionInfoType")
E("OpenRougeView")

return Rouge2_Event
