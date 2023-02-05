local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vozoid/ui-libraries/main/drawing/void/source.lua"))()
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")

if not fireproximityprompt then
    local msg = Instance.new("Message",workspace)
    msg.Text = "you have fireproximityprompt function bro get better executor"
    task.wait(6)
    msg:Destroy()
    error("no prox") 
end

local watermark = library:Watermark("Azura | v1.0.0 | Release")
-- watermark:Set("Watermark Set")
-- watermark:Hide() -- toggles watermark


local flags = {
    speed = 0,
    espdoors = false,
    espkeys = false,
    espitems = false,
    espbooks = false,
    esprush = false,
    espchest = false,
    esplocker = false,
    esphumans = false,
    espgold = false,
    goldespvalue = 0,
    hintrush = false,
    light = false,
    instapp = false,
    noseek = false,
    nogates = false,
    nopuzzle = false,
    noa90 = false,
    noskeledoors = false,
    noscreech = false,
    getcode = false,
    roomsnolock = false,
    draweraura = false,
    autoskip = false,
    HeartbeatWin = false,
}


local DELFLAGS = {table.unpack(flags)}
local esptable = {doors={},keys={},items={},books={},entity={},chests={},lockers={},people={},gold={}}

function esp(what,color,core,name)
    local parts
    
    if typeof(what) == "Instance" then
        if what:IsA("Model") then
            parts = what:GetChildren()
        elseif what:IsA("BasePart") then
            parts = {what,table.unpack(what:GetChildren())}
        end
    elseif typeof(what) == "table" then
        parts = what
    end
    
    local bill
    local boxes = {}
    
    for i,v in pairs(parts) do
        if v:IsA("BasePart") then
            local box = Instance.new("SelectionBox")
            box.Adornee = v
            box.Color3 = color
            box.Parent = game.CoreGui
            
            table.insert(boxes,box)
            
            task.spawn(function()
                while box do
                    if box.Adornee == nil or not box.Adornee:IsDescendantOf(workspace) then
                        box.Adornee = nil
                        box.Visible = false
                        box:Destroy()
                    end  
                    task.wait()
                end
            end)
        end
    end
    
    if core and name then
        bill = Instance.new("BillboardGui",game.CoreGui)
        bill.AlwaysOnTop = true
        bill.Size = UDim2.new(0,400,0,100)
        bill.Adornee = core
        bill.MaxDistance = 2000
        
        local mid = Instance.new("Frame",bill)
        mid.AnchorPoint = Vector2.new(0.5,0.5)
        mid.BackgroundColor3 = color
        mid.Size = UDim2.new(0,8,0,8)
        mid.Position = UDim2.new(0.5,0,0.5,0)
        Instance.new("UICorner",mid).CornerRadius = UDim.new(1,0)
        Instance.new("UIStroke",mid)
        
        local txt = Instance.new("TextLabel",bill)
        txt.AnchorPoint = Vector2.new(0.5,0.5)
        txt.BackgroundTransparency = 1
        txt.BackgroundColor3 = color
        txt.TextColor3 = color
        txt.Size = UDim2.new(1,0,0,20)
        txt.Position = UDim2.new(0.5,0,0.7,0)
        txt.Text = name
        Instance.new("UIStroke",txt)
        
        task.spawn(function()
            while bill do
                if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                    bill.Enabled = false
                    bill.Adornee = nil
                    bill:Destroy() 
                end  
                task.wait()
            end
        end)
    end
    
    local ret = {}
    
    ret.delete = function()
        for i,v in pairs(boxes) do
            v.Adornee = nil
            v.Visible = false
            v:Destroy()
        end
        
        if bill then
            bill.Enabled = false
            bill.Adornee = nil
            bill:Destroy() 
        end
    end
    
    return ret 
end

local entityinfo = game.ReplicatedStorage:WaitForChild("EntityInfo")
function message(text)
    local msg = Instance.new("Message",workspace)
    msg.Text = tostring(text)
    task.wait(5)
    msg:Destroy()
    
    --firesignal(entityinfo.Caption.OnClientEvent,tostring(text)) 
end


local Game = nil
if game.PlaceId == 6516141723 then
    Game = "Doors"
elseif game.PlaceId == 6839171747 then
    Game = "Doors"
else
    Game = "No Game Found"
    --game.Players.LocalPlayer:Kick("Game isnt on list of games")
end


local main = library:Load{
    Name = 'Toldes ' ..Game .. ' Script',
    SizeX = 600,
    SizeY = 650,
    Theme = "Midnight",
    Extension = "json", -- config file extension
    Folder = "Azura" -- config folder name
}


local tab = main:Tab("Main")

