
local function runAppropriateScript()
    local gameId = game.PlaceId
    
    local scripts = {
        [18901165922] = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/PetsGo.txt",
        [16732694052] = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/Fisch.txt",
        [18853192637] = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/PetMine.txt",
        [18956736354] = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/AnimeSlashSim.txt",
        [111130915266245] = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/CarTraining.txt", 
        [86430667919924] = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/StarPetSimulator.lua",
        [4480809144] = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/GrannyMultiplayer.txt",
        [96462622512177] = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/SupermarketSimulator.txt", 
        [16498193900] = "https://raw.githubusercontent.com/jkancc111/Games-V2/refs/heads/main/Lootify.txt",
        [17534163435] = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/DungeonRNG.txt",
        [87039211657390] = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/AriseCrossover.txt", -- Arise Crossover}
    }
    local gameGroups = {
        ["Blox Fruits"] = {
            ids = {2753915549, 4442272183, 7449423635}, -- First, Second, Third Sea
            url = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/BloxFruit.txt"
        },
        ["Dead Rails"] = {
            ids = {116495829188952, 70876832253163}, -- Map 1, Map 2
            url = "https://raw.githubusercontent.com/jkancc111/Games-V2/main/DeadRails.txt"
        }
    }
    
    if scripts[gameId] then
        loadstring(game:HttpGet(scripts[gameId], true))()
        return true
    end
    
    for groupName, groupData in pairs(gameGroups) do
        for _, id in pairs(groupData.ids) do
            if gameId == id then
                loadstring(game:HttpGet(groupData.url, true))()
                return true
            end
        end
    end
    
    return false
end

local success, err = pcall(runAppropriateScript)
if not success then
    warn("Error while running script: " .. tostring(err))
end
