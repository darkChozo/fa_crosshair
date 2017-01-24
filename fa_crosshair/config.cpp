class CfgPatches 
{
	class FA_crosshair
	{
		units[] = {};
		weapons[] = {};
		author[] = {"Ciaran","darkChozo"};
		authorUrl = "folkarps.com";
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