local mainSecetion = tab:Section{
    Name = "Main",
    Side = "Left"
}


local Instause = mainSecetion:Toggle{
    Name = "Insta Use",
    Flag = "Insta Use",
    --Default = true,
    Callback  = function(val)
        flags.instapp = val
    
    local holdconnect
    holdconnect = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
		fireproximityprompt(p)
	end)
    
    repeat task.wait() until not flags.instapp
    holdconnect:Disconnect()
    end
}



local NoSeek = mainSecetion:Toggle{
    Name = "No Seek Chase",
    Flag = "No Seek Chase",
    --Default = true,
    Callback  = function(val)
    flags.noseek = val
    
    if val then
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            local trigger = room:WaitForChild("TriggerEventCollision",2)
            
            if trigger then
                trigger:Destroy() 
            end
        end)
        
        repeat task.wait() until not flags.noseek
        addconnect:Disconnect()
    end
end
}

local walkspeedslider = mainSecetion:Slider{
    Name = "Slider",
    Text = "[value]/22",
    --Default = 0.1,
    Min = 1,
    Max = 22,
    Float = 0.1,
    Flag = "Slider 1",
    Callback = function(value)
        hum.WalkSpeed = value
    flags.speed = value
    end
}

task.spawn(function()
    while true do
        if hum.WalkSpeed < flags.speed then
            hum.WalkSpeed = flags.speed
        end
        
        task.wait()
    end
end)


local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()


local espSecetion = tab:Section{
    Name = "Esp",
    Side = "Right"
}


local pcl = Instance.new("SpotLight")
pcl.Brightness = 1
pcl.Face = Enum.NormalId.Front
pcl.Range = 90
pcl.Parent = game.Players.LocalPlayer.Character.Head
pcl.Enabled = false

local Headlight = espSecetion:Toggle{
    Name = "Headlight",
    Flag = "Headlight",
    --Default = true,
    Callback  = function(val)
        pcl.Enabled = val
    end
}

local doorEsp = espSecetion:Toggle{
    Name = "Door Esp",
    Flag = "Door Esp",
    --Default = true,
    Callback  = function(val)
        flags.espdoors = val
    
        if val then
            local function setup(room)
                local door = room:WaitForChild("Door"):WaitForChild("Door")
                
                task.wait(0.1)
                local h = esp(door,Color3.fromRGB(163, 255, 145),door,"Door")
                table.insert(esptable.doors,h)
                
                door:WaitForChild("Open").Played:Connect(function()
                    h.delete()
                end)
                
                door.AncestryChanged:Connect(function()
                    h.delete()
                end)
            end
            
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
                if room:FindFirstChild("Assets") then
                    setup(room) 
                end
            end
            
            repeat task.wait() until not flags.espdoors
            addconnect:Disconnect()
            
            for i,v in pairs(esptable.doors) do
                v.delete()
            end 
        end
    end
}


local KeyLeverEsp = espSecetion:Toggle{
    Name = "Key/Lever Esp",
    Flag = "Key/Lever Esp",
    --Default = true,
    Callback  = function(val)
        flags.espkeys = val
    
        if val then
            local function check(v)
                if v:IsA("Model") and (v.Name == "LeverForGate" or v.Name == "KeyObtain") then
                    task.wait(0.1)
                    if v.Name == "KeyObtain" then
                        local hitbox = v:WaitForChild("Hitbox")
                        local parts = hitbox:GetChildren()
                        table.remove(parts,table.find(parts,hitbox:WaitForChild("PromptHitbox")))
                        
                        local h = esp(parts,Color3.fromRGB(90,255,40),hitbox,"Key")
                        table.insert(esptable.keys,h)
                        
                    elseif v.Name == "LeverForGate" then
                        local h = esp(v,Color3.fromRGB(90,255,40),v.PrimaryPart,"Lever")
                        table.insert(esptable.keys,h)
                        
                        v.PrimaryPart:WaitForChild("SoundToPlay").Played:Connect(function()
                            h.delete()
                        end) 
                    end
                end
            end
            
            local function setup(room)
                local assets = room:WaitForChild("Assets")
                
                assets.DescendantAdded:Connect(function(v)
                    check(v) 
                end)
                    
                for i,v in pairs(assets:GetDescendants()) do
                    check(v)
                end 
            end
            
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
                if room:FindFirstChild("Assets") then
                    setup(room) 
                end
            end
            
            repeat task.wait() until not flags.espkeys
            addconnect:Disconnect()
            
            for i,v in pairs(esptable.keys) do
                v.delete()
            end 
        end
    end
    }

