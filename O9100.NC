%
O9100 (PROBE Two Point WCS Alignment)

( Title: PROBE Two Point WCS Alignment)
( Author: Gemini Advanced )
( Date: 2024-12-24 )
( Description: This subprogram probes two bores on a fixture, )
( calculates the angle between them, and aligns the WCS to a  )
( specified reference angle.                                  )

( Initialization and safety checks )
G20  ( Set units to inches )
G90  ( Set to absolute programming mode )
G40  ( Cancel cutter radius compensation )

( Retrieve custom coordinates and reference angle from arguments )
#24 = #1  ( X_COORD - X-coordinate of Bore 2 )
#25 = #2  ( Y_COORD - Y-coordinate of Bore 2 )
#26 = #3  ( Z_COORD - Z-coordinate for probing )
#596 = #4  ( REF_ANGLE - Desired alignment angle ) 

( Turn on the probe )
G65P9832

( Move to a safe position above Bore 1 )
G00 X0.0                ( Move to X0 )
G00 Y0.0                ( Move to Y0 )
G43 H1 Z1.0              ( Apply tool length compensation with H1 and move to Z1.0 )

( Protected Positioning - Move to Bore 1 )
G65 P9810 X0.0                ( Protected positioning to Bore 1 - X axis )
G65 P9810 Y0.0                ( Protected positioning to Bore 1 - Y axis )
G65 P9810 Z[#26]              ( Protected positioning to Bore 1 - Z axis )

( Automatic Probe - Bore 1  0.625 diameter )
G65 P9814 D0.625  ( Renishaw bore probing cycle )
( Extract X and Y coordinates of Bore 1 center )
#601 = #185  ( X_BORE1 )
#602 = #186  ( Y_BORE1 )

( Protected Z-Retract after Bore 1 Probe )
G65 P9810 Z1.0  ( Protected move to Z1.0 )

( Calculate incremental distances for Bore 2 )
#610 = #597 - #601  ( X_COORD_INC - Incremental X-coordinate of Bore 2 )
#611 = #598 - #602  ( Y_COORD_INC - Incremental Y-coordinate of Bore 2 )
#612 = #599 - #5043  ( Z_COORD_INC - Incremental Z-coordinate for probing )

( Protected Positioning - Move to Bore 2 )
G65 P9810 X[#610]            ( Protected positioning to Bore 2 - X axis )
G65 P9810 Y[#611]            ( Protected positioning to Bore 2 - Y axis )
G65 P9810 Z[#612]            ( Protected positioning to Bore 2 - Z axis )

( Automatic Probe - Bore 2  0.500 diameter) 
G65 P9814 D0.500  ( Renishaw bore probing cycle )
( Extract X and Y coordinates of Bore 2 center)
#603 = #185  ( X_BORE2 )
#604 = #186  ( Y_BORE2 )

( Protected Z-Retract after Bore 2 Probe )
G65 P9810 Z1.0  ( Protected move to Z1.0 )

( Calculate Actual Angle  )
#691 = #604 - #602  ( Y_DIFF )
#692 = #603 - #601  ( X_DIFF )
#690 = ATAN[ABS[#691] / ABS[#692]] ( ACTUAL_ANGLE - initial calculation )

( Adjust for quadrant )
IF [#692 GT 0] AND [#691 GT 0] THEN #690 = #690  ( Quadrant I - no change ) 
ENDIF
IF [#692 LT 0] AND [#691 GT 0] THEN #690 = 180 - #690  ( Quadrant II ) 
ENDIF
IF [#692 LT 0] AND [#691 LT 0] THEN #690 = #690 + 180  ( Quadrant III ) 
ENDIF
IF [#692 GT 0] AND [#691 LT 0] THEN #690 = 360 - #690  ( Quadrant IV ) 
ENDIF

( Calculate Adjustment Angle )
#600 = #596 - #690  ( ADJUSTMENT_ANGLE ) 

( Display the adjustment angle on the screen )
(WCS ADJUSTMENT ANGLE = [#600] degrees) 

( Optional: Pause for user confirmation )
M0 (Press Cycle Start to continue)

( Return to the main program )
M99 
%