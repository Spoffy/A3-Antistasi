
missionmenu_actionRadius = 4;

missionmenu_fnc_addActionToPetros = {
  params ["_title", "_code", ["_arguments", nil], ["_priority", 0], ["_showWindow", false], ["_hideOnUse", true]];
  petros addAction [_title, //Title
                    _code, //Execute
                    _arguments, //Arguments
                    _priority, //Priority
                    _showWindow, //showWindow
                    _hideOnUse, //hideOnUse
                    "", //shortcut
                    "_this == theBoss", //"(isPlayer _this) and (_this == _this getVariable ['owner',objNull])", //Condition
                    missionmenu_actionRadius //Radius
                   ];

};

missionmenu_fnc_addMissionMenuToPetros = {
  missionmenu_AssassinationMission = ["Assassination Mission", missionmenu_fnc_chooseAssassinationMission, nil, nil, nil, true] call missionmenu_fnc_addActionToPetros;
  missionmenu_ConvoyMission = ["Convoy Mission", missionmenu_fnc_chooseConvoyMission, nil, nil, nil, true] call missionmenu_fnc_addActionToPetros;
  missionmenu_ConquestMission = ["Conquest Mission", missionmenu_fnc_chooseConquestMission, nil, nil, nil, true] call missionmenu_fnc_addActionToPetros;
  missionmenu_DestroyMission = ["Destroy Mission", missionmenu_fnc_chooseDestroyMission, nil, nil, nil, true] call missionmenu_fnc_addActionToPetros;
  missionmenu_LogisticsMission = ["Logistics Mission", missionmenu_fnc_chooseLogisticsMission, nil, nil, nil, false] call missionmenu_fnc_addActionToPetros;
  missionmenu_RescueMission = ["Rescue Mission", missionmenu_fnc_chooseRescueMission, nil, nil, nil, true] call missionmenu_fnc_addActionToPetros;
};

missionmenu_fnc_saveActionsOnPetros = {
  private _actions = actionIDs petros;
  _actions apply {petros actionParams _x};
};

missionmenu_fnc_setPetrosActionsToDefault = {
  removeAllActions petros;
  call missionmenu_fnc_addMissionMenuToPetros;
};

missionmenu_fnc_chooseAssassinationMission = {
  if ((player == theBoss) or (not(isPlayer theBoss))) then {
    [["AS"],"A3A_fnc_missionRequest"] call BIS_fnc_MP
  } else {
    hint "Only Player Commander has access to this function"
  };
};

missionmenu_fnc_chooseConvoyMission = {
  if ((player == theBoss) or (not(isPlayer theBoss))) then {
    [["CONVOY"],"A3A_fnc_missionRequest"] call BIS_fnc_MP
  } else {
    hint "Only Player Commander has access to this function"
  };
};

missionmenu_fnc_chooseDestroyMission = {
  if ((player == theBoss) or (not(isPlayer theBoss))) then {
    [["DES"],"A3A_fnc_missionRequest"] call BIS_fnc_MP
  } else {
    hint "Only Player Commander has access to this function"
  };
};

missionmenu_fnc_chooseLogisticsMission = {
  //Action menu callback
  private _fnc_attemptCreateLogisticsMission = {
    (_this select 3) params ["_type", "_target"];
    
    private _missionParams = if(isNil "_target") then {[_type];} else {[_type, _target];};
    
    if (["LOG"] call BIS_fnc_taskExists) then
    {
      [petros,"globalChat","I already gave you a mission of this type"] remoteExec ["A3A_fnc_commsMP",theBoss]
    }
    else {
      if (!(_missionParams call A3A_fnc_createLogisticsMission)) then
      {
        [petros,"globalChat","I have no logistics missions for you. Move our HQ closer to the enemy or finish some other logistics missions in order to have better intel"] remoteExec ["A3A_fnc_commsMP",theBoss];
        [petros,"hint","Logistics Missions require Outposts, Cities or Banks closer than 4Km from your HQ."] remoteExec ["A3A_fnc_commsMP",theBoss];
      };
    };
    call missionmenu_fnc_setPetrosActionsToDefault;
  };

  if ((player == theBoss) or (not(isPlayer theBoss))) then {
    removeAllActions petros;
    private _possibleLocations = call A3A_fnc_possibleLocationsForLogisticsMissions;
    private _possibleCities = _possibleLocations select 0;
    {
      ["Supply: " + _x, _fnc_attemptCreateLogisticsMission, ["SUPPLY", _x]] call missionmenu_fnc_addActionToPetros;
    } forEach _possibleCities;
    
    ["Steal an Ammo Truck", _fnc_attemptCreateLogisticsMission, ["AMMO"]] call missionmenu_fnc_addActionToPetros;
    ["Rob a bank", _fnc_attemptCreateLogisticsMission, ["BANK"]] call missionmenu_fnc_addActionToPetros;
    ["Cancel Logistics Mission Request", missionmenu_fnc_setPetrosActionsToDefault] call missionmenu_fnc_addActionToPetros;
  } else {
    hint "Only Player Commander has access to this function"
  };
};

missionmenu_fnc_chooseRescueMission = {
  if ((player == theBoss) or (not(isPlayer theBoss))) then {
    [["RES"],"A3A_fnc_missionRequest"] call BIS_fnc_MP
  } else {
    hint "Only Player Commander has access to this function"
  };
};

missionmenu_fnc_chooseConquestMission = {
  if ((player == theBoss) or (not(isPlayer theBoss))) then {
    [["CON"],"A3A_fnc_missionRequest"] call BIS_fnc_MP
  } else {
    hint "Only Player Commander has access to this function"
  };
};

call missionmenu_fnc_setPetrosActionsToDefault;
