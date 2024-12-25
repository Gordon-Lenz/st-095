(O0001 - ST-095 Part Setup and Machining)

(************************************************************************)
( Title: ST-095 Part Setup and Machining                                )
( Author: Gordon Lenz                                                   )
( Date: 2024-12-24                                                       )
( Description: This program sets up the WCS for machining a part        )
(              on Fixture ST-095. It calls subprogram O9999 to probe    )
(              two bores and align the WCS to a specified reference     )
(              angle.                                                    )
(************************************************************************)

# Initialization and safety checks
G20  # Set units to inches
G90  # Set to absolute programming mode
G40  # Cancel cutter radius compensation
G49  # Cancel tool length compensation

# Call the probing and alignment subprogram (O9999)
M98 P9999 L1 X6.5424 Y3.2087 A26.131  (Call with X=6.5424, Y=3.2087, A=26.131)

# Cancel any previous rotation
G69

# Apply the calculated rotation - retrieve the angle directly from #600
G68 X[#601] Y[#602] R[#600] 

# ... Rest of the machining program ...
# (Use the aligned WCS for subsequent machining operations)

# ... (Example machining operations) ...

# ... End of program ...