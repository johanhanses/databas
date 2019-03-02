/**
 * A simple test program importing a class Dice.
 *
 * @author Johan Hanses johv18
 */
"use strict";

let Dice = require("./dice.js");

//Prepare the dice hand to hold the dices (its an array)
let hand = [];

//Add the dices to the hand and roll them once
for (let i = 0; i < 5; i++) {
    hand[i] = new Dice();
    hand[i].roll();
}

console.info("Here is the dices you have rolled.");

//Print out the whole datastructure
console.info(hand);

//join the elements and print out as a string.
//This construction is using the builtin class method toString.
console.info(hand.join());
