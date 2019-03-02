<?php
require __DIR__ . "/vendor/autoload.php";
?>

<!doctype html>
<html lang="sv">
<head>
    <meta charset="utf-8">
    <title>Redovisning | Databasteknologier för webben</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="icon" href="favicon.ico">
</head>

<body>



<header>
    <nav>
        <a href="me.html">Me</a> |
        <a href="redovisning.php">Redovisning</a> |
        <a href="om.html">Om</a>
    </nav>
</header>
<hr>



<article>

<header>
<h1>Redovisning av kursmoment i kursen Databasteknologier för webben</h1>
</header>

<section>
    <?php
    $filename = __DIR__ . "/report/kmom01.md";
    $text     = file_get_contents($filename);
    $filter   = new \Anax\TextFilter\TextFilter();
    $parsed   = $filter->parse($text, ["shortcode", "markdown"]);
    echo $parsed->text;
    ?>
</section>

<section>
    <?php
    $filename = __DIR__ . "/report/kmom02.md";
    $text     = file_get_contents($filename);
    $filter   = new \Anax\TextFilter\TextFilter();
    $parsed   = $filter->parse($text, ["shortcode", "markdown"]);
    echo $parsed->text;
    ?>
</section>

<section>
    <?php
    $filename = __DIR__ . "/report/kmom03.md";
    $text     = file_get_contents($filename);
    $filter   = new \Anax\TextFilter\TextFilter();
    $parsed   = $filter->parse($text, ["shortcode", "markdown"]);
    echo $parsed->text;
    ?>
</section>

<section>
    <?php
    $filename = __DIR__ . "/report/kmom04.md";
    $text     = file_get_contents($filename);
    $filter   = new \Anax\TextFilter\TextFilter();
    $parsed   = $filter->parse($text, ["shortcode", "markdown"]);
    echo $parsed->text;
    ?>
</section>

<section>
<h2>Kmom05</h2>
<p>Här är redovisningstexten</p>
</section>

<section>
<h2>Kmom06</h2>
<p>Här är redovisningstexten</p>
</section>

<section>
<h2>Kmom07-10</h2>
<p>Här är redovisningstexten</p>
</section>

<footer>
    <hr>
    <a href="http://validator.w3.org/unicorn/check?ucn_uri=referer&amp;ucn_task=conformance" target="blank">Unicorn</a>
</footer>

</article>



<script type="text/javascript" src="js/main.js"></script>
</body>
</html>
