/**
 * A collection of useful functions.
 *
 * @author Johan Hanses, johv18
 */
"use strict";

module.exports = {
    "stringRange": stringRange
};



function stringRange(a, b, sep =", ") {
    let res = "";
    let i = a;

    while (i < b) {
        res += i + sep;
        i++;
    }

    res = res.substring(0, res.length - sep.length);
    return res;
}

// console.log(stringRange(1, 10));
// console.log(stringRange(1, 10, "-"));
