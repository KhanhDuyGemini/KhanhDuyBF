-- // ⚙️ Cấu hình
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

local scriptName = tostring(getgenv().NScript or "Unknown")
local inputKey = tostring(getgenv().Key or "")

-- // 🌐 API Supabase Function
local SUPABASE_URL = "https://qoagwkvvhxzjcztxokcq.supabase.co/functions/v1/verify-key"
local SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFvYWd3a3Z2aHh6amN6dHhva2NxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQyNTQ4NjIsImV4cCI6MjA3OTgzMDg2Mn0.iN0eAzzLRySDe7rFckR-PUnh1PhQJNF7VymyShkxYlk"

-- // Kiểm tra key trống
if inputKey == "" then
    warn("[KEY] ❌ Key không được cung cấp.")
    return
end

-------------------------------------------------------
-- 📌 Gửi request verify key
-------------------------------------------------------
local success, response = pcall(function()
    return game:HttpPost(
        SUPABASE_URL .. "?key=" .. inputKey,
        "",
        Enum.HttpContentType.ApplicationJson,
        false,
        {
            ["Authorization"] = "Bearer " .. SUPABASE_ANON_KEY,
            ["apikey"] = SUPABASE_ANON_KEY,
            ["Content-Type"] = "application/json"
        }
    )
end)

if not success then
    warn("[KEY] ❌ Không thể kết nối API.")
    print("LỖI:", response)
    return
end

-------------------------------------------------------
-- 📌 Giải mã JSON
-------------------------------------------------------
local data
local ok, jsonErr = pcall(function()
    data = HttpService:JSONDecode(response)
end)

if not ok then
    warn("[KEY] ❌ JSON lỗi:", jsonErr)
    print("RAW RESPONSE:", response)
    return
end

-------------------------------------------------------
-- 📌 Xử lý kết quả verify
-------------------------------------------------------
if not data.success then
    warn("[KEY] ❌ Key sai hoặc không tồn tại.")
    print("MESSAGE:", data.message or "Unknown")
    return
end

-------------------------------------------------------
-- 🎉 Key hợp lệ
-------------------------------------------------------
print("[KEY] ✅ Key hợp lệ! Discord ID:", data.discord_id or "Unknown")
print("[KEY] 🚀 Đang tải script:", scriptName)

