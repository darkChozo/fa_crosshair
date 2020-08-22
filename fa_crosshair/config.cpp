class CfgPatches 
{
	class FA_crosshair
	{
		name = "FA Crosshair";
		author[] = {"Ciaran","darkChozo"};
		authorUrl = "folkarps.com";
		units[] = {};
		weapons[] = {};
	};
};

class CfgFunctions
{
	class FA_crosshair
	{
		class functions
		{
			class Init { 
				postInit=1;
				file = "\FA_crosshair\init.sqf";
			};
		};
	};
};
