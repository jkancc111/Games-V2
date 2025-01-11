local KeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/jkancc111/Modules/refs/heads/main/dawdaw.lua"))()

local function checkKeyStatus()
    if KeySystem.Success090 or (getgenv().KeySystemResult and getgenv().KeySystemResult.Success090) then
    print('Running')   

    repeat task.wait(0.25) until game:IsLoaded();
    getgenv().Image = "rbxassetid://131242153792023";
    getgenv().ToggleUI = Enum.KeyCode.RightAlt 
    
    local Fluent = nil
    local Window = nil
    
    task.spawn(function()
        
        local existingUI = game:GetService("CoreGui"):FindFirstChild("OpenUI")
        if existingUI then
            existingUI:Destroy()
        end

        
        local OpenUI = Instance.new("ScreenGui")
        local ImageButton = Instance.new("ImageButton")
        local UICorner = Instance.new("UICorner")
        OpenUI.Name = "OpenUI"
        OpenUI.Parent = game:GetService("CoreGui")
        OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ImageButton.Parent = OpenUI
        ImageButton.BackgroundColor3 = Color3.fromRGB(105,105,105)
        ImageButton.BackgroundTransparency = 0.8
        ImageButton.Position = UDim2.new(0.9,0,0.1,0)
        ImageButton.Size = UDim2.new(0,50,0,50)
        ImageButton.Image = getgenv().Image
        ImageButton.Draggable = true
        ImageButton.Transparency = 0.5
        UICorner.CornerRadius = UDim.new(0,200)
        UICorner.Parent = ImageButton

        local function ToggleUI()
            if Window then
                Window:Minimize()
            end
        end
        
        ImageButton.MouseButton1Click:Connect(ToggleUI)
        
        game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == getgenv().ToggleUI then
                ToggleUI()
            end
        end)
    end)
    
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
    
    Window = Fluent:CreateWindow({
        Title = "Lomu Hub | OP Star Pet Simulator",
        SubTitle = "by Lomu",
        TabWidth = 160,
        Size = UDim2.fromOffset(530, 350),
        Acrylic = true,
        Theme = "Darker",
        MinimizeKey = getgenv().ToggleUI
    })
    
    local Tabs = {
        Main = Window:AddTab({ Title = "Main", Icon = "command" }),
        Egg = Window:AddTab({ Title = "Egg", Icon = "egg" }),
        Upgrade = Window:AddTab({ Title = "Upgrade", Icon = "arrow-up" }),
        Potion = Window:AddTab({ Title = "Potion", Icon = "glass-water" }),
        Other = Window:AddTab({ Title = "Other", Icon = "plus-circle" }),
        Credits = Window:AddTab({ Title = "Credits", Icon = "contact" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    }
    
    local Options = Fluent.Options
    
    local starLocations = {}
    if workspace:FindFirstChild("LocalStars") then
        for _, folder in pairs(workspace.LocalStars:GetChildren()) do
            if folder:IsA("Folder") then
                table.insert(starLocations, folder.Name)
            end
        end
    end

    local SelectedStarLocation = nil
    local StarLocationDropdown = Tabs.Main:AddDropdown("StarLocation", {
        Title = "Select Star Location",
        Values = starLocations,
        Default = "",
        Multi = false,
        Callback = function(Value)
            SelectedStarLocation = Value
        end
    })

    
    local TeleportLocations = {
        ["Spawn"          ] = CFrame.new(9.64403915 , 2.5790596 , -423.978149 , 1, 0, 0, 0, 1, 0, 0, 0, 1),
        ["Autumn Forest"  ] = CFrame.new(9.60408688 , 1.57901764, -743.977112 , 1, 0, 0, 0, 1, 0, 0, 0, 1),
        ["Flower Garden"  ] = CFrame.new(8.64550877 , 1.57901764, -939.227051 , 1, 0, 0, 0, 1, 0, 0, 0, 1),
        ["Snow Forest"    ] = CFrame.new(10.6454582 , 1.59208679, -1135.5271  , 1, 0, 0, 0, 1, 0, 0, 0, 1),
        ["Tropical Palms" ] = CFrame.new(9.3041153  , 1.58544922, -1329.05469 , 1, 0, 0, 0, 1, 0, 0, 0, 1),
        ["Mine Shaft"     ] = CFrame.new(9.7040987  , 1.57901764, -1522.69592 , 1, 0, 0, 0, 1, 0, 0, 0, 1),
        ["Diamond Mine"   ] = CFrame.new(10.5040979 , 1.57901764, -1717.27698 , 1, 0, 0, 0, 1, 0, 0, 0, 1),
        ["Magical Forest" ] = CFrame.new(10.3040867 , 1.57901764, -1914.77075 , 1, 0, 0, 0, 1, 0, 0, 0, 1),
        ["Sakura Forest"  ] = CFrame.new(9.80411434 , 1.57901764, -2110.67725 , 1, 0, 0, 0, 1, 0, 0, 0, 1)
    }

    local AutoCollectStarsToggle = Tabs.Main:AddToggle("AutoCollectStars", {
        Title = "Auto Collect Stars (FAST)",
        Description = "",
        Default = false,
        Callback = function(Value)
            getgenv().AutoCollectStars = Value
            if Value then
                task.spawn(function()
                    -- Connect to Heartbeat
                    local connection = game:GetService("RunService").Heartbeat:Connect(function()
                        pcall(function()
                            if workspace:FindFirstChild("LocalStars") and SelectedStarLocation then
                                local locationFolder = workspace.LocalStars:FindFirstChild(SelectedStarLocation)
                                if locationFolder then
                                    -- Collect stars in this location
                                    for _, model in pairs(locationFolder:GetChildren()) do
                                        if model:IsA("Model") and getgenv().AutoCollectStars then
                                            if not model:GetAttribute("CollectedOnClient") then
                                                game:GetService("ReplicatedStorage").Core.Remote.collectStar:FireServer(
                                                    SelectedStarLocation,
                                                    model.Name
                                                )
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end)
                    
                    -- Wait until toggle is turned off
                    while getgenv().AutoCollectStars do
                        task.wait()
                    end
                    
                    -- Disconnect heartbeat when toggle is off
                    if connection then
                        connection:Disconnect()
                    end
                end)
            end
        end
    })
    
    local RefreshStarLocations = Tabs.Main:AddButton({
        Title = "Refresh Star Locations",
        Callback = function()
            starLocations = {}
            if workspace:FindFirstChild("LocalStars") then
                for _, folder in pairs(workspace.LocalStars:GetChildren()) do
                    if folder:IsA("Folder") then
                        table.insert(starLocations, folder.Name)
                    end
                end
            end
            StarLocationDropdown:SetValues(starLocations)
        end
    })
    
    local AutoCollectToggle = Tabs.Main:AddToggle("AutoCollectToggle", {
        Title = "Auto Collect Hidden Rewards",
        Default = false,
        Callback = function(Value)
            getgenv().AutoCollect = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoCollect do
                        pcall(function()
                            if workspace:FindFirstChild("CollectRewards") then
                                for _, model in pairs(workspace.CollectRewards:GetChildren()) do
                                    if model:IsA("Model") and getgenv().AutoCollect then
                                        local sphere = model:FindFirstChild("Meshes/Cave_Sphere")
                                        if sphere then
                                            local prompt = sphere:FindFirstChild("ProximityPrompt")
                                            if prompt then
                                                -- Teleport to the reward
                                                local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                                if humanoidRootPart then
                                                    humanoidRootPart.CFrame = sphere.CFrame
                                                    task.wait(0.1) -- Small delay before firing prompt
                                                    fireproximityprompt(prompt)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end
    })

    local AutoQuestToggle = Tabs.Main:AddToggle("AutoQuest", {
        Title = "Auto Collect All Quests",
        Default = false,
        Callback = function(Value)
            getgenv().AutoQuest = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoQuest do
                        pcall(function()
                            local player = game:GetService("Players").LocalPlayer
                            local dailyQuests = player.Data.Daily_Quests
                            local weeklyQuests = player.Data.Weekly_Quests
                            
                            -- Collect daily quests
                            for _, quest in ipairs(dailyQuests:GetChildren()) do
                                if quest:IsA("NumberValue") then
                                    game:GetService("ReplicatedStorage").Core.Remote.finishQuest:InvokeServer(quest.Name)
                                end
                            end
                            
                            -- Collect weekly quests  
                            for _, quest in ipairs(weeklyQuests:GetChildren()) do
                                if quest:IsA("NumberValue") then
                                    game:GetService("ReplicatedStorage").Core.Remote.finishQuest:InvokeServer(quest.Name)
                                end
                            end
                        end)
                        task.wait(1)
                    end
                end)
            end
        end
    })

    local AutoBuyZoneToggle = Tabs.Main:AddToggle("AutoBuyZone", {
        Title = "Auto Buy Zone",
        Default = false,
        Callback = function(Value)
            getgenv().AutoBuyZone = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoBuyZone do
                        pcall(function()
                            for _, gate in pairs(workspace.Gates:GetChildren()) do
                                if gate:IsA("Model") then
                                    game:GetService("ReplicatedStorage").Core.Remote.buyLocation:InvokeServer(gate.Name)
                                end
                            end
                        end)
                        task.wait(1)
                    end
                end)
            end
        end
    })

    local AutoClaimLevelRoadToggle = Tabs.Main:AddToggle("AutoClaimLevelRoad", {
        Title = "Auto Claim Level Road",
        Default = false,
        Callback = function(Value)
            getgenv().AutoClaimLevelRoad = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoClaimLevelRoad do
                        pcall(function()
                            game:GetService("ReplicatedStorage").Core.Remote.claimLevelRoad:InvokeServer()
                        end)
                        task.wait(1)
                    end
                end)
            end
        end
    })
    

    local function GetEggList()
        local eggs = {}
        if workspace:FindFirstChild("EggModels") then
            for _, model in pairs(workspace.EggModels:GetChildren()) do
                if model:IsA("Model") then
                    table.insert(eggs, model.Name)
                end
            end
        end
        return eggs
    end

    local SelectedEgg = nil
    local EggDropdown = Tabs.Egg:AddDropdown("EggSelect", {
        Title = "Select Egg",
        Description = "Must near the egg to hatch",
        Values = GetEggList(),
        Default = "",
        Callback = function(Value)
            SelectedEgg = Value
        end
    })

    local AutoSingleHatchToggle = Tabs.Egg:AddToggle("AutoSingleHatch", {
        Title = "Auto Single Hatch",
        Default = false,
        Callback = function(Value)
            getgenv().AutoSingleHatch = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoSingleHatch do
                        pcall(function()
                            if SelectedEgg then
                                game:GetService("ReplicatedStorage").PetSystem.Remote.Hatch:InvokeServer(SelectedEgg, "Open")
                            end
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end
    })

    local AutoTripleHatchToggle = Tabs.Egg:AddToggle("AutoTripleHatch", {
        Title = "Auto Triple Hatch",
        Default = false,
        Callback = function(Value)
            getgenv().AutoTripleHatch = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoTripleHatch do
                        pcall(function()
                            if SelectedEgg then
                                game:GetService("ReplicatedStorage").PetSystem.Remote.Hatch:InvokeServer(SelectedEgg, "Open x3")
                            end
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end
    })



    local AutoAllHatchToggle = Tabs.Egg:AddToggle("AutoAllHatch", {
        Title = "Auto Hatch All",
        Default = false,
        Callback = function(Value)
            getgenv().AutoAllHatch = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoAllHatch do
                        pcall(function()
                            if SelectedEgg then
                                game:GetService("ReplicatedStorage").PetSystem.Remote.Hatch:InvokeServer(SelectedEgg, "Open All")
                            end
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end
    })

    local RefreshEggs = Tabs.Egg:AddButton({
        Title = "Refresh Egg List",
        Callback = function()
            local newEggs = GetEggList()
            EggDropdown:SetValues(newEggs)
        end
    })

    local PetsManagement = Tabs.Egg:AddSection("Pets Management")

    local AutoEquipBestCooldownInput = PetsManagement:AddInput("AutoEquipBestCooldown", {
        Title = "CD Auto Equip Best",
        Default = "1",
        Placeholder = "Enter cooldown in seconds",
        Numeric = true,
        Callback = function(Value)
            getgenv().AutoEquipBestCooldown = tonumber(Value) or 1
        end
    })

    local AutoEquipBestToggle = PetsManagement:AddToggle("AutoEquipBest", {
        Title = "Auto Equip Best Pets",
        Default = false,
        Callback = function(Value)
            getgenv().AutoEquipBest = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoEquipBest do
                        pcall(function()
                            game:GetService("ReplicatedStorage").PetSystem.Remote.EquipPet:InvokeServer("*all", true)
                        end)
                        task.wait(getgenv().AutoEquipBestCooldown or 5)
                    end
                end)
            end
        end
    })

    local AutoDeleteUnequippedCooldownInput = PetsManagement:AddInput("AutoDeleteUnequippedCooldown", {
        Title = "CD Auto Delete Unequipped", 
        Default = "5",
        Placeholder = "Enter cooldown in seconds",
        Numeric = true,
        Callback = function(Value)
            getgenv().AutoDeleteUnequippedCooldown = tonumber(Value) or 5
        end
    })

    local AutoDeleteUnequippedToggle = PetsManagement:AddToggle("AutoDeleteUnequipped", {
        Title = "Auto Delete Unequipped Pets",
        Default = false,
        Callback = function(Value)
            getgenv().AutoDeleteUnequipped = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoDeleteUnequipped do
                        pcall(function()
                            local playerPets = game:GetService("Players").LocalPlayer.Data.Pets
                            local petsToDelete = {}
                            
                            -- Collect unequipped pets
                            for _, pet in pairs(playerPets:GetChildren()) do
                                if pet:IsA("Folder") then
                                    local equipped = pet:FindFirstChild("Equipped")
                                    if equipped and equipped:IsA("BoolValue") and equipped.Value == false then
                                        table.insert(petsToDelete, pet.Name)
                                    end
                                end
                            end
                            
                            -- Delete collected pets
                            if #petsToDelete > 0 then
                                game:GetService("ReplicatedStorage").PetSystem.Remote.DeletePet:InvokeServer(petsToDelete)
                            end
                        end)
                        task.wait(getgenv().AutoDeleteUnequippedCooldown or 1)
                    end
                end)
            end
        end
    })

    local function GetAvailableUpgrades()
        local upgrades = {}
        local playerUpgrades = game:GetService("Players").LocalPlayer.Data.Upgrades
        
        for _, upgrade in pairs(playerUpgrades:GetChildren()) do
            if upgrade:IsA("NumberValue") then
                table.insert(upgrades, upgrade.Name)
            end
        end
        
        return upgrades
    end

    local SelectedUpgrades = {}
    local UpgradeDropdown = Tabs.Upgrade:AddDropdown("UpgradeSelect", {
        Title = "Select Upgrades",
        Values = GetAvailableUpgrades(),
        Multi = true,
        Default = {},
        Callback = function(Value)
            SelectedUpgrades = Value
        end
    })

    local RefreshUpgrades = Tabs.Upgrade:AddButton({
        Title = "Refresh Upgrade List",
        Callback = function()
            local newUpgrades = GetAvailableUpgrades()
            UpgradeDropdown:SetValues(newUpgrades)
        end
    })

    local AutoUpgradeToggle = Tabs.Upgrade:AddToggle("AutoUpgrade", {
        Title = "Auto Buy Selected Upgrades",
        Default = false,
        Callback = function(Value)
            getgenv().AutoUpgrade = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoUpgrade do
                        pcall(function()
                            for upgradeName, isSelected in pairs(SelectedUpgrades) do
                                if isSelected then
                                    game:GetService("ReplicatedStorage").Core.Remote.buyUpgrade:InvokeServer(upgradeName)
                                end
                            end
                        end)
                        task.wait(1)
                    end
                end)
            end
        end
    })

    local GoldRainbowManagement = Tabs.Upgrade:AddSection("Pets Crafting")

    local AutoCraftGoldToggle = GoldRainbowManagement:AddToggle("AutoCraftGold", {
        Title = "Auto Craft Gold Pets (100%)",
        Description = "Only works for unequipped pets",
        Default = false,
        Callback = function(Value)
            getgenv().AutoCraftGold = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoCraftGold do
                        pcall(function()
                            local playerPets = game:GetService("Players").LocalPlayer.Data.Pets
                            local petsById = {}
                            
                            -- Group pets by their exact ID value
                            for _, pet in pairs(playerPets:GetChildren()) do
                                if pet:IsA("Folder") then
                                    local idValue = pet:FindFirstChild("ID")
                                    local equipped = pet:FindFirstChild("Equipped")
                                    -- Only include unequipped pets
                                    if equipped and equipped:IsA("BoolValue") and equipped.Value == false and 
                                       pet:FindFirstChild("Tier") and pet:FindFirstChild("Tier").Value == 0 then
                                        -- Get full ID value
                                        if idValue and idValue.Value then
                                            local fullId = idValue.Value
                                            if not petsById[fullId] then
                                                petsById[fullId] = {}
                                            end
                                            table.insert(petsById[fullId], pet.Name)
                                        end
                                    end
                                end
                            end
                            
                            -- Find groups of 4 identical pets (same ID)
                            for petId, petGroup in pairs(petsById) do
                                if #petGroup >= 4 then
                                    -- Create the table with first 4 pets
                                    local craftTable = {
                                        [1] = petGroup[1],
                                        [2] = petGroup[2],
                                        [3] = petGroup[3],
                                        [4] = petGroup[4]
                                    }
                                    -- Craft gold pet with these 4 pets
                                    game:GetService("ReplicatedStorage").PetSystem.Remote.CraftPets:InvokeServer(craftTable)
                                end
                            end
                        end)
                        task.wait(1)
                    end
                end)
            end
        end
    })

    local AutoCraftRainbowToggle = GoldRainbowManagement:AddToggle("AutoCraftRainbow", {
        Title = "Auto Craft Rainbow Pets (100%)",
        Description = "Only works for unequipped gold pets",
        Default = false,
        Callback = function(Value)
            getgenv().AutoCraftRainbow = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoCraftRainbow do
                        pcall(function()
                            local playerPets = game:GetService("Players").LocalPlayer.Data.Pets
                            local goldPetsByName = {}
                            
                            -- Group gold pets by their actual name
                            for _, pet in pairs(playerPets:GetChildren()) do
                                if pet:IsA("Folder") then
                                    local idValue = pet:FindFirstChild("ID")
                                    local equipped = pet:FindFirstChild("Equipped")
                                    local tier = pet:FindFirstChild("Tier")
                                    
                                    -- Only include unequipped gold pets (Tier.Value == 1)
                                    if equipped and equipped.Value == false and tier and tier.Value == 1 then
                                        local petName = idValue and idValue.Value:match("^([^%s]+)")
                                        if petName then
                                            if not goldPetsByName[petName] then
                                                goldPetsByName[petName] = {}
                                            end
                                            table.insert(goldPetsByName[petName], pet.Name)
                                        end
                                    end
                                end
                            end
                            
                            -- Find groups of 6 or more gold pets
                            for petName, petGroup in pairs(goldPetsByName) do
                                if #petGroup >= 6 then
                                    -- Create the table with first 6 pets
                                    local craftTable = {
                                        [1] = petGroup[1],
                                        [2] = petGroup[2],
                                        [3] = petGroup[3],
                                        [4] = petGroup[4],
                                        [5] = petGroup[5],
                                        [6] = petGroup[6]
                                    }
                                    -- Craft rainbow pet with these 6 gold pets
                                    game:GetService("ReplicatedStorage").PetSystem.Remote.CraftPets:InvokeServer(craftTable)
                                end
                            end
                        end)
                        task.wait(1)
                    end
                end)
            end
        end
    })

    -- Function to get equipped pet list
    local function GetEquippedPets()
        local petList = {}
        local playerPets = game:GetService("Players").LocalPlayer.Data.Pets
        
        for _, pet in pairs(playerPets:GetChildren()) do
            if pet:IsA("Folder") then
                local equipped = pet:FindFirstChild("Equipped")
                -- Only include equipped pets
                if equipped and equipped.Value == true then
                    table.insert(petList, pet.Name)
                end
            end
        end
        
        return petList
    end

    local SelectedPet = nil
    local EnchantSection = Tabs.Upgrade:AddSection("Pet Enchanting")

    -- List of all possible enchants
    local EnchantList = {
        "Star Struck I",
        "Star Struck II",
        "Star Struck III",
        "Star Struck IV",
        "Gems I",
        "Gems II",
        "Gems III",
        "Gems IV",
        "Luck I",
        "Luck II",
        "Luck III",
        "Luck IV",
        "Bond I",
        "Bond II",
        "Bond III",
        "Bond IV"
    }

    local SelectedEnchant = nil
    local EnchantDropdown = EnchantSection:AddDropdown("EnchantSelect", {
        Title = "Select Desired Enchant",
        Values = EnchantList,
        Multi = false,
        Default = "",
        Callback = function(Value)
            SelectedEnchant = Value
        end
    })

    -- Keep track of pets that already have desired enchants
    local completedPets = {}

    -- Function to send webhook with embeds and debug print
    local function SendWebhook(content, isEnchantNotify)
        print("Attempting to send webhook:", content, "isEnchantNotify:", isEnchantNotify) -- Debug print
        
        if WebhookURL ~= "" and getgenv().WebhookEnabled then
            if isEnchantNotify and not getgenv().EnchantNotifyEnabled then
                print("Enchant notify is disabled") -- Debug print
                return
            end
            
            pcall(function()
                print("Sending webhook...") -- Debug print
                local message = DiscordUserID ~= "" and string.format("<@%s>", DiscordUserID) or ""
                
                request({
                    Url = WebhookURL,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game:GetService("HttpService"):JSONEncode({
                        content = message,
                        embeds = {
                            {
                                title = isEnchantNotify and "Pet Enchant Success!" or "Star Pet Simulator Notification",
                                description = content,
                                color = isEnchantNotify and 0xFFD700 or 0x2B6BE4,
                                fields = {
                                    {
                                        name = "Player",
                                        value = game:GetService("Players").LocalPlayer.Name,
                                        inline = true
                                    },
                                    {
                                        name = "Time",
                                        value = string.format("<t:%d:R>", os.time()),
                                        inline = true
                                    }
                                },
                                footer = {
                                    text = "Star Pet Simulator • Lomu Hub"
                                },
                                timestamp = string.format("%sZ", os.date("!%Y-%m-%dT%H:%M:%S"))
                            }
                        }
                    })
                })
                print("Webhook sent successfully") -- Debug print
            end)
        else
            print("Webhook URL empty or webhook disabled") -- Debug print
        end
    end

    -- Modify existing enchant toggle with improved notification handling
    local AutoEnchantEquippedToggle = EnchantSection:AddToggle("AutoEnchantEquipped", {
        Title = "Auto Enchant Until Selected",
        Description = "Keeps enchanting equipped pets until getting desired enchant",
        Default = false,
        Callback = function(Value)
            getgenv().AutoEnchantEquipped = Value
            if Value then
                completedPets = {}
            end
            
            if Value then
                task.spawn(function()
                    while getgenv().AutoEnchantEquipped do
                        pcall(function()
                            local playerPets = game:GetService("Players").LocalPlayer.Data.Pets
                            
                            for _, pet in pairs(playerPets:GetChildren()) do
                                if pet:IsA("Folder") then
                                    local equipped = pet:FindFirstChild("Equipped")
                                    local enchant = pet:FindFirstChild("Enchant")
                                    
                                    if equipped and equipped.Value == true and not completedPets[pet.Name] then
                                        local currentEnchant = enchant and enchant.Value or ""
                                        
                                        if currentEnchant == SelectedEnchant then
                                            completedPets[pet.Name] = true
                                        else
                                            game:GetService("ReplicatedStorage").PetSystem.Remote.EnchantPet:InvokeServer(pet.Name)
                                            task.wait(0.1)
                                        end
                                    end
                                end
                            end
                        end)
                        task.wait(1)
                    end
                end)
            end
        end
    })

    local function GetAvailablePotions()
        local potions = {}
        local playerPotions = game:GetService("Players").LocalPlayer.Data.Potions
        
        for _, potion in pairs(playerPotions:GetChildren()) do
            if potion:IsA("NumberValue") and potion.Value > 0 then
                table.insert(potions, potion.Name)
            end
        end
        
        return potions
    end

    local SelectedPotions = {}

    local PotionDropdown = Tabs.Potion:AddDropdown("PotionSelect", {
        Title = "Multi Select Potions",
        Values = GetAvailablePotions(),
        Multi = true,
        Default = {},
        Callback = function(Value)
            SelectedPotions = Value
        end
    })

    local RefreshPotions = Tabs.Potion:AddButton({
        Title = "Refresh Potion List",
        Callback = function()
            local newPotions = GetAvailablePotions()
            PotionDropdown:SetValues(newPotions)
        end
    })

    local AutoUsePotionsToggle = Tabs.Potion:AddToggle("AutoUsePotions", {
        Title = "Auto Use Selected Potions",
        Default = false,
        Callback = function(Value)
            getgenv().AutoUsePotions = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoUsePotions do
                        pcall(function()
                            for potionName, isSelected in pairs(SelectedPotions) do
                                if isSelected then
                                    local potionValue = game:GetService("Players").LocalPlayer.Data.Potions:FindFirstChild(potionName)
                                    if potionValue and potionValue.Value > 0 then
                                        game:GetService("ReplicatedStorage").Core.Remote.usePotion:InvokeServer(potionName)
                                    end
                                end
                            end
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end
    })

    local SelectedLocation = nil

    local TeleportDropdown = Tabs.Other:AddDropdown("TeleportSelect", {
        Title = "Select Location",
        Values = {"Spawn", "Autumn Forest", "Flower Garden", "Snow Forest", "Tropical Palms", "Mine Shaft", "Diamond Mine", "Magical Forest", "Sakura Forest"},
        Multi = false,
        Default = "",
        Callback = function(Value)
            SelectedLocation = Value
        end
    })

    local TeleportButton = Tabs.Other:AddButton({
        Title = "Teleport to Selected Location",
        Callback = function()
            if SelectedLocation and TeleportLocations[SelectedLocation] then
                local player = game:GetService("Players").LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = TeleportLocations[SelectedLocation]
                end
            end
        end
    })

    local AutoClaimRewardsToggle = Tabs.Other:AddToggle("AutoClaimRewards", {
        Title = "Auto Claim Rewards",
        Default = false,
        Callback = function(Value)
            getgenv().AutoClaimRewards = Value
            if Value then
                task.spawn(function()
                    while getgenv().AutoClaimRewards do
                        pcall(function()
                            for i = 1, 16 do
                                game:GetService("ReplicatedStorage").Core.Remote.claimGift:InvokeServer(i)
                            end
                        end)
                        task.wait(1)
                    end
                end)
            end
        end
    })

    local CustomChatTagToggle = Tabs.Other:AddInput("CustomChatTag", {
        Title = "Custom Chat Tag",
        Default = "ADMIN",
        Placeholder = "Enter chat tag...",
        Callback = function(Value)
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local chatTag = player.Data.CustomChatTag
                if chatTag then
                    chatTag.Value = Value
                end
            end)
        end
    })

    local FreeGamepassesToggle = Tabs.Other:AddToggle("FreeGamepasses", {
        Title = "Free Gamepasses",
        Default = false,
        Callback = function(Value)
            getgenv().FreeGamepasses = Value
            if Value then
                task.spawn(function()
                    while getgenv().FreeGamepasses do
                        pcall(function()
                            local player = game:GetService("Players").LocalPlayer
                            local gamepassFolder = player.Data.Gamepasses
                            
                            -- List of gamepass IDs to enable
                            local gamepasses = {
                                "STARTER_PACK",
                                "VIP", 
                                "GEMS_X2",
                                "SECRET_HUNTER",
                                "HUGE_HUNTER", 
                                "MAGIC_EGGS",
                                "LUCKY_EGGS",
                                "ULTRA_LUCKY_EGGS",
                                "FAST_HATCH",
                                "EGG_HATCHES_3",
                                "PET_EQUIPS_2",
                                "PET_EQUIPS_1",
                                "INV_SLOTS_100",
                                "AUTO_L10",
                                "ENCHANTED_EGGS"
                            }
                            
                            -- Enable each gamepass
                            for _, gamepassName in pairs(gamepasses) do
                                local gamepass = gamepassFolder:FindFirstChild(gamepassName)
                                if not gamepass then
                                    gamepass = Instance.new("BoolValue")
                                    gamepass.Name = gamepassName
                                    gamepass.Parent = gamepassFolder
                                end
                                gamepass.Value = true
                            end
                        end)
                        task.wait(1)
                    end
                end)
            end
        end
    })

    Tabs.Other:AddParagraph({
        Title = "Free Gamepasses Info",
        Content = "Some gamepasses may work, while others may not function properly"
    })

    Tabs.Credits:AddParagraph({
        Title = "Script by Lomu",
        Content = "Credits to the original author of the script"
    })

    
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("LomuHub")
    SaveManager:SetFolder("LomuHub/configs")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)
    Window:SelectTab(1)
    SaveManager:LoadAutoloadConfig()

    else
        wait(1.5)
        checkKeyStatus()
    end
end

checkKeyStatus()