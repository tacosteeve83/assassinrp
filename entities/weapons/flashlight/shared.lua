if (SERVER) then

AddCSLuaFile ("shared.lua");

SWEP.HoldType= "flashlight"
SWEP.AutoSwitchTo = false; 
SWEP.AutoSwitchFrom = false;
end
	
if ( CLIENT ) then

SWEP.PrintName = "Flashlight";
SWEP.Slot = 1;
SWEP.SlotPos = 7;
SWEP.DrawAmmo = false; 
SWEP.DrawCrosshair = false;  
end

SWEP.Author = "-=Assassin=-"; 
SWEP.Contact = ""; 
SWEP.Purpose = "Assists in seeing things";
SWEP.Instructions = "Left click to turn on/off";

SWEP.Spawnable = false; 
SWEP.AdminSpawnable = true;

SWEP.ViewModel = "models/weapons/v_flashlight_on.mdl";
SWEP.WorldModel = "models/weapons/w_fists.mdl";

SWEP.Primary.ClipSize = -1; 
SWEP.Primary.DefaultClip = -1; 
SWEP.Primary.Automatic = false; 
SWEP.Primary.Ammo = "none"; 

SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1; 
SWEP.Secondary.Automatic = false; 
SWEP.Secondary.Ammo = "none";

SWEP.IsOn = false
	
function SWEP:Reload() 
 end

function SWEP:Holster( wep )
	if(SERVER) then
	    self.IsOn = false
		self.Owner:Flashlight(false)
		end
	return true
	end
	
function SWEP:PrimaryAttack()
	if (SERVER) then
	    self.IsOn = !self.IsOn
	    self.Owner:Flashlight(self.IsOn) 
    end
end

function SWEP:SecondaryAttack()
end

SWEP.BatteryDrainer = nil
SWEP.Charger = nil

SWEP.MaxEnergy = 100
SWEP.MinEnergy = 0

SWEP.AmmoString = "flashlight_energy"

if(CLIENT) then
	function SWEP:CustomAmmoDisplay()
		self.AmmoDisplay = self.AmmoDisplay or {}

		self.AmmoDisplay.Draw = true
	
		self.AmmoDisplay.PrimaryClip = self:Ammo1() or 0
		self.AmmoDisplay.PrimaryAmmo = -1
		self.AmmoDisplay.SecondaryAmmo = -1

		return 	self.AmmoDisplay
	end
end

function SWEP:Initialize()
	if(CLIENT) then return end

	self:GivePrimaryAmmo(self.MaxEnergy)
end
	
function SWEP:Ammo1()
	return self.Weapon:GetNetworkedInt(self.AmmoString)
end

function SWEP:TakePrimaryAmmo(num)
	if(self:Ammo1() <= self.MinEnergy) then
		self.Weapon:SetNetworkedInt(self.AmmoString, self.MinEnergy)
		return
	end

	self.Weapon:SetNetworkedInt(self.AmmoString, math.Clamp(self:Ammo1() - num, self.MinEnergy, 

self.MaxEnergy))
end

function SWEP:GivePrimaryAmmo(num)
	if(self:Ammo1() >= self.MaxEnergy) then return end

	self.Weapon:SetNetworkedInt(self.AmmoString, math.Clamp(self:Ammo1() + num, self.MinEnergy, 

self.MaxEnergy))
end