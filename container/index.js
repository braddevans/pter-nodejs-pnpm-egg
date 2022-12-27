console.log("It Works :D");

const readline = require("readline");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

console.log("waiting for console input");

rl.question("(MAIN)> ", function (command) {
    console.log(`${command}`);
    rl.close();
});

rl.on("close", function () {
    console.log("\nEXIT !!!");
    process.exit(0);
});