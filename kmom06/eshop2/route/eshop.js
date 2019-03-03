/**
 * Route for bank
 */
"use strict";

const express = require("express");
const router = express.Router();
const eshop = require("../src/eshop.js");
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });

router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | CdOff Online"
    };

    res.render("eshop/index", data);
});

router.get("/category", async (req, res) => {
    let data = {
        title: "Category | CdOff Online"
    };

    data.res = await eshop.showCategory();

    res.render("eshop/category", data);
});

router.get("/product", async (req, res) => {
    let data = {
        title: "Products and categories | CdOff Online"
    };

    data.res = await eshop.showProduct();

    res.render("eshop/product", data);
});

router.get("/productonly", async (req, res) => {
    let data = {
        title: "Products | CdOff Online"
    };

    data.res = await eshop.showProductonly();

    res.render("eshop/productonly", data);
});

router.get("/create", async (req, res) => {
    let data = {
        title: "Create product | CdOff Online"
    };

    res.render("eshop/create", data);
});

router.post("/create", urlencodedParser, async (req, res) => {
    // extract the data from the posted form
    //console.log(JSON.stringify(req.body, null, 4));
    // send data to a stored PROCEDURE
    await eshop.createProduct(req.body.id, req.body.description, req.body.price);
    res.redirect("/eshop/productonly");
});

router.get("/edit/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Edit product ${id}` + ` | CdOff online`,
        product: id
    };

    data.res = await eshop.showAProduct(id);

    res.render("eshop/edit", data);
});

router.post("/edit", urlencodedParser, async (req, res) => {
    await eshop.editProduct(req.body.id, req.body.description, req.body.price);
    res.redirect(`/eshop/edit/${req.body.id}`);
});

router.get("/delete/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Delete product ${id}` + ` | CdOff Online`,
        product: id
    };

    data.res = await eshop.showAProduct(id);

    res.render("eshop/delete", data);
});

router.post("/delete", urlencodedParser, async (req, res) => {
    await eshop.deleteProduct(req.body.id);
    res.redirect("/eshop/productonly");
});
///////////////////








// router.get("/account/:id", async (req, res) => {
//     let id = req.params.id;
//     let data = {
//         title: `Account ${id}` + ` | PJH Bank`,
//         account: id
//     };
//
//     data.res = await bank.showAccount(id);
//
//     res.render("bank/account", data);
// });







module.exports = router;
