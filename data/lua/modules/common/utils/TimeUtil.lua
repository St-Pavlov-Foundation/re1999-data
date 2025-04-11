module("modules.common.utils.TimeUtil", package.seeall)

slot0 = {
	maxDateTable = {
		month = 1,
		year = 2038,
		day = 1
	},
	OneDaySecond = 86400,
	OneHourSecond = 3600,
	OneMinuteSecond = 60,
	OneSecond = 1,
	DateEnFormat = {
		Day = "d",
		Hour = "h",
		Year = "y",
		Second = "s",
		Minute = "m"
	},
	secondsToDDHHMMSS = function (slot0)
		slot0 = math.floor(slot0)

		return math.floor(slot0 / 86400), math.floor(slot0 % 86400 / 3600), math.floor(slot0 % 3600 / 60), math.floor(slot0 % 60)
	end,
	secondToHMS = function (slot0)
		slot1, slot2, slot3, slot4 = uv0.secondsToDDHHMMSS(slot0)

		if slot1 > 0 then
			slot2 = slot2 + slot1 * 24
		end

		return slot2, slot3, slot4
	end,
	second2TimeString = function (slot0, slot1)
		slot2, slot3, slot4 = uv0.secondToHMS(slot0)

		if slot1 then
			return string.format("%02d:%02d:%02d", slot2, slot3, slot4)
		else
			return string.format("%02d:%02d", slot3, slot4)
		end
	end,
	stringToTimestamp = function (slot0)
		if string.nilorempty(slot0) then
			return 0
		end

		slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8 = string.find(slot0, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")

		if not slot3 or not slot4 or not slot5 or not slot6 or not slot7 or not slot8 then
			logError("请输入正确的时间文本格式!")

			return 0
		end

		return uv0.dtTableToTimeStamp({
			year = slot3,
			month = slot4,
			day = slot5,
			hour = slot6,
			min = slot7,
			sec = slot8
		}) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
	end,
	timeToTimeStamp = function (slot0, slot1, slot2, slot3, slot4, slot5)
		return uv0.dtTableToTimeStamp({
			year = slot0,
			month = slot1,
			day = slot2,
			hour = slot3,
			min = slot4,
			sec = slot5
		}) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
	end,
	dtTableToTimeStamp = function (slot0)
		if not os.time(slot0) then
			slot1 = os.time(uv0.maxDateTable)

			logError("os.time 32位溢出，输入时间超出2038年")
		end

		return slot1
	end,
	timestampToString = function (slot0)
		return os.date("%Y-%m-%d %H:%M:%S", slot0)
	end,
	langTimestampToString = function (slot0)
		if LangSettings.instance:getCurLangShortcut() == "en" then
			return os.date("%m/%d/%Y %H:%M:%S", slot0)
		else
			return os.date("%Y-%m-%d %H:%M:%S", slot0)
		end
	end,
	timestampToString1 = function (slot0)
		return os.date("%Y-%m-%d", slot0)
	end,
	timestampToString2 = function (slot0)
		return string.format(os.date("%Y%%s%m%%s%d%%s", slot0), luaLang("time_year"), luaLang("time_month"), luaLang("time_day2"))
	end,
	timestampToString3 = function (slot0)
		return os.date("%Y.%m.%d", slot0)
	end,
	langTimestampToString3 = function (slot0)
		if LangSettings.instance:getCurLangShortcut() == "en" then
			return os.date("%m/%d/%Y", slot0)
		else
			return os.date("%Y.%m.%d", slot0)
		end
	end,
	timestampToString4 = function (slot0)
		return os.date("%H:%M", slot0)
	end,
	timestampToString5 = function (slot0)
		return os.date("%Y/%m/%d", slot0)
	end,
	timestampToString6 = function (slot0)
		return os.date("%Y-%m-%d %H", slot0)
	end,
	localTime2ServerTimeString = function (slot0, slot1)
		if slot0 then
			return os.date(slot1 or "%Y/%m/%d", ServerTime.timeInLocal(slot0))
		end
	end,
	timestampToTable = function (slot0)
		slot2 = string.split(os.date("%Y#%m#%d#%H#%M#%S", slot0), "#")

		return {
			year = tonumber(slot2[1]),
			month = tonumber(slot2[2]),
			day = tonumber(slot2[3]),
			hour = tonumber(slot2[4]),
			min = tonumber(slot2[5]),
			sec = tonumber(slot2[6])
		}
	end,
	secondToRoughTime = function (slot0, slot1)
		slot2, slot3, slot4, slot5 = uv0.secondsToDDHHMMSS(slot0)

		return nil, slot2 > 0 and (slot1 and uv0.DateEnFormat.Day or luaLang("time_day")) or slot3 > 0 and (slot1 and uv0.DateEnFormat.Hour or luaLang("time_hour")) or slot1 and uv0.DateEnFormat.Minute or luaLang("time_minute"), slot2 > 0
	end,
	secondToRoughTime2 = function (slot0, slot1)
		slot2, slot3, slot4, slot5 = uv0.secondsToDDHHMMSS(slot0)
		slot6, slot7 = nil

		if slot2 > 0 then
			slot6 = slot2
			slot7 = slot1 and uv0.DateEnFormat.Day or luaLang("time_day")
		elseif slot3 > 0 then
			slot6 = slot3
			slot7 = slot1 and uv0.DateEnFormat.Hour or luaLang("time_hour")
		elseif slot4 >= 60 then
			slot6 = 1
			slot7 = slot1 and uv0.DateEnFormat.Hour or luaLang("time_hour")
		else
			slot6 = slot4
			slot7 = slot1 and uv0.DateEnFormat.Minute or luaLang("time_minute")
		end

		return slot6, slot7
	end,
	secondToRoughTime3 = function (slot0, slot1)
		slot2, slot3, slot4, slot5 = uv0.secondsToDDHHMMSS(slot0)
		slot6, slot7, slot8 = uv1(slot1)

		if slot2 > 0 then
			return uv2(slot2, slot6, slot3, slot7)
		elseif slot3 > 0 then
			return uv2(slot3, slot7, slot4, slot8)
		elseif slot4 > 0 then
			return slot1 and " " .. slot4 .. " " .. uv0.DateEnFormat.Minute or slot4 .. " " .. luaLang("time_minute")
		else
			return luaLang("summonmain_deadline_time_min")
		end
	end,
	convertWday = function (slot0)
		if slot0 - 1 <= 0 then
			slot0 = 7
		end

		return slot0
	end,
	weekDayToLangStr = function (slot0)
		return luaLang(string.format("weekday%s", slot0))
	end,
	isSameDay = function (slot0, slot1)
		if os.date("!*t", slot0 + ServerTime.serverUtcOffset()).year ~= os.date("!*t", slot1 + ServerTime.serverUtcOffset()).year then
			return false
		end

		if slot2.month ~= slot3.month then
			return false
		end

		if slot2.day ~= slot3.day then
			return false
		end

		return true
	end,
	getDiffDay = function (slot0, slot1)
		slot3 = string.split(os.date("%Y#%m#%d#%H#%M#%S", slot0), "#")
		slot8 = string.split(os.date("%Y#%m#%d#%H#%M#%S", slot1), "#")
		slot13 = os.time({
			hour = 0,
			min = 0,
			sec = 0,
			year = tonumber(slot8[1]),
			month = tonumber(slot8[2]),
			day = tonumber(slot8[3])
		})

		if not os.time({
			hour = 0,
			min = 0,
			sec = 0,
			year = tonumber(slot3[1]),
			month = tonumber(slot3[2]),
			day = tonumber(slot3[3])
		}) or not slot13 then
			logError("os.time 32位溢出，输入时间超出2038年")

			return 0
		end

		return math.abs(slot12 - slot13) / 60 / 60 / 24
	end,
	setDayFirstLoginRed = function (slot0)
		PlayerPrefsHelper.setString(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginTodayRed .. "_" .. slot0, uv0.timestampToString1(ServerTime.now() - 18000))
	end,
	getDayFirstLoginRed = function (slot0)
		return PlayerPrefsHelper.getString(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginTodayRed .. "_" .. slot0) ~= uv0.timestampToString1(ServerTime.now() - 18000)
	end,
	setWeekFirstLoginRed = function (slot0)
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginWeekRed .. "_" .. slot0, math.floor(ServerTime.getWeekEndTimeStamp(true) / 3600))
	end,
	getWeekFirstLoginRed = function (slot0)
		return PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginWeekRed .. "_" .. slot0, 0) ~= math.floor(ServerTime.getWeekEndTimeStamp(true) / 3600)
	end,
	getTodayWeedDay = function (slot0)
		if slot0.wday == 1 then
			return 7
		end

		return slot0.wday - 1
	end,
	getFormatTime2 = function (slot0, slot1)
		slot2, slot3, slot4, slot5 = uv0.secondsToDDHHMMSS(slot0)
		slot6, slot7, slot8, slot9 = uv1(slot1)

		if slot2 > 0 then
			return uv2(slot2, slot6, slot3, slot7)
		elseif slot3 > 0 then
			return uv2(slot3, slot7, slot4, slot8)
		elseif slot4 > 0 then
			return uv2(slot4, slot8, slot5, slot9)
		else
			return string.format("%s%s", slot5, slot9)
		end
	end,
	getFormatTime1 = function (slot0, slot1)
		slot2, slot3, slot4, slot5 = uv0.secondsToDDHHMMSS(slot0)
		slot6, slot7, slot8, slot9 = uv1(slot1)

		if slot2 > 0 then
			return string.format("%s%s", slot2, slot6)
		elseif slot3 > 0 then
			return string.format("%s%s", slot3, slot7)
		elseif slot4 > 0 then
			return string.format("%s%s", slot4, slot8)
		else
			return string.format("%s%s", slot5, slot9)
		end
	end,
	SecondToActivityTimeFormat = function (slot0, slot1)
		slot3, slot4, slot5, slot6 = uv1.secondsToDDHHMMSS(slot0)
		slot7, slot8, slot9, slot10, slot11 = uv2(slot1)

		if math.floor(slot0 / uv0) > 0 then
			return uv3(slot2, slot7, slot3, slot8)
		elseif slot3 > 0 then
			return uv3(slot3, slot8, slot4, slot9)
		elseif slot4 > 0 then
			return uv3(slot4, slot9, slot5, slot10)
		else
			return uv3(0, slot9, math.max(1, slot5), slot10)
		end
	end
}

