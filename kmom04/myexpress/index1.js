/**
 * A sample Express server.
 */
"use strict";

// Enable server to run on port selected by the user selected
// enviroment varible DBWEBB_PORT
const port = process.env.DBWEBB_PORT || 1337;

// set up express server
const express = require("express");
const app = express();

// This is middleware called for all routes
// middleware takes three parameters.
// Its callback ends with a call to next() to proceed to the
// next middleware, ot the actual route.
app.use((req, res, next) => {
    console.info(`Got a request on ${req.path} (${req.method}).`);
    next();
});

// Add a route for the path /
app.get("/", (req, res) => {
    res.send("Hello World");
});

// Add a route for the path /about
app.get("/about", (req, res) => {
    res.send("About something");
});

// start up server and begin listen to requests
app.listen(port, () => {
    console.info(`Server is listening on port ${port}.`);

    // Show which routes are supported
    console.info("Avaliable routes are:");
    app._router.stack.forEach((r) => {
        if (r.route && r.route.path) {
            console.info(r.route.path);
        }
    });
});
