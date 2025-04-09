module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroEditItem", package.seeall)

slot0 = class("Act191HeroEditItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.nameCnTxt = gohelper.findChildText(slot1, "namecn")
	slot0.nameEnTxt = gohelper.findChildText(slot1, "nameen")
	slot0.cardIcon = gohelper.findChild(slot1, "mask/charactericon")
	slot0.commonHeroCard = CommonHeroCard.create(slot0.cardIcon, slot0.__cname)
	slot0.front = gohelper.findChildImage(slot1, "mask/front")
	slot0.current = gohelper.findChild(slot1, "current")
	slot0.rare = gohelper.findChildImage(slot1, "image_rare")
	slot0.selectframe = gohelper.findChild(slot1, "selectframe")
	slot0.careerIcon = gohelper.findChildImage(slot1, "career")
	slot0.goexskill = gohelper.findChild(slot1, "#go_exskill")
	slot0.imageexskill = gohelper.findChildImage(slot1, "#go_exskill/#image_exskill")
	slot0.newTag = gohelper.findChild(slot1, "new")
	slot0.goStar1 = gohelper.findChild(slot1, "quality/bg/1")
	slot0.goStar2 = gohelper.findChild(slot1, "quality/bg/2")
	slot0.goStar3 = gohelper.findChild(slot1, "quality/bg/3")
	slot0.goFetter = gohelper.findChild(slot1, "fetter/image_Fetter")
	slot0.goOrderBg = gohelper.findChild(slot1, "go_OrderBg")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "click")
	slot0._animator = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0.isSelect = false
	slot0.inteam = gohelper.findChild(slot1, "inteam")
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0._onItemClick, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0.config = slot1.config
	slot0.nameCnTxt.text = slot0.config.name

	UISpriteSetMgr.instance:setCommonSprite(slot0.careerIcon, "lssx_" .. tostring(slot0.config.career))
	UISpriteSetMgr.instance:setAct174Sprite(slot0.rare, "act174_rolefame_" .. tostring(slot0.config.quality))

	if not FightConfig.instance:getSkinCO(slot0.config.skinId) then
		logError("找不到皮肤配置, id: " .. tostring(slot0.config.skinId))

		return
	end

	slot0.commonHeroCard:onUpdateMO(slot2)

	for slot6 = 1, Activity191Enum.CharacterMaxStar do
		gohelper.setActive(slot0["goStar" .. slot6], slot6 <= slot0._mo.star)
	end

	gohelper.setActive(slot0.goexskill, slot0.config.exLevel ~= 0)

	slot0.imageexskill.fillAmount = slot0.config.exLevel / CharacterEnum.MaxSkillExLevel

	for slot7, slot8 in ipairs(string.split(slot0.config.tag, "#")) do
		Activity191Helper.setFetterIcon(gohelper.findChildImage(gohelper.cloneInPlace(slot0.goFetter), ""), Activity191Config.instance:getRelationCo(slot8).icon)
	end

	gohelper.setActive(slot0.goFetter, false)
	gohelper.setActive(slot0.inteam, slot1.inTeam == 1)
	gohelper.setActive(slot0.current, slot1.inTeam == 2)
end

function slot0.onSelect(slot0, slot1)
	slot0.isSelect = slot1

	gohelper.setActive(slot0.selectframe, slot1)

	if slot1 then
		Activity191Controller.instance:dispatchEvent(Activity191Event.OnClickHeroEditItem, slot0._mo)
	end
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if slot0.isSelect then
		slot0._view:selectCell(slot0._index, false)
		Activity191Controller.instance:dispatchEvent(Activity191Event.OnClickHeroEditItem)
	else
		slot0._view:selectCell(slot0._index, true)
	end
end

function slot0.onDestroy(slot0)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
