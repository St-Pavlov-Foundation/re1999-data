module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroGameViewContainer", package.seeall)

slot0 = class("DiceHeroGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	DiceHeroModel.instance.guideLevel = DiceHeroModel.instance.lastEnterLevelId

	return {
		DiceHeroGameView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
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
	if DiceHeroFightModel.instance.finishResult ~= DiceHeroEnum.GameStatu.None then
		return
	end

	if lua_dice_level.configDict[DiceHeroModel.instance.lastEnterLevelId] then
		if DiceHeroModel.instance:getGameInfo(slot2.chapter).currLevel ~= slot1 or slot3.allPass then
			return slot0:closeThis()
		end
	else
		return slot0:closeThis()
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroExitFight, MsgBoxEnum.BoxType.Yes_No, slot0.closeThis, nil, , slot0)
end

return slot0
