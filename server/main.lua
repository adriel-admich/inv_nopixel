Bridge = Bridge or {}
local cooldowns = {}

local function validAmount(amount)
    amount = tonumber(amount)
    return amount and amount > 0 and amount <= Config.Security.maxAmount and math.floor(amount) == amount
end

local function snapshot(source)
    return {
        slots = Config.MaxSlots,
        maxWeight = Config.MaxWeight,
        items = Bridge.GetInventory(source)
    }
end

local function allowed(source)
    local now = GetGameTimer()
    if cooldowns[source] and now - cooldowns[source] < Config.Security.actionCooldown then return false end
    cooldowns[source] = now
    return true
end

lib.callback.register('inv_nopixel:getInventory', function(source)
    return snapshot(source)
end)

RegisterNetEvent('inv_nopixel:requestOpen', function()
    local source = source
    TriggerClientEvent('inv_nopixel:open', source, snapshot(source))
end)

RegisterNetEvent('inv_nopixel:useItem', function(slot)
    local source = source
    if not allowed(source) then return end
    local inventory = Bridge.GetInventory(source)
    local item = inventory[slot] or inventory[tonumber(slot)]
    if not item or not Items[item.name] or not Items[item.name].usable then return end
    TriggerClientEvent('inv_nopixel:itemUsed', source, item.name, item.metadata or item.info or {})
    TriggerClientEvent('inv_nopixel:open', source, snapshot(source))
end)

RegisterNetEvent('inv_nopixel:removeItem', function(name, amount, metadata)
    local source = source
    if not validAmount(amount) or type(name) ~= 'string' then return end
    if Bridge.RemoveItem(source, name, amount, metadata) then
        TriggerClientEvent('inv_nopixel:open', source, snapshot(source))
    end
end)

exports('GetInventory', Bridge.GetInventory)
exports('AddItem', function(source, name, amount, metadata) return Bridge.AddItem(source, name, amount, metadata) end)
exports('RemoveItem', function(source, name, amount, metadata) return Bridge.RemoveItem(source, name, amount, metadata) end)
exports('HasItem', Bridge.HasItem)
