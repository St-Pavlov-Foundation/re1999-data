module("modules.logic.fight.model.datahelper.FightDataUtil", package.seeall)

slot1 = {
	class = true
}

return {
	copyData = function (slot0)
		if type(slot0) ~= "table" then
			return slot0
		else
			slot1 = {
				[slot5] = uv0.copyData(slot6)
			}

			for slot5, slot6 in pairs(slot0) do
				-- Nothing
			end

			if getmetatable(slot0) then
				setmetatable(slot1, slot2)
			end

			return slot1
		end
	end,
	coverData = function (slot0, slot1, slot2, slot3)
		if slot0 == nil then
			return nil
		end

		if slot1 == nil then
			if getmetatable(slot0) then
				setmetatable({}, slot4)
			end
		end

		for slot7, slot8 in pairs(slot1) do
			slot9 = false

			if slot2 and slot2[slot7] then
				slot9 = true
			end

			if uv0[slot7] then
				slot9 = true
			end

			if not slot9 and slot0[slot7] == nil then
				slot1[slot7] = nil
			end
		end

		for slot7, slot8 in pairs(slot0) do
			slot9 = false

			if slot2 and slot2[slot7] then
				slot9 = true
			end

			if uv0[slot7] then
				slot9 = true
			end

			if not slot9 then
				if slot3 and slot3[slot7] then
					slot3[slot7](slot0, slot1)
				elseif slot1[slot7] == nil then
					slot1[slot7] = FightHelper.deepCopySimpleWithMeta(slot0[slot7])
				elseif type(slot8) == "table" then
					uv1.coverInternal(slot8, slot1[slot7])
				else
					slot1[slot7] = slot8
				end
			end
		end

		return slot1
	end,
	coverInternal = function (slot0, slot1)
		for slot5, slot6 in pairs(slot1) do
			if slot0[slot5] == nil then
				slot1[slot5] = nil
			end
		end

		for slot5, slot6 in pairs(slot0) do
			if type(slot6) == "table" then
				if slot1[slot5] == nil then
					slot1[slot5] = FightHelper.deepCopySimpleWithMeta(slot6)
				else
					uv0.coverInternal(slot6, slot1[slot5])
				end
			else
				slot1[slot5] = slot6
			end
		end
	end,
	findDiffList = {},
	findDiffPath = {},
	addPathkey = function (slot0)
		table.insert(uv0.findDiffPath, slot0)
	end,
	removePathKey = function ()
		table.remove(uv0.findDiffPath)
	end,
	findDiff = function (slot0, slot1, slot2, slot3)
		uv0.findDiffList = {}
		uv0.findDiffPath = {}
		slot8 = slot3

		uv0.doFindDiff(slot0, slot1, slot2, slot8)

		slot4 = {}

		for slot8, slot9 in ipairs(uv0.findDiffList) do
			slot4[slot10] = slot4[slot9.pathList[1]] or {}

			table.insert(slot4[slot10], slot9)
		end

		return #uv0.findDiffList > 0, slot4, uv0.findDiffList
	end,
	doFindDiff = function (slot0, slot1, slot2, slot3, slot4)
		if type(slot0) ~= "table" or type(slot1) ~= "table" then
			logError("传入的参数必须是表结构,请检查代码")

			return
		end

		slot8 = slot2

		uv0.doCheckMissing(slot0, slot1, slot8)

		for slot8, slot9 in pairs(slot0) do
			slot10 = false

			if slot2 and slot2[slot8] then
				slot10 = true
			end

			if not slot10 and slot1[slot8] ~= nil then
				uv0.addPathkey(slot8)

				if slot3 and slot3[slot8] then
					slot3[slot8](slot0[slot8], slot1[slot8], slot0, slot1)
				elseif slot4 then
					slot4(slot0[slot8], slot1[slot8])
				else
					uv0.checkDifference(slot0[slot8], slot1[slot8])
				end

				uv0.removePathKey()
			end
		end
	end,
	checkDifference = function (slot0, slot1)
		if type(slot0) ~= type(slot1) then
			uv0.addDiff(nil, uv0.diffType.difference)

			return
		elseif type(slot0) == "table" then
			uv0.doCheckMissing(slot0, slot1)

			for slot5, slot6 in pairs(slot0) do
				if slot1[slot5] ~= nil then
					uv0.addPathkey(slot5)
					uv0.checkDifference(slot6, slot1[slot5])
					uv0.removePathKey()
				end
			end
		elseif slot0 ~= slot1 then
			uv0.addDiff(nil, uv0.diffType.difference)
		end
	end,
	doCheckMissing = function (slot0, slot1, slot2)
		for slot6, slot7 in pairs(slot1) do
			slot8 = false

			if slot2 and slot2[slot6] then
				slot8 = true
			end

			if not slot8 and slot0[slot6] == nil then
				uv0.addDiff(slot6, uv0.diffType.missingSource)
			end
		end

		for slot6, slot7 in pairs(slot0) do
			slot8 = false

			if slot2 and slot2[slot6] then
				slot8 = true
			end

			if not slot8 and slot1[slot6] == nil then
				uv0.addDiff(slot6, uv0.diffType.missingTarget)
			end
		end
	end,
	diffType = {
		missingTarget = 2,
		difference = 3,
		missingSource = 1
	},
	addDiff = function (slot0, slot1)
		slot2 = {
			diffType = slot1 or uv0.diffType.difference
		}
		slot3 = uv0.coverData(uv0.findDiffPath)

		if slot0 then
			table.insert(slot3, slot0)
		end

		slot2.pathList = slot3
		slot2.pathStr = table.concat(slot3, ".")

		table.insert(uv0.findDiffList, slot2)

		return slot2
	end,
	getDiffValue = function (slot0, slot1, slot2)
		slot3, slot4 = nil

		for slot11, slot12 in ipairs(slot2.pathList) do
			slot6 = slot0[slot12]
			slot7 = slot1[slot12]
		end

		if slot3 == nil then
			slot3 = "nil"
		end

		if slot4 == nil then
			slot4 = "nil"
		end

		return slot3, slot4
	end
}