local ItemrEsp = espSecetion:Toggle{
    Name = "Item Esp",
    Flag = "Item Esp",
    --Default = true,
    Callback  = function(val)
        flags.espitems = val
    
    if val then
        local function check(v)
            if v:IsA("Model") and (v:GetAttribute("Pickup") or v:GetAttribute("PropType")) then
                task.wait(0.1)
                
                local part = (v:FindFirstChild("Handle") or v:FindFirstChild("Prop"))
                local h = esp(part,Color3.fromRGB(160,190,255),part,v.Name)
                table.insert(esptable.items,h)
            end
        end
        
        local function setup(room)
            local assets = room:WaitForChild("Assets")
            
            if assets then  
                local subaddcon
                subaddcon = assets.DescendantAdded:Connect(function(v)
                    check(v) 
                end)
                
                for i,v in pairs(assets:GetDescendants()) do
                    check(v)
                end
                
                task.spawn(function()
                    repeat task.wait() until not flags.espitems
                    subaddcon:Disconnect()  
                end) 
            end 
        end
        
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            setup(room)
        end)
        
        for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
            if room:FindFirstChild("Assets") then
                setup(room) 
            end
        end
        
        repeat task.wait() until not flags.espitems
        addconnect:Disconnect()
        
        for i,v in pairs(esptable.items) do
            v.delete()
        end 
    end
    end
    }

    local BookBreakerEsp = espSecetion:Toggle{
        Name = "Book/Breaker Esp",
        Flag = "Book/Breaker Esp",
        --Default = true,
        Callback  = function(val)
            flags.espbooks = val
    
            if val then
                local function check(v)
                    if v:IsA("Model") and (v.Name == "LiveHintBook" or v.Name == "LiveBreakerPolePickup") then
                        task.wait(0.1)
                        
                        local h = esp(v,Color3.fromRGB(160,190,255),v.PrimaryPart,"Book")
                        table.insert(esptable.books,h)
                        
                        v.AncestryChanged:Connect(function()
                            if not v:IsDescendantOf(room) then
                                h.delete() 
                            end
                        end)
                    end
                end
                
                local function setup(room)
                    if room.Name == "50" or room.Name == "100" then
                        room.DescendantAdded:Connect(function(v)
                            check(v) 
                        end)
                        
                        for i,v in pairs(room:GetDescendants()) do
                            check(v)
                        end
                    end
                end
                
                local addconnect
                addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                    setup(room)
                end)
                
                for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
                    setup(room) 
                end
                
                repeat task.wait() until not flags.espbooks
                addconnect:Disconnect()
                
                for i,v in pairs(esptable.books) do
                    v.delete()
                end 
            end
        end
        }

        local entitynames = {"RushMoving","AmbushMoving","Snare","A60","A120"}


        local EntityEsp = espSecetion:Toggle{
            Name = "Entity Esp",
            Flag = "Entity Esp",
            --Default = true,
            Callback  = function(val)
                flags.esprush = val
    
                if val then
                    local addconnect
                    addconnect = workspace.ChildAdded:Connect(function(v)
                        if table.find(entitynames,v.Name) then
                            task.wait(0.1)
                            
                            local h = esp(v,Color3.fromRGB(255,25,25),v.PrimaryPart,v.Name:gsub("Moving",""))
                            table.insert(esptable.entity,h)
                        end
                    end)
                    
                    local function setup(room)
                        if room.Name == "50" or room.Name == "100" then
                            local figuresetup = room:WaitForChild("FigureSetup")
                        
                            if figuresetup then
                                local fig = figuresetup:WaitForChild("FigureRagdoll")
                                task.wait(0.1)
                                
                                local h = esp(fig,Color3.fromRGB(255,25,25),fig.PrimaryPart,"Figure")
                                table.insert(esptable.entity,h)
                            end 
                        else
                            local assets = room:WaitForChild("Assets")
                            
                            local function check(v)
                                if v:IsA("Model") and table.find(entitynames,v.Name) then
                                    task.wait(0.1)
                                    
                                    local h = esp(v:WaitForChild("Base"),Color3.fromRGB(255,25,25),v.Base,"Snare")
                                    table.insert(esptable.entity,h)
                                end
                            end
                            
                            assets.DescendantAdded:Connect(function(v)
                                check(v) 
                            end)
                            
                            for i,v in pairs(assets:GetDescendants()) do
                                check(v)
                            end
                        end 
                    end
                    
                    local roomconnect
                    roomconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                        setup(room)
                    end)
                    
                    for i,v in pairs(workspace.CurrentRooms:GetChildren()) do
                        setup(room) 
                    end
                    
                    repeat task.wait() until not flags.esprush
                    addconnect:Disconnect()
                    roomconnect:Disconnect()
                    
                    for i,v in pairs(esptable.entity) do
                        v.delete()
                    end 
                end
            end
            }

            local LockerEsp = espSecetion:Toggle{
                Name = "Locker Esp",
                Flag = "Locker Esp",
                --Default = true,
                Callback  = function(val)
                    flags.esplocker = val
    
                    if val then
                        local function check(v)
                            if v:IsA("Model") then
                                task.wait(0.1)
                                if v.Name == "Wardrobe" then
                                    local h = esp(v.PrimaryPart,Color3.fromRGB(145,100,25),v.PrimaryPart,"Closet")
                                    table.insert(esptable.lockers,h) 
                                elseif (v.Name == "Rooms_Locker" or v.Name == "Rooms_Locker_Fridge") then
                                    local h = esp(v.PrimaryPart,Color3.fromRGB(145,100,25),v.PrimaryPart,"Locker")
                                    table.insert(esptable.lockers,h) 
                                end
                            end
                        end
                        
                        local function setup(room)
                            local assets = room:WaitForChild("Assets")
                            
                            if assets then
                                local subaddcon
                                subaddcon = assets.DescendantAdded:Connect(function(v)
                                    check(v) 
                                end)
                                
                                for i,v in pairs(assets:GetDescendants()) do
                                    check(v)
                                end
                                
                                task.spawn(function()
                                    repeat task.wait() until not flags.esplocker
                                    subaddcon:Disconnect()  
                                end) 
                            end 
                        end
                        
                        local addconnect
                        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                            setup(room)
                        end)
                        
                        for i,v in pairs(workspace.CurrentRooms:GetChildren()) do
                            setup(room) 
                        end
                        
                        repeat task.wait() until not flags.esplocker
                        addconnect:Disconnect()
                        
                        for i,v in pairs(esptable.lockers) do
                            v.delete()
                        end 
                    end
                end
            }

            local ChestEsp = espSecetion:Toggle{
                Name = "Chest Esp",
                Flag = "Chest Esp",
                --Default = true,
                Callback  = function(val)
                    flags.espchest = val
    
                    if val then
                        local function check(v)
                            if v:IsA("Model") then
                                task.wait(0.1)
                                if v.Name == "ChestBox" then
                                    warn(v.Name)
                                    local h = esp(v,Color3.fromRGB(205,120,255),v.PrimaryPart,"Chest")
                                    table.insert(esptable.chests,h) 
                                elseif v.Name == "ChestBoxLocked" then
                                    local h = esp(v,Color3.fromRGB(255,120,205),v.PrimaryPart,"Locked Chest")
                                    table.insert(esptable.chests,h) 
                                end
                            end
                        end
                        
                        local function setup(room)
                            local subaddcon
                            subaddcon = room.DescendantAdded:Connect(function(v)
                                check(v) 
                            end)
                            
                            for i,v in pairs(room:GetDescendants()) do
                                check(v)
                            end
                            
                            task.spawn(function()
                                repeat task.wait() until not flags.espchest
                                subaddcon:Disconnect()  
                            end)  
                        end
                        
                        local addconnect
                        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                            setup(room)
                        end)
                        
                        for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
                            if room:FindFirstChild("Assets") then
                                setup(room) 
                            end
                        end
                        
                        repeat task.wait() until not flags.espchest
                        addconnect:Disconnect()
                        
                        for i,v in pairs(esptable.chests) do
                            v.delete()
                        end 
                    end
                end
            }

            local PlayerEsp = espSecetion:Toggle{
                Name = "Player Esp",
                Flag = "Player Esp",
                --Default = true,
                Callback  = function(val)
                    flags.esphumans = val
    
                    if val then
                        local function personesp(v)
                            v.CharacterAdded:Connect(function(vc)
                                local vh = vc:WaitForChild("Humanoid")
                                local torso = vc:WaitForChild("UpperTorso")
                                task.wait(0.1)
                                
                                local h = esp(vc,Color3.fromRGB(255,255,255),torso,v.DisplayName)
                                table.insert(esptable.people,h) 
                            end)
                            
                            if v.Character then
                                local vc = v.Character
                                local vh = vc:WaitForChild("Humanoid")
                                local torso = vc:WaitForChild("UpperTorso")
                                task.wait(0.1)
                                
                                local h = esp(vc,Color3.fromRGB(255,255,255),torso,v.DisplayName)
                                table.insert(esptable.people,h) 
                            end
                        end
                        
                        local addconnect
                        addconnect = game.Players.PlayerAdded:Connect(function(v)
                            if v ~= plr then
                                personesp(v)
                            end
                        end)
                        
                        for i,v in pairs(game.Players:GetPlayers()) do
                            if v ~= plr then
                                personesp(v) 
                            end
                        end
                        
                        repeat task.wait() until not flags.esphumans
                        addconnect:Disconnect()
                        
                        for i,v in pairs(esptable.people) do
                            v.delete()
                        end 
                    end
                end
            }

            local GoldEsp = espSecetion:Toggle{
                Name = "Gold Esp",
                Flag = "Gold Esp",
                --Default = true,
                Callback  = function(val)
                    flags.espgold = val
    
                    if val then
                        local function check(v)
                            if v:IsA("Model") then
                                task.wait(0.1)
                                local goldvalue = v:GetAttribute("GoldValue")
                                
                                if goldvalue and goldvalue >= flags.goldespvalue then
                                    local hitbox = v:WaitForChild("Hitbox")
                                    local h = esp(hitbox:GetChildren(),Color3.fromRGB(255,255,0),hitbox,"GoldPile [".. tostring(goldvalue).."]")
                                    table.insert(esptable.gold,h)
                                end
                            end
                        end
                        
                        local function setup(room)
                            local assets = room:WaitForChild("Assets")
                            
                            local subaddcon
                            subaddcon = assets.DescendantAdded:Connect(function(v)
                                check(v) 
                            end)
                            
                            for i,v in pairs(assets:GetDescendants()) do
                                check(v)
                            end
                            
                            task.spawn(function()
                                repeat task.wait() until not flags.espchest
                                subaddcon:Disconnect()  
                            end)  
                        end
                        
                        local addconnect
                        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                            setup(room)
                        end)
                        
                        for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
                            if room:FindFirstChild("Assets") then
                                setup(room) 
                            end
                        end
                        
                        repeat task.wait() until not flags.espgold
                        addconnect:Disconnect()
                        
                        for i,v in pairs(esptable.gold) do
                            v.delete()
                        end 
                    end
                end
            }


            local slider = espSecetion:Slider{
                Name = "Minimum Gold Value",
                Text = "[value]/150",
                --Default = 0.1,
                Min = 5,
                Max = 150,
                Float = 0.1,
                Flag = "Minimum GOld Value",
                Callback = function(value)
                    flags.goldespvalue = value
                end
            }

            Notification:Notify(
                {Title = "TEXT TITLE", Description = "DESCRIPTION"},
                {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "option"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84), Callback = function(State) print(tostring(State)) end}
            )
            


            local EnttyNotif = mainSecetion:Toggle{
                Name = "Notify Entities",
                Flag = "Notify Entities",
                --Default = true,
                Callback  = function(val)
            flags.hintrush = val
    
            if val then
                local addconnect
                addconnect = workspace.ChildAdded:Connect(function(v)
                    if table.find(entitynames,v.Name) then
                        repeat task.wait() until plr:DistanceFromCharacter(v:GetPivot().Position) < 1000 or not v:IsDescendantOf(workspace)
                        
                        if v:IsDescendantOf(workspace) then
                            Notification:Notify(
                {Title = "TEXT TITLE", Description = (v.Name:gsub("Moving",""):lower().." is coming go hide")},
                {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "option"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84), Callback = function(State) print(tostring(State)) end})

                        end
                    end
                end) 
                
                
                repeat task.wait() until not flags.hintrush
                addconnect:Disconnect()
            end

                end
            }


            local DeleteGates = mainSecetion:Toggle{
                Name = "Delete Gates",
                Flag = "Delete Gates",
                --Default = true,
                Callback  = function(val)
                    flags.nogates = val
    
                    if val then
                        local addconnect
                        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                            local gate = room:WaitForChild("Gate",2)
                            
                            if gate then
                                local door = gate:WaitForChild("ThingToOpen",2)
                                
                                if door then
                                    door:Destroy() 
                                end
                            end
                        end)
                        
                        repeat task.wait() until not flags.nogates
                        addconnect:Disconnect()
                    end
                end
            }

            
