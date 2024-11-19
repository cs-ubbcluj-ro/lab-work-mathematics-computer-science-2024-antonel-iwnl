#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <unordered_set>
#include <unordered_map>
#include <vector>
#include <regex>
#include <algorithm> // for trim
using namespace std;

// Finite Automaton class
class FiniteAutomaton {
private:
    unordered_set<string> states;
    unordered_set<char> alphabet;
    unordered_map<string, unordered_map<char, string> > transitions;
    string initialState;
    unordered_set<string> finalStates;

public:
    void readFromFile(const string& filename) {
        ifstream file(filename);
        if (!file.is_open()) {
            cerr << "Error: Unable to open file " << filename << endl;
            return;
        }

        string line;
        while (getline(file, line)) {
            if (line.find("States:") == 0) {
                parseStates(line);
            } else if (line.find("Alphabet:") == 0) {
                parseAlphabet(line);
            } else if (line.find("Transitions:") == 0) {
                parseTransitions(line);
            } else if (line.find("InitialState:") == 0) {
                parseInitialState(line);
            } else if (line.find("FinalStates:") == 0) {
                parseFinalStates(line);
            }
        }

        file.close();
    }

    void display() const {
        cout << "States: ";
        for (const string& state : states)
            cout << state << " ";
        cout << endl;

        cout << "Alphabet: ";
        for (const char& symbol : alphabet)
            cout << symbol << " ";
        cout << endl;

        cout << "Transitions:" << endl;
        for (const auto& pair : transitions) {
            const string& fromState = pair.first;
            for (const auto& subPair : pair.second) {
                char symbol = subPair.first;
                const string& toState = subPair.second;
                cout << "  " << fromState << " --" << symbol << "--> " << toState << endl;
            }
        }

        cout << "InitialState: " << initialState << endl;
        cout << "FinalStates: ";
        for (const string& state : finalStates)
            cout << state << " ";
        cout << endl;
    }

    bool isValidToken(const string& token) const {
        string currentState = initialState;

        for (char symbol : token) {
            if (alphabet.find(symbol) == alphabet.end())
                return false;

            if (transitions.find(currentState) == transitions.end() ||
                transitions.at(currentState).find(symbol) == transitions.at(currentState).end())
                return false;

            currentState = transitions.at(currentState).at(symbol);
        }

        return finalStates.find(currentState) != finalStates.end();
    }

private:
    void parseStates(const string& line) {
        string statesStr = line.substr(line.find(":") + 1);
        stringstream ss(statesStr);
        string state;

        while (getline(ss, state, ',')) {
            states.insert(trim(state));
        }
    }

    void parseAlphabet(const string& line) {
        string alphabetStr = line.substr(line.find(":") + 1);
        stringstream ss(alphabetStr);
        string symbol;

        while (getline(ss, symbol, ',')) {
            if (!symbol.empty())
                alphabet.insert(symbol[0]);
        }
    }

    void parseTransitions(const string& line) {
        string transitionsStr = line.substr(line.find(":") + 1);
        stringstream ss(transitionsStr);
        string transition;
    
        while (getline(ss, transition, ',')) {
            regex pattern(R"((\w+)->(.)->(\w+))");
            smatch match;
    
            if (regex_match(transition, match, pattern)) {
                string fromState = match[1].str();
                char symbol = match[2].str()[0];
                string toState = match[3].str();
    
                transitions[fromState][symbol] = toState;
            } else {
                cerr << "Error: Invalid transition format: " << transition << endl;
            }
        }
    }


    void parseInitialState(const string& line) {
        string initialStateStr = line.substr(line.find(":") + 1);
        initialState = trim(initialStateStr);

        if (initialState.empty()) {
            cerr << "Error: Initial state not specified or incorrectly formatted." << endl;
        } else {
            cout << "Debug: Parsed Initial State: " << initialState << endl; // Debug output
        }
    }

    void parseFinalStates(const string& line) {
        string finalStatesStr = line.substr(line.find(":") + 1);
        stringstream ss(finalStatesStr);
        string state;

        while (getline(ss, state, ',')) {
            state = trim(state);
            if (!state.empty()) {
                finalStates.insert(state);
            }
        }

        if (finalStates.empty()) {
            cerr << "Error: No final states specified or incorrectly formatted." << endl;
        } else {
            cout << "Debug: Parsed Final States: ";
            for (const auto& state : finalStates) cout << state << " ";
            cout << endl; // Debug output
        }
    }

    string trim(const string& str) const {
        if (str.empty()) return "";
        size_t first = str.find_first_not_of(" \t");
        size_t last = str.find_last_not_of(" \t");
        return str.substr(first, (last - first + 1));
    }
};

// Main function
int main() {
    FiniteAutomaton automaton;

    // Read automaton from file
    automaton.readFromFile("FA.in");

    // Display the automaton
    automaton.display();

    // BONUS: Test if a string is a valid token
    string testString;
    cout << "Enter a string to validate: ";
    cin >> testString;

    if (automaton.isValidToken(testString)) {
        cout << "The string '" << testString << "' is a valid token." << endl;
    } else {
        cout << "The string '" << testString << "' is NOT a valid token." << endl;
    }

    return 0;
}
