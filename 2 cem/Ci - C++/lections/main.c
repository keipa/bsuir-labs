#include <stdio.h>

const int SECONDS_PER_MINUTE = 60;
const int MINUTES_PER_HOUR = 60;
//const int SECONDS_PER_HOUR = SECONDS_PER_MINUTE * MINUTES_PER_HOUR;

int main()
{
    int number;
    /* scanf("%d", &number);
     * 
     * printf("Hello, World! %d:%d \n", number, number); */
    int int_value;
    int int_value_other;
    double double_value;
    /* printf("%d %d %lf\n", int_value, int_value_other, double_value); */

    char character;
    /* scanf("%c", &character);
     * printf("'%c'\n", character); */

    int signed_value = -1;
    unsigned int unsigned_value = -1;

    /* printf("%d %u\n", signed_value, unsigned_value); */

    int one = 1;
    int two = 2;

    /* printf("%d %d %d\n", one, two, one + two);
     * printf("%d %d %d\n", 10, 7, 10 % 7); */

    {
        int i = 0;
        int ione = i;
        int itwo = i++;
        printf("%d %d\n", ione, itwo);
    }

    /* printf("%d %lf\n", one, (double)one); */

    int age = 14;
    int iq = 100;
    if (18 == age) {
        printf("You are ok!\n");
    } else {
        printf("You are not ok!\n");
    }

    int money = 100;
    money += 100;
    printf("%d\n", money);

    int health = age > 60 ? 50 : 100;
    printf("%d\n", health);

    int count = 0;
    scanf("%d", &count);

    for (int i = 0; i < count; ++i) {
        int choice = 0;
        scanf("%d", &choice);

        if (choice == 100500) {
            goto error;
        }

        switch (choice) {
        case 0:
            printf("You want nothing(\n");
            break;
        case 1:
            printf("You want something(\n");
            break;
        case 2:
            printf("You want something else(\n");
            break;
        default:
            printf("I don't know what to do\n");
            break;
        };
    }

    // DONT DO THAT
    goto no_error;
error:
    printf("You've got an error!\n");
no_error:

    return 0;
}
