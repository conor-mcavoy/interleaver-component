#Script to write some lines for a test waveform for interleaver

import sys
import random

if (len(sys.argv) == 3):
    # needs 2 args, name of file and large or small block ("l" or "s")
    output_filename = sys.argv[1]
    l_or_s = sys.argv[2]

    if l_or_s == "l":
        blocksize = 6144
    elif l_or_s == "s":
        blocksize = 1056
    else:
        print("Invalid arg. Assuming small block.")
    
    file_str = ""
    for x in range(blocksize):
        level = random.randint(0, 1) # random 0 or 1
        file_str += "\t\tLEVEL " + str(level) + " FOR 10.0;\n"


    print("Writing to data file: " + output_filename)
    data_file = open(output_filename, 'w');
    data_file.write(file_str)
    data_file.close()

    print("Done")