-- // 🚀 Chạy script tương ứng
if scriptName == "MaruHub" then
    getgenv().NScript = "MaruHub"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "KaitunMaruDefault" then
    getgenv().NScript = "MaruHub"
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "MaruKaitunFisch" then
    getgenv().NScript = "MaruHub"
    local Second_Sea = game.PlaceId == 72907489978215
    local Second_Sea_Loc = CFrame.new(1532.36096, 83.9225464, 2335.48999, -0.407974303, 3.71246642e-08, 0.912993431,
        5.38818279e-09, 1, -3.825485e-08, -0.912993431, -1.06876197e-08, -0.407974303)
    local First_Sea_Loc = CFrame.new(-13887.3965, -11048.6885, 350.285706, 0.948456287, 1.08180259e-07, 0.316907942,
        -1.06977055e-07, 1, -2.11960565e-08, -0.316907942, -1.37983438e-08, 0.948456287)

    _G.Settings = _G.Settings or {
        ["DefaultPosition"] = (Second_Sea and Second_Sea_Loc) or First_Sea_Loc,
        ["AfkCheckTime"] = 30, -- Seconds
        ["AfkFix"] = "Reset", -- Rejoin, Reset
        ["EquipRod"] = "Auto", -- Trident Rod, Destiny Rod,... Rod
        ["InstantFishing"] = true,
        ["Return to Sea1"] = {
            ["Obtained All Rods"] = true
        },
        ["SellFish"] = {
            ["SellDelay"] = 120, -- Seconds
            ["Enable"] = true,
            ["Method"] = {
                ["Event"] = true,
                ["Enchant"] = false,
                ["Mythical"] = true,
                ["Legendary"] = true,
                ["Exotic"] = true -- recommend to enable it
            }
        },
        ['Rod'] = {
            -- Necessary Rods: Rods that are required or essential for the gameplay
            Necessary_Rods = {"Steady Rod", -- First Sea Rod
            "Reinforced Rod", "Depthseeker Rod", "Kraken Rod", "Zeus Rod", "Ethereal Prism Rod", "Free Spirit Rod"},

            -- Custom Rods: Special rods that can be customized after obtained all necessary rods.
            Custom_Rods = {"Aurora Rod", "Tempest Rod", "Abyssal Specter Rod", "Destiny Rod", "Challenger's Rod",
                           "Rod Of The Zenith", "Challenger's Rod", "Nocturnal Rod", "Kings Rod", "Trident Rod",
                           "Poseidon Rod", "Champions Rod", "Volcanic Rod", "Summit Rod", "Training Rod", "Plastic Rod",
                           "Carbon Rod", "Long Rod", "Lucky Rod", "Fortune Rod", "Rapid Rod", "Magnet Rod",
                           "Mythical Rod", "Midas Rod", "Scurvy Rod", "Stone Rod", "Phoenix Rod", "Arctic Rod",
                           "Crystalized Rod", "Ice Warpers Rod", "Avalanche Rod", "Stone Rod", "Wildflower Rod",
                           "Firefly Rod", "Frog Rod", "Azure Of Lagoon", "Free Spirit Rod", -- need bestinary 70%
            "Verdant Shear Rod", "Great Dreamer Rod"},

            -- Puzzle Rods: Rods that will be available in the future (currently unavailable)
            Puzzle_Rods = {
                -- ["Heaven's Rod"] = 400, -- ( name, required level )
            }
        },
        ["Enchant"] = {
            ["Enabled"] = true, -- Enable or disable the enchantment system
            ["Rod"] = { -- Specific enchantments for each rod
                ["Depthseeker Rod"] = {
                    LevelFarm = {"Clever"}
                },
                ["Zeus Rod"] = {
                    LevelFarm = {"Clever"}
                },
                ["Kraken Rod"] = {
                    LevelFarm = {"Clever"}
                },
                ["Ethereal Prism Rod"] = {
                    LevelFarm = {"Hasty"},
                    CashFarm = {"Abyssal"}
                },
                ["Free Spirit Rod"] = {
                    LevelFarm = {"Clever"}
                }
            }
        },
        ["Totems"] = {
            ["Enabled"] = true, -- Enable or disable the totem system
            ["ActivationLevel"] = 300, -- Level required to activate totems

            ["DayTotem"] = "Sundial Totem", -- Totem used during the day
            ["NightTotem"] = "Aurora Totem", -- Totem used during the night

            ["AutoPurchase"] = true, -- Enable automatic totem purchasing
            ["PurchaseLimit"] = { -- Maximum allowed purchases per type
                ["DayTotem"] = 1,
                ["NightTotem"] = 1
            }
        },
        ['EnabledFishingZones'] = true,
        ["CastZone"] = {
            ['OnLevel'] = 300,
            ['Ignored_Aurora'] = true, -- skip farming level when aurora is active
            ['Zones'] = {"Forsaken Veil - Scylla", "Lovestorm Eel", "Orcas Pool", "The Kraken Pool",
                         "Megalodon Default", "The Depths - Serpent", "Great White Shark", "Great Hammerhead Shark",
                         "Whale Shark", "Animal Pool"}
        },
        ["RAM_Config"] = {
            ['Port'] = 7963,
            ['Password'] = "",
            ['Update Interval'] = 5,
            ['Subfix'] = " - ",
            ['Rod Displayed'] = 10
        },
        ['ShakeMode'] = "Fast", -- Fast, Fix bug
        ["FpsBoost"] = false,
        ["Black_Screen"] = true
    }
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "MaruKaitunGrowAGarden" then
    getgenv().NScript = "MaruHub"
    _G.Settings = {
        SelectSeeds = {"Cherry Blossom", "Coconut", "Mint", "Easter Egg", "Lemon", "Succulent", "Raspberry",
                       "Passionfruit", "Cranberry", "Candy Blossom", "Watermelon", "Red Lollipop", "Pineapple",
                       "Blood Banana", "Peach", "Candy Sunflower", "Crimson Vine", "Mushroom", "Pear",
                       "Chocolate Carrot", "Starfruit", "Pumpkin", "Pepper", "Cacao", "Glowshroom", "Eggplant",
                       "Durian", "Avocado", "Venus Fly Trap", "Lotus", "Banana", "Dragon Fruit", "Cursed Fruit",
                       "Mango", "Cactus", "Papaya", "Beanstalk", "Grape", "Bamboo", "Soul Fruit", "Carrot",
                       "Orange Tulip", "Daffodil", "Celestiberry"},
        StartBuyEggWhen = 150000,
        SelectEggs = {"Legendary Egg", "Mythical Egg", "Bug Egg"},
        SelectHoneyStocks = {"Bee Egg"},
        UpgradePetSlots = 2,
        RemoveTrashFruits = true
    }
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "MaruKaitunBF" then
    getgenv().NScript = "MaruHub"
    repeat
        task.wait()
    until game.Players
    repeat
        task.wait()
    until game.Players.LocalPlayer
    repeat
        task.wait()
    until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    _G.Team = "Pirate" -- Marine / Pirate
    getgenv().Script_Mode = "Kaitun_Script"
    _G.MainSettings = {
        ["EnabledHOP"] = true,
        ['FPSBOOST'] = true,
        ["FPSLOCKAMOUNT"] = 60,
        ['WhiteScreen'] = true,
        ['CloseUI'] = false,
        ["NotifycationExPRemove"] = true,
        ['AFKCheck'] = 150,
        ["LockFragments"] = 20000,
        ["LockFruitsRaid"] = {
            [1] = "Dough-Dough",
            [2] = "Dragon-Dragon"
        }
    }
    _G.SharkAnchor_Settings = {
        ["Enabled_Farm"] = true,
        ['FarmAfterMoney'] = 2500000
    }
    _G.Quests_Settings = {
        ['Rainbow_Haki'] = true,
        ["MusketeerHat"] = true,
        ["PullLever"] = true,
        ['DoughQuests_Mirror'] = {
            ['Enabled'] = true,
            ['UseFruits'] = true
        }
    }
    _G.Races_Settings = {
        ['Race'] = {
            ['EnabledEvo'] = true,
            ["v2"] = true,
            ["v3"] = true,
            ["Races_Lock"] = {
                ["Races"] = {
                    ["Mink"] = true,
                    ["Human"] = true,
                    ["Fishman"] = true
                },
                ["RerollsWhenFragments"] = 20000
            }
        }
    }
    _G.Fruits_Settings = {
        ['Main_Fruits'] = {'Dough-Dough'},
        ['Select_Fruits'] = {"Flame-Flame", "Ice-Ice", "Quake-Quake", "Light-Light", "Dark-Dark", "Spider-Spider",
                             "Rumble-Rumble", "Magma-Magma", "Buddha-Buddha"}
    }
    _G.Settings_Melee = {
        ['Superhuman'] = true,
        ['DeathStep'] = true,
        ['SharkmanKarate'] = true,
        ['ElectricClaw'] = true,
        ['DragonTalon'] = true,
        ['Godhuman'] = true
    }
    _G.SwordSettings = {
        ['Saber'] = true,
        ["Pole"] = false,
        ['MidnightBlade'] = false,
        ['Shisui'] = true,
        ['Saddi'] = true,
        ['Wando'] = false,
        ['Yama'] = true,
        ['Rengoku'] = false,
        ['Canvander'] = false,
        ['BuddySword'] = false,
        ['TwinHooks'] = false,
        ['HallowScryte'] = false,
        ['TrueTripleKatana'] = false,
        ['CursedDualKatana'] = true
    }
    _G.GunSettings = {
        ['Kabucha'] = false,
        ['SerpentBow'] = false,
        ['SoulGuitar'] = false
    }
    _G.FarmMastery_Settings = {
        ['Melee'] = true,
        ['Sword'] = true,
        ['DevilFruits'] = true,
        ['Select_Swords'] = {
            ["AutoSettings"] = true,
            ["ManualSettings"] = {"Saber", "Buddy Sword"}
        }
    }
    _G.Hop_Settings = {
        ["Find Tushita"] = false
    }
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()
    -- // HoHoHub
elseif scriptName == "HoHoHub" then
    getgenv().NScript = "HohoHub"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()
else
    LocalPlayer:Kick("🚫 Không xác định script cần chạy. (scriptName = " .. tostring(scriptName) .. ")")
end