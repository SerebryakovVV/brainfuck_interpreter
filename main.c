#include <stdio.h>
#define MEM_SIZE 10


int main() {

    // hello world
    // char src[] = ">++++++++[<+++++++++>-]<.>++++[<+++++++>-]<+.+++++++..+++.>>++++++[<+++++++>-]<++.------------.>++++++[<+++++++++>-]<+.<.+++.------.--------.>>>++++[<++++++++>-]<+.";    
    
    // nested loops, repeats char 1000 times
    char src[] = ",>>+++[<-[-<.>]>-]++++[<----->-]<-[-<.>]";    
    
    unsigned char mem[MEM_SIZE]={0};
    int cur_cell = 0;
    int pc = 0;
    char inp;
    int loop_stack[15]={0};
    int lst_count = 0;

    while (src[pc] != '\0') {
        switch (src[pc]) {
            case '>':
                if (cur_cell == MEM_SIZE - 1) {
                    cur_cell = 0;
                } else {
                    cur_cell++;
                }
                break;
            case '<':
                if (cur_cell == 0) {
                    cur_cell = MEM_SIZE - 1;
                } else {
                    cur_cell--;
                }            
                break;
            case '+':
                mem[cur_cell]++;
                break;
            case '-':
                mem[cur_cell]--;
                break;
            case '.':
                printf("%c", mem[cur_cell]);
                break;
            case ',':
                inp = getchar();
                getchar();
                mem[cur_cell] = inp;
                break;
            case '[':
                loop_stack[lst_count] = pc;
                lst_count++;
                break;
            case ']':
                if (mem[cur_cell] != 0) {
                    pc = loop_stack[lst_count-1];
                } else {
                    lst_count--;
                }
                break;
            default:
                printf("\nwrong command");
                return 0;
        }
        pc++;
    }

    printf("\n");
    for (int i = 0; i < MEM_SIZE; i++) {
        printf("%d ", mem[i]);
    }

    return 0;
}