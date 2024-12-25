# PROBE Two Point WCS Alignment (O9999)

### Author: Gordon Lenz

### Date: 2024-12-24

### Description:
This subprogram probes two bores, calculates the angle between them, and sets the coordinate system to a specified reference angle. It uses Renishaw Inspection Plus cycles for probing and protected positioning. The calculated angle adjustment is displayed on the screen, and the program pauses for user confirmation. The adjustment angle is stored in macro variable #600. This version is compatible with controllers that only support the ATAN function (not ATAN2).

### Usage:
Call this subprogram from your main program using:
```M98 P9999 L1 X[X-coordinate] Y[Y-coordinate] A[Reference Angle]```

Where:

* `X[X-coordinate]` is the X-coordinate of Bore 2
* `Y[Y-coordinate]` is the Y-coordinate of Bore 2
* `A[Reference Angle]` is the desired alignment angle

### Features:

* Probes two bores using Renishaw Inspection Plus cycles.
* Calculates the required WCS rotation to align with the specified reference angle.
* Displays the calculated angle adjustment on the screen.
* Pauses the program for user confirmation.
* Stores the adjustment angle in macro variable `#600`
* Compatible with controllers that only support the `ATAN` function.

### Tracked Variables:

| Macro Variable | Description |
|---|---|
| `#600` | WCS adjustment angle |
| `#601` | X-coordinate of Bore 1 center |
| `#602` | Y-coordinate of Bore 1 center |
| `#603` | X-coordinate of Bore 2 center |
| `#604` | Y-coordinate of Bore 2 center |
| `#690` | Calculated actual angle between bores |
| `#691` | Y-axis difference between Bore 2 and Bore 1 centers |
| `#692` | X-axis difference between Bore 2 and Bore 1 centers |