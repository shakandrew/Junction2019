TRUNCATE TABLE user;
TRUNCATE TABLE user_list;
TRUNCATE TABLE product;
TRUNCATE TABLE product_cl;
TRUNCATE TABLE product_size;

INSERT INTO product_cl VALUES (1, "Class 1");
INSERT INTO product_cl VALUES (2, "Class 1");
INSERT INTO product_cl VALUES (3, "Chocolate");

INSERT INTO product VALUES (1, "Omo pyykinpesuneste 1L Color", 40000, 1, 'http://students.mimuw.edu.pl/~ps388939/greenlist/detergent_1l.png');
INSERT INTO product VALUES (2, "Omo pyykinpesuneste 2L Color", 68000, 2, 'http://students.mimuw.edu.pl/~ps388939/greenlist/detergent_2l.png');
INSERT INTO product VALUES (3, "Marabou Premium Dark Mint 70% 100g", 600, 3, 'http://students.mimuw.edu.pl/~ps388939/greenlist/chocolate.png');
INSERT INTO product VALUES (4, "Marabou Premium 90g Eco 70%", 400, 3, 'http://students.mimuw.edu.pl/~ps388939/greenlist/chocolate_eco.png');

INSERT INTO product_size VALUES (1, 1, 1);
INSERT INTO product_size VALUES (2, 1, 2);
