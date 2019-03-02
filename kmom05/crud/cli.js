/**
 * terminal based program that moves 1.5 peng from adam to eva
 *
 * @author Johan Hanses johv18
 *
 */
"use strict";

// Import console.table
require("console.table");

// Import the methods
const move = require("./src/bank.js");

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
    rl.setPrompt("Bank: ");
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
        case "balance":
            await move.showBalance();
            break;
        case "move":
            await move.moveMoney("1111", "2222");
            console.info("(Move 1.5 money from 1111 to 2222)\n" +
            "Eva got 1.5 pengar, she is currently checking out her account balance");
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
        `\nYou can choose for these commands:\n` +
        `exit, quit: Exits the program\n`+
        `menu, help: Shows this menu\n` +
        `balance   : view balance for all accounts\n` +
        `move      : move 1.5 peng to Eva\n\n`
    );
}
