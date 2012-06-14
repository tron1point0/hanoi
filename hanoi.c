#import <stdlib.h>
#import <stdio.h>

typedef struct {
    void *car;
    void *cdr;
} cons_t;

cons_t* cons (void *car, cons_t *cdr) {
    cons_t *new = (cons_t *) malloc(sizeof(cons_t));
    new->car = car;
    new->cdr = cdr;
    return new;
}
void* car (cons_t *cell) { return cell->car; }
cons_t* cdr (cons_t *cell) { return cell->cdr; }

cons_t* append (cons_t *a, cons_t *b) {
    if (b == NULL) return a;
    if (a == NULL) return b;
    cons_t *current = a;
    while (cdr(current) != NULL) current = cdr(current);
    current->cdr = b;
    return a;
}

cons_t* solve (int n, char a, char b, char c) {
    if (n == 0) return NULL;
    char *pa = malloc(sizeof(char));
    char *pc = malloc(sizeof(char));
    *pa = a;
    *pc = c;
    return append(solve(n-1,a,c,b),cons(pa,cons(pc,solve(n-1,b,a,c))));
}

void solution (cons_t *cell) {
    cons_t *current = cell;
    while (current != NULL) {
        printf("%s -> %s\n",(char *) car(current),(char *) car(cdr(current)));
        current = cdr(cdr(current));
    }
}

int main(int argc, char *argv[]) {
    int n = 7;
    if (argc > 1) n = atoi(argv[1]);
    printf("%d\n",n);
    solution(solve(n,'A','B','C'));
    return 0;
}
