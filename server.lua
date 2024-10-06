ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dv_identity:checkRegistration')
AddEventHandler('dv_identity:checkRegistration', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT firstname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if #result == 0 then
            TriggerClientEvent('dv_identity:showRegistrationMenu', source)
        else
            TriggerClientEvent('esx:showNotification', source, 'Willkommen zurück, ' .. result[1].firstname .. '!')
        end
    end)
end)

RegisterServerEvent('dv_identity:register')
AddEventHandler('dv_identity:register', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local firstname = data.firstname
    local lastname = data.lastname
    local dateofbirth = data.dateofbirth
    local sex = data.sex
    local height = data.height

    MySQL.Async.execute('UPDATE users SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier,
        ['@firstname'] = firstname,
        ['@lastname'] = lastname,
        ['@dateofbirth'] = dateofbirth,
        ['@sex'] = sex,
        ['@height'] = height
    }, function(affectedRows)
        if affectedRows > 0 then
            TriggerClientEvent('esx:showNotification', source, 'Ihre Identität wurde erfolgreich registriert!')
        else
            TriggerClientEvent('esx:showNotification', source, 'Fehler bei der Registrierung Ihrer Identität. Bitte versuchen Sie es erneut.')
        end
    end)
end)
