local CoreName = exports[Config.Core]:GetCoreObject()

CreateThread(function()
    if Config.TargetCore == 'qb' then 
        for k, v in pairs(Config.ReviewPed.coords) do 
            CoreName.Functions.LoadModel(Config.ReviewPed.model)
            local ped = CreatePed(4, Config.ReviewPed.model, v.x, v.y, v.z - 1.0, v.w, false, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            exports[Config.Target]:AddTargetEntity(ped, {
                options = {
                    {
                        event = 'kael-review:client:openReviewMenu',
                        icon = 'fas fa-star',
                        label = 'Submit Review',
                    },
                },
                distance = 2.5,
            })
        end
        for k, v in pairs(Config.LeaderboardPed.coords) do 
            CoreName.Functions.LoadModel(Config.LeaderboardPed.model)
            local ped = CreatePed(4, Config.LeaderboardPed.model, v.x, v.y, v.z - 1.0, v.w, false, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            exports[Config.Target]:AddTargetEntity(ped, {
                options = {
                    {
                        event = 'kael-review:client:openJobLeaderboardMenu',
                        icon = 'fas fa-trophy',
                        label = 'View Job Leaderboard',
                    },
                },
                distance = 2.5,
            })
        end
        for k, v in pairs(Config.CheckReviewsPed.coords) do 
            CoreName.Functions.LoadModel(Config.CheckReviewsPed.model)
            local ped = CreatePed(4, Config.CheckReviewsPed.model, v.x, v.y, v.z - 1.0, v.w, false, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            exports[Config.Target]:AddTargetEntity(ped, {
                options = {
                    {
                        event = 'kael-review:client:openCheckReviewsMenu',
                        icon = 'fas fa-book',
                        label = 'Check Reviews',
                    },
                },
                distance = 2.5,
            })
        end
    elseif Config.TargetCore == 'ox' then 
        for k, v in pairs(Config.ReviewPed.coords) do 
            CoreName.Functions.LoadModel(Config.ReviewPed.model)
            local ped = CreatePed(4, Config.ReviewPed.model, v.x, v.y, v.z - 1.0, v.w, false, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            
            exports.ox_target:addLocalEntity(ped, {
                {
                    name = 'kael-review:client:openReviewMenu',
                    icon = 'fas fa-star',
                    label = 'Submit Review',
                    onSelect = function(data)
                        TriggerEvent('kael-review:client:openReviewMenu')
                    end
                }
            })
        end
        for k, v in pairs(Config.LeaderboardPed.coords) do 
            CoreName.Functions.LoadModel(Config.LeaderboardPed.model)
            local ped = CreatePed(4, Config.LeaderboardPed.model, v.x, v.y, v.z - 1.0, v.w, false, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            
            exports.ox_target:addLocalEntity(ped, {
                {
                    name = 'kael-review:client:openJobLeaderboardMenu',
                    icon = 'fas fa-trophy',
                    label = 'View Job Leaderboard',
                    onSelect = function(data)
                        TriggerEvent('kael-review:client:openJobLeaderboardMenu')
                    end
                }
            })
        end
        for k, v in pairs(Config.CheckReviewsPed.coords) do 
            CoreName.Functions.LoadModel(Config.CheckReviewsPed.model)
            local ped = CreatePed(4, Config.CheckReviewsPed.model, v.x, v.y, v.z - 1.0, v.w, false, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            
            exports.ox_target:addLocalEntity(ped, {
                {
                    name = 'kael-review:client:openCheckReviewsMenu',
                    icon = 'fas fa-book',
                    label = 'Check Reviews',
                    onSelect = function(data)
                        TriggerEvent('kael-review:client:openCheckReviewsMenu')
                    end
                }
            })
        end        
    end
end)

RegisterNetEvent('kael-review:client:openReviewMenu', function()
    local jobOptions = {}
    if Config.MenuCore == 'qb' then 
        for _, job in pairs(Config.Jobs) do
            jobOptions[#jobOptions + 1] = { value = job.value, text = job.text }
        end
        local input = exports[Config.Input]:ShowInput({
            header = 'Submit Your Review',
            submitText = 'Submit',
            inputs = {
                {
                    text = 'Rating (1-5)',
                    name = 'rating',
                    type = 'number',
                    isRequired = true,
                    default = 5,
                    min = 1,
                    max = 5
                },
                {
                    text = 'Comments',
                    name = 'comments',
                    type = 'text',
                    isRequired = false,
                    default = ''
                },
                {
                    text = 'Job',
                    name = 'job',
                    type = 'select',
                    options = jobOptions,
                    isRequired = true
                }
            }
        })
        if input then
            local rating = tonumber(input.rating)
            local comments = input.comments
            local job = input.job
    
            if rating and rating >= 1 and rating <= 5 then
                TriggerServerEvent('kael-review:server:submitReview', {
                    rating = rating,
                    comments = comments,
                    job = job
                })
            else
                Notify('Review' ,'Please provide a valid rating between 1 and 5.', 'error')
            end
        end
    elseif Config.MenuCore == 'ox' then 
        for _, job in pairs(Config.Jobs) do
            jobOptions[#jobOptions + 1] = { value = job.value, text = job.text }
        end
        
        local input = lib.inputDialog('Submit Your Review', {
            {
                type = 'number',
                label = 'Rating (1-5)',
                name = 'rating',
                icon = 'fas fa-star',
                default = 5,
                min = 1,
                max = 5,
                required = true
            },
            {
                type = 'textarea',
                label = 'Comments',
                name = 'comments',
                default = '',
                icon = 'fas fa-comments',
                required = false
            },
            {
                type = 'select',
                label = 'Job',
                name = 'job',
                options = jobOptions,
                icon = 'fas fa-briefcase',
                required = true
            }
        })
        if input then
            local rating = input[1]
            local comments = input[2]
            local job = input[3]
            if rating and rating >= 1 and rating <= 5 then
                TriggerServerEvent('kael-review:server:submitReview', {
                    rating = rating,
                    comments = comments,
                    job = job
                })
            else
                Notify('Review' ,'Please provide a valid rating between 1 and 5.', 'error')
            end
        end        
    end
end)


RegisterNetEvent('kael-review:client:openCheckReviewsMenu', function()
    if Config.MenuCore == 'qb' then 
        CoreName.Functions.TriggerCallback('kael-review:getReviews', function(reviews)
            if reviews and #reviews > 0 then
                local menu = {
                    {
                        header = 'Recent Reviews',
                        isMenuHeader = true
                    }
                }
    
                for _, review in ipairs(reviews) do
                    menu[#menu + 1] = {
                        header = string.format('%s - %s (%s)', review.playerName, string.rep('⭐', review.rating), review.job),
                        txt = review.comments,
                        isMenuHeader = true
                    }
                end
                menu[#menu + 1] = {
                    header = '< Back',
                    params = { event = Config.Menu .. ':closeMenu' }
                }
    
                exports[Config.Menu]:openMenu(menu)
            else
                Notify('Empty' ,'No reviews available', 'error')
            end
        end)
    elseif Config.MenuCore == 'ox' then
        CoreName.Functions.TriggerCallback('kael-review:getReviews', function(reviews)
            if reviews and #reviews > 0 then
                local menu = {
                    {
                        title = 'Recent Reviews',
                        readOnly = true
                    }
                }
        
                for _, review in ipairs(reviews) do
                    menu[#menu + 1] = {
                        title = string.format('%s - %s (%s)', review.playerName, string.rep('⭐', review.rating), review.job),
                        description = review.comments,
                        readOnly = true
                    }
                end
        
                menu[#menu + 1] = {
                    title = '< Back',
                    event = Config.Menu .. ':closeMenu'
                }
        
                lib.registerContext({
                    id = 'reviewMenu',
                    title = 'Reviews',
                    options = menu
                })
        
                lib.showContext('reviewMenu')
            else
                Notify('Empty' ,'No reviews available', 'error')
            end
        end)
        
    end
end)

RegisterNetEvent('kael-review:client:openJobLeaderboardMenu', function()
    if Config.MenuCore == 'qb' then 
        CoreName.Functions.TriggerCallback('kael-review:getJobLeaderboard', function(leaderboard)
            if leaderboard and #leaderboard > 0 then
                local menu = {
                    {
                        header = 'Top Rated Jobs',
                        isMenuHeader = true
                    }
                }
    
                for _, job in ipairs(leaderboard) do
                    menu[#menu+1] = {
                        header = string.format('%s - %.2f ⭐', job.job, job.avg_rating),
                        txt = 'Click to view reviews',
                        params = {
                            event = 'kael-review:openJobReviewsMenu',
                            args = { job = job.job }
                        }
                    }
                end
                menu[#menu+1] = {
                    header = '< Back',
                    params = { event = Config.Menu .. ':closeMenu' }
                }
    
                exports[Config.Menu]:openMenu(menu)
            else
                Notify('Leaderboard' ,'No job leaderboard data available.', 'error')
            end
        end)
    elseif Config.MenuCore == 'ox' then
        CoreName.Functions.TriggerCallback('kael-review:getJobLeaderboard', function(leaderboard)
            if leaderboard and #leaderboard > 0 then
                local menu = {
                    {
                        title = 'Top Rated Jobs',
                        readOnly = true,
                        iconAnimation = 'beat'
                    }
                }
                for _, job in ipairs(leaderboard) do
                    menu[#menu+1] = {
                        title = string.format('%s - %.2f ⭐', job.job, job.avg_rating),
                        description = 'Click to view reviews',
                        event = 'kael-review:openJobReviewsMenu',
                        args = { job = job.job }
                    }
                end
                menu[#menu+1] = {
                    title = '< Back',
                    event = Config.Menu .. ':closeMenu'
                }
                lib.registerContext({
                    id = 'jobLeaderboardMenu',
                    title = 'Job Leaderboard',
                    options = menu
                })
        
                lib.showContext('jobLeaderboardMenu')
            else
                Notify('Leaderboard' ,'No job leaderboard data available.', 'error')
            end
        end)
        
    end
end)

RegisterNetEvent('kael-review:openJobReviewsMenu', function(data)
    local job = data.job
    if Config.MenuCore == 'qb' then 
        CoreName.Functions.TriggerCallback('kael-review:getJobReviews', function(reviews)
            if reviews and #reviews > 0 then
                local menu = {
                    {
                        header = string.format('Reviews for %s', job),
                        isMenuHeader = true
                    }
                }
                for _, review in ipairs(reviews) do
                    menu[#menu+1] = {
                        header = string.format('%s - %s', review.playerName, string.rep('⭐', review.rating)),
                        txt = review.comments,
                        isMenuHeader = true
                    }
                end
                menu[#menu+1] = {
                    header = '< Back',
                    params = { event = 'kael-review:client:openJobLeaderboardMenu' }
                }
                exports[Config.Menu]:openMenu(menu)
            else
                Notify('Review', string.format('No reviews available for %s.', job), 'error')
            end
        end, job)
    elseif Config.MenuCore == 'ox' then 
        CoreName.Functions.TriggerCallback('kael-review:getJobReviews', function(reviews)
            if reviews and #reviews > 0 then
                local menu = {
                    {
                        title = string.format('Reviews for %s', job),
                        readOnly = true
                    }
                }
                for _, review in ipairs(reviews) do
                    menu[#menu+1] = {
                        title = string.format('%s - %s', review.playerName, string.rep('⭐', review.rating)),
                        description = review.comments
                    }
                end
                menu[#menu+1] = {
                    title = '< Back',
                    event = 'kael-review:client:openJobLeaderboardMenu'
                }
                lib.registerContext({
                    id = 'jobReviewsMenu',
                    title = string.format('Reviews for %s', job),
                    options = menu
                })
        
                lib.showContext('jobReviewsMenu')
            else
                Notify('Review', string.format('No reviews available for %s.', job), 'error')
            end
        end, job)
        
    end
end)