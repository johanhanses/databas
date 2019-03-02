/**
 * To verify that mysql is installed and is working.
 * Create a connection to the database and execute
 * a query without actually using the database.
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");

/**
 * Main function
 * @async
 * @returns void
 */
(async function() {
    let sql;
    let res;
    const db = await mysql.createConnection(config);

    sql = "SELECT 1+1 AS Sum";
    res = await db.query(sql);

    console.info(res);

    db.end();
}) ();
