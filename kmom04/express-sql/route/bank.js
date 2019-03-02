/**
 * Route for bank
 */
"use strict";

const express = require("express");
const router = express.Router();
const bank = require("../src/bank.js");

router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | PJH Bank"
    };

    res.render("bank/index", data);
});

router.get("/balance", async (req, res) => {
    let data = {
        title: "Account balance | PJH Bank"
    };

    data.res = await bank.showBalance();

    res.render("bank/balance", data);
});

router.get("/move-to-adam", async (req, res) => {
    let data = {
        title: "Move to Adam | PJH Bank"
    };

    data.res = await bank.moveMoney("2222", "1111");

    res.render("bank/move-to-adam", data);
});

module.exports = router;
