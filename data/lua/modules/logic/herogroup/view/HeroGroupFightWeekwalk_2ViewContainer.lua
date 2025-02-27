module("modules.logic.herogroup.view.HeroGroupFightWeekwalk_2ViewContainer", package.seeall)

slot0 = class("HeroGroupFightWeekwalk_2ViewContainer", HeroGroupFightViewContainer)

function slot0.addFirstViews(slot0, slot1)
	uv0.super.addFirstViews(slot0, slot1)
	table.insert(slot1, WeekWalk_2HeroGroupFightLayoutView.New())
end

function slot0.defineFightView(slot0)
	slot0._heroGroupFightView = HeroGroupWeekWalk_2FightView.New()
	slot0._heroGroupFightListView = WeekWalk_2HeroGroupListView.New()
	slot0._heroGroupLevelView = WeekWalk_2HeroGroupFightView_Level.New()
end

function slot0.addCommonViews(slot0, slot1)
	table.insert(slot1, slot0._heroGroupFightView)
	table.insert(slot1, HeroGroupAnimView.New())
	table.insert(slot1, slot0._heroGroupFightListView.New())
	table.insert(slot1, slot0._heroGroupLevelView.New())
	table.insert(slot1, HeroGroupFightWeekWalk_2ViewRule.New())
	table.insert(slot1, HeroGroupInfoScrollView.New())
	table.insert(slot1, CheckActivityEndView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(slot1, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

function slot0.addLastViews(slot0, slot1)
	table.insert(slot1, HeroGroupFightWeekWalk_2View.New())
	table.insert(slot1, WeekWalk_2HeroGroupBuffView.New())

	slot0.helpView = HelpShowView.New()

	slot0.helpView:setHelpId(HelpEnum.HelpId.WeekWalk_2HeroGroup)
	table.insert(slot1, slot0.helpView)
end

function slot0.getHelpId(slot0)
	return HelpEnum.HelpId.WeekWalk_2HeroGroup
end

return slot0
