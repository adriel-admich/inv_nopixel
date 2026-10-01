local open = false
local debugMode = Config.Debug or false

local function setVisible(state, data)
    open = state
    SetNuiFocus(state, state)
    SendNUIMessage({ 
        action = state and 'open' or 'close', 
        data = data 
    })
end

RegisterCommand(Config.Command, function()
    if open then
        setVisible(false)
        return
    end
    TriggerServerEvent('inv_nopixel:requestOpen')
end, false)

RegisterKeyMapping(Config.Command, 'Abrir inventário', 'keyboard', Config.OpenKey)

RegisterNetEvent('inv_nopixel:open', function(data)
    setVisible(true, data)
end)

RegisterNetEvent('inv_nopixel:itemUsed', function(name, metadata)
    if debugMode then
        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {'Inventário', 'Item usado: ' .. name}
        })
    end
end)

RegisterNUICallback('close', function(_, cb)
    setVisible(false)
    cb({ ok = true })
end)

RegisterNUICallback('use', function(data, cb)
    if data and data.slot then
        TriggerServerEvent('inv_nopixel:useItem', data.slot)
    end
    cb({ ok = true })
end)

RegisterNUICallback('discard', function(data, cb)
    if data and data.name then
        TriggerServerEvent('inv_nopixel:removeItem', data.name, data.amount or 1, data.metadata)
    end
    cb({ ok = true })
end)

exports('openInventory', function()
    TriggerServerEvent('inv_nopixel:requestOpen')
end)

exports('closeInventory', function()
    if open then
        setVisible(false)
    end
end)

if debugMode then
    print('^2[inv_nopixel]^7 Client loaded successfully')
end
