#ifndef MENU_H
#define MENU_H

#include <ncurses.h>
#include <functional>
#include <vector>
#include <string>

class MenuOption {
public:
    std::string name;
    std::function<void()> action;

    MenuOption(const std::string& name, std::function<void()> action);
};

class Menu {
private:
    std::vector<MenuOption> options;
    int highlight;

public:
    Menu();
    void addOption(const std::string& name, std::function<void()> action);
    void display();
};

#endif // MENU_H
