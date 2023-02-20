_numberOfSectors = 3; //Number of active sectors (1-4)

_pointAddTime = 11; //How often points are added (seconds)

//Points will be added more slowly if there are more sectors to control
switch (_numberOfSectors) do {
  case 2: {_pointAddTime = _pointAddTime * 1.4};
  case 3: {_pointAddTime = _pointAddTime * 1.7};
  case 4: {_pointAddTime = _pointAddTime * 2};
};

/*
Neutral sector control mode. Can choose between 1-4 sectors. First team to 100 points wins.
Only infantry can capture sectors.

1 sector = fnf_sector1
2 sectors = fnf_sector1 & fnf_sector2
3 sectors = fnf_sector1 & fnf_sector2 & fnf_sector3
4 sectors = fnf_sector1 & fnf_sector2 & fnf_sector3 & fnf_sector4

Usage:
1. Choose how many sectors you want with the var _numberOfSectors.
2. Adjust the _pointAddTime if you wish.
3. Move the objects fnf_sector1, fnf_sector2, fnf_sector3, and fnf_sector4 to where you want. Adjust sector size if wanted.
*/
