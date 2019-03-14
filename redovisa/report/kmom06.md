##Kmom06


Index hjälper databasen att hålla reda på datan i databasen och normalt så har man index på en kolumn med namn "id". Då ett index bör var unikt och gör då, på så sätt, att när användaren söker i databasen så behöver inte databasen söka i alla datafält för att finna den efterfrågade informationen. Index kan sedan läggas på ytterligare kolumner för att hjälpa databasens frågeoptimerare ytterligare. Om te.x. en kolumn innehåller namn som kan ses som unika och inte förekommer på andra platser i databasen så kan man te.x. skapa ytterligare index i en tabell/ ett schema.  

Jag lade in ett index, förutom primärnyckeln, i tabellen "order" i kolumnen "description" som i mitt fall innehåller namnet på produkterna. Jag applicerade där index enligt "index för delsökning av sträng" ifrån guiden/övningen till kursmomentet. Jag lade också in indexet UNIQUE i tabellen "warehouse_shelf" på kolumnen "description" som beskriver hyllornas namn. Jag valde dessa index då dessa kolumner förekommer ofta i olika sökningar/selectsatser i programmen mot min databas.

Det är fantastiskt med funktioner, jag tyckte order_search()-implementationen verkligen visade på styrkan med detta, i och för sig är funktioner alltid bra att ha, även i andra programmeringsspråk.

Arbetet med eshopen har varit det mest omfattande och svåraste jag hittills gjort inom programmering men också det mest lärorika. Med lärorikt så syftar jag inte bara på SQL utan att jobba med programmering som helhet. Jag är nöjd med resultatet men förbättringspotential finns det massor av. Något jag reflekterade över när jag nyligen implementerade de sista kraven i uppgiften, de kopplade till terminalklienten, var hur enkelt det gick. och när jag funderade över detta och tittade på de tidigare kraven i kmomet men också kmom05 så insåg jag att kraven inte alls var lättare än de tidigare snarare svårare, det var bara en insikt om att jag lärt mig att jobba med mer komplexa uppgifter, en mycket angenäm insikt.

Jag implementerade ingen extrauppgift i detta kmom på min eshop. Jag såg över extrauppgifterna och såg de som roliga och kanske utmanande men jag sparar extraarbetet till eshop3 i kmom07/10.

Mitt TIL för detta kursmoment är nog att jag blivit väldigt säker på mina JOINS, ett par kursmoment tillbaka så var det mest chansningar men nu vet jag vad det jag kodar ger för resultat och detsamma när jag läser andras kod. Att funktioner, triggers och framför allt lagrade procedurer sitter som en smäck skadar inte det heller.
