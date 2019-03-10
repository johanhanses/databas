/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showBalance: showBalance,
    moveMoney: moveMoney,
    findAllInTable: findAllInTable,
    createAccount: createAccount,
    showAccount: showAccount,
    editAccount: editAccount,
    deleteAccount: deleteAccount
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
    let sql = `CALL show_balance();`;
    let res;

    res = await db.query(sql);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
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
/**
 * create a new account.
 *
 * @async
 * @param {string} id      An id of the account
 * @param {string} name    The name of the account holder
 * @param {string} balance Initial amount in the account.
 *
 * @returns {void}
 */
async function createAccount(id, name, balance) {
    let sql = `CALL create_account(?, ?, ?);`;
    let res;

    res = await db.query(sql, [id, name, balance]);
    console.log(res);

    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

/**
 * Show details for an account.
 *
 * @async
 * @param {string} id A id of the account.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showAccount(id) {
    let sql = `CALL show_account(?);`;
    let res;

    res = await db.query(sql, [id]);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Edit details on an account.
 *
 * @async
 * @param {string} id      The of the account to be uppdated
 * @param {string} name    The updated name of the account holder.
 * @param {string} balance The updated amount in the account
 *
 * @returns {void}
 */
async function editAccount(id, name, balance) {
    let sql = `CALL edit_account(?, ?, ?);`;
    let res;

    res = await db.query(sql, [id, name, balance]);

    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

/**
 * Edit details on an account.
 *
 * @async
 * @param {string} id The id of the account to be uppdated
 *
 * @returns {void}
 */
async function deleteAccount(id) {
    let sql = `CALL delete_account(?);`;

    await db.query(sql, [id]);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);
}
