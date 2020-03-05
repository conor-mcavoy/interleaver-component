#!/usr/bin/python
#Script to make RAM MIF

import sys

header = """DEPTH = 8192;
WIDTH = 13;
ADDRESS_RADIX = DEC;
DATA_RADIX = DEC;
CONTENT BEGIN\n"""
# required header for MIF files

# Data @ given Pi calculated value in RAM
check_string = []

## large - want to check this since waveforms don't allow enough of a time window
f1 = 263
f2 = 480
K = 6144

## small
# f1 = 17
# f2 = 66
# K = 1056

if (len(sys.argv) == 2):
    # needs 1 arg, name of mif
    output_filename = sys.argv[1]
    
    data_file_str = ""
    for address in range(0, 8192):
        if address < K:
            if ((f1 * address + f2 * address**2) % K) % 2 == 0:
                check_string.append(0)
            else:
                check_string.append(1)
            
            if address % 2 == 0:
                result = 0
            else:
                result = 1
        
        data_file_str += str(address) + ":\t " + str(result) + ";\n"

    print("Writing to data file: " + output_filename)
    data_file = open(output_filename, 'w');
    data_file.write(header)
    data_file.write(data_file_str + "END;")
    data_file.close()

    # print first and last 10 values of check string
    print(str(check_string[0:9]) + " ... " + str(check_string[-10:]))
    
    print("Done")
