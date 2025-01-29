_Hawk = "ohhahtuhthttouttpwuttuaunbotwo"

local Hawk = loadstring(game:HttpGet("https://raw.githubusercontent.com/incrimination/HawkHUB-fork/refs/heads/main/LibSources/HawkLib.lua", true))()

local Window = Hawk:Window({
    ScriptName = "Lomu HUB",
    DestroyIfExists = true,
    Theme = "Dark"
})

Window:Close({
    visibility = true,
    Callback = function()
        Window:Destroy()
    end,
})

Window:Minimize({
    visibility = true,
    OpenButton = true,
    Callback = function()
    end,
})

local tab1 = Window:Tab("Games")
local infoTab = Window:Tab("ℹ️ Information")

-- Add information sections
local execInfo = infoTab:Section("⚠️ Executor Requirements")
execInfo:Label("Your executor is not supported!")
execInfo:Label("Required functions:")
execInfo:Label("• writefile, readfile, isfile, setclipboard")
execInfo:Label("")
execInfo:Label("• This script requires an executor with 100% UNC support")
execInfo:Label("• If you see 'hands up skid' in console, your executor")
execInfo:Label("  doesn't support obfuscated scripts")

local scriptInfo = infoTab:Section("📝 Script Information")
scriptInfo:Label("• Version: 1.0.0")
scriptInfo:Label("• Last Updated: 2024")
scriptInfo:Label("• Created by: Lomu")

local troubleInfo = infoTab:Section("🔧 Troubleshooting")
troubleInfo:Label("• If script fails to load, try running it again")
troubleInfo:Label("• Make sure you're in the correct game")
troubleInfo:Label("• Check if your executor is updated")
troubleInfo:Label("• Join our Discord for support")

local creditsInfo = infoTab:Section("👥 Credits")
creditsInfo:Label("• UI Library: HawkLib")
creditsInfo:Label("• Special thanks to all contributors")

local Recome = tab1:Section("🔥 Frequently executed scripts")

local function CreateRecomend(placeName, placeIdOrCallback, scriptUrl)
    Recome:Button(placeName, "Load script for " .. placeName, function()
        if type(placeIdOrCallback) == "function" then
            placeIdOrCallback()
        else
            if game.PlaceId == placeIdOrCallback then
                loadstring(game:HttpGet(scriptUrl, true))()
                Window:Destroy()
            else
                Hawk:AddNotifications():Notification("Error", "Wrong game!", "Error", 3)
                game.Players.LocalPlayer:Kick("Wrong game! Please join the correct game to use this script.")
            end
        end
    end)
end

CreateRecomend("PETS GO! ✨", 18901165922, "https://raw.githubusercontent.com/jkancc111/Games-V2/main/PetsGo.txt")
CreateRecomend("[UPD] Fisch", 16732694052, "https://raw.githubusercontent.com/jkancc111/Games-V2/main/Fisch.txt")
CreateRecomend("[🎁XMAS] Blox Fruits", function()
    local bloxFruitIds = {
        2753915549,  -- First Sea
        4442272183,  -- Second Sea
        7449423635   -- Third Sea
    }
    
    local currentGame = game.PlaceId
    local isValidGame = false
    
    for _, gameId in pairs(bloxFruitIds) do
        if currentGame == gameId then
            isValidGame = true
            break
        end
    end
    
    if isValidGame then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/jkancc111/Games-V2/main/BloxFruit.txt", true))()
        Window:Destroy()
    else
        Hawk:AddNotifications():Notification("Error", "Wrong game!", "Error", 3)
        game.Players.LocalPlayer:Kick("Wrong game! Please join Blox Fruits to use this script.")
    end
end)

local gamesSection = tab1:Section("Supported Games (if it doesn't load, try running it again)")

local function createGameButton(placeName, placeId, scriptUrl)
    gamesSection:Button(placeName, "Load script for " .. placeName, function()
        if game.PlaceId == placeId then
            loadstring(game:HttpGet(scriptUrl, true))()
        else
            Hawk:AddNotifications():Notification("Error", "Wrong game!", "Error", 3)
            game.Players.LocalPlayer:Kick("Wrong game! Please join the correct game to use this script.")
        end
        Window:Destroy()
    end)
end

-- Create buttons for each game
createGameButton("💎 Pet Mine!", 18853192637, "https://raw.githubusercontent.com/jkancc111/Games-V2/main/PetMine.txt")

createGameButton("[2x🍀]Anime Slashing Simulator", 18956736354, "https://raw.githubusercontent.com/jkancc111/Games-V2/main/AnimeSlashSim.txt")

createGameButton("[UPD🦑] Car Training🚗", 111130915266245, "https://raw.githubusercontent.com/jkancc111/Games-V2/main/CarTraining.txt")

createGameButton("[🎉RELEASE] Pet Star Simulator! 🐾", 86430667919924, "https://raw.githubusercontent.com/jkancc111/Games-V2/main/StarPetSimulator.lua")

createGameButton("Granny: Multiplayer", 4480809144, "https://raw.githubusercontent.com/jkancc111/Games-V2/main/GrannyMultiplayer.txt")

createGameButton("Supermarket Simulator", 96462622512177, "https://raw.githubusercontent.com/jkancc111/Games-V2/main/SupermarketSimulator.txt")
createGameButton("🗝️Lootify[🌍UPD]", 16498193900, "https://raw.githubusercontent.com/jkancc111/Games-V2/refs/heads/main/Lootify.txt")
createGameButton("[🎅Event] ⚔️Dungeon RNG", 17534163435, "https://raw.githubusercontent.com/jkancc111/Games-V2/main/DungeonRNG.txt")
