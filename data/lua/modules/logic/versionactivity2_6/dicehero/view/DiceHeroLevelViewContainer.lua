module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroLevelViewContainer", package.seeall)

slot0 = class("DiceHeroLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	DiceHeroModel.instance.guideChapter = slot0.viewParam.chapterId

	return {
		DiceHeroLevelView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return slot0
