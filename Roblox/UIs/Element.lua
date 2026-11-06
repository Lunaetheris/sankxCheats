local gui=game:GetService("CoreGui")
local ts=game:GetService("TweenService")
local uis=game:GetService("UserInputService")
local versionn="0.1.7.2"

local lib={}
lib.nver="Element "..versionn
local m3e = {}
local function clamp(n, min, max)
	return math.clamp(n, min, max)
end
local function rotatehue(hue, degrees)
	return (hue + degrees / 360) % 1
end
function tween(a,b,c)task.spawn(function()ts:Create(a,b,c):Play()end)end
function m3e.fromsource(source: Color3, variant: string?)
	variant = variant or "tonalspot"

	local h, s, v = source:ToHSV()

	local primarys = clamp(s * 1.05, 0.35, 0.85)
	local primaryv = clamp(v, 0.55, 0.95)

	local secondarys, tertiarys, neutrals, neutralvars
	local tertiaryoffset = 60

	if variant == "expressive" then
		tertiaryoffset = 120
		secondarys  = primarys * 0.45
		tertiarys   = primarys * 0.70
		neutrals    = 0.04
		neutralvars = 0.09
	elseif variant == "vibrant" then
		secondarys  = primarys * 0.65
		tertiarys   = primarys * 0.80
		neutrals    = 0.05
		neutralvars = 0.12
	elseif variant == "neutral" then
		primarys    = clamp(primarys * 0.35, 0.08, 0.25)
		secondarys  = primarys * 0.6
		tertiarys   = primarys * 0.7
		neutrals    = 0.03
		neutralvars = 0.07
	else -- tonalspot (default)
		secondarys  = primarys * 0.38
		tertiarys   = primarys * 0.55
		neutrals    = 0.04
		neutralvars = 0.10
	end

	return {
		primary        = Color3.fromHSV(h, primarys, primaryv),
		secondary      = Color3.fromHSV(h, clamp(secondarys, 0.12, 0.55), clamp(primaryv * 0.92, 0.45, 0.90)),
		tertiary       = Color3.fromHSV(rotatehue(h, tertiaryoffset), clamp(tertiarys, 0.25, 0.75), clamp(primaryv * 0.95, 0.50, 0.92)),
		neutral        = Color3.fromHSV(h, neutrals, clamp(primaryv * 0.85, 0.40, 0.88)),
		neutralvariant = Color3.fromHSV(h, neutralvars, clamp(primaryv * 0.82, 0.38, 0.86)),
	}
end

