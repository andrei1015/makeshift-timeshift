#include "Menu.h"

void option1Action() {}

void option2Action() {}

int main() {
    initscr();
    noecho();
    cbreak();

    Menu menu;
    menu.addOption("Option 1", option1Action);
    menu.addOption("Option 2", option2Action);

    menu.display();

    endwin();

    return 0;
}
