local plr=game.Players.LocalPlayer
local gui=game:GetService("CoreGui")
local uis=game:GetService("UserInputService")
local versionn="0.1.0"

local lib={}

function lib.init()
    local toret1={}
    local ui=Instance.new("ScreenGui",gui)
    
    function toret1.window(name,shortcut)
        local toret2={}
        local window=Instance.new("Frame",ui)
        window.BackgroundColor3=Color.new(0,0,0)
        window.Size=UDim2.fromScale(1,1)
        window.BackgroundTransparency=.25

        local logo=Instance.new("TextLabel",window)
        logo.Size=UDim2.fromScale(1,.1)
        logo.BackgroundTransparency=1
        logo.Position=UDim2.fromScale(.5,1)
        logo.AnchorPoint=Vector2.new(.5,1)
        logo.TextScaled=true
        logo.Text=if name then name else "Element "..versionn
        logo.TextTransparency=.5

        local sht
        local s,e = pcall(function() sht = Enum.KeyCode[shortcut] end)
        if s and sht then
          uis.InputBegan:Connect(function(inp,b)
            if b then return end
            if inp.KeyCode==sht then
              window.Visible = not window.Visible
            end
          end
        end

        function toret2.tab(name2)
            local toret3={}
        
            local tab=Instance.new("Frame",window)
            tab.Size=UDim2.fromOffset(200,50)
            tab.Position=UDim2.fromOffset(50,50)
            tab.BackgroundColor3=Color3.new(1,1,1)
            local UIDragger=Instance.new("UIDragDetector",tab)
            local List=Instance.new("UIListLayout",tab)
            local logo1=Instance.new("TextLabel",tab)
            logo1.BackgroundTransparency=1
            logo1.Size=UDim2.fromScale(1,1)
            logo1.TextSize=12
            logo1.Text=name or "tab"

            function toret3.button(name3)
                local toret4={}
                
                local button=Instance.new("TextButton",tab)
                button.BackgroundColor3=Color3.new(1,1,1)
                button.TextSize=12
                button.Text=name3 or "button"
                toret4.clicked=button.MouseButton1Click
                toret4.instance=button
                
                return toret4
            end
            return toret3
        end
        return toret2
    end    
    return toret1
end

return lib
