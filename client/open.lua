local QBCore = exports[Config.Core]:GetCoreObject()

function Notify(title, desc, type)
    if Config.Notify == 'qb' then 
        QBCore.Functions.Notify(desc, type, 5000)
    elseif Config.Notify == 'ox' then 
        lib.notify({
            title = title,
            description = desc,
            type = type
        })
    elseif Config.Notify == 'okok' then 
        exports['okokNotify']:Alert(title, desc, 5000, type, true)
    elseif Config.Notify == 'fl' then 
        exports['FL-Notify']:Notify(title, "", desc, 5000, type, Right)
    end
end