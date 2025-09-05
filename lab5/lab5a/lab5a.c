int read(int __fd, const void *__buf, int __n){
    int ret_val;
    __asm__ __volatile__(
        "mv a0, %1           # file descriptor\n"
        "mv a1, %2           # buffer \n"
        "mv a2, %3           # size \n"
        "li a7, 63           # syscall read code (63) \n"
        "ecall               # invoke syscall \n"
        "mv %0, a0           # move return value to ret_val\n"
        : "=r"(ret_val)  // Output list
        : "r"(__fd), "r"(__buf), "r"(__n)    // Input list
        : "a0", "a1", "a2", "a7"
    );
    return ret_val;
}

void write(int __fd, const void *__buf, int __n)
{
    __asm__ __volatile__(
        "mv a0, %0           # file descriptor\n"
        "mv a1, %1           # buffer \n"
        "mv a2, %2           # size \n"
        "li a7, 64           # syscall write (64) \n"
        "ecall"
        :   // Output list
        :"r"(__fd), "r"(__buf), "r"(__n)    // Input list
        : "a0", "a1", "a2", "a7"
    );
}

#define STDIN_FD  0
#define STDOUT_FD 1

int conv_char_to_int(const char* buf) { // função que converte char pra int
    int number = 0;
    int sign = 1;

    int start_index = 0;

    if (buf[0] == '+') { // pra ajustar sinal dps
        start_index = 1;
    } else {
        start_index = 1;
        sign = -1;
    }

    for (int i=start_index; i<5; i++) {
        int digit = buf[i] - '0'; // transformando ascii
        number = number * 10 + digit;
    }

    return number * sign;
}

/* Funções de masking usando operadores (<< e &) */

int mask_fifth(int number) {
    long long mask = 0b011111111111; // 11 bits
    long long masked = number & mask;
    masked <<=21;

    return masked;
}

int mask_fourth(int number) {
    long long mask = 0b000000011111; // 5 bits
    long long masked = number & mask;
    masked <<=16;

    return masked;
}

int mask_third(int number) {
    long long mask = 0b000000011111; // 5 bits
    long long masked = number & mask;
    masked <<=11;

    return masked;
}

int mask_second(int number) {
    long long mask = 0b000011111111; // 8 bits
    long long masked = number & mask;
    masked <<=3;

    return masked;
}

int mask_first(int number) {
    long long mask = 0b000000000111; // 3 bits
    long long masked = number & mask;
    return masked;
}

/* Função de pack usando operador | */

void pack(unsigned int *packed, int first_bi, int second_bi, int third_bi, int fourth_bi, int fifth_bi) {
    *packed |= first_bi;
    *packed |= second_bi;
    *packed |= third_bi;
    *packed |= fourth_bi;
    *packed |= fifth_bi;
}

void hex_code(int val){
    char hex[11];
    unsigned int uval = (unsigned int) val, aux;

    hex[0] = '0';
    hex[1] = 'x';
    hex[10] = '\n';

    for (int i = 9; i > 1; i--){
        aux = uval % 16;
        if (aux >= 10)
            hex[i] = aux - 10 + 'A';
        else
            hex[i] = aux + '0';
        uval = uval / 16;
    }
    write(1, hex, 11); // já vai printar
}

void exit(int code)
{
    __asm__ __volatile__(
        "mv a0, %0           # return code\n"
        "li a7, 93           # syscall exit (93) \n"
        "ecall"
        :   // Output list
        :"r"(code)    // Input list
        : "a0", "a7"
    );
}

int main();

void _start()
{
    int ret_code = main();
    exit(ret_code);
}

char buffer[30];

int main()
{
    /* Recebendo o numero */
    int n = read(STDIN_FD, (void*) buffer, 30);
    //write(STDOUT_FD, buffer, 30);
    unsigned int packed = 0;

    int first_val = conv_char_to_int(&buffer[0]);
    int first_bi = mask_first(first_val);
    
    int second_val = conv_char_to_int(&buffer[6]);
    int second_bi = mask_second(second_val);
    
    int third_val = conv_char_to_int(&buffer[12]);
    int third_bi = mask_third(third_val);
    
    int fourth_val = conv_char_to_int(&buffer[18]);
    int fourth_bi = mask_fourth(fourth_val);
    
    int fifth_val = conv_char_to_int(&buffer[24]);
    int fifth_bi = mask_fifth(fifth_val);

    pack(&packed, first_bi, second_bi, third_bi, fourth_bi, fifth_bi);
    hex_code(packed);
}