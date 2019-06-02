private ["_unit","_enemigos"];

_unit = _this select 0;

_unit setSkill 0;

_unit disableAI "TARGET";
_unit disableAI "AUTOTARGET";
//Stops civilians from shouting out commands.
[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];

_unit addEventHandler ["HandleDamage",
	{
	_dam = _this select 2;
	_proy = _this select 4;
	if (_proy == "") then
		{
		_injurer = _this select 3;
		if ((_dam > 0.95) and (!isPlayer _injurer)) then {_dam = 0.9};
		};
	_dam
	}
	];
_EHkilledIdx = _unit addEventHandler ["killed",
	{
	_muerto = _this select 0;
	_killer = _this select 1;
	if (_muerto == _killer) then
		{
		_nul = [-1,-1,getPos _muerto] remoteExec ["A3A_fnc_citySupportChange",2];
		}
	else
		{
      if (isPlayer _killer) then {
      _profit = 20 / ({side _x == buenos} count (call BIS_fnc_listPlayers));
			_nul = [0,_profit] remoteExec ["A3A_fnc_resourcesFIA",2];
			_killer addRating 1000;
			};
      _multiplicador = 1;
      if (typeOf _muerto == "C_journalist_F") then {_multiplicador = 10};
      if (side _killer == buenos) then
        {
        _nul = [1*_multiplicador,0] remoteExec ["A3A_fnc_prestige",2];
        _nul = [1,0,getPos _muerto] remoteExec ["A3A_fnc_citySupportChange",2];
        }
      else
        {
        if (side _killer == malos) then
        {
          //_nul = [-1*_multiplicador,0] remoteExec ["A3A_fnc_prestige",2];
          _nul = [0,1,getPos _muerto] remoteExec ["A3A_fnc_citySupportChange",2];
        }
        else
        {
          if (side _killer == muyMalos) then
          {
            //_nul = [2*_multiplicador,0] remoteExec ["A3A_fnc_prestige",2];
            _nul = [-1,1,getPos _muerto] remoteExec ["A3A_fnc_citySupportChange",2];
          };
        };
      };
		};
	}
	];
