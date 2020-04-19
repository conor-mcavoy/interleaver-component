#!/usr/bin/python
#Script to make pi calculator ROM MIF

import sys

header = """DEPTH = 1024;
WIDTH = 10;
ADDRESS_RADIX = DEC;
DATA_RADIX = DEC;
CONTENT BEGIN\n"""
# required header for MIF files

## large
f1 = 263
f2 = 480
K = 6144

## small
#f1 = 17
#f2 = 66
#K = 1056

if (len(sys.argv) == 2):
    # needs 1 arg, name of mif
    target_address = 0;
    output_filename = sys.argv[1]
    
    data_file_str = ""
    K_limit = K/8;
    for address in range(0, 1024):
        if address < K_limit:
            target_address = 8*address +7
            result = (f1 * target_address + f2 * target_address**2) % K
        else:
            result = 0
        
        data_file_str += str(address) + ":\t " + str(result) + ";\n"

    print("Writing to data file: " + output_filename)
    data_file = open(output_filename, 'w');
    data_file.write(header)
    data_file.write(data_file_str + "END;")
    data_file.close()

    print("Done")
