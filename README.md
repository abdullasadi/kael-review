# kael-reviews

`kael-reviews` is a standalone review script for FiveM servers, allowing players to submit, manage, and view reviews for businesses or locations directly within the game.

## 🔔 Contact

Discord: [Join the Discord](https://discord.gg/TjZXDQSsDF)  
Store: [Click Here](https://kael.tebex.io/)

## 💾 Installation

1. Download the script from GitHub.
2. Extract the downloaded file and rename the folder to `kael-reviews`.
3. Place the `kael-reviews` folder into your server's `resources` directory.
4. Add `ensure kael-reviews` to your `server.cfg` to start the resource automatically.
5. Add your discord webhook to our server > open.lua.

## 📖 Dependencies

- [oxmysql](https://github.com/overextended/oxmysql)
- [ox_lib](https://github.com/overextended/ox_lib)

## 📖 Features

- **Target-Based System**: Interact with an NPC using `qb-target` or `ox_target` to leave and view reviews.
- **Leaderboard System**: Displays top-rated businesses and users.
- **Check Reviews**: Players can view past reviews for any business.
- **ReviewPed System**: Customizable NPC for submitting and checking reviews.
- **Discord Logs**: Logs all reviews and interactions to a Discord webhook for moderation.

## 🛠️ Usage

1. Approach the ReviewPed placed in the world.
2. Use the target system (`qb-target` or `ox_target`) to open the review menu.
3. Submit a new review, check existing reviews, or view the leaderboard.
4. All interactions and new reviews will be logged in Discord (if enabled).

## 🔧 Configuration

All configurations, including NPC placement, review settings, and Discord webhook integration, can be modified in the `config.lua` file.

---

Enjoy using `kael-reviews` for a better roleplay experience! 🎉

