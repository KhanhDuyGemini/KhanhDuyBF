-- // ⚙️ Cấu hình
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local scriptName = tostring(getgenv().NScript or "Unknown")
local inputKey = tostring(getgenv().Key or "")

-- // 🔑 Danh sách key hợp lệ (cập nhật từ bot Discord)
-- Nếu bạn đặt `getgenv().ValidKeys` thì script sẽ kiểm tra theo danh sách đó.
-- Nếu không đặt `getgenv().ValidKeys`, script sẽ chấp nhận `getgenv().Key` (không an toàn nhưng cần thiết nếu executor không cho HTTP).
local VALID_KEYS = getgenv().ValidKeys -- may be nil

-- // 🗝️ Kiểm tra key
if inputKey == nil or inputKey == "" then
    warn("[KEY] ❌ Key rỗng hoặc không được cung cấp.")
    local msg = "Thiếu key để xác minh. Vui lòng cấu hình getgenv().Key trước khi chạy."
    print("[KEY] " .. msg)
    -- Đợi một chút để user có thể xem console trước khi kick
    for i = 10, 1, -1 do
        print("[KEY] 🔔 Kick in " .. i .. "s...")
        task.wait(1)
    end
    LocalPlayer:Kick(msg)
    return
end

print("[KEY] 🔍 Đang kiểm tra key: " .. inputKey)
-- // Kiểm tra key trong danh sách hợp lệ (nếu có)
local keyValid = false
if VALID_KEYS and type(VALID_KEYS) == "table" and #VALID_KEYS > 0 then
    for _, validKey in ipairs(VALID_KEYS) do
        if inputKey == validKey then
            keyValid = true
            break
        end
    end
else
    -- Nếu không có danh sách VALID_KEYS, chấp nhận key đã được cung cấp (getgenv().Key)
    print("[KEY] ⚠️ Không có danh sách VALID_KEYS; chấp nhận key được cung cấp (không an toàn).")
    keyValid = true
end

if not keyValid then
    local msg = "❌ Key không hợp lệ hoặc không tồn tại."
    print("[KEY] " .. msg)
    -- Provide a short countdown so user can read logs
    for i = 10, 1, -1 do
        print("[KEY] 🔔 Kick in " .. i .. "s...")
        task.wait(1)
    end
    LocalPlayer:Kick(msg)
    return
end

-- // ✅ Key hợp lệ
print("[KEY] ✅ Key hợp lệ!")
print("[KEY] 🔄 Đang tải script:", scriptName)

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
        ["AfkCheckTime"] = 30,
        ["AfkFix"] = "Reset",
        ["EquipRod"] = "Auto",
        ["InstantFishing"] = true,
        ["Return to Sea1"] = {
            ["Obtained All Rods"] = true
        },
        ["SellFish"] = {
            ["SellDelay"] = 120,
            ["Enable"] = true,
            ["Method"] = {
                ["Event"] = true,
                ["Enchant"] = false,
                ["Mythical"] = true,
                ["Legendary"] = true,
                ["Exotic"] = true
            }
        },
        ['Rod'] = {
            Necessary_Rods = {"Steady Rod",
            "Reinforced Rod", "Depthseeker Rod", "Kraken Rod", "Zeus Rod", "Ethereal Prism Rod", "Free Spirit Rod"},
            Custom_Rods = {"Aurora Rod", "Tempest Rod", "Abyssal Specter Rod", "Destiny Rod", "Challenger's Rod",
                           "Rod Of The Zenith", "Nocturnal Rod", "Kings Rod", "Trident Rod",
                           "Poseidon Rod", "Champions Rod", "Volcanic Rod", "Summit Rod", "Training Rod", "Plastic Rod",
                           "Carbon Rod", "Long Rod", "Lucky Rod", "Fortune Rod", "Rapid Rod", "Magnet Rod",
                           "Mythical Rod", "Midas Rod", "Scurvy Rod", "Stone Rod", "Phoenix Rod", "Arctic Rod",
                           "Crystalized Rod", "Ice Warpers Rod", "Avalanche Rod", "Wildflower Rod",
                           "Firefly Rod", "Frog Rod", "Azure Of Lagoon", "Free Spirit Rod",
            "Verdant Shear Rod", "Great Dreamer Rod"},
            Puzzle_Rods = {}
        },
        ["Enchant"] = {
            ["Enabled"] = true,
            ["Rod"] = {
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
            ["Enabled"] = true,
            ["ActivationLevel"] = 300,
            ["DayTotem"] = "Sundial Totem",
            ["NightTotem"] = "Aurora Totem",
            ["AutoPurchase"] = true,
            ["PurchaseLimit"] = {
                ["DayTotem"] = 1,
                ["NightTotem"] = 1
            }
        },
        ['EnabledFishingZones'] = true,
        ["CastZone"] = {
            ['OnLevel'] = 300,
            ['Ignored_Aurora'] = true,
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
        ['ShakeMode'] = "Fast",
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
    _G.Team = "Pirate"
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

elseif scriptName == "HoHoHub" then
    getgenv().NScript = "HohoHub"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

else
    LocalPlayer:Kick("🚫 Không xác định script cần chạy. (scriptName = " .. tostring(scriptName) .. ")")
end
