local open = false

local function setVisible(state, data)
    open = state
    SetNuiFocus(state, state)
    SendNUIMessage({ action = state and 'open' or 'close', data = data })
end

RegisterCommand(Config.Command, function()
    if open then return end
    TriggerServerEvent('inv_nopixel:requestOpen')
end, false)

RegisterKeyMapping(Config.Command, 'Abrir inventário', 'keyboard', Config.OpenKey)

RegisterNetEvent('inv_nopixel:open', function(data)
    setVisible(true, data)
end)

RegisterNetEvent('inv_nopixel:itemUsed', function(name, metadata)
    -- Integre aqui os efeitos de consumo da sua base.
    if Config.Debug then print(('[inv_nopixel] item usado: %s'):format(name)) end
end)

RegisterNUICallback('close', function(_, cb)
    setVisible(false)
    cb({ ok = true })
end)

RegisterNUICallback('use', function(data, cb)
    TriggerServerEvent('inv_nopixel:useItem', data.slot)
    cb({ ok = true })
end)

RegisterNUICallback('discard', function(data, cb)
    TriggerServerEvent('inv_nopixel:removeItem', data.name, data.amount or 1, data.metadata)
    cb({ ok = true })
end)

exports('openInventory', function() TriggerServerEvent('inv_nopixel:requestOpen') end)
exports('closeInventory', function() if open then setVisible(false) end end)
