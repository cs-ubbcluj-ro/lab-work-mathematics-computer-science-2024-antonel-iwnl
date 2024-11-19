#include <iostream>
#include <string>
#include <regex>

bool isValidIdentifier(const std::string& str) {
    std::regex identifierRegex(R"(^@[a-zĂÂÎȚȘ][a-zĂÂÎȚȘ0-9_]*$)");
    return std::regex_match(str, identifierRegex);
}

bool isValidInteger(const std::string& str) {
    std::regex integerRegex(R"(^(\+|-)?[0-9]+$)");
    return std::regex_match(str, integerRegex);
}

bool isValidCharacter(const std::string& str) {
    std::regex characterRegex(R"(^[a-zĂÂÎȚȘ0-9_]$)");
    return std::regex_match(str, characterRegex);
}

bool isValidString(const std::string& str) {
    std::regex stringRegex(R"(^\"[a-zĂÂÎȚȘ0-9_]*\"$)");
    return std::regex_match(str, stringRegex);
}

int main() {
    std::string input;
    std::cout << "Enter a string to validate: ";
    std::getline(std::cin, input);

    if (isValidIdentifier(input)) {
        std::cout << "Valid identifier" << std::endl;
    } else if (isValidInteger(input)) {
        std::cout << "Valid integer" << std::endl;
    } else if (isValidCharacter(input)) {
        std::cout << "Valid character" << std::endl;
    } else if (isValidString(input)) {
        std::cout << "Valid string" << std::endl;
    } else {
        std::cout << "Invalid input" << std::endl;
    }

    return 0;
}