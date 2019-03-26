/**
 * terminal based program
 *
 * @author Johan Hanses johv18
 *
 */
"use strict";

// Import console.table
require("console.table");

// Import the methods
const tenta = require("./src/tenta.js");

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
(function() {
    rl.on("close", process.exit);
    rl.on("line", handleInput);

    showMenu();
    rl.setPrompt("Eshop: ");
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
        case "log":
            await tenta.showLog(lineArray[1]);
            break;
        case "shelf":
            await tenta.showShelf();
            break;
        case "inventory":
            if (lineArray[1]) {
                await tenta.searchInventory(lineArray[1]);
            } else {
                await tenta.showInventory();
            }
            break;
        case "invadd":
            await tenta.addToShelf(lineArray[1], lineArray[2], lineArray[3]);
            break;
        case "invdel":
            await tenta.removeFromShelf(lineArray[1], lineArray[2], lineArray[3]);
            break;
        case "order":
            if (lineArray[1]) {
                await tenta.searchOrder(lineArray[1]);
            } else {
                await tenta.showAllAboutOrder();
            }
            break;
        case "picklist":
            await tenta.searchPicklist(lineArray[1]);
            break;
        case "ship":
            await tenta.shipOrder(lineArray[1]);
            break;
        case "about":
            tenta.about();
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
        `\nYou can choose from these commands:\n` +
        `exit, quit                    : Exits the program\n` +
        `menu, help                    : Shows this menu\n` +
        `log <number>                  : View desired entries in the log table\n` +
        `shelf                         : View which shelves exists at the warehouse \n` +
        `inventory                     : View products and their location at the warehouse \n` +
        `inventory <str>                         : Search inventory \n` +
        `invadd <productid> <shelf> <number>     : Add to stock \n` +
        `invdel <productid> <shelf> <number>     : remove from stock \n` +
        `order                         : View orders and their status \n` +
        `order <search>                : Search orders on order or customer id\n` +
        `picklist <orderid>            : View picklist for choosen order id\n` +
        `ship <orderid>                : Set selected order status to "skickad"\n` +
        `about                         : Who did this?\n\n`
    );
}
