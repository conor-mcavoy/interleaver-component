#Script to write some lines for a test waveform for interleaver

import sys
import random

random.seed(15)

if (len(sys.argv) == 4):
    # needs 3 args
    # name of waveform file
    # name of check file
    # large or small block ("l" or "s")
    waveform_filename = sys.argv[1]
    check_filename = sys.argv[2]
    
    l_or_s = sys.argv[3]

    if l_or_s == "l":
        blocksize = 6144
        f1 = 263
        f2 = 480
        K = 6144
    elif l_or_s == "s":
        blocksize = 1056
        f1 = 17
        f2 = 66
        K = 1056
    else:
        print("Invalid arg. Assuming small block.")
    
    wvf_str = ""
    data_list = []
    for i in range(blocksize):
        level = random.randint(0, 1) # random 0 or 1
        data_list.append(level)
        wvf_str += "\t\tLEVEL " + str(level) + " FOR 10.0;\n"

    check_str = ""
    check2_str = ""
    check3_str = ""
    for i in range(blocksize):
        pi_of_i = (f1 * i + f2 * i**2) % K
        check_str += str(data_list[pi_of_i])
        
        #pi_of_i = (f1 * (i-1) + f2 * (i-1)**2) % K
        check2_str += str(data_list[(pi_of_i-1)%K])
        
        #pi_of_i = (f1 * (i+1) + f2 * (i+1)**2) % K
        check3_str += str(data_list[(pi_of_i+1)%K])

    print("Writing waveform file: " + waveform_filename)
    f = open(waveform_filename, 'w');
    f.write(wvf_str)
    f.close()

    print("Writing check file: " + check_filename)
    f = open(check_filename, 'w');
    f.write(check_str + "\n\n")
    f.write(check2_str + "\n\n")
    f.write(check3_str + "\n\n")
    f.close()

    print("Done")
