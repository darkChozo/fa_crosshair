/*
 *  FA Crosshair
 *
 *  Thanks to Ciaran for the initial code injection and Folk ARPS for being Folk ARPS.
 *  Code currently maintained by darkChozo - https://github.com/darkChozo/fa_crosshair
 */

dc_fac_fnc_crosshairInit = {
	if (hasInterface && isNil {dc_fac_ev_crosshair}) then {
		/******** Settings ********/
		
		_briefingText = "";

		
		
		// Enable/disable crosshair
		dc_fac_fnc_crosshairEnable = {
			if (!params [["_chBool",true,[true]]]) exitWith {systemChat "dc_fac_fnc_crosshairEnable: bad arguments"};
			params ["_chBool"];
			profileNamespace setVariable ['dc_fac_var_crosshairEnable',_chBool];
			saveProfileNamespace;
		};

		if (isNil {profileNamespace getVariable "dc_fac_var_crosshairEnable"}) then {
			profileNamespace setVariable ['dc_fac_var_crosshairEnable',true];
			saveProfileNamespace;
		};
		
		_briefingText = _briefingText + format ["
Enable crosshair? <execute expression=""true call dc_fac_fnc_crosshairEnable"">ON</execute>/<execute expression=""false call dc_fac_fnc_crosshairEnable"">OFF</execute><br/>"];



		// Display crosshair at range?
		dc_fac_fnc_crosshairRange = {
			params ["_chBool"];
			profileNamespace setVariable ['dc_fac_var_crosshairRange',_chBool];
			saveProfileNamespace;
		};

		if (isNil {profileNamespace getVariable "dc_fac_var_crosshairRange"}) then {
			true call dc_fac_fnc_crosshairRange;
		};
		
		_briefingText = _briefingText + format ["
Display crosshair at long range? <execute expression=""true call dc_fac_fnc_crosshairRange"">YES</execute>/<execute expression=""false call dc_fac_fnc_crosshairRange"">NO</execute><br/><br/>"];



		// Crosshair size
		dc_fac_fnc_setCrosshairScale = {
			if (!params [["_scale",2,[2]]]) exitWith {systemChat "dc_fac_var_crosshairScale: bad arguments"};
			profileNamespace setVariable ["dc_fac_var_crosshairScale",_scale];
			saveProfileNamespace;
		};

		if (isNil {profileNamespace getVariable "dc_fac_var_crosshairScale"}) then {
			2 call dc_fac_fnc_setCrosshairScale;
		};

		_briefingText = _briefingText + "Crosshair size:";
		{
			_briefingText = format ["%1 <execute expression=""%2 call dc_fac_fnc_setCrosshairScale;"">%3</execute> •",_briefingText,_x select 1,_x select 0];
		} forEach [["Smallest",.75],
				   ["Smaller",1.25],
				   ["Normal",2],
				   ["Larger",3],
				   ["Giant",4]];
		_briefingText = [_briefingText,0,-1] call BIS_fnc_trimString;
		
		
		
		// Crosshair alpha/transparency
		dc_fac_fnc_setCrosshairAlpha = {
			if (!params [["_alpha",2,[2]]]) exitWith {systemChat "dc_fac_var_crosshairAlpha: bad arguments"};
			profileNamespace setVariable ["dc_fac_var_crosshairAlpha",_alpha];
			saveProfileNamespace;
		};

		if (isNil {profileNamespace getVariable "dc_fac_var_crosshairAlpha"}) then {
			.75 call dc_fac_fnc_setCrosshairAlpha;
		};

		_briefingText = _briefingText + "<br/>Crosshair transparency:";
		{
			_briefingText = format ["%1 <execute expression=""%2 call dc_fac_fnc_setCrosshairAlpha;"">%3</execute> •",_briefingText,_x select 1,_x select 0];
		} forEach [["High",.3],
				   ["Medium",.55],
				   ["Low",.75],
				   ["None",1]];
		_briefingText = [_briefingText,0,-1] call BIS_fnc_trimString;
		
		
		
		// Crosshair color
		_crossHairColors = [
			["White",[1,1,1]],
			["Red",[1,0,0]],
			["Green",[0,1,0]],
			["Blue",[0,0,1]],
			["Yellow",[1,1,0]],
			["Purple",[1,0,1]]
		];

		// this one takes [[1,1,1]] because params
		dc_fac_fnc_setCrosshairColor = {
			if (!params [["_color",2,[[1,1,1]]]]) exitWith {systemChat "dc_fac_var_crosshairColor: bad arguments"};
			profileNamespace setVariable ["dc_fac_var_crosshairColor",_color];
			saveProfileNamespace;
		};

		if (isNil {profileNamespace getVariable "dc_fac_var_crosshairColor"}) then {
			[_crossHairColors select 0 select 1] call dc_fac_fnc_setCrosshairColor;
		};

		_briefingText = _briefingText + "<br/>Crosshair color:";
		{
			_briefingText = format ["%1 <execute expression=""[%2] call dc_fac_fnc_setCrosshairColor;"">%3</execute> •",_briefingText,_x select 1,_x select 0];
		} forEach _crossHairColors;
		_briefingText = [_briefingText,0,-1] call BIS_fnc_trimString;



		// Crosshair type/image
		_crossHairImages = [
			"\a3\ui_f\data\IGUI\Cfg\Cursors\weapon_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\CrewAimIndicator\gunner_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\WeaponCursors\coil_gs.paa",
			"\a3\ui_f\data\IGUI\Cfg\CrewAimIndicator\gunnerReady_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\Cursors\selectOver_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\Cursors\watch_ca.paa"
		];

		dc_fac_fnc_setCrosshairImage = {
			if (!params [["_image","",[""]]]) exitWith {systemChat "dc_fac_fnc_setCrosshairImage: bad arguments"};
			profileNamespace setVariable ["dc_fac_var_crosshairImage",_image];
			saveProfileNamespace;
		};

		if (isNil {profileNamespace getVariable "dc_fac_var_crosshairImage"}) then {
			_crossHairImages select 0 call dc_fac_fnc_setCrosshairImage;
		};

		_briefingText = _briefingText + "<br/>";
		{
			_briefingText = _briefingText + format ["<br/><img image=""%1"" width=30 height=30/> <execute expression=""'%1' call dc_fac_fnc_setCrosshairImage""> Use this crosshair</execute>",_x];
		} forEach _crossHairImages;


		// create settings briefing menu
		player createDiaryRecord ["diary",["FA Crosshair",_briefingText]];

		// mostly for debug
		dc_fac_fnc_clearSettings = {
			{
				profileNamespace setVariable [_x,nil];
			} forEach ['dc_fac_var_crosshairEnable','dc_fac_var_crosshairRange','dc_fac_var_crosshairScale','dc_fac_var_crosshairAlpha','dc_fac_var_crosshairColor','dc_fac_var_crosshairImage'];
			saveProfileNamespace;
		};


		/******** Event Handler ********/
		dc_fac_ev_crosshair = addMissionEventHandler ["draw3D",{
			// First thing to do is to check server has vanilla crosshair off, there's no point running any other checks until this is determined
			if (difficultyOption "weaponCrosshair" == 0) then {
				_showCrosshair = false;

				// Should crosshair be shown for animation? Animations in order: stopped, tactical pace, walking, deployed, FFV, limping, diving, bottom diving, surface diving
				{
					if ([_x,animationState player] call BIS_fnc_inString) exitWith {_showCrosshair = true};
				} forEach [
					"MstpSrasW",
					"MtacSrasW",
					"MwlkSrasW",
					"bipod",
					"aim",
					"MlmpSrasW",
					"AdvePercMstpSnonWrfl",
					"AbdvPercMstpSnonWrfl",
					"AsdvPercMstpSnonWrfl"
				];

				// Only show crosshair if player alive, player not aiming down sights, animation correct and player has crosshair enabled
				if (alive player && cameraView in ["INTERNAL","EXTERNAL"] && _showCrosshair && profileNamespace getVariable "dc_fac_var_crosshairEnable") then {
					_posLaser = [0,0,0];
					_right = [0,0,0];
					_up = [0,0,0];
					_forward = [0,0,0];

					// To estimate muzzle position, primary weapons (rifles) use the Weapon mempoint, pistols + launchers use RightHand mempoint.
					// Weapon is more accurate but only tracks the primary weapon.
					if (currentWeapon player == primaryWeapon player) then {
						_posLaser = AGLToASL (player modelToWorld (player selectionPosition "Weapon"));

						_right = _posLaser vectorFromTo AGLToASL (player modelToWorld (player selectionPosition "RightHand"));
						_forward = player weaponDirection currentWeapon player;
						_up = _right vectorCrossProduct _forward;
						_right = _forward vectorCrossProduct _up;
					} else {
						_posLaser = AGLToASL (player modelToWorld (player selectionPosition "RightHand"));

						_right = AGLToASL (player modelToWorld (player selectionPosition "LeftShoulder")) vectorFromTo AGLToASL (player modelToWorld (player selectionPosition "RightShoulder"));
						_forward = player weaponDirection currentWeapon player;
						_up = _right vectorCrossProduct _forward;
						_right = _forward vectorCrossProduct _up;
					};

					// Calculate muzzle offset based on weapon type.
					{
						switch (currentWeapon player) do {
							case (handgunWeapon player) : {
								_posLaser = _posLaser vectorAdd (_x vectorMultiply ([-.018, .05, .023] select _forEachIndex));
							};
							case (secondaryWeapon player) : {
								_posLaser = _posLaser vectorAdd (_x vectorMultiply ([-0.118, 0.2, .025] select _forEachIndex));
							};
							case (primaryWeapon player) : {
								_posLaser = _posLaser vectorAdd (_x vectorMultiply ([0.67, 0.77, 0.035] select _forEachIndex));
							};
						};
					} forEach [_right, _forward, _up];


					// Raycast collision check; up to 15m
					_posXhair = _posLaser vectorAdd (_forward vectorMultiply 15);
					_hitLaser = lineIntersectsSurfaces [_posLaser, _posXhair, player];

					if (profileNamespace getVariable "dc_fac_var_crosshairRange") then {
						_arXhair = ASLToAGL _posXhair;
						if (count _hitLaser > 0) then {
							// If there's a hit, display crosshair at hit, otherwise just at "far"
							_arXhair = ASLToAGL ((_hitLaser select 0) select 0);
						};
						_dist = ASLToAGL _posLaser distance _arXhair;
						_scaleMod = .7 + ((_dist min 5)^2 / 83); // from 5m, scales down to 70% quadratically at 0m.
						drawIcon3D [profileNamespace getVariable "dc_fac_var_crosshairImage",
									(profileNamespace getVariable "dc_fac_var_crosshairColor") + [profileNamespace getVariable "dc_fac_var_crosshairAlpha"],
									_arXhair,
									_scaleMod*(profileNamespace getVariable "dc_fac_var_crosshairScale"),
									_scaleMod*(profileNamespace getVariable "dc_fac_var_crosshairScale"),
									0];
					} else {
						if (count _hitLaser > 0) then {
							// If there's a hit, display crosshair,
							_arXhair = ASLToAGL ((_hitLaser select 0) select 0);
							_dist = ASLToAGL _posLaser distance _arXhair;
							_alphaMod = 1 min (1 - (_dist - 5)/10);  // full alpha at <10m, decays linerally to 0 between 10-15m
							_scaleMod = .7 + ((_dist min 5)^2 / 83); // from 5m, scales down to 70% quadratically at 0m.
							drawIcon3D [profileNamespace getVariable "dc_fac_var_crosshairImage",
										(profileNamespace getVariable "dc_fac_var_crosshairColor") + [_alphaMod * (profileNamespace getVariable "dc_fac_var_crosshairAlpha")],
										_arXhair,
										_scaleMod*(profileNamespace getVariable "dc_fac_var_crosshairScale"),
										_scaleMod*(profileNamespace getVariable "dc_fac_var_crosshairScale"),
										0];
						};
					};
				};
			};
		}];
	};
};

if (isServer) then {
	publicVariable "dc_fac_fnc_crosshairInit";
	remoteExec ["dc_fac_fnc_crosshairInit",0,true];
} else {
	call dc_fac_fnc_crosshairInit;
};
