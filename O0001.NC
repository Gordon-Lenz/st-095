%
O0001 (ST-095 Part Setup and Machining)

( Title: ST-095 Part Setup and Machining )
( Author: Gordon Lenz )
( Date: 2024-12-24 )
( Description: This program sets up the WCS for machining a part )
( on Fixture ST-095.                                          )

( Initialization and safety checks )
G20  ( Set units to inches )
G90  ( Set to absolute programming mode )
G40  ( Cancel cutter radius compensation )
G49  ( Cancel tool length compensation )

( Set X, Y, and Z coordinates for Bore 2 )
#596 = 26.131 ( REF_ANGLE - Desired alignment angle )
#597 = 6.5424  ( X_COORD - X-coordinate of Bore 2 )
#598 = 3.2087  ( Y_COORD - Y-coordinate of Bore 2 )
#599 = -0.3    ( Z_COORD - Z-coordinate for probing )

( Call the probing and alignment subprogram (O9100) )
M98 P9100 L1 ( Call with D=26.131 )

( Cancel any previous rotation )
G69

( Apply the calculated rotation )
G68 X[#601] Y[#602] R[#600] 

( ... Rest of the machining program ... )

( ... End of program ... )
M30
%