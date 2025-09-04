#include <inttypes.h>

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

int conv_char_to_int(const *buf) {
    int number = 0;

    if (buf[0] == '+') {
        buf[0] = 0;
        int i = 1;

        while (buf[i] != '\n') {
            int digit = buf[i] - '0';
            number = number * 10 + digit;
            i++;
        }

    } else {
        buf[0] = 0;
        int number = 0;
        int i = 1;

        while (buf[i] != '\n') {
            int digit = buf[i] - '0';
            number = number * 10 - digit;
            i++;
        }
    }
    return number;
}

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

void pack(unsigned int packed, int first_bi, int second_bi, int third_bi, int fourth_bi, int fifth_bi) {
    packed |= first_bi;
    packed |= second_bi;
    packed |= third_bi;
    packed |= fourth_bi;
    packed |= fifth_bi;
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
    char fifth_char[6];
    char fourth_char[6];
    char third_char[6];
    char second_char[6];
    char first_char[6];

    unsigned int packed = 0;
    
    /* Separando os numeros em vetores, convertendo-os pra int e depois pra binario  */
    for (int i=0; i<5; i++) {
        fifth_char[i] = buffer[i];
    }
    fifth_char[5] = '\n';
    int fifth_bi = mask_fifth(conv_char_to_int((void*)fifth_char));

    int g = 0;
    for (int i=6; i<11; i++) {
        fourth_char[g] = buffer[i];
        g++;
    }
    fourth_char[11] = '\n';
    int fourth_bi = mask_fourth(conv_char_to_int((void*)fourth_char));

    int h = 0;
    for (int i=12; i<17; i++) {
        third_char[h] = buffer[i];
        h++;
    }
    third_char[17] = '\n';
    int third_bi = mask_third(conv_char_to_int((void*)third_char));

    int j = 0;
    for (int i=18; i<23; i++) {
        second_char[j] = buffer[i];
        j++;
    }
    second_char[23] = '\n';
    int second_bi = mask_second(conv_char_to_int(*void)second_char)

    int k = 0;
    for (int i=24; i<29; i++) {
        first_char[k] = buffer[i];
        k++;
    }
    first_char[29] = '\n';
    int first_bi = mask_first((void*)first_char);

    pack(packed, first_bi, second_bi, third_bi, fourth_bi, fifth_bi);
    hex_code(packed);
}