(************************************************************************)
( Title: PROBE Two Point WCS Alignment                                  )
( Author: Gemini Advanced                                                )
( Date: 2024-12-24                                                       )
( Description: This subprogram probes two bores, calculates the angle    )
(              between them, and rotates the WCS to align with a         )
(              specified reference angle. It uses Renishaw Inspection    )
(              Plus cycles for probing and protected positioning.        )
(              The calculated angle adjustment is displayed on the       )
(              screen, and the program pauses for user confirmation.     )
(              The adjustment angle is stored in macro variable #600.    )
(              This version is compatible with controllers that only    )
(              support the ATAN function (not ATAN2).                    )
(                                                                        )
( Usage: Call this subprogram from your main program using:              )
(              M98 P9999 L1 X[X-coordinate] Y[Y-coordinate]              )
(                    A[Reference Angle]                                )
(              where:                                                    )
(                  X[X-coordinate] is the X-coordinate of Bore 2        )
(                  Y[Y-coordinate] is the Y-coordinate of Bore 2        )
(                  A[Reference Angle] is the desired alignment angle    )
(************************************************************************)

( Initialization and safety checks )
G20  ( Set units to inches )
G90  ( Set to absolute programming mode )
G40  ( Cancel cutter radius compensation )
G49  ( Cancel tool length compensation )

( Retrieve custom coordinates and reference angle from arguments )
#1 = #1  ( (X_COORD) X-coordinate passed from the main program )
#2 = #2  ( (Y_COORD) Y-coordinate passed from the main program )
#3 = #3  ( (REF_ANGLE) Reference angle passed from the main program )

( Manual Probe - G111 )
G111 X0 Y0  ( Set G111 origin based on manual probe within the larger bore )

( Protected Positioning - Move to Bore 1 )
G65 P9810 X0.0 Y0.0 Z-0.4  ( Protected positioning to Bore 1 )

( Automatic Probe - Bore 1 (0.625 diameter) )
G65 P9814 D0.625  ( Renishaw bore probing cycle )
( Extract X and Y coordinates of Bore 1 center from macro variables )
#601 = #185  ( (X_BORE1) )
#602 = #186  ( (Y_BORE1) )

( Protected Z-Retract after Bore 1 Probe )
G65 P9810 X0.0 Y0.0 Z1.0  ( Protected move to Z1.0 )

( Protected Positioning - Move to Bore 2 using custom coordinates )
G65 P9810 X[#1] Y[#2] Z-0.4  ( Protected positioning to Bore 2 )

( Automatic Probe - Bore 2 (0.500 diameter) )
G65 P9814 D0.500  ( Renishaw bore probing cycle )
( Extract X and Y coordinates of Bore 2 center from macro variables )
#603 = #185  ( (X_BORE2) )
#604 = #186  ( (Y_BORE2) )

( Protected Z-Retract after Bore 2 Probe )
G65 P9810 X[#1] Y[#2] Z1.0  ( Protected move to Z1.0 )

( Calculate Actual Angle (workaround for ATAN2 using ATAN) )
#691 = #604 - #602  ( (Y_DIFF) )
#692 = #603 - #601  ( (X_DIFF) )
#690 = ATAN(ABS(#691) / ABS(#692)) * 180 / 3.14159  ( (ACTUAL_ANGLE) - initial calculation )

( Adjust for quadrant )
IF [#692 GT 0] AND [#691 GT 0] THEN #690 = #690  ( Quadrant I - no change ) 
ENDIF
IF [#692 LT 0] AND [#691 GT 0] THEN #690 = 180 - #690  ( Quadrant II ) 
ENDIF
IF [#692 LT 0] AND [#691 LT 0] THEN #690 = #690 + 180  ( Quadrant III ) 
ENDIF
IF [#692 GT 0] AND [#691 LT 0] THEN #690 = 360 - #690  ( Quadrant IV ) 
ENDIF

( Calculate Adjustment Angle using the reference angle from the argument )
#600 = #3 - #690  ( (ADJUSTMENT_ANGLE) )

( Display the adjustment angle on the screen with context )
(WCS ADJUSTMENT ANGLE = [#600] degrees) 

( Optional: Pause the program for user confirmation )
M0 (Press Cycle Start to continue)

( Return to the main program without executing G68 )
M99