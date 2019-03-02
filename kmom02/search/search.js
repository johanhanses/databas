/**
 * Search teachers and their departments.
 *
 * @author johan hanses johv18
 */
"use strict";

//Read from commandline
const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const mysql = require("promise-mysql");
const config = require("./config.json");

/**
 * Main function.
 *
 * @async
 * @returns void
 */
(async function () {
    const db = await mysql.createConnection(config);
    let str;

    //ask question and handle answer in async arrow function callback.
    rl.question("What to search for? ", async (search) => {
        str = await searchTeachers(db, search);
        console.info(str);

        rl.close();
        db.end();
    });
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
            lon
        FROM larare
        WHERE
            akronym LIKE ?
            OR fornamn LIKE ?
            OR efternamn LIKE ?
            OR avdelning LIKE ?
            OR lon = ?
        ORDER BY akronym;
    `;
    res = await db.query(sql, [like, like, like, like, search]);
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

    str  = "+-----------+---------------------+-----------+----------+\n";
    str += "| Akronym   | Namn                | Avdelning |   Lön    |\n";
    str += "|-----------|---------------------|-----------|----------|\n";
    for (const row of res) {
        str += "| ";
        str += row.akronym.padEnd(10);
        str += "| ";
        str += (row.fornamn + " " + row.efternamn).padEnd(20);
        str += "| ";
        str += row.avdelning.padEnd(10);
        str += "| ";
        str += row.lon.toString().padStart(8);
        str += " |\n";
    }
    str += "+-----------+---------------------+-----------+----------+\n";

    return str;
}