function m3e.makescheme(source: Color3, isdark: boolean?, variant: string?)
	isdark = isdark or false
	local keys = m3e.fromsource(source, variant)

	local vars = {}

	if isdark then
		vars.primary              = keys.primary:Lerp(Color3.new(1,1,1), 0.25)
		vars.onprimary            = Color3.fromRGB(28, 27, 31)
		vars.primarycontainer     = keys.primary:Lerp(Color3.new(0,0,0), 0.55)
		vars.onprimarycontainer   = keys.primary:Lerp(Color3.new(1,1,1), 0.85)

		vars.secondary            = keys.secondary:Lerp(Color3.new(1,1,1), 0.30)
		vars.onsecondary          = Color3.fromRGB(28, 27, 31)
		vars.secondarycontainer   = keys.secondary:Lerp(Color3.new(0,0,0), 0.50)
		vars.onsecondarycontainer = keys.secondary:Lerp(Color3.new(1,1,1), 0.80)

		vars.tertiary             = keys.tertiary:Lerp(Color3.new(1,1,1), 0.28)
		vars.ontertiary           = Color3.fromRGB(28, 27, 31)
		vars.tertiarycontainer    = keys.tertiary:Lerp(Color3.new(0,0,0), 0.52)
		vars.ontertiarycontainer  = keys.tertiary:Lerp(Color3.new(1,1,1), 0.82)

		vars.surface              = Color3.fromRGB(18, 18, 22)
		vars.onsurface            = Color3.fromRGB(230, 225, 230)
		vars.onsurfacevariant     = Color3.fromRGB(180, 175, 185)

		vars.surfacecontainerlowest  = Color3.fromRGB(12, 12, 16)
		vars.surfacecontainerlow     = Color3.fromRGB(22, 22, 26)
		vars.surfacecontainer        = Color3.fromRGB(28, 27, 32)
		vars.surfacecontainerhigh    = Color3.fromRGB(35, 34, 40)
		vars.surfacecontainerhighest = Color3.fromRGB(42, 41, 48)

		vars.surfacedim           = Color3.fromRGB(16, 16, 20)
		vars.surfacebright        = Color3.fromRGB(45, 44, 50)

		vars.outline              = Color3.fromRGB(120, 115, 125)
		vars.outlinevariant       = Color3.fromRGB(70, 68, 75)
		vars.shadow               = Color3.new(0, 0, 0)
		vars.scrim                = Color3.new(0, 0, 0)
		vars.inversesurface       = Color3.fromRGB(230, 225, 230)
		vars.inverseonsurface     = Color3.fromRGB(45, 44, 50)
		vars.inverseprimary       = keys.primary:Lerp(Color3.new(0,0,0), 0.25)

		vars.error                = Color3.fromRGB(242, 184, 181)
		vars.onerror              = Color3.fromRGB(96, 20, 16)
		vars.errorcontainer       = Color3.fromRGB(140, 29, 24)
		vars.onerrorcontainer     = Color3.fromRGB(249, 222, 220)
	else
		vars.primary              = keys.primary
		vars.onprimary            = Color3.new(1, 1, 1)
		vars.primarycontainer     = keys.primary:Lerp(Color3.new(1,1,1), 0.78)
		vars.onprimarycontainer   = keys.primary:Lerp(Color3.new(0,0,0), 0.65)

		vars.secondary            = keys.secondary
		vars.onsecondary          = Color3.new(1, 1, 1)
		vars.secondarycontainer   = keys.secondary:Lerp(Color3.new(1,1,1), 0.80)
		vars.onsecondarycontainer = keys.secondary:Lerp(Color3.new(0,0,0), 0.60)

		vars.tertiary             = keys.tertiary
		vars.ontertiary           = Color3.new(1, 1, 1)
		vars.tertiarycontainer    = keys.tertiary:Lerp(Color3.new(1,1,1), 0.78)
		vars.ontertiarycontainer  = keys.tertiary:Lerp(Color3.new(0,0,0), 0.62)

		vars.surface              = Color3.fromRGB(255, 251, 255)
		vars.onsurface            = Color3.fromRGB(28, 27, 31)
		vars.onsurfacevariant     = Color3.fromRGB(75, 70, 80)

		vars.surfacecontainerlowest  = Color3.fromRGB(255, 255, 255)
		vars.surfacecontainerlow     = Color3.fromRGB(250, 246, 252)
		vars.surfacecontainer        = Color3.fromRGB(245, 240, 247)
		vars.surfacecontainerhigh    = Color3.fromRGB(238, 232, 242)
		vars.surfacecontainerhighest = Color3.fromRGB(230, 224, 235)

		vars.surfacedim           = Color3.fromRGB(220, 215, 225)
		vars.surfacebright        = Color3.fromRGB(255, 251, 255)

		vars.outline              = Color3.fromRGB(120, 115, 125)
		vars.outlinevariant       = Color3.fromRGB(195, 190, 200)
		vars.shadow               = Color3.new(0, 0, 0)
		vars.scrim                = Color3.new(0, 0, 0)
		vars.inversesurface       = Color3.fromRGB(45, 44, 50)
		vars.inverseonsurface     = Color3.fromRGB(230, 225, 230)
		vars.inverseprimary       = keys.primary:Lerp(Color3.new(1,1,1), 0.25)

		vars.error                = Color3.fromRGB(179, 38, 30)
		vars.onerror              = Color3.new(1, 1, 1)
		vars.errorcontainer       = Color3.fromRGB(249, 222, 220)
		vars.onerrorcontainer     = Color3.fromRGB(65, 14, 11)
	end
	vars.key = keys
	return vars
end

function m3e.get(source: Color3, isdark: boolean?, variant: string?)
	return m3e.makescheme(source, isdark, variant)
end

function cornertab(type_)
	if type_=="top"then
		local s=Instance.new("UICorner")
		s.Name="corner"
		s.CornerRadius=UDim.new(0,0)
		s.TopLeftRadius=UDim.new(0,15)
		s.TopRightRadius=UDim.new(0,15)
		s.BottomLeftRadius=UDim.new(0,5)
		s.BottomRightRadius=UDim.new(0,5)
		return s
	elseif type_=="mid"then
		local s=Instance.new("UICorner")
		s.Name="corner"
		s.CornerRadius=UDim.new(0,5)
		return s
	elseif type_=="bot"then
		local s=Instance.new("UICorner")
		s.Name="corner"
		s.CornerRadius=UDim.new(0,0)
		s.TopLeftRadius=UDim.new(0,5)
		s.TopRightRadius=UDim.new(0,5)
		s.BottomLeftRadius=UDim.new(0,15)
		s.BottomRightRadius=UDim.new(0,15)
		return s
	end
