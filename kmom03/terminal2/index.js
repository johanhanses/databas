/**
 * Some crazy tool for kmom03 in the course databas at BTH
 *
 * @author Johan Hanses johv18
 *
 */
"use strict";

// Import console.table
require("console.table");

// Import the methods
const teachers = require("./func.js");

// import readline module
const readline = require("readline");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

/**
 * Main function
 *
 * @returns void
 */
(function () {
    rl.on("close", process.exit);
    rl.on("line", handleInput);

    showMenu();
    rl.setPrompt("Choose from the menu: ");
    rl.prompt();
})();

/**
 * Handle input as a command and sent it to a function that deals with it.
 *
 * @param (string) line The input from the user.
 *
 * @returns (void)
 */
async function handleInput(line) {
    line = line.trim();
    let lineArray = line.split(" ");



    switch (lineArray[0]) {
        case "quit":
        case "exit":
            process.exit();
            break;
        case "menu":
        case "help":
            showMenu();
            break;
        case "larare":
            await teachers.larare();
            break;
        case "kompetens":
            await teachers.kompetens();
            break;
        case "lon":
            await teachers.lon();
            break;
        case "sok":
            await teachers.sok(lineArray[1]);
            break;
        case "nylon":
            await teachers.nylon(lineArray[1], lineArray[2]);
            break;
        default:
            console.info('You have entered an invalid command, please try again or type menu');
            break;
    }
    rl.prompt();
}

/**
 * a function that shows the programs menu options
 */
function showMenu() {
    console.info(
        `\nYou can choose for these commands:\n\n` +
        `exit, quit: Exits the program\n`+
        `menu, help: Shows this menu\n` +
        `larare: Show table Teachers and their info\n`+
        `kompetens: Shows how the teachers competence changed during the payreview\n`+
        `lon: Shows how the teachers salary changed during the payreview\n`+
        `sok: <searchString> search teachers table\n`+
        `nylon: <acronym> <lon> choose a teacher and change their salary\n\n`
    );
}
