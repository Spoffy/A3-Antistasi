params ["_location"];

if (isNil "_location") then { false; } else {

private _pos = if (_location in marcadores) then
               {
                 getMarkerPos _location;
               }
               else
               {
                 getPos _location;
               };

private _posbase = getMarkerPos respawnBuenos;

private _validSide = if (_location in bancos) then
                     {
                       private _city = [ciudades, _pos] call BIS_fnc_nearestPosition;
                       lados getVariable [_city,sideUnknown] != buenos;
                     }
                     else
                     {
                       lados getVariable [_location,sideUnknown] != buenos;
                     };
                    

private _validDistance = _pos distance _posbase < distanciaMiss;
private _validPrestigeOrSameIsland = {
  if (_location in ciudades) then
  {
    _data = server getVariable _location;
    _prestigeOPFOR = _data select 2;
    _prestigeBLUFOR = _data select 3;
    if (_prestigeOPFOR + _prestigeBLUFOR < 90) then { true; } else { false; };
  }
  else
  {
    if ([_pos,_posbase] call A3A_fnc_isTheSameIsland) then { true; } else { false; };
  };
};

(_validSide and _validDistance and _validPrestigeOrSameIsland);

};