end

function lib.init()
	local toret1={}
	local ui=Instance.new("ScreenGui",gui)

	function toret1.window(name,shortcut,scl)
		local toret2={}
		local uiclrset=if typeof(scl)=="Color3"then m3e.makescheme(scl,true) else m3e.makescheme(Color3.fromRGB(86, 129, 91),true)
		local window=Instance.new("Frame",ui)
		window.BackgroundColor3=Color3.new(0,0,0)
		window.Size=UDim2.fromScale(1,1)
		window.BackgroundTransparency=.25
		local modalw=Instance.new("TextButton",window)
		modalw.Size=UDim2.new(0,0,0,0)
		modalw.BackgroundTransparency=1
		modalw.Text=""
		modalw.Modal=true

		local wgrad=Instance.new("UIGradient",window)
		wgrad.Transparency=NumberSequence.new(10,0)
		wgrad.Rotation=90

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
			local amtofstuff=0
			local minimized=false

			local tab=Instance.new("Frame",window)
			tab.Size=UDim2.fromOffset(200,50)
			tab.Position=UDim2.fromOffset(amtoftabs*200+10,50)
			tab.BackgroundColor3=uiclrset.primary
			cornertab("top").Parent=tab
			local UIDragger=Instance.new("UIDragDetector",tab)
			UIDragger.CursorIcon="rbxasset://textures/cursors/KeyboardMouse/ArrowFarCursor.png"
			UIDragger.ActivatedCursorIcon="rbxasset://textures/cursors/KeyboardMouse/ArrowFarCursor.png"
			local List=Instance.new("UIListLayout",tab)
			List.SortOrder=Enum.SortOrder.LayoutOrder
			List.Padding=UDim.new(0,5)
			local tframe=Instance.new("Frame",tab)
			tframe.BackgroundTransparency=1
			tframe.Size=UDim2.fromScale(1,1)
			local logo1=Instance.new("TextLabel",tframe)
			logo1.BackgroundTransparency=1
			logo1.Size=UDim2.fromScale(.6,.9)
			logo1.Position=UDim2.fromScale(.05,.5)
			logo1.AnchorPoint=Vector2.new(0,.5)
			logo1.TextColor3=Color3.new(1,1,1)
			logo1.TextSize=12
			logo1.Text=name2 or "tab"
			tframe.Name=tostring(amtofstuff)
			local minimize=Instance.new("TextButton",tframe)
			minimize.Size=UDim2.fromOffset(30,30)
			minimize.Position=UDim2.fromScale(.95,.5)
			minimize.AnchorPoint=Vector2.new(1,.5)
			minimize.BackgroundColor3=uiclrset.tertiary
			minimize.TextColor3=Color3.new(1,1,1)
			minimize.TextScaled=true
			minimize.AutoButtonColor=false
			cornertab("mid").Parent=minimize
			minimize.Text="-"
			minimize.MouseEnter:Connect(function()
				tween(minimize,TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{BackgroundColor3=uiclrset.ontertiary})
			end)
			minimize.MouseLeave:Connect(function()
				tween(minimize,TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{BackgroundColor3=uiclrset.tertiary})
			end)

			minimize.MouseButton1Click:Connect(function()
				if minimized then
					for i=amtofstuff,1,-1 do
						tween(tab[tostring(i)].scale,TweenInfo.new(.125,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1})
						task.wait(.1)
					end
					minimized=false
				else
					for i=amtofstuff,1,-1 do
						tween(tab[tostring(i)].scale,TweenInfo.new(.125,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0})
						task.wait(.075)
					end	
					minimized=true
				end
			end)

			amtoftabs+=1

			function toret3.button(name3)
				local toret4={}

				local button=Instance.new("TextButton",tab)
				button.BackgroundColor3=uiclrset.secondary
				button.TextSize=12
				button.Size=UDim2.fromScale(1,1)
				button.Text=name3 or "button"
				button.TextColor3=Color3.new(1,1,1)
				button.Modal=true
				Instance.new("UIScale",button).Name="scale"
				if amtofstuff~=0 then
					tab[tostring(amtofstuff)].corner:Destroy()
					cornertab("mid").Parent=tab[tostring(amtofstuff)]
				end
				amtofstuff+=1
				button.Name=tostring(amtofstuff)
				cornertab("bot").Parent=button
				if minimized then
					button.scale.Scale=0
				else
					button.scale.Scale=0
					tween(button.scale,TweenInfo.new(.125,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1})
				end
				button.MouseEnter:Connect(function()
					tween(button,TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{BackgroundColor3=uiclrset.onsecondary})
				end)
				button.MouseLeave:Connect(function()
					tween(button,TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{BackgroundColor3=uiclrset.secondary})
				end)
				button.AutoButtonColor=false
				toret4.clicked=button.MouseButton1Click
				toret4.instance=button

				return toret4
			end
			function toret3.toggle(name3)
				local toret4={}
				
				toret4.state=false
				toret4.changed=lib.newevent()
				local button=Instance.new("TextButton",tab)
				button.BackgroundColor3=uiclrset.tertiary
				button.TextSize=12
				button.Size=UDim2.fromScale(1,1)
				button.Text=name3 or "button"
				button.TextColor3=Color3.new(1,1,1)
				button.Modal=true
				Instance.new("UIScale",button).Name="scale"
				if amtofstuff~=0 then
					tab[tostring(amtofstuff)].corner:Destroy()
					cornertab("mid").Parent=tab[tostring(amtofstuff)]
				end
				amtofstuff+=1
				button.Name=tostring(amtofstuff)
				cornertab("bot").Parent=button
				if minimized then
					button.scale.Scale=0
				else
					button.scale.Scale=0
					tween(button.scale,TweenInfo.new(.125,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1})
				end
				local function updateClr()
					local onoff={["false"]=uiclrset.tertiary,["true"]=uiclrset.tertiarycontainer}
					tween(button,TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{BackgroundColor3=onoff[tostring(toret4.state)]})
				end
				button.MouseEnter:Connect(function()
					tween(button,TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{BackgroundColor3=uiclrset.ontertiary})
				end)
				button.MouseLeave:Connect(function()
					local onoff={["false"]=uiclrset.tertiary,["true"]=uiclrset.tertiarycontainer}
					tween(button,TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{BackgroundColor3=onoff[tostring(toret4.state)]})
				end)
				button.MouseButton1Click:Connect(function()
					if toret4.state then
						toret4.state=false
					else
						toret4.state=true
					end
					toret4.changed:fire(toret4.state)
					updateClr()
				end)
				button.AutoButtonColor=false
				toret4.instance=button

				return toret4
			end
			function toret3.label(text1)
				local toret4={}
				local button=Instance.new("TextLabel",tab)
				button.BackgroundColor3=uiclrset.key.neutralvariant
				button.TextSize=12
				if amtofstuff~=0 then
					tab[tostring(amtofstuff)].corner:Destroy()
					cornertab("mid").Parent=tab[tostring(amtofstuff)]
				end
				amtofstuff+=1
				button.Name=tostring(amtofstuff)
				cornertab("bot").Parent=button
				button.Size=UDim2.fromScale(1,1)
				button.TextColor3=Color3.new(1,1,1)
				button.Text=text1 or "label"
				Instance.new("UIScale",button).Name="scale"
				if minimized then
					button.scale.Scale=0
				else
					button.scale.Scale=0
					tween(button.scale,TweenInfo.new(.125,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1})
				end
				toret4.instance=button
				return toret4
			end

			return toret3
		end
		return toret2
	end    
	return toret1
end

function lib.newevent()
	local funcs = {}
	local funcToCall = {}
	local funcadd = 1

	function funcs:connect(func)
		local address = tostring(funcadd)
		funcToCall[address] = func
		funcadd += 1

		return {
			Disconnect = function()
				funcToCall[address] = nil
			end
		}
	end

	function funcs:once(func)
		local connection
		connection = funcs:Connect(function(...)
			connection:Disconnect()
			func(...)
		end)
		return connection
	end

	function funcs:fire(...)
		for _, functionn in funcToCall do
			if functionn then
				local s, e = pcall(functionn, ...)
				if not s then
					warn("eventpp call fail: " .. tostring(e))
				end
			end
		end
	end

	function funcs:disconnectall()
		funcToCall = {}
	end

	function funcs:destroy()
		funcToCall = {}
		funcs = nil
	end

	return funcs
end

return lib
-- ignore i needed ts for github steak
