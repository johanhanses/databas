/**
 * A sample of a main function stating the famous Hello World.
 *
 * @author Johan Hanses, johv18
 */
function main() {
    let a = 1;
    let b;
    let range = "";

    b = a + 1;

    for (let i=0; i < 9; i++) {
        range += i + ", ";
    }

    let j = 8;

    if (j !== 0) {
        j--;
        range += j + ", ";
    }

    let k = 7;

    while (k < 10) {
        k++;
        range += k + ", ";
    }

    console.info("Hello World");
    console.info(range.substring(0, range.length - 2));
    console.info(a, b);
    console.info(Date());
}

main();
