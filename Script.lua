loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "[HIDE AND SEEK] Hack ⚙️",
   LoadingTitle = "HIDE AND SEEK",
   LoadingSubtitle = "by Alessandro",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "HideAndSeekScript",
      FileName = "Config"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false,
})

-- GUI Tabs
local Main = Window:CreateTab("⚙️ Funções", 4483362458)
local Misc = Window:CreateTab("🎮 Extras", 4483362458)

-- Auto Dash (Q ou outro bind se liberado)
Main:CreateToggle({
   Name = "🏃 Auto Dash",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoDash = Value
      while getgenv().AutoDash do
         local character = game.Players.LocalPlayer.Character
         if character and character:FindFirstChild("HumanoidRootPart") then
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Q", false, game)
         end
         wait(1) -- Ajuste o intervalo conforme necessário
      end
   end,
})

-- Fly (mobile incluso)
Main:CreateButton({
   Name = "🛸 Ativar Fly (Mobile)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Alessandrokkk/Roblox/main/FlyMobile.lua"))()
   end,
})

-- Speed Hack
Main:CreateSlider({
   Name = "⚡ Speed Hack",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- ESP (inimigos/objetos)
Misc:CreateButton({
   Name = "🔍 Ativar ESP",
   Callback = function()
      loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))() -- Kiriot ESP padrão
      ESP.Players = true
      ESP:Toggle(true)
   end,
})

-- Invisibilidade
Misc:CreateButton({
   Name = "👻 Invisibilidade",
   Callback = function()
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Head") then
         char.Head.Transparency = 1
         char.Torso.Transparency = 1
         for _,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
               v.Transparency = 1
            end
         end
      end
   end,
})

-- AntiKick (bypass básico)
Misc:CreateButton({
   Name = "🛡️ Anti Kick",
   Callback = function()
      local mt = getrawmetatable(game)
      local backup = mt.__namecall
      setreadonly(mt, false)
      mt.__namecall = newcclosure(function(...)
         local args = {...}
         if getnamecallmethod() == "Kick" then
            return nil
         end
         return backup(...)
      end)
      setreadonly(mt, true)
   end,
})

-- AutoFarm (placeholder, depende do jogo)
Main:CreateToggle({
   Name = "💰 Auto Farm (experimental)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoFarm = Value
      while getgenv().AutoFarm do
         -- Exemplo básico
         for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
               firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
               wait(0.2)
               firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
            end
         end
         wait(1)
      end
   end,
})

-- No Cooldown (padrão)
Misc:CreateButton({
   Name = "⏱️ Remover Cooldown (padrão)",
   Callback = function()
      for _,v in pairs(getgc(true)) do
         if type(v) == "function" and islclosure(v) and not isexecutorclosure(v) then
            setupvalue(v, 1, 0)
         end
      end
   end,
})
