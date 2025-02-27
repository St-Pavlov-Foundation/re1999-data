module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroTalkViewContainer", package.seeall)

slot0 = class("DiceHeroTalkViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {
		DiceHeroTalkView.New()
	}

	DiceHeroStatHelper.instance:resetTalkDt()

	DiceHeroModel.instance.guideLevel = slot0.viewParam.co.id

	if slot0.viewParam.co.type == DiceHeroEnum.LevelType.Story then
		table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))
	end

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot2:setOverrideClose(slot0.defaultOverrideCloseClick, slot0)

		return {
			slot2
		}
	end
end

function slot0.defaultOverrideCloseClick(slot0)
	slot1 = slot0.viewParam.co

	if DiceHeroModel.instance:getGameInfo(slot1.chapter).currLevel == slot1.id and not slot2.allPass then
		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroExitFight, MsgBoxEnum.BoxType.Yes_No, slot0.statAndClose, nil, , slot0)
	else
		slot0:statAndClose()
	end
end

function slot0.statAndClose(slot0)
	DiceHeroStatHelper.instance:sendStoryEnd(false, false)
	slot0:closeThis()
end

return slot0
