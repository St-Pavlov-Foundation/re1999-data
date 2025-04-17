module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroHeadItem", package.seeall)

slot0 = class("Act191HeroHeadItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	if slot1 then
		slot0.noFetter = slot1.noFetter
		slot0.showExSkill = slot1.exSkill
		slot0.noClick = slot1.noClick
	end
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goequiped = gohelper.findChild(slot1, "go_equiped")
	slot0.gonormal = gohelper.findChild(slot1, "go_normal")
	slot0.simageIcon = gohelper.findChildSingleImage(slot1, "go_normal/hero/simage_Icon")
	slot0.goExSkill = gohelper.findChild(slot1, "go_normal/hero/ExSkill")
	slot0.imageExSkill = gohelper.findChildImage(slot1, "go_normal/hero/ExSkill/bg/image_ExSkill")
	slot0.imageRare = gohelper.findChildImage(slot1, "go_normal/hero/image_Rare")
	slot0.imageCareer = gohelper.findChildImage(slot1, "go_normal/image_Career")
	slot0.goTag = gohelper.findChild(slot1, "go_normal/tag")

	gohelper.setActive(slot0.goTag, not slot0.noFetter)

	slot0.item = gohelper.findChild(slot1, "go_normal/tag/item")

	gohelper.setActive(slot0.item, false)

	slot0.gounown = gohelper.findChild(slot1, "go_unown")
	slot0.simageIconU = gohelper.findChildSingleImage(slot1, "go_unown/hero/simage_Icon")
	slot0.goMask = gohelper.findChild(slot1, "go_unown/hero/mask")
	slot0.imageRareU = gohelper.findChildImage(slot1, "go_unown/hero/image_Rare")
	slot0.imageCareerU = gohelper.findChildImage(slot1, "go_unown/image_Career")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "btn_Click")

	gohelper.setActive(slot0.btnClick, not slot0.noClick)

	slot0.goMaxRare = gohelper.findChild(slot1, "go_normal/hero/Rare_effect")
	slot0.fetterItemList = {}
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
end

function slot0.setData(slot0, slot1, slot2)
	if slot2 then
		slot0.config = Activity191Config.instance:getRoleCo(slot2)
	elseif Activity191Model.instance:getActInfo():getGameInfo():getHeroInfoInWarehouse(slot1) then
		slot0.config = Activity191Config.instance:getRoleCoByNativeId(slot1, slot4.star)
	end

	if slot0.config then
		slot3 = Activity191Helper.getHeadIconSmall(slot0.config)

		slot0.simageIcon:LoadImage(slot3)
		UISpriteSetMgr.instance:setCommonSprite(slot0.imageCareer, "lssx_" .. slot0.config.career)
		UISpriteSetMgr.instance:setAct174Sprite(slot0.imageRare, "act174_roleframe_" .. slot0.config.quality)
		slot0.simageIconU:LoadImage(slot3)
		UISpriteSetMgr.instance:setCommonSprite(slot0.imageCareerU, "lssx_" .. slot0.config.career)
		UISpriteSetMgr.instance:setAct174Sprite(slot0.imageRareU, "act174_roleframe_" .. slot0.config.quality)
		gohelper.setActive(slot0.goMaxRare, slot0.config.quality == 5)

		if slot0.showExSkill and slot0.config.exLevel ~= 0 then
			slot0.imageExSkill.fillAmount = slot0.config.exLevel / CharacterEnum.MaxSkillExLevel

			gohelper.setActive(slot0.goExSkill, true)
			gohelper.setActive(slot0.goMask, true)
		else
			gohelper.setActive(slot0.goExSkill, false)
			gohelper.setActive(slot0.goMask, true)
		end

		slot0:refreshFetter()
	end
end

function slot0.refreshFetter(slot0)
	if slot0.noFetter then
		return
	end

	for slot4, slot5 in ipairs(slot0.fetterItemList) do
		gohelper.setActive(slot5.go, false)
	end

	for slot5, slot6 in ipairs(string.split(slot0.config.tag, "#")) do
		if Activity191Config.instance:getRelationCo(slot6) then
			if not slot0.fetterItemList[slot5] then
				slot8 = slot0:getUserDataTb_()
				slot8.go = gohelper.cloneInPlace(slot0.item)
				slot8.icon = gohelper.findChildImage(slot8.go, "icon")
				slot0.fetterItemList[slot5] = slot8
			end

			Activity191Helper.setFetterIcon(slot8.icon, slot7.icon)
			gohelper.setActive(slot8.go, true)
		end
	end
end

function slot0.onClick(slot0)
	if slot0._overrideClick then
		slot0._overrideClick(slot0._overrideClickObj, slot0._clickParam)

		return
	end

	Activity191Controller.instance:openHeroTipView({
		preview = slot0.preview,
		heroList = {
			slot0.config.id
		}
	})
end

function slot0.setActivation(slot0, slot1)
	gohelper.setActive(slot0.goequiped, slot1)
end

function slot0.setNotOwn(slot0)
	gohelper.setActive(slot0.gonormal, false)
	gohelper.setActive(slot0.gounown, true)
end

function slot0.setOverrideClick(slot0, slot1, slot2, slot3)
	slot0._overrideClick = slot1
	slot0._overrideClickObj = slot2
	slot0._clickParam = slot3
end

function slot0.setPreview(slot0)
	slot0.preview = true
end

return slot0
