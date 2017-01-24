
dc_fnc_crosshair = {
	if (hasInterface && isNil {dc_ev_crosshair}) then {
		_crossHairImages = [
			"\a3\ui_f\data\IGUI\Cfg\Cursors\weapon_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\CrewAimIndicator\gunner_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\CrewAimIndicator\gunnerReady_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\Cursors\selectOver_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\Cursors\watch_ca.paa"
		];

		dc_var_crosshairImage = _crossHairImages select 0;
		dc_var_crosshairScale = 2;
		
		_briefingText = "
			<execute expression=""dc_var_crosshairScale=1.25"">Use Smaller Crosshair</execute><br/>
			<execute expression=""dc_var_crosshairScale=2"">Use Normal Crosshair</execute><br/>
			<execute expression=""dc_var_crosshairScale=3"">Use Larger Crosshair</execute><br/>
		";
		
		{
			_briefingText = _briefingText + format ["<br/><img image=""%1"" width=30 height=30/> <execute expression=""dc_var_crosshairImage='%1'""> Use this crosshair</execute>",_x];
		} forEach _crossHairImages;

		player createDiaryRecord ["diary",["FA Crosshair",_briefingText]];
		
		dc_ev_crosshair = addMissionEventHandler ["draw3D",{
			_showCrosshair = false;
			{
				if ([_x,animationState player] call BIS_fnc_inString) exitWith {_showCrosshair = true};
			} forEach [
				"MstpSrasW",
				"MtacSrasW",
				"MwlkSrasW",
				"MlmpSrasW",
				"aim",
				"bipod"
			];
			if (alive player && cameraView in ["INTERNAL","EXTERNAL"] && _showCrosshair && difficultyOption "weaponCrosshair" == 0) then {
		 
				_posLaser = [0,0,0];
				_right = [0,0,0];
				_up = [0,0,0];
				_forward = [0,0,0];
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
		 


				_posXhair = _posLaser vectorAdd (_forward vectorMultiply 15);
				_hitLaser = lineIntersectsSurfaces [_posLaser, _posXhair, player];
				if (count _hitLaser > 0) then
				{
					_arXhair = ASLToAGL ((_hitLaser select 0) select 0);
					_dist = ASLToAGL _posLaser distance _arxHair;
					_alphaMod = 1 min (1 - (_dist - 5)/10);
					_scaleMod = .7 + ((_dist min 5) / 16.7);
					drawIcon3D [dc_var_crosshairImage, [1, 1, 1, .9 * _alphaMod], _arXhair, _scaleMod*dc_var_crosshairScale, _scaleMod*dc_var_crosshairScale, 0];
				};

			};
		}];
	};
};

if (isServer) then {
	publicVariable "dc_fnc_crosshair";
	remoteExec ["dc_fnc_crosshair",0,true];
} else {
	call dc_fnc_crosshair;
};
