RegisterNetEvent('dv_identity:showRegistrationMenu')
AddEventHandler('dv_identity:showRegistrationMenu', function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'show'})
end)

function registerIdentity()
    local data = {
        firstname = document.getElementById('firstname').value,
        lastname = document.getElementById('lastname').value,
        dateofbirth = document.getElementById('dateofbirth').value,
        sex = document.querySelector('input[name="sex"]:checked').value,
        height = document.getElementById('height').value
    }

    TriggerServerEvent('dv_identity:register', data)
end

document.getElementById('register').onsubmit = function(event)
    event.preventDefault()
    registerIdentity()
end

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerServerEvent('dv_identity:checkRegistration')
    end
end)
