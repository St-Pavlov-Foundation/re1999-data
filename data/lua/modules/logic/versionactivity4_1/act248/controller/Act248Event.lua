-- chunkname: @modules/logic/versionactivity4_1/act248/controller/Act248Event.lua

module("modules.logic.versionactivity4_1.act248.controller.Act248Event", package.seeall)

local Act248Event = _M
local _get = GameUtil.getUniqueTb()

Act248Event.onOpenClueCategory = _get()
Act248Event.onClickClueItem = _get()
Act248Event.onOpenSlotView = _get()
Act248Event.onOpenClueEditorView = _get()
Act248Event.onSlotMoveFinish = _get()
Act248Event.onFillClueItem = _get()
Act248Event.onConfirmFillClue = _get()
Act248Event.onFinishFileFill = _get()
Act248Event.onClickRoleItem = _get()
Act248Event.onCorrectRole = _get()
Act248Event.onGenerateReport = _get()
Act248Event.onFinishReport = _get()
Act248Event.onShowAutoFillReport = _get()
Act248Event.onGainClue = _get()
Act248Event.onShowSlotTip = _get()
Act248Event.OnRefreshNew = _get()

return Act248Event
