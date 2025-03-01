Webhook = ''


function Notify(title, desc, type)
    if Config.Notify == 'qb' then 
        QBCore.Functions.Notify(desc, type, 5000)
    elseif Config.Notify == 'ox' then 
        lib.notify({
            title = title,
            description = desc,
            type = type
        })
    end
end