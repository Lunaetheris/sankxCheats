local ts=game:GetService("TweenService")
local lib=loadstring(game:HttpGet('https://raw.githubusercontent.com/Lunaetheris/sankxCheats/refs/heads/main/Roblox/UIs/Element.lua'))()
local init=lib.init()
local win=init.window("Flee the fuckility","X")
local esp=win.tab("ESP")

local espstogs={
    "computer","exit","beast"
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
                        local light = Instance.new("Highlight",v)
                        table.insert(pcesplights,light)
                        task.wait(1)
                        local screen = v:FindFirstChild("Screen")
                        if screen then
                            pchighlightcolor(light,screen.Color)
                            screen:GetPropertyChangedSignal("Color"):Connect(function()
                                pchighlightcolor(light,screen.Color)
                            end)
                        end
                    end)
                end 
            end
            workspace.DescendantAdded:Connect(function(ins)
                if ins:IsA("Model") and ins.Name == "ComputerTable" then
                    task.spawn(function()
                        local light = Instance.new("Highlight",ins)
                        table.insert(pcesplights,light)
                        task.wait(1)
                        local screen = ins:FindFirstChild("Screen")
                        if screen then
                            pchighlightcolor(light,screen.Color)
                            screen:GetPropertyChangedSignal("Color"):Connect(function()
                                pchighlightcolor(light,screen.Color)
                            end)
                        end
                    end)
                end 
            end)
        end,
        thread=nil,
        cleanup=function()
        	for _, instance in pcesplights do
        		instance:Destroy()
        	end
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
            workspace.DescendantAdded:Connect(function(ins)
                if ins:IsA("Model") and ins.Name == "ExitDoor" then
                    task.spawn(function()
                        local light = Instance.new("Highlight",ins)
                        table.insert(exitlights,light)
                        light.FillColor = Color3.new(1,1,0)
                    end)
                end 
            end)
        end,
        thread=nil,
        cleanup=function()
        	for _, instance in exitlights do
        		instance:Destroy()
        	end
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
            workspace.DescendantAdded:Connect(function(ins)
                if ins:IsA("Model") and ins.Name == "Hammer" then
                    if v.Parent:FindFirstChild("Humanoid")then
                		task.spawn(function()
                            local light = Instance.new("Highlight",v.Parent)
                            hammerlight=light
                            light.FillColor = Color3.new(1,0.5,0)
                            ins.Destroying:Connect(function()
                                light:Destroy()
                            end)
                        end)
                	end
                end 
            end)
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
    	if typeof(cesp.thread)~="thread"then
    		cesp.thread=task.spawn(cesp.func)
            return true
        else
            task.cancel(cesp.thread)
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
