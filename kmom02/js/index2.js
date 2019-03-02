/**
 * A test program to show off async and await.
 *
 * @author Johan Hanses johv18
 */
"use strict";

const fs = require("fs");
const path = "file.txt";
let data;

console.info("1) Program is starting up");

data = fs.readFileSync(path, "utf-8");
console.info(data);

console.info("3) End of program!");
