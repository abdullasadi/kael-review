local Reviews = {}
local CoreName = exports[Config.Core]:GetCoreObject()

local function saveReviewsToFile()
    SaveResourceFile(GetCurrentResourceName(), 'reviews.json', json.encode(Reviews, { indent = true }), -1)
end

local function loadReviewsFromFile()
    local fileContent = LoadResourceFile(GetCurrentResourceName(), 'reviews.json')
    if fileContent then
        Reviews = json.decode(fileContent) or {}
    end
end

CreateThread(function()
    loadReviewsFromFile()
end)

CreateThread(function()
    Wait(600000)
    saveReviewsToFile()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        saveReviewsToFile()
    end
end)

RegisterNetEvent('kael-review:server:submitReview', function(data)
    local src = source
    local playerName = GetPlayerName(src)
    local rating = data.rating
    local comments = data.comments or 'No comments'
    local job = data.job or 'Unknown Job'
    local timestamp = os.date('%Y-%m-%d %H:%M:%S', os.time())
    local review = {
        playerName = playerName,
        rating = rating,
        comments = comments,
        job = job,
        timestamp = timestamp
    }
    Reviews[#Reviews + 1] = review
    saveReviewsToFile()
    sendToDiscord(review)
    Notify('Thank You', 'Thank you for your review!', 'success')
end)

CoreName.Functions.CreateCallback('kael-review:getReviews', function(source, cb)
    cb(Reviews)
end)

function sendToDiscord(review)
    local embed = {
        {
            ["color"] = 3447003,
            ["title"] = "New Review Submitted",
            ["fields"] = {
                {
                    ["name"] = "Player",
                    ["value"] = review.playerName,
                    ["inline"] = true
                },
                {
                    ["name"] = "Rating",
                    ["value"] = string.rep('⭐', review.rating),
                    ["inline"] = true
                },
                {
                    ["name"] = "Job",
                    ["value"] = review.job,
                    ["inline"] = true
                },
                {
                    ["name"] = "Comments",
                    ["value"] = review.comments,
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = review.timestamp
            }
        }
    }

    PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, avatar_url= Config.Logo, embeds = embed}), { ['Content-Type'] = 'application/json' })
end


CoreName.Functions.CreateCallback('kael-review:getJobLeaderboard', function(source, cb)
    local jobRatings = {}
    for _, review in ipairs(Reviews) do
        if not jobRatings[review.job] then
            jobRatings[review.job] = { totalRating = 0, count = 0 }
        end
        jobRatings[review.job].totalRating = jobRatings[review.job].totalRating + review.rating
        jobRatings[review.job].count = jobRatings[review.job].count + 1
    end

    local leaderboard = {}
    for job, data in pairs(jobRatings) do
        table.insert(leaderboard, {
            job = job,
            avg_rating = data.totalRating / data.count
        })
    end

    table.sort(leaderboard, function(a, b) return a.avg_rating > b.avg_rating end)
    cb(leaderboard)
end)

CoreName.Functions.CreateCallback('kael-review:getJobReviews', function(source, cb, job)
    local jobReviews = {}
    for _, review in ipairs(Reviews) do
        if review.job == job then
            table.insert(jobReviews, review)
        end
    end
    cb(jobReviews)
end)
