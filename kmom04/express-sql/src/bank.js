/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showBalance: showBalance,
    moveMoney: moveMoney,
    findAllInTable: findAllInTable
};

const mysql = require("promise-mysql");
const config = require("../config/db/bank.json");
let db;

/**
 * Main function.
 * @async
 * @returns void
 */
(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

/**
 * Show all entries in the account table.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showBalance() {
    return findAllInTable("account");
}

/**
 * Show all entries in the selected table.
 *
 * @async
 * @param {string} table A valid table name.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function findAllInTable(table) {
    let sql =`SELECT * FROM ??;`;
    let res;

    res = await db.query(sql, [table]);
    // console.info(`SQL: ${sql} (${table}) got ${res.lengt} rows.`);
    console.table(res);
    return res;
}

async function moveMoney(from, to) {
    let sql =`
        START TRANSACTION;

        UPDATE account
        SET
            balance = balance + 1.5
        WHERE
            id = ?;

        UPDATE account
        SET
            balance = balance - 1.5

        WHERE
            id = ?;

        COMMIT;
        `;

    let res;

    res = await db.query(sql, [to, from]);
    // console.info(`SQL: ${sql} (${trans}) got ${res.lengt} rows.`);

    return res;
}
