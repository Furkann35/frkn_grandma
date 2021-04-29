ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)



RegisterNetEvent('parakes')
AddEventHandler('parakes', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if(xPlayer.getMoney() >= Config.TedaviUcret) then
		xPlayer.removeMoney(Config.TedaviUcret)
        frkn_grandmalog(xPlayer, 'Grandma tarafından tedavi edildi')

    end
end)


RegisterServerEvent('disc:sil')
AddEventHandler('disc:sil', function(name, amount)
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(name, amount)
end)


function frkn_grandmalog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
   
    local discord_webhook = "BURAYA WEBHOOK GİRİNİZ"
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "Furkan Log Sistemi",
      ["avatar_url"] = "https://cdn.discordapp.com/attachments/707305833871966360/769400563442909214/Visual_Studio_code_logo.png",
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. xPlayer.identifier 
        },
        ["color"] = 1942002,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
    local replacements = {
        ['&' ] = '&amp;',
        ['<' ] = '&lt;',
        ['>' ] = '&gt;',
        ['\n'] = '<br/>'
    }

    return str
        :gsub('[&<>\n]', replacements)
        :gsub(' +', function(s)
            return ' '..('&nbsp;'):rep(#s-1)
        end)
end