local DeletePainting = mainSecetion:Toggle{
    Name = "Delte Painting Door",
    Flag = "Delete Painting Door",
    --Default = true,
    Callback  = function(val)
        flags.nopuzzle = val
    
    if val then
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            local assets = room:WaitForChild("Assets")
            local paintings = assets:WaitForChild("Paintings",2)
            
            if paintings then
                local door = paintings:WaitForChild("MovingDoor",2)
            
                if door then
                    door:Destroy() 
                end 
            end
        end)
        
        repeat task.wait() until not flags.nopuzzle
        addconnect:Disconnect()
    end
    end
}




local screechremote = entityinfo:FindFirstChild("Screech")

if screechremote then
local noscreech = mainSecetion:Toggle{
    Name = "No Screech",
    Flag = "No Screech",
    --Default = true,
    Callback  = function(val)
        flags.noscreech = val
        
        if val then
            screechremote.Parent = nil
            repeat task.wait() until not flags.noscreech
            screechremote.Parent = entityinfo
        end
    end
}
end


local AutoLibrary = mainSecetion:Toggle{
    Name = "Get Library Code",
    Flag = "Get Library Code",
    --Default = true,
    Callback  = function(val)
flags.getcode = val
    
if val then
    local function deciphercode()
    local paper = char:FindFirstChild("LibraryHintPaper")
    local hints = plr.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")
    
    local code = {[1]="_",[2]="_",[3]="_",[4]="_",[5]="_"}
        
        if paper then
            for i,v in pairs(paper:WaitForChild("UI"):GetChildren()) do
                if v:IsA("ImageLabel") and v.Name ~= "Image" then
                    for i,img in pairs(hints:GetChildren()) do
                        if img:IsA("ImageLabel") and img.Visible and v.ImageRectOffset == img.ImageRectOffset then
                            local num = img:FindFirstChild("TextLabel").Text
                            
                            code[tonumber(v.Name)] = num 
                        end
                    end
                end
            end 
        end
        
        return code
    end
    
    local addconnect
    addconnect = char.ChildAdded:Connect(function(v)
        if v:IsA("Tool") and v.Name == "LibraryHintPaper" then
            task.wait()
            
            local code = table.concat(deciphercode())
            
            if code:find("_") then
                message("get all hints first")
            else
                message("the code is ".. code)
            end
        end
    end)
    
    repeat task.wait() until not flags.getcode
    addconnect:Disconnect()
end
end
}



