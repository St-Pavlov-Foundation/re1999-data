module("modules.logic.versionactivity2_5.challenge.view.store.Act183CurrencyReplaceTipsView", package.seeall)

slot0 = class("Act183CurrencyReplaceTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/#txt_desc")
	slot0._simageold = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_old/#simage_old")
	slot0._simagenew = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_new/#simage_new")
	slot0._txtoldcount = gohelper.findChildText(slot0.viewGO, "root/#go_old/#txt_oldcount")
	slot0._txtnewcount = gohelper.findChildText(slot0.viewGO, "root/#go_new/#txt_newcount")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0:refresh()
	Act183Helper.saveOpenCurrencyReplaceTipsViewInLocal()
end

function slot0.refresh(slot0)
	slot0._oldCurrencyId, slot0._oldCurrencyCo, slot0._oldCurrencyIconUrl = slot0:initSingleInfo("oldCurrencyId", "oldCurrencyIconUrl")
	slot0._newCurrencyId, slot0._newCurrencyCo, slot0._newCurrencyIconUrl = slot0:initSingleInfo("newCurrencyId", "newCurrencyIconUrl")

	slot0._simageold:LoadImage(slot0._oldCurrencyIconUrl)
	slot0._simagenew:LoadImage(slot0._newCurrencyIconUrl)

	slot0._replaceRate = slot0.viewParam and slot0.viewParam.replaceRate

	if not slot0._replaceRate then
		logError(string.format("缺少货币替换比例参数replaceRate"))

		slot0._replaceRate = 1
	end

	slot0._oldCurrencyNum = slot0.viewParam and slot0.viewParam.oldCurrencyNum

	if not slot0._oldCurrencyNum then
		logError(string.format("缺少原始货币数量参数oldCurrencyNum"))

		slot0._oldCurrencyNum = 0
	end

	slot0._newCurrencyNum = slot0._oldCurrencyNum * slot0._replaceRate
	slot0._txtoldcount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), slot0._oldCurrencyNum)
	slot0._txtnewcount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), slot0._newCurrencyNum)
	slot0._txtdesc.text = slot0.viewParam and slot0.viewParam.desc or ""
end

function slot0.initSingleInfo(slot0, slot1, slot2)
	if not CurrencyConfig.instance:getCurrencyCo(slot0.viewParam and slot0.viewParam[slot1]) then
		logError(string.format("货币配置不存在  currencyIdParamName = %s, currencyId = %s", slot1, slot3))
	end

	return slot3, slot4, slot0.viewParam and slot0.viewParam[slot2] or ResUrl.getCurrencyItemIcon(slot4 and slot4.icon)
end

function slot0.getCurrencyCount(slot0, slot1)
	if not CurrencyModel.instance:getCurrency(slot1) then
		logError(string.format("货币数据不存在 currencyId = %s", slot1))

		return 0
	end

	return slot2.quantity
end

function slot0.onDestroy(slot0)
	slot0._simageold:UnLoadImage()
	slot0._simagenew:UnloadImage()
end

return slot0
