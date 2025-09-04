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

void conv_dec2binary(char *str, int n) {
}

void checksignaldec(char *str, int n) {
    if (str[0] == '-') {
        for 

    } else {
        int base = 1;
        for (int i=n-1; i>=0; i--) {
            if (str[i] == '1') {
                str_dec = 1 * base;
            }
            base *= 2;
        }
    }

}

void conv_binary2hex(char *str, int n) {
    char str_hex[20];

}

void conv_hex2binary(char *str, int n) {
    int str_dec; // para guardar as conversões

    if (str[1] == 'b') { // se a entrada é um binario, já printamos
        write(STDOUT_FD, str, n);

    } else if (str[1] == 'x') { // se a entrada é um hexadecimal, chamamos a f correta
        conv_binary2hex(str, n);

    } else { // ou é decimal


    }
    

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


int main()
{
    char str[20];
    int n = read(STDIN_FD, str, 20);
    int start_index = 0;

    n--;
    str[n] = \0;

    if (str[1] == 'x') { // convertemos de hex pra outras bases
        start_index = 2;

    } else {


    }

    /* Write n bytes from the str buffer to the standard output */
    write(STDOUT_FD, str, n);
    return 0;
}
