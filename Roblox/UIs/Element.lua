local gui=game:GetService("CoreGui")
local uis=game:GetService("UserInputService")
local versionn="0.1.4"

local lib={}

function lib.init()
    local toret1={}
    local ui=Instance.new("ScreenGui",gui)
    
    function toret1.window(name,shortcut)
        local toret2={}
        local window=Instance.new("Frame",ui)
        window.BackgroundColor3=Color3.new(0,0,0)
        window.Size=UDim2.fromScale(1,1)
        window.BackgroundTransparency=.25
        local modalw=Instance.new("TextButton",window)
        modalw.Size=UDim2.new(0,0,0,0)
        modalw.BackgroundTransparency=1
        modalw.Text=""
        modalw.Modal=true

        local amtoftabs=1

        local wlogo=if name then name else "Element "..versionn

        local logo=Instance.new("TextLabel",window)
        logo.Size=UDim2.fromScale(1,.1)
        logo.BackgroundTransparency=1
        logo.Position=UDim2.fromScale(.5,1)
        logo.AnchorPoint=Vector2.new(.5,1)
        logo.TextScaled=true
        logo.Text=wlogo.." | Show/Hide With "..shortcut
        logo.TextTransparency=.25
        logo.TextColor3=Color3.new(.9,.9,.9)

        local sht
        local s,e = pcall(function() sht = Enum.KeyCode[shortcut] end)
        if s and sht then
          uis.InputBegan:Connect(function(inp,b)
            if b then return end
            if inp.KeyCode==sht then
              window.Visible = not window.Visible
            end
          end)
        end

        function toret2.tab(name2)
            local toret3={}
            local amtofstuff=1
            
        
            local tab=Instance.new("Frame",window)
            tab.Size=UDim2.fromOffset(200,50)
            tab.Position=UDim2.fromOffset(amtoftabs*200+5,50)
            tab.BackgroundColor3=Color3.new(1,1,1)
            local UIDragger=Instance.new("UIDragDetector",tab)
            local List=Instance.new("UIListLayout",tab)
            List.SortOrder=Enum.SortOrder.Name
            local logo1=Instance.new("TextLabel",tab)
            logo1.BackgroundTransparency=1
            logo1.Size=UDim2.fromScale(1,1)
            logo1.TextSize=12
            logo1.Text=name2 or "tab"
            logo1.Name=tostring(amtofstuff)
            amtoftabs+=1

            function toret3.button(name3)
                local toret4={}
                
                local button=Instance.new("TextButton",tab)
                button.BackgroundColor3=Color3.new(1,1,1)
                button.TextSize=12
                button.Size=UDim2.fromScale(1,1)
                button.Text=name3 or "button"
                button.Modal=true
                amtofstuff+=1
                button.Name=tostring(amtofstuff)
                toret4.clicked=button.MouseButton1Click
                toret4.instance=button
                
                return toret4
            end
            function toret3.label(text1)
            	local toret4={}
            	local button=Instance.new("TextLabel",tab)
                button.BackgroundColor3=Color3.new(1,1,1)
                button.TextSize=12
                button.Size=UDim2.fromScale(1,1)
                button.Text=text1 or "label"
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
