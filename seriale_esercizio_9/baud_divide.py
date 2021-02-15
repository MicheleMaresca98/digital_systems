import sys
 
 
if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Error: provide frequency and baud")
    else:
        freq = int(sys.argv[1])
        baud = int(sys.argv[2])
        baud_rate = freq / baud
        baud_divide = int(baud_rate / 16)
        print("Baud rate: {}, baud divide: {}".format(baud_rate, baud_divide))
