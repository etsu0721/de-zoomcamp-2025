import pandas as pd
import sys

# Print all command line args (and filename)
print(sys.argv)

# Capture first command line arg
day = sys.argv[1]

# some data processing with pandas

print(f'Job finished successfully for {day}')