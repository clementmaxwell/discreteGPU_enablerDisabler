# discreteGPU_enablerDisabler
Batch script to enable or disable discrete GPU on laptop to extend its battery life.
It uses devcon to enable/disable the GPU which is identified by its PCIE vendor ID,
thus forcing the PC to use its iGPU to output display.

## Config:
For NVIDIA GPU users:
replace line 1 in gpuID.txt with
```
PCI\VEN_10DE&
```

For AMD GPU users:
replace line 1 in gpuID.txt with
```
PCI_1022&
```

## Deployment:
Click on dGPU_EnablerDisabler.bat to run.
