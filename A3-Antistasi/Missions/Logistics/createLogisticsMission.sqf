params ["_type", "_target"];
 
private _possibleTargets = call A3A_fnc_possibleLocationsForLogisticsMissions;
private _possibleCities = _possibleTargets select 0;
private _possibleOutposts = _possibleTargets select 1;
private _possibleBanks = _possibleTargets select 2;

private _result = false;
 
if (_type == "AMMO") then
{
  _target = selectRandom _possibleOutposts;
  if (!isNil "_target") then
  {
    [[_target],"LOG_Ammo"] remoteExec ["A3A_fnc_scheduler",2];
    _result = true;
  };
};

if (_type == "SUPPLY" ) then
{
  if (isNil "_target" or {!([_target] call A3A_fnc_isValidLocationForLogisticsMission)}) then
  {
    _target = selectRandom _possibleCities;
  };
  if (!isNil "_target") then
  {
    [[_target],"LOG_Suministros"] remoteExec ["A3A_fnc_scheduler",2];
    _result = true;
  };
};

if (_type == "BANK" ) then
{
  _target = selectRandom _possibleBanks;
  if (!isNil "_target") then
  {
    [[_target],"LOG_Bank"] remoteExec ["A3A_fnc_scheduler",2];
    _result = true;
  };
};

_result;
