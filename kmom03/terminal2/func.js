/**
* Some methods in an object for the crazy tool for kmom03 in the course databas at BTH
 *
 * @author Johan Hanses johv18
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");

const teachers = {
    //show info about all the teacher in a table
    larare: async function () {
        const db = await mysql.createConnection(config);

        let sql = `
            SELECT
                akronym,
                fornamn,
                efternamn,
                avdelning,
                lon,
                kompetens,
                TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS ålder
            FROM larare
            ORDER BY akronym
        `;

        let res = await db.query(sql);

        console.table(res);

        db.end();
    },
    // show the change in kompetens after the salaryreview as a table
    kompetens: async function () {
        const db = await mysql.createConnection(config);

        let sql = `
            SELECT
                akronym,
                fornamn,
                efternamn,
                prekomp,
                nukomp,
                diffkomp
            FROM Vlonerevision
            ORDER BY nukomp DESC, diffkomp DESC
        `;

        let res = await db.query(sql);

        console.table(res);

        db.end();
    },
    // show the change in salary after the salaryreview as a table
    lon: async function () {
        const db = await mysql.createConnection(config);

        let sql = `
            SELECT
                akronym,
                fornamn,
                efternamn,
                pre,
                nu,
                diff,
                proc,
                mini
            FROM v_lonerevision
            ORDER BY proc DESC
        `;

        let res = await db.query(sql);

        console.table(res);

        db.end();
    },
    // search larare table
    sok: async function (searchString) {
        const db = await mysql.createConnection(config);

        let like = `%${searchString}%`;

        console.info(`Searching for: ${searchString}`);

        let sql = `
            SELECT
                akronym,
                fornamn,
                efternamn,
                avdelning,
                lon,
                kompetens,
                TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS ålder
            FROM larare
            WHERE
                akronym LIKE ?
                OR fornamn LIKE ?
                OR efternamn LIKE ?
                OR avdelning LIKE ?
                OR lon = ?
                OR kompetens LIKE ?
                OR fodd = ?
            ORDER BY akronym
            `;

        let res = await db.query(sql, [like, like, like, like, searchString, like, searchString]);

        console.table(res);

        db.end();
    },
    // update teachers salary using akronym as identifier
    nylon: async function (akr, cash) {
        const db = await mysql.createConnection(config);


        console.info(`Setting salary: ${cash} to ${akr}`);

        let sql = `
            UPDATE
                larare
            SET lon = ?
            WHERE akronym = ?
            `;

        let res = await db.query(sql, [cash, akr]);

        console.table(res);

        db.end();
    }
};

module.exports = teachers;