local LootAura = mainSecetion:Toggle{
    Name = "Loot Aura",
    Flag = "Loot Aura",
    --Default = true,
    Callback  = function(val)
        flags.draweraura = val
    
        if val then
            local function setup(room)
                local function check(v)
                    if v:IsA("Model") then
                        if v.Name == "DrawerContainer" then
                            local knob = v:WaitForChild("Knobs")
                            
                            if knob then
                                local prompt = knob:WaitForChild("ActivateEventPrompt")
                                local interactions = prompt:GetAttribute("Interactions")
                                
                                if not interactions then
                                    task.spawn(function()
                                        repeat task.wait(0.1)
                                            if plr:DistanceFromCharacter(knob.Position) <= 12 then
                                                fireproximityprompt(prompt)
                                            end
                                        until prompt:GetAttribute("Interactions") or not flags.draweraura
                                    end)
                                end
                            end
                        elseif v.Name == "GoldPile" then
                            local prompt = v:WaitForChild("LootPrompt")
                            local interactions = prompt:GetAttribute("Interactions")
                                
                            if not interactions then
                                task.spawn(function()
                                    repeat task.wait(0.1)
                                        if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
                                            fireproximityprompt(prompt) 
                                        end
                                    until prompt:GetAttribute("Interactions") or not flags.draweraura
                                end)
                            end
                        elseif v.Name:sub(1,8) == "ChestBox" then
                            local prompt = v:WaitForChild("ActivateEventPrompt")
                            local interactions = prompt:GetAttribute("Interactions")
                            
                            if not interactions then
                                task.spawn(function()
                                    repeat task.wait(0.1)
                                        if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
                                            fireproximityprompt(prompt)
                                        end
                                    until prompt:GetAttribute("Interactions") or not flags.draweraura
                                end)
                            end
                        elseif v.Name == "RolltopContainer" then
                            local prompt = v:WaitForChild("ActivateEventPrompt")
                            local interactions = prompt:GetAttribute("Interactions")
                            
                            if not interactions then
                                task.spawn(function()
                                    repeat task.wait(0.1)
                                        if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
                                            fireproximityprompt(prompt)
                                        end
                                    until prompt:GetAttribute("Interactions") or not flags.draweraura
                                end)
                            end
                        end 
                    end
                end
        
                local subaddcon
                subaddcon = room.DescendantAdded:Connect(function(v)
                    check(v) 
                end)
                
                for i,v in pairs(room:GetDescendants()) do
                    check(v)
                end
                
                task.spawn(function()
                    repeat task.wait() until not flags.draweraura
                    subaddcon:Disconnect() 
                end)
            end
            
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
                if room:FindFirstChild("Assets") then
                    setup(room) 
                end
            end
            
            repeat task.wait() until not flags.draweraura
            addconnect:Disconnect()
        end
    end
}



