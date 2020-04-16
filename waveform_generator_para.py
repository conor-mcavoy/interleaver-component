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
    
    wvf_str0 = ""
    wvf_str1 = ""
    wvf_str2 = ""
    wvf_str3 = ""
    wvf_str4 = ""
    wvf_str5 = ""
    wvf_str6 = ""
    wvf_str7 = ""
    wvf_str8 = ""
    data_list = []
    for i in range(blocksize):
        level = random.randint(0, 1) # random 0 or 1
        data_list.append(level)
    index =0
    size_result = blocksize/8;
    while index<size_result:
        wvf_str0 += "\t\tLEVEL " + str(data_list[index*8+0]) + " FOR 5.0;\n"
        wvf_str1 += "\t\tLEVEL " + str(data_list[index*8+1]) + " FOR 5.0;\n"
        wvf_str2 += "\t\tLEVEL " + str(data_list[index*8+2]) + " FOR 5.0;\n"
        wvf_str3 += "\t\tLEVEL " + str(data_list[index*8+3]) + " FOR 5.0;\n"
        wvf_str4 += "\t\tLEVEL " + str(data_list[index*8+4]) + " FOR 5.0;\n"
        wvf_str5 += "\t\tLEVEL " + str(data_list[index*8+5]) + " FOR 5.0;\n"
        wvf_str6 += "\t\tLEVEL " + str(data_list[index*8+6]) + " FOR 5.0;\n"
        wvf_str7 += "\t\tLEVEL " + str(data_list[index*8+7]) + " FOR 5.0;\n"
        index=index+1

    
    check_str = ""
    check2_str = ""
    check3_str = ""
    check4_str = ""
    check5_str = ""
    check6_str = ""
    check7_str = ""
    check8_str = ""
    check9_str = ""
    check10_str = ""

    for i in range(blocksize):
        pi_of_i = (f1 * i + f2 * i**2) % K
        check_str += str(data_list[pi_of_i])
        
        #pi_of_i = (f1 * (i-1) + f2 * (i-1)**2) % K
        check2_str += str(data_list[(pi_of_i-1)%K])
        
        #pi_of_i = (f1 * (i+1) + f2 * (i+1)**2) % K
        check3_str += str(data_list[(pi_of_i+1)%K])
        check4_str += str(data_list[(pi_of_i+2)%K])
        check5_str += str(data_list[(pi_of_i+3)%K])
        check6_str += str(data_list[(pi_of_i+4)%K])
        check7_str += str(data_list[(pi_of_i+5)%K])
        check8_str += str(data_list[(pi_of_i+6)%K])
        check9_str += str(data_list[(pi_of_i+7)%K])
        check10_str += str(data_list[(pi_of_i+8)%K])

    print("Writing waveform file: " + waveform_filename)
    f = open(waveform_filename, 'w');
    f.write(wvf_str0+ "\n end of bit 0 \n")
    f.write(wvf_str1+ "\n end of bit 1 \n")
    f.write(wvf_str2+ "\n end of bit 2 \n")
    f.write(wvf_str3+ "\n end of bit 3 \n")
    f.write(wvf_str4+ "\n end of bit 4 \n")
    f.write(wvf_str5+ "\n end of bit 5 \n")
    f.write(wvf_str6+ "\n end of bit 6 \n")
    f.write(wvf_str7+ "\n end of bit 7 \n")
    f.close()

    print("Writing check file: " + check_filename)
    f = open(check_filename, 'w');
    f.write(check_str + "\n\n")
    f.write(check2_str + "\n\n")
    f.write(check3_str + "\n\n")
    f.write(check4_str + "\n\n")
    f.write(check5_str + "\n\n")
    f.write(check6_str + "\n\n")
    f.write(check7_str + "\n\n")
    f.write(check8_str + "\n\n")
    f.write(check9_str + "\n\n")
    f.write(check10_str + "\n\n")
    f.close()

    print("Done")
