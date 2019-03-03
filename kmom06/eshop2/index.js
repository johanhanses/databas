/**
 * A sample Express server.
 */
"use strict";

const port = process.env.DBWEBB_PORT || 1337;
const express = require("express");
const app = express();
const middleware = require("./middleware/index.js");
const path = require("path");
const routeEshop = require("./route/eshop.js");

app.use(middleware.logIncomingToConsole);
app.use(express.static(path.join(__dirname, "public")));
app.use("/eshop", routeEshop);
app.set("view engine", "ejs");
app.listen(port, logStartUpDetailsToConsole);

/**
 * Log app details to console when starting up.
 *
 * @return {void}
 */
function logStartUpDetailsToConsole() {
    let routes = [];

    //find what routes are supported
    app._router.stack.forEach((middleware) => {
        if (middleware.route) {
            // routes registered directly on the app
            routes.push(middleware.route);
        } else if (middleware.name === "router") {
            // routes added as router middleware
            middleware.handle.stack.forEach((handler) => {
                let route;

                route = handler.route;
                route && routes.push(route);
            });
        }
    });
    console.info(`Server is listening on port ${port}.`);
    console.info("Avaliable routes are:");
    console.info(routes);
}
