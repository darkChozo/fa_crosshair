# FA Crosshair
FA Crosshair is a crosshair mod designed for the Folk ARPS ARMA 3 community. The mod is intended to provide a happy medium between the crosshair and no-crosshair lifestyles, ending a yearslong server settings debate.

The FA crosshair acts as a normal crosshair below 10m. Beyond that point, it slowly fades, disappearing completely at 15m. This lets you check weapon clearance and hipfire at short range, without giving you a magical floating weapons sight at longer ranges.

FA Crosshair can be run as as a serverside mod, as a clientside mod, or as both. This means that it can be used in modless or mod-optional communities. In addition, the crosshair is configurable in-game, with the option of several crosshair styles and sizes.

Note that FA Crosshair will only work if the default crosshair is disabled in the difficulty settings.

## Configuring FA Crosshair
When playing a mission with FA Crosshair running (either on the server on on the client), there will be a menu in the briefing titled "FA Crosshair" (appropriately enough). This menu lets you adjust the crosshair size and type. Settings are saved to profileNamespace, meaning that they will persist across servers and play sessions.

If the default options aren't enough, they can also be set programmatically. The mod exposes settings functions that can be used to set settings to precise values. This also opens up the option for custom crosshairs.

    //default scale ranges from .75 to 4
    2 call dc_fac_fnc_setCrosshairScale;
    
    // image can be in an arma addon (ie. 'a3\addon\data\image.paa'), or an absolute path
    // image must be in the paa or jpg file formats
    'path\to\image' call dc_fac_fnc_setCrosshairImage;
    