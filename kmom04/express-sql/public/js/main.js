/**
 * A function to wrap it all in.
 */
(function () {
    "use strict";

    let messageElement = document.getElementById('message');

    let now = new Date();
    let timeOfDay = now.getHours();
    let message = "God afton";

    if (timeOfDay < 10) {
        message = "God morgon";
    } else if (timeOfDay < 18) {
        message = "God dag";
    }

    messageElement.textContent = message + " och välkommen till";

    console.log(messageElement);
}());
