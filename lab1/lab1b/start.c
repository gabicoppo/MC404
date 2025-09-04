/* read
 * Parameters:
 *  __fd:  file descriptor of the file to be read.
 *  __buf: buffer to store the data read.
 *  __n:   maximum amount of bytes to be read.
 * Return:
 *  Number of bytes read.
 */
int read(int __fd, const void *__buf, int __n)
{
    int ret_val;
  __asm__ __volatile__(
    "mv a0, %1           # file descriptor\n"
    "mv a1, %2           # buffer \n"
    "mv a2, %3           # size \n"
    "li a7, 63           # syscall read code (63) \n"
    "ecall               # invoke syscall \n"
    "mv %0, a0           # move return value to ret_val\n"
    : "=r"(ret_val)                   // Output list
    : "r"(__fd), "r"(__buf), "r"(__n) // Input list
    : "a0", "a1", "a2", "a7"
  );
  return ret_val;
}

/* write
 * Parameters:
 *  __fd:  files descriptor where that will be written.
 *  __buf: buffer with data to be written.
 *  __n:   amount of bytes to be written.
 * Return:
 *  Number of bytes effectively written.
 */
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

void exit(int code)
{
  __asm__ __volatile__(
    "mv a0, %0           # return code\n"
    "li a7, 93           # syscall exit (64) \n"
    "ecall"
    :   // Output list
    :"r"(code)    // Input list
    : "a0", "a7"
  );
}


#define STDIN_FD  0
#define STDOUT_FD 1

/* Buffer to store the data read */
char buffer[6];


int main()
{
  /* Reads a string from standard input */
  int n = read(STDIN_FD, (void*) buffer, 6);
  int sp1, sp2;
  char op;

  if (buffer[0] == '0') { // da pra fazer um  loop com i
    sp1 = 0;
  } else if (buffer[0] == '1') {
    sp1 = 1;
  } else if (buffer[0] == '2') {
    sp1 = 2;
  } else if (buffer[0] == '3') {
    sp1 = 3;
  } else if (buffer[0] == '4') {
    sp1 = 4;
  } else if (buffer[0] == '5') {
    sp1 = 5;
  } else if (buffer[0] == '6') {
    sp1 = 6;
  } else if (buffer[0] == '7') {
    sp1 = 7;
  } else if (buffer[0] == '8') {
    sp1 = 8;
  } else if (buffer[0] == '9') {
    sp1 = 9;
  }

  if (buffer[4] == '0') {
    sp2 = 0;
  } else if (buffer[4] == '1') {
    sp2 = 1;
  } else if (buffer[4] == '2') {
    sp2 = 2;
  } else if (buffer[4] == '3') {
    sp2 = 3;
  } else if (buffer[4] == '4') {
    sp2 = 4;
  } else if (buffer[4] == '5') {
    sp2 = 5;
  } else if (buffer[4] == '6') {
    sp2 = 6;
  } else if (buffer[4] == '7') {
    sp2 = 7;
  } else if (buffer[4] == '8') {
    sp2 = 8;
  } else if (buffer[4] == '9') {
    sp2 = 9;
  }

  if (buffer[2] == '+') {
    op = sp1 + sp2;
  } else if (buffer[2] == '-') {
    op = sp1 - sp2;
  } else if (buffer[2] == '*') {
    op = sp1 * sp2;
  } 

  if (op == 0) {
    op = '0';
  } else if (op == 1) {
    op = '1';
  } else if (op == 2) {
    op = '2';
  } else if (op == 3) {
    op = '3';
  } else if (op == 4) {
    op = '4';
  } else if (op == 5) {
    op = '5';
  } else if (op == 6) {
    op = '6';
  } else if (op == 7) {
    op = '7';
  } else if (op == 8) {
    op = '8';
  } else if (op == 9) {
    op = '9';
  }

  write(STDOUT_FD, &op, 1);
  write(STDOUT_FD, "\n", 1);

  return 0;
}

void _start()
{
  int ret_code = main();
  exit(ret_code);
}