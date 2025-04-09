module("modules.logic.versionactivity2_7.act191.view.Act191CharacterTipViewContainer", package.seeall)

slot0 = class("Act191CharacterTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act191CharacterTipView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
