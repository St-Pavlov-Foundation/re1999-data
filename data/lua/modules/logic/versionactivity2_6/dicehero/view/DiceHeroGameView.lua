module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroGameView", package.seeall)

slot0 = class("DiceHeroGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._anim = gohelper.findChildAnim(slot0.viewGO, "")
	slot0._godice = gohelper.findChild(slot0.viewGO, "#go_dice")
	slot0._maskAnim = gohelper.findChildAnim(slot0.viewGO, "#simage_mask")
	slot0._gocard = gohelper.findChild(slot0.viewGO, "#go_card/item")
	slot0._goenemy = gohelper.findChild(slot0.viewGO, "#go_enemy/#go_item")
	slot0._gohero = gohelper.findChild(slot0.viewGO, "#go_hero")
	slot0._curRound = gohelper.findChildTextMesh(slot0.viewGO, "#go_target/roundbg/anim/curround/#txt_curround")
	slot0._txttarget = gohelper.findChildTextMesh(slot0.viewGO, "#go_target/#go_tasklist/#go_taskitem/txt_desc")
	slot0._damageEffectHero = gohelper.findChild(slot0.viewGO, "#screeneff_attack/hero")
	slot0._damageEffectEnemy = gohelper.findChild(slot0.viewGO, "#screeneff_attack/enemy")

	if gohelper.findChild(slot0.viewGO, "#go_texture_ref") then
		for slot6 = 0, slot1.transform.childCount - 1 do
			if slot2:GetChild(slot6).gameObject:GetComponent(gohelper.Type_RawImage) then
				DiceHeroHelper.instance:setDiceTexture(slot7.name, slot8.texture)
			end
		end
	end
end

function slot0.addEvents(slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.RoundEnd, slot0.beginRound, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.ConfirmDice, slot0.confirmDice, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.OnDamage, slot0.onDamageEffect, slot0)
end

function slot0.removeEvents(slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.RoundEnd, slot0.beginRound, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.ConfirmDice, slot0.confirmDice, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.OnDamage, slot0.onDamageEffect, slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._maskAnim, true)

	slot3 = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.effect, slot0.viewGO)

	gohelper.setActive(slot3, false)
	DiceHeroHelper.instance:setEffectItem(slot3)

	slot0._diceBox = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._godice, DiceHeroDiceBoxItem, slot0)
	slot0._hero = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.roleinfoitem, slot0._gohero), DiceHeroHeroItem)
	slot0._txttarget.text = luaLang("dicehero_target")

	slot0:refreshCards()
	slot0:refreshEnemys()
	slot0:beginRound()
end

function slot0.onUpdateParam(slot0)
	if not slot0._diceBox then
		return
	end

	slot0._anim:Play("open", 0, 0)
	slot0._diceBox:onStepEnd(true)
	slot0._hero:refreshAll()
	slot0:refreshCards()
	slot0:refreshEnemys()
	slot0:beginRound()
end

function slot0.beginRound(slot0)
	slot0._maskAnim:Play("out", 0, 1)

	slot0._curRound.text = DiceHeroFightModel.instance:getGameData().round
	slot0._roundFlow = FlowSequence.New()

	slot0._roundFlow:addWork(FunctionWork.New(slot0._hideDiceAndShowEnemyBehavior, slot0))
	slot0._roundFlow:addWork(DelayDoFuncWork.New(slot0._showMask, slot0, 1))
	slot0._roundFlow:addWork(DelayDoFuncWork.New(slot0._showDiceAndHideEnemyBehavior, slot0, 0.1))
	slot0._roundFlow:registerDoneListener(slot0.flowDone, slot0)
	slot0._roundFlow:start()
end

function slot0._hideDiceAndShowEnemyBehavior(slot0)
	slot4 = 1

	UIBlockHelper.instance:startBlock("DiceHeroGameView_RoundStart", slot4)
	gohelper.setActive(slot0._godice, false)

	for slot4, slot5 in pairs(slot0._enemys) do
		slot5:refreshAll()
		slot5:showBehavior()
	end

	slot0._hero:refreshAll()
end

function slot0._showMask(slot0)
	slot0._anim:Play("camerain", 0, 0)
	slot0._maskAnim:Play("in", 0, 0)
end

function slot0.onDamageEffect(slot0, slot1)
	gohelper.setActive(slot0._damageEffectHero, slot1)
	gohelper.setActive(slot0._damageEffectEnemy, not slot1)

	if DiceHeroFightModel.instance:getGameData().confirmed then
		slot0._anim:Play("damage", 0, 0)
	else
		slot0._anim:Play("damage1", 0, 0)
	end
end

function slot0._showDiceAndHideEnemyBehavior(slot0)
	gohelper.setActive(slot0._godice, true)
	slot0._diceBox:startRoll()

	for slot4, slot5 in pairs(slot0._enemys) do
		slot5:hideBehavior()
	end
end

function slot0.flowDone(slot0)
	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.DiceHeroGuideRoundInfo, string.format("%s_%s", DiceHeroModel.instance.lastEnterLevelId, DiceHeroFightModel.instance:getGameData().round))

	slot0._roundFlow = nil

	if DiceHeroHelper.instance.afterFlow then
		DiceHeroHelper.instance.afterFlow = nil

		DiceHeroHelper.instance:startFlow(DiceHeroHelper.instance.afterFlow)
	end
end

function slot0.confirmDice(slot0)
	slot0._anim:Play("cameraout", 0, 0)
	slot0._maskAnim:Play("out", 0, 0)
end

function slot0.refreshCards(slot0)
	slot0._cards = slot0._cards or {}

	gohelper.CreateObjList(slot0, slot0._createCard, DiceHeroFightModel.instance:getGameData().skillCards, nil, slot0._gocard, DiceHeroCardItem)
end

function slot0._createCard(slot0, slot1, slot2, slot3)
	slot1:initData(slot2)

	slot0._cards[slot2.skillId] = slot1
end

function slot0.refreshEnemys(slot0)
	slot0._enemys = slot0._enemys or {}

	gohelper.CreateObjList(slot0, slot0._createEnemy, DiceHeroFightModel.instance:getGameData().enemyHeros, nil, slot0._goenemy, DiceHeroEnemyItem, nil, , 1)
end

function slot0._createEnemy(slot0, slot1, slot2, slot3)
	slot1:initData(slot2)

	slot0._enemys[slot2.uid] = slot1
end

function slot0.onDestroyView(slot0)
	if slot0._roundFlow then
		slot0._roundFlow:onDestroyInternal()

		slot0._roundFlow = nil
	end

	DiceHeroHelper.instance:clear()
end

return slot0
