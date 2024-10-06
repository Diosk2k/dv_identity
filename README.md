# Dv_Identity

Dv_Identity is an identity registration system for FiveM servers that provides a user-friendly interface for registering user data.

## Installation

1. **Create Resource:**
   - Create a new folder for the resource, e.g., `dv_identity`.

2. **Add Files:**
   - Place the following scripts in the `dv_identity` folder:
     - `server.lua`
     - `client.lua`
   - Create a subfolder named `html` and add the following files there:
     - `index.html`
     - `style.css`

3. **Enable Resource:**
   - Add the line `start dv_identity` to your `server.cfg`.

## Usage

- The script checks if the player is already registered in the database. If not, the registration menu will be displayed.
- Players can input their data, and it will be stored in the database.

## Making Changes

- **Change UI Texts:** To change the texts in the user interface, edit the `index.html` file and adjust the contents of the input fields and buttons.
- **Modify Database Structure:** To modify the database structure, edit the SQL queries in `server.lua` according to your needs.
- **Change Design:** To change the design, edit the CSS file (`style.css`) to adjust colors, fonts, and layouts.
- **Add New Fields:** For new fields or data, you can modify the HTML file and the `registerIdentity` function in `client.lua` to handle additional inputs.

## Code

### 1. Server Script (`server.lua`)

```lua
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
            TriggerClientEvent('esx:showNotification', source, 'Welcome back, ' .. result[1].firstname .. '!')
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
            TriggerClientEvent('esx:showNotification', source, 'Your identity has been successfully registered!')
        else
            TriggerClientEvent('esx:showNotification', source, 'Error registering your identity. Please try again.')
        end
    end)
end)