if game.ReplicatedStorage:WaitForChild("GameData"):WaitForChild("Floor").Value == "Rooms" then
    local Rooms = main:Tab("The Rooms")

    local Roomsection = Rooms:Section{
        Name = "Main",
        Side = "Left"
    }    
    
    local a90remote = game.ReplicatedStorage:WaitForChild("EntityInfo"):WaitForChild("A90")
    

    
local NoA90 = Roomsection:Toggle{
    Name = "Delete A90",
    Flag = "Delete A90",
    --Default = true,
    Callback  = function(val)
        
        flags.noa90 = val
        
        if val  then
            local jumpscare = plr.PlayerGui:WaitForChild("MainUI"):WaitForChild("Jumpscare"):FindFirstChild("Jumpscare_A90")
           
            if jumpscare then
                jumpscare.Parent = nil
                
                a90remote.Parent = nil
                repeat task.wait()
                    game.SoundService.Main.Volume = 1 
                until not flags.noa90
                jumpscare.Parent = plr.PlayerGui.MainUI.Jumpscare
                a90remote.Parent = entityinfo 
            end
        end
    end
}


local AutoRooms = Roomsection:Toggle{
    Name = "Auto Rooms",
    Flag = "Auto Rooms",
    --Default = true,
    Callback  = function(val)
flags.autorooms = val
        
        if val then
            local hide = false

            local function getrecentroom(index)
                local rooms = workspace.CurrentRooms:GetChildren() 
                table.sort(rooms,function(a,b)
                    return tonumber(a.Name) > tonumber(b.Name) 
                end)
                
                return rooms[index]
            end
            
            local entconnect
            entconnect = workspace.ChildAdded:Connect(function(v)
                if v:IsA("Model") then
                    if v.Name == "A60" or v.Name == "A120" then
                        hide = true
                        
                        repeat task.wait() until not v:IsDescendantOf(workspace)
                        hide = false
                    end
                end
            end)
            
            while flags.autorooms do
                local room = getrecentroom(2)
                local door = room:WaitForChild("Door")
                local dpos = door:GetPivot()
                
                if hide then
                    repeat task.wait()
                        char:PivotTo(dpos+Vector3.new(0,150,0))
                    until not hide
                else
                    repeat task.wait()
                        char:PivotTo(dpos)
                    until lastroom ~= room or not flags.autorooms
                end
                
                task.wait()
            end
            entconnect:Disconnect()
        end
end
}
end

