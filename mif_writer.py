#Script to make pi calculator ROM MIF

import sys

header = """DEPTH = 6144;
WIDTH = 1;
ADDRESS_RADIX = DEC;
DATA_RADIX = BIN;
CONTENT BEGIN\n"""
# required header for MIF files

f1 = 263
f2 = 480


if (len(sys.argv) == 2):
    # needs 1 arg, name of mif
    output_filename = sys.argv[1]
    
    data_file_str = ""
    for address in range(0, 8192):
        data_file_str += str(address) + ":\t 0;\n"

    print("Writing to data file: " + output_filename)
    data_file = open(output_filename, 'w');
    data_file.write(header)
    data_file.write(data_file_str + "END;")
    data_file.close()

    print("Done")
