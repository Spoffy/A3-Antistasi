private _cities = ciudades - destroyedCities;
private _outposts = puertos;
private _banks = bancos;

private _possibleCities = _cities select {[_x] call A3A_fnc_isValidLocationForLogisticsMission};
private _possibleOutposts = _outposts select {[_x] call A3A_fnc_isValidLocationForLogisticsMission};
private _possibleBanks = _banks select {[_x] call A3A_fnc_isValidLocationForLogisticsMission};

[_possibleCities, _possibleOutposts, _possibleBanks];