local configs = main:Tab("Configuration")

local themes = configs:Section{Name = "Theme", Side = "Left"}

local themepickers = {}

local themelist = themes:Dropdown{
    Name = "Theme",
    Default = library.currenttheme,
    Content = library:GetThemes(),
    Flag = "Theme Dropdown",
    Callback = function(option)
        if option then
            library:SetTheme(option)

            for option, picker in next, themepickers do
                picker:Set(library.theme[option])
            end
        end
    end
}

library:ConfigIgnore("Theme Dropdown")

local namebox = themes:Box{
    Name = "Custom Theme Name",
    Placeholder = "Custom Theme",
    Flag = "Custom Theme"
}

library:ConfigIgnore("Custom Theme")

themes:Button{
    Name = "Save Custom Theme",
    Callback = function()
        if library:SaveCustomTheme(library.flags["Custom Theme"]) then
            themelist:Refresh(library:GetThemes())
            themelist:Set(library.flags["Custom Theme"])
            namebox:Set("")
        end
    end
}

local customtheme = configs:Section{Name = "Custom Theme", Side = "Right"}

themepickers["Accent"] = customtheme:ColorPicker{
    Name = "Accent",
    Default = library.theme["Accent"],
    Flag = "Accent",
    Callback = function(color)
        library:ChangeThemeOption("Accent", color)
    end
}

library:ConfigIgnore("Accent")

themepickers["Window Background"] = customtheme:ColorPicker{
    Name = "Window Background",
    Default = library.theme["Window Background"],
    Flag = "Window Background",
    Callback = function(color)
        library:ChangeThemeOption("Window Background", color)
    end
}

library:ConfigIgnore("Window Background")

themepickers["Window Border"] = customtheme:ColorPicker{
    Name = "Window Border",
    Default = library.theme["Window Border"],
    Flag = "Window Border",
    Callback = function(color)
        library:ChangeThemeOption("Window Border", color)
    end
}

library:ConfigIgnore("Window Border")

themepickers["Tab Background"] = customtheme:ColorPicker{
    Name = "Tab Background",
    Default = library.theme["Tab Background"],
    Flag = "Tab Background",
    Callback = function(color)
        library:ChangeThemeOption("Tab Background", color)
    end
}

library:ConfigIgnore("Tab Background")

themepickers["Tab Border"] = customtheme:ColorPicker{
    Name = "Tab Border",
    Default = library.theme["Tab Border"],
    Flag = "Tab Border",
    Callback = function(color)
        library:ChangeThemeOption("Tab Border", color)
    end
}

