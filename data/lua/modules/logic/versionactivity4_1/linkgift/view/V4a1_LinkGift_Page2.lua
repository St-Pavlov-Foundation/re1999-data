-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_Page2.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_Page2", package.seeall)

local V4a1_LinkGift_Page2 = class("V4a1_LinkGift_Page2", V4a1_LinkGift_PageImpl)

function V4a1_LinkGift_Page2:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_LinkGift_Page2:addEvents()
	return
end

function V4a1_LinkGift_Page2:removeEvents()
	return
end

function V4a1_LinkGift_Page2:ctor(...)
	V4a1_LinkGift_Page2.super.ctor(self, ...)

	self._headItemList = {}
end

function V4a1_LinkGift_Page2:_editableInitView()
	V4a1_LinkGift_Page2.super._editableInitView(self)
	self:_editableInitView_playerhead()
end

function V4a1_LinkGift_Page2:_editableInitView_playerhead()
	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("playerhead/go_rolehead%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_V4a1_LinkGift_PlayerHeadItem(go, i)
			local txtCmp = gohelper.findChildText(self.viewGO, string.format("playerhead/txt_name%s", i))

			if txtCmp then
				txtCmp.text = ""

				item:bindName(txtCmp)
			end

			table.insert(self._headItemList, item)
		end

		i = i + 1
	until isNil
end

function V4a1_LinkGift_Page2:_create_V4a1_LinkGift_PlayerHeadItem(srcGO, index)
	local item = V4a1_LinkGift_PlayerHeadItem.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(srcGO)

	return item
end

function V4a1_LinkGift_Page2:onPlayerHeaddItemClick(item)
	return true
end

function V4a1_LinkGift_Page2:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_headItemList")
	V4a1_LinkGift_Page2.super.onDestroyView(self)
end

function V4a1_LinkGift_Page2:setData(mo)
	V4a1_LinkGift_Page2.super.setData(self, mo)
	self:_refreshHeadItemList()
end

function V4a1_LinkGift_Page2:_refreshHeadItemList()
	local c = self:baseViewContainer()
	local productList = c:getChargeGoodsProductListByIndex(self:index())
	local maxCount = #productList
	local itemMaxCount = #self._headItemList

	for i = 1, maxCount do
		if itemMaxCount < i then
			break
		end

		local item = self._headItemList[i]
		local itemCO = productList[i]

		if not item then
			if isDebugBuild then
				logError("[V4a1_LinkGift_Page2] item count out of range! index:" .. i)
			end

			break
		end

		item:onUpdateMO(itemCO)
		item:setActive(true)
	end

	for i = maxCount + 1, #self._headItemList do
		local item = self._headItemList[i]

		item:setActive(false)
	end
end

return V4a1_LinkGift_Page2
