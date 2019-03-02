/**
 * Search on teachers salary and competence from the database skolan.
 *
 * @author Johan Hanses johv18 2019-01-28
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");

//Read from commandline
const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Promisify rl.question to guestion
const util = require("util");

rl.question[util.promisify.custom] = (arg) => {
    return new Promise((resolve) => {
        rl.question(arg, resolve);
    });
};
const question = util.promisify(rl.question);



/**
 * Main function.
 *
 * @async
 * @returns void
 */
(async function () {
    const db = await mysql.createConnection(config);
    let str;
    let searchMin;
    let searchMax;

    searchMin = await question("Enter minimum value? ");
    searchMax = await question("Enter maximum value? ");
    str = await searchTeachers(db, searchMin, searchMax);
    console.info(str);

    rl.close();
    db.end();
}) ();

/**
 * Output resultset as formatted table with details on a teacher.
 *
 * @async
 * @param {connection} db     Database connection.
 * @param {string}     search String to search for.
 *
 * @returns {string} Formatted table to print out.
 */
async function searchTeachers(db, searchMin, searchMax) {
    let sql;
    let res;
    let str;
    // let like = `%${searchMin}% %${searchMax}%` ;

    console.info(`Searching for values between ${searchMin} - ${searchMax}`);

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon,
            kompetens,
            DATE_FORMAT(fodd, "%Y-%m-%d") AS fodd
        FROM larare
        WHERE
            (lon >= ? AND lon <= ?)
            OR
            (kompetens >= ? AND kompetens <= ?)
        ORDER BY akronym;
    `;
    res = await db.query(sql, [searchMin, searchMax, searchMin, searchMax]);
    str = teacherAsTable(res);
    return str;
}

/**
 * Output resultset as formatted table with details on teachers.
 *
 * @param {Array} res Resultset with details on from database query.
 *
 * @returns {string} Formatted table to print out.
 */
function teacherAsTable(res) {
    let str;

    str  = "+-----------+---------------------+-----------+----------+------+------------+\n";
    str += "| Akronym   | Namn                | Avdelning |   Lön    | Komp | Född       |\n";
    str += "|-----------|---------------------|-----------|----------|------+------------+\n";
    for (const row of res) {
        str += "| ";
        str += row.akronym.padEnd(10);
        str += "| ";
        str += (row.fornamn + " " + row.efternamn).padEnd(20);
        str += "| ";
        str += row.avdelning.padEnd(10);
        str += "| ";
        str += row.lon.toString().padStart(9);
        str += "| ";
        str += row.kompetens.toString().padStart(5);
        str += "| ";
        str += row.fodd;
        str += " |\n";
    }
    str += "+-----------+---------------------+-----------+----------+------+------------+\n";

    return str;
}
