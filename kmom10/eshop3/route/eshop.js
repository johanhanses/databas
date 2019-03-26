/**
 * Route for eshop
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

router.get("/category", async(req, res) => {
    let data = {
        title: "Category | CdOff Online"
    };

    data.res = await eshop.showCategory();

    res.render("eshop/category", data);
});

router.get("/product", async(req, res) => {
    let data = {
        title: "Products and categories | CdOff Online"
    };

    data.res = await eshop.showProduct();

    res.render("eshop/product", data);
});

router.get("/productonly", async(req, res) => {
    let data = {
        title: "Products | CdOff Online"
    };

    data.res = await eshop.showProductOnly();

    res.render("eshop/productonly", data);
});

router.get("/create", async(req, res) => {
    let data = {
        title: "Create product | CdOff Online"
    };

    data.res = await eshop.showCategory();

    res.render("eshop/create", data);
});

router.post("/create", urlencodedParser, /*async*/(req, res) => {
    // extract the data from the posted form
    //console.log(JSON.stringify(req.body, null, 4));
    // send data to a stored PROCEDURE
    console.log(req.body);
    // await eshop.createProduct(
    //     req.body
    //     req.body.description,
    //     req.body.price,
    //     req.body.cid
    // );

    res.redirect("/eshop/product");
});

router.get("/edit/:id", async(req, res) => {
    let id = req.params.id;
    let data = {
        title: `Edit product ${id}` + ` | CdOff online`,
        product: id
    };

    data.res = await eshop.showAProduct(id);

    res.render("eshop/edit", data);
});

router.post("/edit", urlencodedParser, async(req, res) => {
    await eshop.editProduct(req.body.id, req.body.description, req.body.price);
    res.redirect(`/eshop/edit/${req.body.id}`);
});

router.get("/delete/:id", async(req, res) => {
    let id = req.params.id;
    let data = {
        title: `Delete product ${id}` + ` | CdOff Online`,
        product: id
    };

    data.res = await eshop.showAProduct(id);

    res.render("eshop/delete", data);
});

router.post("/delete", urlencodedParser, async(req, res) => {
    await eshop.deleteProduct(req.body.id);
    res.redirect("/eshop/productonly");
});
/////////////////////////////////////////////////
router.get("/customer", async(req, res) => {
    let data = {
        title: "Customers | CdOff Online"
    };

    data.res = await eshop.showCustomers();

    res.render("eshop/customer", data);
});

router.get("/order", async(req, res) => {
    let data = {
        title: "Orders | CdOff Online"
    };

    data.res = await eshop.showAllOrder();

    res.render("eshop/order", data);
});

router.get("/createorder", async(req, res) => {
    let data = {
        title: "Create order | CdOff Online"
    };

    data.res = await eshop.showCustomers();

    res.render("eshop/createorder", data);
});

router.post("/createorder", urlencodedParser, async(req, res) => {
    //console.log(JSON.stringify(req.body, null, 4));

    await eshop.createOrder(req.body);
    res.redirect("/eshop/order");
});

router.get("/show/:id", urlencodedParser, async(req, res) => {
    let id = req.params.id;
    let data = {
        title: "View order  | CdOff Online",
        orderNo: id
    };

    data.res = await eshop.showOrderInfo(id);

    res.render("eshop/show", data);
});

router.get("/createrow/:id", urlencodedParser, async(req, res) => {
    let id = req.params.id;
    let data = {
        title: "View order  | CdOff Online",
        orderNo: id
    };

    data.res = await eshop.showProduct();

    res.render("eshop/createrow", data);
});

router.post("/createrow", urlencodedParser, async(req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));

    await eshop.createOrderRow(req.body);
    res.redirect("/eshop/show/" + req.body.order);
});

router.post("/show", urlencodedParser, async(req, res) => {
    console.log(JSON.stringify(req.body, null, 4));

    await eshop.sendOrder(req.body.id);
    res.redirect("/eshop/order");
});

router.get("/about", (req, res) => {
    let data = {
        title: "Om | CdOff Online"
    };

    res.render("eshop/about", data);
});

















/////////////////////////////////
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
