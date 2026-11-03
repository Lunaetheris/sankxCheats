local ts=game:GetService("TweenService")
local plrs=game:GetService("Players")
local lplr=plrs.LocalPlayer
local lib=loadstring(game:HttpGet('https://raw.githubusercontent.com/Lunaetheris/sankxCheats/refs/heads/main/Roblox/UIs/Element.lua'))()
local init=lib.init()
local win=init.window("Flee the fuckility","X")
local esp=win.tab("ESP")

local espstogs={
    "computer","exit","beast"
}

local plrstats={
    "TempPlayerStatsModule","SavedPlayerStatsModule"
}

function tween(a,b,c)task.spawn(function()ts:Create(a,b,c):Play()end)end
function pchighlightcolor(high,color)
    if color == Color3.fromRGB(40,127,71) then
        task.spawn(function()
            high.FillColor = Color3.new(0,1,0)
            local TWINFPCESP = TweenInfo.new(5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
            tween(high,TWINFPCESP,{FillTransparency=1})
            task.wait(TWINFPCESP.Time/2)
            tween(high,TWINFPCESP,{OutlineTransparency=1})
            task.wait(TWINFPCESP.Time+(TWINFPCESP.Time/2))
            high.Enabled = false
        end)
    else
        high.FillColor = color
    end
end
function exithighlightcolor(high,rot)
    if rot.Y ~= 0 then
        high.FillColor = Color3.new(1,0,0)
    end
end
local pcesplights = {}
local exitlights = {}
local hammeron
local hammerlight
local esps={
    computer={
        func=function()
        	for i, v in workspace:GetDescendants() do
                if v:IsA("Model") and v.Name == "ComputerTable" then
                    task.spawn(function()
                    	local lighttoret={}
                        local light = Instance.new("Highlight",v)
                        lighttoret.instance=light
                        task.wait(1)
                        local screen = v:FindFirstChild("Screen")
                        if screen then
                            pchighlightcolor(light,screen.Color)
                            lighttoret.cn=screen:GetPropertyChangedSignal("Color"):Connect(function()
                                pchighlightcolor(light,screen.Color)
                            end)
                        end
                        table.insert(pcesplights,lighttoret)
                    end)
                end 
            end
            local cn=workspace.DescendantAdded:Connect(function(ins)
                if ins:IsA("Model") and ins.Name == "ComputerTable" then
                    task.spawn(function()
                    	local lighttoret={}
                        local light = Instance.new("Highlight",ins)
                        lighttoret.instance=light
                        task.wait(1)
                        local screen = ins:FindFirstChild("Screen")
                        if screen then
                            pchighlightcolor(light,screen.Color)
                            lighttoret.cn=screen:GetPropertyChangedSignal("Color"):Connect(function()
                                pchighlightcolor(light,screen.Color)
                            end)
                        end
                        table.insert(pcesplights,lighttoret)
                    end)
                end 
            end)
            return cn
        end,
        thread=nil,
        cleanup=function()
        	for _, ldata in pcesplights do
        		local ins=ldata["instance"]
                local cn=ldata["cn"]
                if typeof(ins)=="Instance"then ins:Destroy()end
                if typeof(cn)=="RBXScriptConnection"then cn:Disconnect()end
        	end
            table.clear(pcesplights)
        end,
    },
    exit={
        func=function()
        	for i, v in workspace:GetDescendants() do
                if v:IsA("Model") and v.Name == "ExitDoor" then
                    task.spawn(function()
                        local light = Instance.new("Highlight",v)
                        table.insert(exitlights,light)
                        light.FillColor = Color3.new(1,1,0)
                    end)
                end 
            end
            local cn=workspace.DescendantAdded:Connect(function(ins)
                if ins:IsA("Model") and ins.Name == "ExitDoor" then
                    task.spawn(function()
                        local light = Instance.new("Highlight",ins)
                        table.insert(exitlights,light)
                        light.FillColor = Color3.new(1,1,0)
                    end)
                end 
            end)
            return cn
        end,
        thread=nil,
        cleanup=function()
        	for _, instance in exitlights do
        		instance:Destroy()
        	end
            table.clear(exitlights)
        end,
    },
    beast={
        func=function()
        	for i, v in workspace:GetDescendants() do
                if v:IsA("Model") and v.Name == "Hammer" then
                	if v.Parent:FindFirstChild("Humanoid")then
                		task.spawn(function()
                            local light = Instance.new("Highlight",v.Parent)
                            hammerlight=light
                            light.FillColor = Color3.new(1,0.5,0)
                            v.Destroying:Connect(function()
                                light:Destroy()
                            end)
                        end)
                	end 
                end 
            end
            local cn=workspace.DescendantAdded:Connect(function(ins)
                if ins:IsA("Model") and ins.Name == "Hammer" then
                    if ins.Parent:FindFirstChild("Humanoid")then
                		task.spawn(function()
                            local light = Instance.new("Highlight",ins.Parent)
                            hammerlight=light
                            light.FillColor = Color3.new(1,0.5,0)
                            ins.Destroying:Connect(function()
                                light:Destroy()
                            end)
                        end)
                	end
                end 
            end)
            return cn
        end,
        thread=nil,
        cleanup=function()
        	if typeof(hammerlight)=="Instance"then
        		hammerlight:Destroy()
                hammerlight=nil
        	end
        end,
    },
}

function toggleESPthreadfor(type_)
	local cesp=esps[type_]
    if cesp then
    	if typeof(cesp.thread)~="RBXScriptConnection"then
    		cesp.thread=cesp.func()
            return true
        else
        	cesp.thread:Disconnect()
            cesp.thread=nil
            local s,e=pcall(cesp.cleanup)
            if not s then
            	warn("=== FLEE THE FUCKILITY ERROR ===")
                warn(tostring(e))
            end
            return false
    	end
    end
end

--[[
local debugwin=init.window("debug","RightShift")
for _, splr in plrs:GetPlayers() do
	for _, stat1 in plrstats do
	local i1=splr:FindFirstChild(stat1)
    if i1 then
    	local v1=debugwin.tab(stat1..": "..splr.Name)
    	for _, i2 in i1:GetChildren() do
    		local label=v1.label(i2.Name..": "..tostring(i2.Value))
            i2:GetPropertyChangedSignal("Value"):Connect(function()
            	label.instance.Text=i2.Name..": "..tostring(i2.Value)
                label.instance.BackgroundColor3=Color3.new(.5,.5,.5)
                label.instance.TextWrapped=true
                tween(label.instance,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{BackgroundColor3=Color3.new(1,1,1)})
            end)
    	end
    end
end
end]]

for _, toggle in espstogs do
	local button = esp.button(toggle)
    button.instance.BackgroundColor3=Color3.new(1,0,0)
    button.clicked:Connect(function()
    	local state=toggleESPthreadfor(toggle)
        if state==true then
        	button.instance.BackgroundColor3=Color3.new(0,1,0)
        elseif state==false then
            button.instance.BackgroundColor3=Color3.new(1,0,0)
        elseif state==nil then
            button.instance.BackgroundColor3=Color3.new(0,0,1)		
        end
    end)
end