library:ConfigIgnore("Tab Border")

themepickers["Tab Toggle Background"] = customtheme:ColorPicker{
    Name = "Tab Toggle Background",
    Default = library.theme["Tab Toggle Background"],
    Flag = "Tab Toggle Background",
    Callback = function(color)
        library:ChangeThemeOption("Tab Toggle Background", color)
    end
}

library:ConfigIgnore("Tab Toggle Background")

themepickers["Section Background"] = customtheme:ColorPicker{
    Name = "Section Background",
    Default = library.theme["Section Background"],
    Flag = "Section Background",
    Callback = function(color)
        library:ChangeThemeOption("Section Background", color)
    end
}

library:ConfigIgnore("Section Background")

themepickers["Section Border"] = customtheme:ColorPicker{
    Name = "Section Border",
    Default = library.theme["Section Border"],
    Flag = "Section Border",
    Callback = function(color)
        library:ChangeThemeOption("Section Border", color)
    end
}

library:ConfigIgnore("Section Border")

themepickers["Text"] = customtheme:ColorPicker{
    Name = "Text",
    Default = library.theme["Text"],
    Flag = "Text",
    Callback = function(color)
        library:ChangeThemeOption("Text", color)
    end
}

library:ConfigIgnore("Text")

themepickers["Disabled Text"] = customtheme:ColorPicker{
    Name = "Disabled Text",
    Default = library.theme["Disabled Text"],
    Flag = "Disabled Text",
    Callback = function(color)
        library:ChangeThemeOption("Disabled Text", color)
    end
}

library:ConfigIgnore("Disabled Text")

themepickers["Object Background"] = customtheme:ColorPicker{
    Name = "Object Background",
    Default = library.theme["Object Background"],
    Flag = "Object Background",
    Callback = function(color)
        library:ChangeThemeOption("Object Background", color)
    end
}

library:ConfigIgnore("Object Background")

themepickers["Object Border"] = customtheme:ColorPicker{
    Name = "Object Border",
    Default = library.theme["Object Border"],
    Flag = "Object Border",
    Callback = function(color)
        library:ChangeThemeOption("Object Border", color)
    end
}

library:ConfigIgnore("Object Border")

themepickers["Dropdown Option Background"] = customtheme:ColorPicker{
    Name = "Dropdown Option Background",
    Default = library.theme["Dropdown Option Background"],
    Flag = "Dropdown Option Background",
    Callback = function(color)
        library:ChangeThemeOption("Dropdown Option Background", color)
    end
}

library:ConfigIgnore("Dropdown Option Background")

local configsection = configs:Section{Name = "Configs", Side = "Left"}

local configlist = configsection:Dropdown{
    Name = "Configs",
    Content = library:GetConfigs(), -- GetConfigs(true) if you want universal configs
    Flag = "Config Dropdown"
}

library:ConfigIgnore("Config Dropdown")

local loadconfig = configsection:Button{
    Name = "Load Config",
    Callback = function()
        library:LoadConfig(library.flags["Config Dropdown"]) -- LoadConfig(library.flags["Config Dropdown"], true)  if you want universal configs
    end
}

local delconfig = configsection:Button{
    Name = "Delete Config",
    Callback = function()
        library:DeleteConfig(library.flags["Config Dropdown"]) -- DeleteConfig(library.flags["Config Dropdown"], true)  if you want universal configs
        configlist:Refresh(library:GetConfigs())
    end
}


local configbox = configsection:Box{
    Name = "Config Name",
    Placeholder = "Config Name",
    Flag = "Config Name"
}

library:ConfigIgnore("Config Name")

local save = configsection:Button{
    Name = "Save Config",
    Callback = function()
        library:SaveConfig(library.flags["Config Dropdown"] or library.flags["Config Name"]) -- SaveConfig(library.flags["Config Name"], true) if you want universal configs
        configlist:Refresh(library:GetConfigs())
    end
}

local keybindsection = configs:Section{Name = "UI Toggle Keybind", Side = "Left"}

keybindsection:Keybind{
    Name = "UI Toggle",
    Flag = "UI Toggle",
    Default = Enum.KeyCode.LeftAlt,
    Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3},
    Callback = function(_, fromsetting)
        if not fromsetting then
            library:Close()
        end
    end
}

keybindsection:Keybind{
    Name = "Destroy UI",
    Flag = "Unload UI",
    Default = Enum.KeyCode.Delete,
    Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3},
    Callback = function(_, fromsetting)
        if not fromsetting then
            library:Unload()
        end
    end
}

--library:Close()
--library:Unload()
