
function xUI_RepairSell()

    local sellTotal = 0;

    -- Sell Items:
    for bag = 0, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            -- Obtain the item:
            local item = GetContainerItemLink(bag,slot)

            -- Check the quality:
            if item then
                local itemQuality = select(3, GetItemInfo(item))
                local itemValue = select(11, GetItemInfo(item))
                if itemQuality == 0 then
                    sellTotal = sellTotal + itemValue
                    UseContainerItem(bag,slot)
                end
            end
        end
    end

    if sellTotal > 0 then
        print('Sold your gray items for ' .. GetCoinTextureString(sellTotal))
    end

    -- Auto repair:
    if CanMerchantRepair() then
        local repairCost = GetRepairAllCost()
        local money = GetMoney()

        if repairCost < money then
            RepairAllItems()
            print('Repairing all items for ' .. GetCoinTextureString(repairCost))
        else
            print('Tried to repair for ' .. GetCoinTextureString(repairCost) .. ' but you only have ' .. GetCoinTextureString(money))
        end
    end
end

XervishUI:RegisterCallback("MERCHANT_SHOW", xUI_RepairSell)