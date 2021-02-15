if __name__ == "__main__":    
    m, n = 4, 7
    h = 2**m
    # dest obsolete: transmitted as header
    print("i : std_logic_vector({} downto 0)".format(n*h - 1))
    #print("dest : std_logic_vector({} downto 0)".format(m*h - 1))
    print("u : std_logic_vector({} downto 0)".format(n*h - 1))
    print("u_internal : std_logic_vector({} downto 0)".format(n*h*(m-1) - 1))
    print("Indici del primo stadio (stadio 0)")
    for j in range(0, int(h/2)):
        print("    Switch {}".format(j))
        print("        i0 => i({} downto {})".format((j+1)*n - 1, j*n))
        print("        i1 => i({} downto {})".format((int(h/2)+j+1)*n - 1, (int(h/2)+j)*n))
        #print("        dest_i0 => dest({})".format((j+1)*m - 1))
        #print("        dest_i1 => dest({})".format((int(h/2)+j+1)*m - 1))
        print("        u0 => u_internal({} downto {})".format((2*j+1)*n-1, 2*j*n))
        print("        u1 => u_internal({} downto {})".format((2*j+2)*n-1, (2*j+1)*n))
    for i in range(1, m-1):
        print("Indici dello stadio {}".format(i))
        for j in range(0, int(h/2)):
            print("    Switch {}".format(j))
            print("        i0 => u_internal({} downto {})".format((j+1)*n - 1 + (i-1)*n*h, j*n + (i-1)*n*h))
            print("        i1 => u_internal({} downto {})".format((int(h/2)+j+1)*n - 1 + (i-1)*n*h, (int(h/2)+j)*n + (i-1)*n*h))
            #print("        dest_i0 => dest({})".format((j+1)*m - 1 - i))
            #print("        dest_i1 => dest({})".format((int(h/2)+j+1)*m - 1 - i))
            print("        u0 => u_internal({} downto {})".format((2*j+1)*n - 1 + i*n*h, (2*j)*n + i*n*h))
            print("        u1 => u_internal({} downto {})".format((2*j+2)*n - 1 + i*n*h, (2*j+1)*n + i*n*h))
    print("Indici dell'ultimo stadio (stadio m-1)")
    for j in range(0, int(h/2)):
        print("    Switch {}".format(j))
        print("        i0 => u_internal({} downto {})".format((j+1)*n - 1 + (m-2)*n*h, j*n + (m-2)*n*h))
        print("        i1 => u_internal({} downto {})".format((int(h/2)+j+1)*n - 1 + (m-2)*n*h, (int(h/2)+j)*n + (m-2)*n*h))
        #print("        dest_i0 => dest({})".format((j+1)*m - 1 - (m-1)))
        #print("        dest_i1 => dest({})".format((int(h/2)+j+1)*m - 1 - (m-1)))
        print("        u0 => u({} downto {})".format((2*j+1)*n-1, 2*j*n))
        print("        u1 => u({} downto {})".format((2*j+2)*n-1, (2*j+1)*n))