function slot1(slot0, slot1, slot2, slot3)
	if LangSettings.instance:isEn() then
		return string.format("%s%s %s%s", slot0, slot1, slot2, slot3)
	else
		return string.format("%s%s%s%s", slot0, slot1, slot2, slot3)
	end
end

function slot2(slot0, slot1, slot2, slot3, slot4, slot5)
	return slot0 and uv0.DateEnFormat.Year or luaLang(slot1), slot0 and uv0.DateEnFormat.Day or luaLang(slot2), slot0 and uv0.DateEnFormat.Hour or luaLang(slot3), slot0 and uv0.DateEnFormat.Minute or luaLang(slot4), slot0 and uv0.DateEnFormat.Second or luaLang(slot5)
end

function slot3(slot0)
	return uv0(slot0, "time_year", "time_day", "time_hour", "time_minute", "time_second")
end

function slot4(slot0)
	return uv0(slot0, "time_year", "time_day", "time_hour2", "time_minute2", "time_second")
end

function slot5(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7, slot8, slot9 = uv0(slot0, "time_year", slot1, slot2, slot3, slot4)

	return slot6, slot7, slot8, slot9
end

function slot6(slot0)
	return uv0(slot0, "time_day", "time_hour", "time_minute", "time_second")
end

function slot7(slot0)
	return uv0(slot0, "time_day", "time_hour2", "time_minute2", "time_second")
end

slot8 = 31536000
slot0.maxDateTimeStamp = slot0.dtTableToTimeStamp({
	hour = 0,
	month = 1,
	year = 2038,
	min = 0,
	sec = 0,
	day = 1
})

function slot0.getServerDateToString()
	slot0 = ServerTime.nowDateInLocal()

	return string.format("%04d-%02d-%02d %02d:%02d:%02d", slot0.year, slot0.month, slot0.day, slot0.hour, slot0.min, slot0.sec)
end

function slot0.getServerDateUTCToString()
	return uv0.getServerDateToString() .. " (" .. ServerTime.GetUTCOffsetStr() .. ")"
end

function slot0.getTimeStamp(slot0, slot1)
	return uv0.dtTableToTimeStamp(slot0) + 3600 * (uv0.getCurrentZoneOffset() - slot1) - ServerTime.getDstOffset()
end

function slot0.getCurrentZoneOffset()
	return os.difftime(os.time(), os.time(os.date("!*t", os.time()))) / 3600
end

function slot0.isDstTime(slot0)
	return os.date("*t", slot0).isdst
end

function slot0.getFormatTime(slot0)
	if not slot0 or slot0 <= 0 then
		return luaLang("summonmain_deadline_time_min")
	end

	slot2, slot3, slot4, slot5 = uv1.secondsToDDHHMMSS(slot0)
	slot6, slot7, slot8, slot9, slot10 = uv2()

	if math.floor(slot0 / uv0) > 0 then
		return uv3(slot1, slot6, slot2, slot7)
	elseif slot2 > 0 then
		return uv3(slot2, slot7, slot3, slot8)
	elseif slot3 > 0 then
		return uv3(slot3, slot8, slot4, slot9)
	elseif slot4 > 0 then
		return string.format("%s%s", slot4, slot9)
	else
		return luaLang("summonmain_deadline_time_min")
	end
end

return slot0
