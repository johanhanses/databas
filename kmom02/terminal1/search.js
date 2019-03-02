/**
 * Search teachers or any of their attribute except birthdate from the database skolan.
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
    let search;

    search = await question("What to search for? ");
    str = await searchTeachers(db, search);
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
async function searchTeachers(db, search) {
    let sql;
    let res;
    let str;
    let like = `%${search}%`;

    console.info(`Searching for: ${search}`);

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
            akronym LIKE ?
            OR fornamn LIKE ?
            OR efternamn LIKE ?
            OR avdelning LIKE ?
            OR lon = ?
            OR kompetens LIKE ?
        ORDER BY akronym;
    `;
    res = await db.query(sql, [like, like, like, like, search, like]);
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
