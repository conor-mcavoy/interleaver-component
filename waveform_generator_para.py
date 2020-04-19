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
    wvf_hexallstr = ""
    wvf_hexallbit=""
    data_list = []
    for i in range(blocksize):
        level = random.randint(0, 1) # random 0 or 1
        data_list.append(level)
        wvf_hexallstr += str(level);
    index =0
    size_result = blocksize/8;
    hex_result = blocksize/4;
    '''
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
    '''

    while index<size_result:
        wvf_str0 += str(data_list[index*8+0])
        wvf_str1 += str(data_list[index*8+1])
        wvf_str2 += str(data_list[index*8+2])
        wvf_str3 += str(data_list[index*8+3]) 
        wvf_str4 += str(data_list[index*8+4]) 
        wvf_str5 += str(data_list[index*8+5])
        wvf_str6 += str(data_list[index*8+6])
        wvf_str7 += str(data_list[index*8+7])
        index=index+1

    index0=0
    while index0<hex_result:
        wvf_hexallbit += str(hex(int(  str(wvf_hexallstr[index0*4:(index0+1)*4])[::-1]  ,2)))[2]
        index0=index0+1

    in_hex=0;
    tmp=""
    while in_hex<len(wvf_hexallbit):
        tmp += wvf_hexallbit[in_hex:in_hex+2][::-1]
        in_hex=in_hex+2;

    wvf_hex0 = int(wvf_str0,base=16)
    wvf_hex1 = int(wvf_str1,base=16)
    wvf_hex2 = int(wvf_str2,base=16)
    wvf_hex3 = int(wvf_str3,base=16)
    wvf_hex4 = int(wvf_str4,base=16)
    wvf_hex5 = int(wvf_str5,base=16)
    wvf_hex6 = int(wvf_str6,base=16)
    wvf_hex7 = int(wvf_str7,base=16)
   

    check_str = ""
    check2_str = ""
    check3_str = ""
    for i in range(blocksize):
        pi_of_i = (f1 * i + f2 * i**2) % K
        check_str += str(data_list[pi_of_i])
        
        #pi_of_i = (f1 * (i-1) + f2 * (i-1)**2) % K
        check2_str += str(data_list[(pi_of_i-8)%K])
        
        #pi_of_i = (f1 * (i+1) + f2 * (i+1)**2) % K
        check3_str += str(data_list[(pi_of_i+8)%K])
        

    print("Writing waveform file: " + waveform_filename)
    f = open(waveform_filename, 'w');
    f.write(tmp+ "\n hex input\n")
    f.write(str(wvf_str0)+ "\n end of bit 0 \n")
    f.write(str(wvf_str1)+ "\n end of bit 1 \n")
    f.write(str(wvf_str2)+ "\n end of bit 2 \n")
    f.write(str(wvf_str3)+ "\n end of bit 3 \n")
    f.write(str(wvf_str4)+ "\n end of bit 4 \n")
    f.write(str(wvf_str5)+ "\n end of bit 5 \n")
    f.write(str(wvf_str6)+ "\n end of bit 6 \n")
    f.write(str(wvf_str7)+ "\n end of bit 7 \n")
    f.close()

    print("Writing check file: " + check_filename)
    f = open(check_filename, 'w');
    f.write(check_str + "\n\n")
    f.write(check2_str + "\n\n")
    f.write(check3_str + "\n\n")
    f.close()

    print("Done")
