-- chunkname: @modules/logic/versionactivity4_1/act248/define/Act248Enum.lua

module("modules.logic.versionactivity4_1.act248.define.Act248Enum", package.seeall)

local Act248Enum = _M

Act248Enum.Toast = {
	CorrectClue = 411003,
	CollectClue = 411001,
	ClueLock = 411002
}
Act248Enum.UnlockType = {
	Story = 1,
	AVG = 100,
	Element = 2,
	Defalut = 101,
	Episode = 3
}
Act248Enum.SlotFillStatus = {
	Correct = 2,
	Error = 3,
	Normal = 1
}
Act248Enum.Const = {
	AvgBeforeStoryId = 3,
	ReportCheckBtnShowTime = 1,
	AvgAfterStoryId = 4,
	ReportCheckBtnLongClickTime = 2
}
Act248Enum.ClueInfoSwitchDelayTime = 0.16
Act248Enum.AniName = {
	close = "close",
	finished = "finished",
	idle = "idle",
	wrong = "wrong",
	to_clue = "to_clue",
	unlock_idle = "unlock_idle",
	switch = "switch",
	unlock = "unlock",
	open = "open",
	to_slot = "to_slot",
	lock_idle = "lock_idle",
	finish = "finish",
	clue_switch = "clue_switch",
	finish_idle = "finish_idle"
}
Act248Enum.PlayerPrefKey = {
	NewClue = "Act248_NewClue",
	FileFirstFinish = "Act248_FileFirstFinish",
	FileAnimStatus = "Act248_FileAnimStatus",
	SlotWrongClueIds = "Act248_SlotWrongClueIds",
	NewFile = "Act248_NewFile"
}
Act248Enum.FileStatus = {
	Finish = 3,
	Lock = 1,
	Unlock = 2
}

return Act248Enum
