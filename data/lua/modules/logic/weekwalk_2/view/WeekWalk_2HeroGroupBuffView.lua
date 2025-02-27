module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupBuffView", package.seeall)

slot0 = class("WeekWalk_2HeroGroupBuffView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(slot0.viewContainer, HeroGroupEvent.SwitchBalance, slot0._onSwitchBalance, slot0)
	slot0:addEventCb(slot0.viewContainer, HeroGroupEvent.BeforeEnterFight, slot0.beforeEnterFight, slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSetupReply, slot0._onBuffSetupReply, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SwitchReplay, slot0._switchReplay, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, slot0._onModifyGroupSelectIndex, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(slot0.viewContainer, HeroGroupEvent.SwitchBalance, slot0._onSwitchBalance, slot0)
end

function slot0.beforeEnterFight(slot0)
end

function slot0._onSwitchBalance(slot0)
	if slot0._animator then
		slot0._animator:Play("switch", 0, 0)
	end
end

function slot0._initFairyLandCard(slot0)
	slot0:_loadEffect()
end

function slot0._loadEffect(slot0)
	slot0._effectUrl = "ui/viewres/weekwalk/weekwalkheart/herogroupviewweekwalkheart.prefab"
	slot0._effectLoader = MultiAbLoader.New()

	slot0._effectLoader:addPath(slot0._effectUrl)
	slot0._effectLoader:startLoad(slot0._effectLoaded, slot0)
end

function slot0._effectLoaded(slot0, slot1)
	slot2 = gohelper.findChild(slot0.viewGO, "#go_fairylandcard")

	gohelper.setActive(slot2, true)

	slot5 = gohelper.clone(slot1:getAssetItem(slot0._effectUrl):GetResource(slot0._effectUrl), slot2)
	slot0._animator = slot5:GetComponent(typeof(UnityEngine.Animator))
	slot0._goBuffNew = gohelper.findChild(slot5, "#go_weekwalkheart/#go_new")
	slot0._goNoBuff = gohelper.findChild(slot5, "#go_weekwalkheart/#go_NoBuff")
	slot0._goHasBuff = gohelper.findChild(slot5, "#go_weekwalkheart/#go_HasBuff")
	slot0._buffName = gohelper.findChildText(slot5, "#go_weekwalkheart/#go_HasBuff/cardnamebg/#txt_buffname")
	slot0._imageBuff = gohelper.findChildImage(slot5, "#go_weekwalkheart/#go_HasBuff/#image_buff")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot5, "#go_weekwalkheart/#btn_click")

	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:_initBuff()
	slot0:_updateBuffNewFlag()
end

function slot0._updateBuffNewFlag(slot0)
	if not WeekWalk_2Model.instance:getCurMapId() then
		return
	end

	if WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.FightBuffNew, slot1) then
		return
	end

	if not (WeekWalk_2Model.instance:getCurMapInfo().config.preId and WeekWalk_2Model.instance:getLayerInfo(slot3)) then
		return
	end

	slot5 = slot2.config.chooseSkillNum ~= slot4.config.chooseSkillNum

	gohelper.setActive(slot0._goBuffNew, slot5)

	slot0._showBuffNewFlag = slot5
end

function slot0._onOpenView(slot0, slot1)
	if slot0._showBuffNewFlag and slot1 == ViewName.WeekWalk_2HeartBuffView then
		slot0._showBuffNewFlag = false

		gohelper.setActive(slot0._goBuffNew, false)
		WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.FightBuffNew, WeekWalk_2Model.instance:getCurMapId())
	end
end

function slot0._initBuff(slot0)
	slot0._buffConfig = nil

	if WeekWalk_2BuffListModel.getCurHeroGroupSkillId() then
		slot0._buffConfig = lua_weekwalk_ver2_skill.configDict[slot1]
	end

	slot0:_updateDreamLandCardInfo()
end

function slot0._btnclickOnClick(slot0)
	if slot0._isReplay then
		return
	end

	WeekWalk_2Controller.instance:openWeekWalk_2HeartBuffView({
		isBattle = true
	})
end

function slot0._editableInitView(slot0)
	slot0:_initFairyLandCard()
end

function slot0.onOpen(slot0)
	slot0:_setTaskDes()
end

function slot0._setTaskDes(slot0)
end

function slot0._switchReplay(slot0, slot1)
	if not slot0._taskConfig then
		return
	end

	if slot0._animator then
		slot0._animator:Play("switch", 0, 0)
	end

	slot0._isReplay = slot1

	TaskDispatcher.cancelTask(slot0._doSwitchReplay, slot0)

	if slot0._isReplay then
		TaskDispatcher.runDelay(slot0._doSwitchReplay, slot0, 0.16)
	end
end

function slot0._doSwitchReplay(slot0)
	if slot0._isReplay then
		-- Nothing
	end
end

function slot0._onModifyGroupSelectIndex(slot0)
	slot0:_initBuff()
end

function slot0._onBuffSetupReply(slot0)
	slot0:_initBuff()
end

function slot0._updateDreamLandCardInfo(slot0)
	gohelper.setActive(slot0._goNoBuff, false)
	gohelper.setActive(slot0._goHasBuff, false)

	if not slot0._buffConfig or not slot0._imageBuff then
		gohelper.setActive(slot0._goNoBuff, true)

		return
	end

	gohelper.setActive(slot0._goHasBuff, true)

	slot2 = lua_skill.configDict[slot0._buffConfig.id]
	slot0._buffName.text = slot0._buffConfig.name

	UISpriteSetMgr.instance:setWeekWalkSprite(slot0._imageBuff, slot0._buffConfig.icon)
end

function slot0.onClose(slot0)
	if slot0._btnclick then
		slot0._btnclick:RemoveClickListener()
	end

	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play("close", 0, 0)
	end

	TaskDispatcher.cancelTask(slot0._doSwitchReplay, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._effectLoader then
		slot0._effectLoader:dispose()
	end
end

return slot0
