TRUNCATE TABLE product;
TRUNCATE TABLE product_cl;
TRUNCATE TABLE product_size;

INSERT INTO product_cl VALUES (1, "Class 1");
INSERT INTO product_cl VALUES (2, "Class 1");
INSERT INTO product_cl VALUES (3, "Chocolate");

INSERT INTO product VALUES (1, "Omo pyykinpesuneste 1L Color", 40000, 1, 'https://public.keskofiles.com/f/k-ruoka/product/8710447330722?w=400&h=250&auto=format&fm=jpg&fit=fillmax&fill=solid&fill-color=ffffff&cs=srgb');
INSERT INTO product VALUES (2, "Omo pyykinpesuneste 2L Color", 68000, 2, 'https://public.keskofiles.com/f/k-ruoka/product/8710447330777?w=400&h=250&auto=format&fm=jpg&fit=fillmax&fill=solid&fill-color=ffffff&cs=srgb');
INSERT INTO product VALUES (3, "Marabou Premium Dark Mint 70% 100g", 600, 3, 'https://public.keskofiles.com/f/k-ruoka/product/7622300313715?w=400&h=250&auto=format&fm=jpg&fit=fillmax&fill=solid&fill-color=ffffff&cs=srgb');
INSERT INTO product VALUES (4, "Marabou Premium 90g Eco 70%", 400, 3, 'https://public.keskofiles.com/f/k-ruoka/product/7622210757395?w=400&h=250&auto=format&fm=jpg&fit=fillmax&fill=solid&fill-color=ffffff&cs=srgb');

INSERT INTO product_size VALUES (1, 1, 1);
INSERT INTO product_size VALUES (2, 1, 2);
