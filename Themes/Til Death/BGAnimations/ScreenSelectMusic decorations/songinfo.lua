local update = false
local t = Def.ActorFrame{
	BeginCommand=cmd(queuecommand,"Set";xy,0,-500),
	OffCommand=cmd(bouncy,0.32;xy,-100,0;diffusealpha,0),
	OnCommand=cmd(bouncy,0.32;xy,0,0;diffusealpha,1),
	SetCommand=function(self)
		self:finishtweening()
		if getTabIndex() == 0 then
			self:queuecommand("On");
			update = true
		else 
			self:queuecommand("Off");
			update = false
		end;
	end;
	TabChangedMessageCommand=cmd(queuecommand,"Set");
	PlayerJoinedMessageCommand=cmd(queuecommand,"Set");
};


t[#t+1] = Def.Banner{
	InitCommand=cmd(x,10;y,61;halign,0;valign,0);
	SetMessageCommand=function(self)
		if update then
			local top = SCREENMAN:GetTopScreen()
			if top:GetName() == "ScreenSelectMusic" or top:GetName() == "ScreenNetSelectMusic" then
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				local group = top:GetMusicWheel():GetSelectedSection()
				if song then
					self:LoadFromSong(song)
				elseif course then
					self:LoadFromCourse(song)
				elseif group then
					self:LoadFromSongGroup(group)
				end;
			end;
		end;
		self:scaletoclipped(capWideScale(get43size(384),384),capWideScale(get43size(120),120))
	end;
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
};

return t