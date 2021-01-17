#include <stdio.h>
#include <sys/time.h>

#define LENGTH 10000
#define INPUT_FILE_NAME "./input.txt"

int *read_ints(char *, int *, int);
int *bubble_sort(int *, int);

int main(int argc, char *argv[])
{
    struct timeval start, stop;
    gettimeofday(&start, NULL);
    int array[LENGTH];
    read_ints(INPUT_FILE_NAME, array, LENGTH);
    bubble_sort(array, LENGTH);
    gettimeofday(&stop, NULL);
    double secs = (double)(stop.tv_usec - start.tv_usec) / 1000000 + (double)(stop.tv_sec - start.tv_sec);
    printf("%f\n", secs);
    return(0);
}

int *read_ints(char *file_name, int *array, int length)
{
    FILE *file = fopen(file_name, "r");
    for (int i = 0; i < length; i++)
        fscanf(file, "%d", &array[i]);
    fclose(file);
    return array;
}

int *bubble_sort(int *array, int length)
{
    int sorted = 1;
    for(int i = 0; i < length - 1; i++){
        if(array[i] > array[i+1]){
            int tmp = array[i];
            array[i] = array[i+1];
            array[i+1] = tmp;
            sorted = 0;
        }
    }
    if(sorted) return array;
    return bubble_sort(array, length);
}
