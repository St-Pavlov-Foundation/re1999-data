module("modules.logic.fight.entity.comp.buff.FightBuffAddCardContinueChannel", package.seeall)

slot0 = class("FightBuffAddCardContinueChannel")
slot0.RecordCount2BuffEffect = {
	nil,
	"buff/alf_kpjp_2",
	"buff/alf_kpjp_3",
	"buff/alf_kpjp_4"
}

function slot0.onBuffStart(slot0, slot1, slot2)
	slot0.entity = slot1
	slot0.buffUid = slot2.uid

	FightController.instance:registerCallback(FightEvent.ALF_AddRecordCardUI, slot0.onUpdateRecordCard, slot0)

	slot0.effectRes, slot0.recordCount = slot0:getEffectRes(slot2)
	slot0.loader = MultiAbLoader.New()

	slot0.loader:addPath(FightHelper.getEffectUrlWithLod(slot0.effectRes))
	slot0.loader:startLoad(slot0.createEffect, slot0)
end

function slot0.getEffectRes(slot0, slot1)
	slot4 = 0

	for slot8, slot9 in ipairs(FightStrUtil.instance:getSplitString2Cache(slot1:getCO().features, true)) do
		if slot9[1] == 923 then
			slot4 = slot9[3]

			break
		end
	end

	if not uv0.RecordCount2BuffEffect[slot4] then
		logError("阿莱夫 没有找到对应数量的特效 ： " .. tostring(slot4))

		return uv0.RecordCount2BuffEffect[2], 2
	end

	return slot5, slot4
end

function slot0.createEffect(slot0, slot1)
	slot0.effectWrap = slot0.entity.effect:addHangEffect(slot0.effectRes, ModuleEnum.SpineHangPointRoot)

	slot0.effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(slot0.entity.id, slot0.effectWrap)
	slot0.entity.buff:addLoopBuff(slot0.effectWrap)
	slot0:refreshEffect()
end

function slot0.onBuffEnd(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0:resetMat()
	slot0:clearTextureLoader()

	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end

	if slot0.effectWrap then
		slot0.entity.buff:removeLoopBuff(slot0.effectWrap)
		slot0.entity.effect:removeEffect(slot0.effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0.entity.id, slot0.effectWrap)

		slot0.effectWrap = nil
	end

	FightController.instance:unregisterCallback(FightEvent.ALF_AddRecordCardUI, slot0.onUpdateRecordCard, slot0)
end

function slot0.dispose(slot0)
	slot0:clear()
end

function slot0.onUpdateRecordCard(slot0)
	slot0:refreshEffect()
end

slot0.PreFix = "root/l_boli"
slot0.RecordCountNameDict = {
	[2] = {
		"l_boli01_di",
		"l_boli01_di03"
	},
	[3] = {
		"l_boli01_di",
		"l_boli01_di02",
		"l_boli01_di03"
	},
	[4] = {
		"l_boli01_di",
		"l_boli01_di02",
		"l_boli01_di03",
		"l_boli01_di04"
	}
}

function slot0.clearTextureLoader(slot0)
	if slot0.textureLoader then
		slot0.textureLoader:dispose()

		slot0.textureLoader = nil
	end
end

function slot0.getAlfCacheSkillList(slot0)
	if slot0.entity.heroCustomComp and slot0.entity.heroCustomComp:getCustomComp() then
		return slot1:getCacheSkillList()
	end
end

function slot0.refreshEffect(slot0)
	if not slot0.effectWrap then
		return
	end

	slot0:clearTextureLoader()

	slot0.skillResList = slot0.skillResList or {}

	tabletool.clear(slot0.skillResList)

	if not slot0:getAlfCacheSkillList() then
		slot0:resetMat()

		return
	end

	if #slot1 < 2 then
		slot0:resetMat()

		return
	end

	slot0.textureLoader = MultiAbLoader.New()

	for slot5 = 2, #slot1 do
		if not string.nilorempty(lua_skill.configDict[slot1[slot5]] and slot6.icon) then
			slot8 = ResUrl.getSkillIcon(slot7)

			slot0.textureLoader:addPath(slot8)
			table.insert(slot0.skillResList, slot8)
		else
			table.insert(slot0.skillResList, nil)
		end
	end

	slot0.textureLoader:startLoad(slot0._refreshEffect, slot0)
end

function slot0._refreshEffect(slot0)
	for slot6 = 1, slot0.recordCount do
		slot11 = slot0.skillResList[slot6] and slot0.textureLoader:getAssetItem(slot10)

		if gohelper.findChild(slot0.effectWrap.effectGO, string.format("%s/%s/mask", uv0.PreFix, uv0.RecordCountNameDict[slot0.recordCount][slot6])) and slot9:GetComponent(gohelper.Type_Render) and slot13.material then
			slot14:SetTexture("_MainTex", slot11 and slot11:GetResource())
		end
	end
end

function slot0.resetMat(slot0)
	if not slot0.effectWrap then
		return
	end

	for slot6 = 1, slot0.recordCount do
		if gohelper.findChild(slot0.effectWrap.effectGO, string.format("%s/%s/mask", uv0.PreFix, uv0.RecordCountNameDict[slot0.recordCount][slot6])) and slot9:GetComponent(gohelper.Type_Render) and slot10.material then
			slot11:SetTexture("_MainTex", nil)
		end
	end
end

return slot0
