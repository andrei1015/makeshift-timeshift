#include "Menu.h"

MenuOption::MenuOption(const std::string& name, std::function<void()> action)
    : name(name), action(action) {}

Menu::Menu() : highlight(0) {}

void Menu::addOption(const std::string& name, std::function<void()> action) {
    options.push_back(MenuOption(name, action));
}

void Menu::display() {
    int choice;
    while(1) {
        for(int i = 0; i < options.size(); i++) {
            if(i == highlight)
            wattron(menuwin, A_REVERSE);
            wclrtoeol(menuwin);  // Clear the line
            mvwprintw(menuwin, i+1, 1, options[i].name.c_str());
            wattroff(menuwin, A_REVERSE);
        }
        choice = wgetch(menuwin);

        switch(choice) {
            case KEY_UP:
                highlight--;
                if(highlight == -1)
                    highlight = 0;
                break;
            case KEY_DOWN:
                highlight++;
                if(highlight == options.size())
                    highlight = options.size() - 1;
                break;
            default:
                break;
        }
        if(choice == 10) {
            options[highlight].action();
            break;
        }
    }

    endwin();
}
