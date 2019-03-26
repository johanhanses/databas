/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showCategory: showCategory,
    showProduct: showProduct,
    showProductOnly: showProductOnly,
    showAProduct: showAProduct,
    createProduct: createProduct,
    editProduct: editProduct,
    deleteProduct: deleteProduct,
    showLog: showLog,
    showShelf: showShelf,
    showInventory: showInventory,
    searchInventory: searchInventory,
    addToShelf: addToShelf,
    removeFromShelf: removeFromShelf,
    showCustomers: showCustomers,
    showAllOrder: showAllOrder,
    createOrder: createOrder,
    showOrderInfo: showOrderInfo,
    createOrderRow: createOrderRow,
    sendOrder: sendOrder,
    showAllAboutOrder: showAllAboutOrder,
    searchOrder: searchOrder,
    searchPicklist: searchPicklist,
    shipOrder: shipOrder,
    about: about
};

const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");
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

// ////////////////////////////////////////////////////
// functions for index.js
// ////////////////////////////////////////////////////
/**
 * Show all entries in the category table.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showCategory() {
    let sql = `CALL show_category();`;
    let res;

    res = await db.query(sql);

    return res[0];
}

/**
 * Show all entries in the product table with joins from other tables.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showProduct() {
    let sql = `CALL show_product();`;
    let res;

    res = await db.query(sql);

    return res[0];
}

/**
 * Show all entries in the product table only.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showProductOnly() {
    let sql = `CALL show_productonly();`;
    let res;

    res = await db.query(sql);

    return res[0];
}

/**
 * create a new product
 *
 * @async
 * @param {string} id      An id of the product
 * @param {string} description   The description of the product
 * @param {string} price    the price for the product
 * @param {string} cat_id the id for the category of the product
 *
 * @returns {void}
 */
async function createProduct(id, description, price, cid) {
    let sql = `CALL create_product(?, ?, ?, ?);`;
    let res;

    res = await db.query(sql, [id, description, price, cid]);
    console.log(res[1]);
}

/**
 * Show details for a product
 *
 * @async
 * @param {string} id A id of the product.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showAProduct(id) {
    let sql = `CALL show_a_product(?);`;
    let res;

    res = await db.query(sql, [id]);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Edit details on a product.
 *
 * @async
 * @param {string} id      The id of the product to be updated
 * @param {string} name    The updated description of the product.
 * @param {string} price The updated price of the product
 *
 * @returns {void}
 */
async function editProduct(id, description, price) {
    let sql = `CALL edit_product(?, ?, ?);`;
    let res;

    res = await db.query(sql, [id, description, price]);

    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

/**
 * Delete a product from table.
 *
 * @async
 * @param {string} id The id of the product to be deleted
 *
 * @returns {void}
 */
async function deleteProduct(id) {
    let sql = `CALL delete_product(?);`;

    await db.query(sql, [id]);
}

/**
 * Show all entries in the customer table.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showCustomers() {
    let sql = `CALL show_customer();`;
    let res;

    res = await db.query(sql);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show all orders and order info.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showAllOrder() {
    let sql = `CALL show_all_order();`;
    let res;

    res = await db.query(sql);
    // console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * create a new order
 *
 * @async
 * @param {string} id      An id of the customer
 *
 * @returns {void}
 */
async function createOrder(body) {
    let sql = `CALL create_order(?);`;

    await db.query(sql, [body.customer_id]);
}

//show order showOrderInfo
async function showOrderInfo(id) {
    let sql = "CALL show_order_info(?);";
    let res;

    res = await db.query(sql, [id]);

    return res[0];
}

//create a row in order_row table
async function createOrderRow(body) {
    let sql = "CALL create_order_row(?, ?, ?);";
    let res;

    res = await db.query(sql, [
        body.order,
        body.product,
        body.items
    ]);

    return res[0];
}

//set order to beställd
async function sendOrder(id) {
    let sql = "CALL send_order(?);";
    let res;

    res = await db.query(sql, [id]);

    return res[0];
}
// /////////////////////////////////////////////////////////////
// functions for cli.js
// /////////////////////////////////////////////////////////////

// view event_log table
async function showLog(number) {
    let like = `${number}`;

    console.info(`View: ${number} entries in the event_log table`);

    let sql = `CALL show_log(?)`;

    let res = await db.query(sql, [like]);

    console.table(res[0]);
}

// view event_log table
async function showShelf() {
    console.info(`These are the shelves avaliable at the warehouse`);

    let sql = `CALL show_shelf()`;

    let res = await db.query(sql);

    console.table(res[0]);
}

// view inventory
async function showInventory() {
    console.info(`These are the products and their location at the warehouse`);

    let sql = `CALL show_inventory()`;

    let res = await db.query(sql);

    console.table(res[0]);
}

// search inventory
async function searchInventory(str) {
    let like = `%${str}%`;

    console.info(`Your search %${str}% returned:`);

    let sql = `CALL search_product(?);`;

    let res = await db.query(sql, [like]);

    console.table(res[0]);
}

// add to shelf
async function addToShelf(id, shelf, stock) {
    // let like = `%${str}%`;

    // console.info(`Your search %${str}% returned:`);

    let sql = `CALL add_to_shelf(?, ?, ?);`;

    await db.query(sql, [id, shelf, stock]);

    console.info("Stock has been updated");
}

// remove from shelf
async function removeFromShelf(id, shelf, stock) {
    let sql = `CALL remove_from_shelf(?, ?, ?);`;

    let res = await db.query(sql, [id, shelf, stock]);

    console.info(res[0]);
    // console.info("Stock has been updated");
}

/**
 * Show all orders and order info.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showAllAboutOrder() {
    console.info(`These are the orders and their status`);

    let sql = `CALL show_all_about_order();`;

    let res = await db.query(sql);

    console.table(res[0]);
}

// search order
async function searchOrder(id) {
    let like = `${id}`;

    console.info(`Your search ${id} on order id or customer id returned:`);

    let sql = `CALL search_order(?);`;

    let res = await db.query(sql, [like]);

    console.table(res[0]);
}

// search picklist
async function searchPicklist(id) {
    let like = `${id}`;

    console.info(`Your search ${id} on order id returned:`);

    let sql = `CALL search_picklist(?);`;

    let res = await db.query(sql, [like]);

    console.table(res[0]);
}

//set order to skickad
async function shipOrder(id) {
    let sql = "CALL ship_order(?);";

    let res = await db.query(sql, [id]);

    // console.info(`Order no. ${id} has been shiped`);
    console.info(res[1]);
}

// about
function about() {
    console.info(`Skapad av Johan Hanses(johv18)`);
}


////////////////////
