-- =====================================================================
-- Chaayos location analysis: where should the next outlet open in Gurugram?
-- ################ PART 1: CREATE DATABASE, TABLES AND LOAD DATA ################
DROP DATABASE IF EXISTS chaayos_location;
CREATE DATABASE chaayos_location;
USE chaayos_location;

CREATE TABLE outlets (
  outlet_id INT PRIMARY KEY, outlet_name VARCHAR(150), location_name VARCHAR(100), sector VARCHAR(10),
  outlet_type VARCHAR(30), rating DECIMAL(2,1), review_count INT, latitude DECIMAL(10,7), longitude DECIMAL(10,7));
CREATE TABLE poi (
  poi_id INT PRIMARY KEY, poi_name VARCHAR(150), poi_type VARCHAR(30), rating DECIMAL(2,1) NULL,
  review_count INT NULL, latitude DECIMAL(10,7), longitude DECIMAL(10,7));
CREATE TABLE direct_competitors (
  competitor_id INT PRIMARY KEY, brand VARCHAR(50), outlet_name VARCHAR(150), location_name VARCHAR(100),
  rating DECIMAL(2,1) NULL, review_count INT NULL, latitude DECIMAL(10,7), longitude DECIMAL(10,7));
CREATE TABLE indirect_cafes (
  cafe_id INT PRIMARY KEY, brand VARCHAR(50), outlet_name VARCHAR(150), rating DECIMAL(2,1) NULL,
  review_count INT NULL, latitude DECIMAL(10,7), longitude DECIMAL(10,7));

INSERT INTO outlets (outlet_id, outlet_name, location_name, sector, outlet_type, rating, review_count, latitude, longitude) VALUES
  (1, 'Chaayos Cafe | Central Plaza Mall | Sector 53', 'Central Plaza Mall', '53', 'mall', 4.2, 3842, 28.4430101, 77.1009004),
  (2, 'Chaayos Cafe | Galleria Market | Sector 28', 'Galleria Market', '28', 'street', 4.2, 3923, 28.4673879, 77.0821819),
  (3, 'Chaayos Cafe | 83 Avenue | Sector 83', '83 Avenue', '83', 'mall', 4.2, 130, 28.3970404, 76.9632194),
  (4, 'Chaayos Cafe | Reach 3 Road | Sector 70', 'Reach 3 Road', '70', 'street', 4.3, 257, 28.3909625, 77.0305084),
  (5, 'Chaayos Cafe | Iris Broadway | Sector 85', 'Iris Broadway', '85', 'mall', 4.2, 396, 28.4040275, 76.9479222),
  (6, 'Chaayos Experience | Magnum Global Park', 'Magnum Global Park', NULL, 'office_park', 4.7, 327, 28.4116083, 77.1069559),
  (7, 'Chaayos Cafe | Satya The Hive Mall | Sector 102', 'Satya The Hive Mall', '102', 'mall', 4.5, 42, 28.4714015, 76.962975),
  (8, 'Chaayos Cafe | DLF Cyber Greens | Sector 24', 'DLF Cyber Greens', '24', 'office_park', 4.4, 166, 28.4941497, 77.0929735),
  (9, 'Chaayos Cafe | Felix Plaza Mall | Sector 82A', 'Felix Plaza Mall', '82A', 'mall', 4.7, 23, 28.3829925, 76.96666),
  (10, 'Chaayos Cafe | Golf Course Road | Sector 54', 'Golf Course Road', '54', 'street', 4.2, 158, 28.4352763, 77.1046987),
  (11, 'Chaayos Cafe | Artemis Hospital | Sector 51', 'Artemis Hospital', '51', 'hospital', 4.6, 24, 28.4316368, 77.0722561),
  (12, 'Chaayos - Good Earth City Center', 'Good Earth City Center', NULL, 'mall', 4.1, 1087, 28.4214481, 77.0531627),
  (13, 'Chaayos Cafe at Cyber Hub', 'Cyber Hub', NULL, 'office_park', 4.3, 418, 28.4949194, 77.0882806),
  (14, 'Chaayos Cafe | Capital Cyberscape | Sector 59', 'Capital Cyberscape', '59', 'office_park', 4.2, 70, 28.4006649, 77.10427),
  (15, 'Chaayos Cafe | Ardee Mall | Sector 52', 'Ardee Mall', '52', 'mall', 4.2, 452, 28.4451466, 77.0807682),
  (16, 'Chaayos Cafe | Elan Miracle | Sector 84', 'Elan Miracle', '84', 'mall', 4.3, 134, 28.4149328, 76.9637266),
  (17, 'Chaayos Cafe | AIPL Joy Street | Sector 66', 'AIPL Joy Street', '66', 'mall', 4.2, 253, 28.3921489, 77.0591471),
  (18, 'Chaayos Cafe | Khasrupur | Sector 109', 'Khasrupur', '109', 'street', 4.3, 135, 28.5040689, 77.0048946),
  (19, 'Chaayos Cafe | One Horizon Centre | Sector 43', 'One Horizon Centre', '43', 'office_park', 4.2, 438, 28.4509678, 77.0979383),
  (20, 'Chaayos Cafe | Sohna Road | Sector 49', 'Sohna Road', '49', 'office_park', 4.2, 570, 28.4060331, 77.0448114),
  (21, 'Chaayos Cafe | DLF Cyberpark | Sector 20', 'DLF Cyberpark', '20', 'office_park', 4.6, 207, 28.5036323, 77.0894518),
  (22, 'Chaayos Experience | Sikandarpur', 'Sikandarpur', NULL, 'office_park', 4.5, 743, 28.4804159, 77.0926211),
  (23, 'Chaayos Cafe | Metro World Mall', 'Metro World Mall', NULL, 'mall', 3.9, 142, 28.4288478, 77.0996876),
  (24, 'Chaayos Cafe | M3M Route 65 | Sector 65', 'M3M Route 65', '65', 'mall', 4.4, 18, 28.3988243, 77.0750521),
  (25, 'Chaayos Cafe | Unitech InfoSpace | Sector 21', 'Unitech InfoSpace', '21', 'office_park', 4.5, 297, 28.5097702, 77.0717282),
  (26, 'Chaayos Cafe | Sushant Lok | Sector 43', 'Sushant Lok', '43', 'street', 4.3, 268, 28.4530527, 77.0824365),
  (27, 'Chaayos Cafe At Downtown Sec 29, Gurgaon', 'Downtown', '29', 'mall', 4.4, 44, 28.4633544, 77.0669966),
  (28, 'Chaayos Cafe | Galaxy Road | Sector 15', 'Galaxy Road', '15', 'street', 4.3, 41, 28.4633882, 77.0482003),
  (29, 'Chaayos Cafe | Nirvana Courtyard', 'Nirvana Courtyard', NULL, 'mall', 4.5, 123, 28.4144005, 77.0654617),
  (30, 'Chaayos Cafe | Fortis Memorial | Sector 44', 'Fortis Memorial', '44', 'hospital', 4.3, 30, 28.4567324, 77.0727312),
  (31, 'Chaayos Cafe at DLF Cyber City - Building 5', 'DLF Cyber City Building 5', NULL, 'office_park', 4.2, 719, 28.4899373, 77.0920985),
  (32, 'Chaayos Cafe at Ambience Mall', 'Ambience Mall', NULL, 'mall', 4.0, 244, 28.5047166, 77.0970095),
  (33, 'Chaayos Cafe | Global Foyer Mall | Palam Vihar', 'Global Foyer Mall', NULL, 'mall', 4.4, 29, 28.5111279, 77.0401721),
  (34, 'Chaayos Cafe | Infinity Tower | Cyber City', 'Infinity Tower', NULL, 'office_park', 4.4, 2161, 28.4962872, 77.0910943);

INSERT INTO poi (poi_id, poi_name, poi_type, rating, review_count, latitude, longitude) VALUES
  (1, 'Ambience Mall', 'mall', 4.6, 131077, 28.5048748, 77.0969594),
  (2, 'DLF CyberHub', 'mall', 4.7, 78006, 28.4951598, 77.0892137),
  (3, 'MGF Metropolitan Mall', 'mall', 4.3, 36010, 28.4809085, 77.0802798),
  (4, 'Sahara Mall', 'mall', 3.9, 34239, 28.4794099, 77.0862897),
  (5, 'HUDA Market, Sector 14', 'mall', 4.3, 23653, 28.473778, 77.0475697),
  (6, 'Raheja Mall', 'mall', 3.7, 16961, 28.4233145, 77.0394082),
  (7, 'Dreamz Mall', 'mall', 3.8, 15909, 28.4728616, 77.0177572),
  (8, 'Omaxe City Centre', 'mall', 3.8, 15582, 28.4108859, 77.0432963),
  (9, 'Omaxe Celebration Mall', 'mall', 3.7, 15535, 28.4274185, 77.0361638),
  (10, 'Airia Mall', 'mall', 4.5, 15335, 28.3831981, 77.052905),
  (11, 'Baani Square', 'mall', 4.3, 14162, 28.4257225, 77.0577849),
  (12, 'Ardee Mall', 'mall', 4.4, 13078, 28.4450079, 77.0807773),
  (13, 'MGF Megacity Mall', 'mall', 4.1, 12273, 28.4797196, 77.0895512),
  (14, 'Hong Kong Bazaar', 'mall', 4.0, 11477, 28.420999, 77.0905606),
  (15, 'Star Mall', 'mall', 4.0, 9948, 28.4612445, 77.052757),
  (16, 'Mega Mall Gurgaon', 'mall', 4.2, 8432, 28.4758757, 77.0933341),
  (17, 'DLF Galleria', 'mall', 4.5, 7059, 28.4671497, 77.0817404),
  (18, 'Sapphire Mall', 'mall', 4.1, 7011, 28.4117963, 77.0487276),
  (19, 'The Shopping Mall, Arjun marg', 'mall', 4.1, 6615, 28.4661344, 77.0997046),
  (20, 'Good Earth City Center Mall', 'mall', 4.4, 4313, 28.4216825, 77.0534786),
  (21, 'Grand Mall', 'mall', 4.0, 4285, 28.4795985, 77.0898417),
  (22, 'ILD Trade Centre', 'mall', 4.0, 4012, 28.4247864, 77.0391352),
  (23, 'Gold city Manama', 'mall', 4.4, 3597, 28.4507667, 77.0786475),
  (24, 'Central Plaza Mall', 'mall', 4.3, 3544, 28.4430139, 77.1008718),
  (25, 'Mall Fifty One', 'mall', 4.2, 3535, 28.4348478, 77.0681279),
  (26, 'Eros City Square', 'mall', 4.3, 3454, 28.4124717, 77.0553761),
  (27, 'The Esplanade Mall', 'mall', 4.2, 3335, 28.4535998, 76.992598),
  (28, 'Plaza Mall', 'mall', 4.1, 2658, 28.4777114, 77.0732598),
  (29, 'HUDA city center', 'mall', 4.4, 2365, 28.4591521, 77.0729103),
  (30, 'S S Plaza', 'mall', 4.1, 2358, 28.4269403, 77.0569854),
  (31, 'South point Mall', 'mall', 4.3, 2286, 28.4479546, 77.0992365),
  (32, 'Sushant Shopping Arcade', 'mall', 4.2, 2226, 28.4608417, 77.0791792),
  (33, 'M2K Corporate Park Shopping Plaza', 'mall', 4.0, 1514, 28.4270009, 77.0585),
  (34, 'MGF Metropolis Mall', 'mall', 4.2, 1415, 28.4784857, 77.0818051),
  (35, 'Horizon Plaza', 'mall', 4.6, 1318, 28.4512907, 77.0973104),
  (36, 'JMD Regent Plaza Mall', 'mall', 4.2, 1271, 28.481266, 77.1004388),
  (37, 'Elements One Mall', 'mall', 4.1, 1189, 28.4200401, 77.0505608),
  (38, 'Jmd Regent Arcade Mall', 'mall', 4.2, 1102, 28.4798511, 77.0885311),
  (39, 'Metro World Mall', 'mall', 4.0, 1028, 28.4286663, 77.0996807),
  (40, 'Satyam Plaza', 'mall', 3.9, 969, 28.4602203, 77.0335388),
  (41, 'Queens Plaza Market', 'mall', 4.1, 927, 28.4542419, 77.0852783),
  (42, 'Elan Town Centre', 'mall', 4.3, 779, 28.3843185, 77.0542983),
  (43, 'Kataria Complex', 'mall', 3.8, 669, 28.488102, 77.0196076),
  (44, 'Baba Chitru Complex', 'mall', 4.1, 557, 28.4311445, 77.0899025),
  (45, 'Bestech Central Square Mall', 'mall', 4.1, 394, 28.4215969, 77.0903498),
  (46, 'City Centre Mall', 'mall', 4.3, 340, 28.4788618, 77.0806421),
  (47, 'Paradise Mall', 'mall', 4.3, 322, 28.4120281, 77.0507805),
  (48, 'Ireo Grand View High Street Gurugram', 'mall', 4.3, 256, 28.4158799, 77.102038),
  (49, 'Tapasya One', 'mall', 4.5, 247, 28.4367885, 77.1031191),
  (50, 'D Block Commercial Shopping Centre', 'mall', 4.1, 222, 28.4172158, 77.0504708);
INSERT INTO poi (poi_id, poi_name, poi_type, rating, review_count, latitude, longitude) VALUES
  (51, 'Trilium Avenue', 'mall', 4.3, 198, 28.4615242, 77.0687357),
  (52, 'Ansal Plaza Mall', 'mall', 4.1, 195, 28.4332536, 77.0364604),
  (53, 'Ninex City Mart', 'mall', 4.0, 136, 28.4167421, 77.0415138),
  (54, 'Worldmark', 'office_park', 4.6, 12042, 28.3976496, 77.0721006),
  (55, 'Work Candor TechSpace', 'office_park', 4.3, 9359, 28.5100597, 77.0725492),
  (56, 'JMD Megapolis', 'office_park', 4.3, 8169, 28.4198677, 77.0382266),
  (57, 'Signature Towers', 'office_park', 4.2, 3890, 28.4663919, 77.0583071),
  (58, 'M3M Urbana Business Park', 'office_park', 4.4, 3846, 28.3902542, 77.065441),
  (59, 'DLF One Horizon Center', 'office_park', 4.7, 3610, 28.4511625, 77.0964531),
  (60, 'Global Business Park', 'office_park', 4.3, 3007, 28.4810142, 77.1023305),
  (61, 'DLF Cyberpark', 'office_park', 4.7, 2702, 28.5021239, 77.0909955),
  (62, 'Vatika Business Centre & Co-working Spaces', 'office_park', 4.4, 2614, 28.4061013, 77.0445654),
  (63, 'TCS, Cyber City', 'office_park', 4.4, 2099, 28.496629, 77.0966458),
  (64, 'Centrum Plaza', 'office_park', 4.0, 2084, 28.4337717, 77.103908),
  (65, 'Airtel Center, Sector 18', 'office_park', 4.3, 2084, 28.4912178, 77.0803009),
  (66, 'DLF Infinity Tower A', 'office_park', 4.5, 1966, 28.4953404, 77.0915841),
  (67, 'Candor Techspace', 'office_park', 4.3, 1756, 28.4258145, 77.0311845),
  (68, 'FIS Global Business Solutions India', 'office_park', 4.1, 1710, 28.4900929, 77.078841),
  (69, 'Genpact India', 'office_park', 4.4, 1643, 28.4488285, 77.0988747),
  (70, 'Suncity Success Tower', 'office_park', 4.2, 1531, 28.4082791, 77.070448),
  (71, 'Kpmg', 'office_park', 4.5, 1519, 28.4933613, 77.0884098),
  (72, 'Vatika Towers', 'office_park', 4.3, 1359, 28.4378689, 77.1050666),
  (73, 'Sewa Tower', 'office_park', 4.2, 1328, 28.4923732, 77.0789016),
  (74, 'DLF Building 9B, Cyber City Gurugram', 'office_park', 4.6, 1231, 28.4947732, 77.0933785),
  (75, 'Concentrix, DLF Centre Court', 'office_park', 4.3, 1186, 28.4574039, 77.097724),
  (76, 'Magnum Towers', 'office_park', 4.2, 1115, 28.4113492, 77.108402),
  (77, 'DLF Downtown', 'office_park', 4.6, 1085, 28.5030454, 77.0958937),
  (78, 'Teleperformance (Ex Majorel)/iEnergizer IT services', 'office_park', 4.2, 1080, 28.5101678, 77.0867849),
  (79, 'AIHP Signature', 'office_park', 4.1, 925, 28.499461, 77.0784927),
  (80, 'DLF Corporate Park', 'office_park', 4.4, 872, 28.482756, 77.1051404),
  (81, 'DLF Square', 'office_park', 4.4, 837, 28.4912375, 77.0842312),
  (82, 'Times Internet', 'office_park', 4.4, 824, 28.5052594, 77.0881479),
  (83, 'Novus Tower', 'office_park', 4.4, 811, 28.4915428, 77.0778137),
  (84, 'BPTP Park Centra', 'office_park', 4.3, 748, 28.4599285, 77.0521832),
  (85, 'Orchid Business Park', 'office_park', 4.0, 711, 28.4260524, 77.0365727),
  (86, 'MobiKwik HQ', 'office_park', 3.0, 704, 28.4464971, 77.0993138),
  (87, 'DLF Building 14', 'office_park', 4.6, 696, 28.4968631, 77.0943635),
  (88, 'International Tech Park Gurgaon', 'office_park', 4.5, 692, 28.408087, 77.1166075),
  (89, 'Cyber Park', 'office_park', 4.3, 670, 28.4350259, 77.105939),
  (90, 'EY GDS Gurgaon', 'office_park', 4.6, 667, 28.5033599, 77.0894065),
  (91, 'Vatika Business Centre - Golf Course Road', 'office_park', 4.2, 665, 28.4400624, 77.1018633),
  (92, 'BharatPe', 'office_park', 2.4, 650, 28.4951006, 77.08915),
  (93, 'DLF World Techpark (DLF IT SEZ)', 'office_park', 4.4, 614, 28.4647327, 77.0560211),
  (94, 'Optum Global Solutions India Pvt. Ltd.', 'office_park', 4.4, 612, 28.4066875, 77.1185625),
  (95, 'DLF Atria', 'office_park', 4.5, 607, 28.493206, 77.0853653),
  (96, 'Quattro Towers', 'office_park', 4.1, 501, 28.4965218, 77.0842016),
  (97, 'Welldone Techpark', 'office_park', 4.3, 449, 28.4186693, 77.0380747),
  (98, 'Paras Twin Towers', 'office_park', 4.5, 418, 28.4342831, 77.1054775),
  (99, 'Capital Business Park', 'office_park', 4.2, 405, 28.4156818, 77.0393364),
  (100, 'Landmark Cyber Park', 'office_park', 4.3, 363, 28.3909961, 77.0599513);
INSERT INTO poi (poi_id, poi_name, poi_type, rating, review_count, latitude, longitude) VALUES
  (101, 'Building 5c Dlf Cyber City', 'office_park', 4.6, 357, 28.4899406, 77.0920813),
  (102, 'Concentrix', 'office_park', 4.3, 329, 28.5135858, 77.0868341),
  (103, 'Lite Bite Foods', 'office_park', 4.2, 327, 28.4999831, 77.0811112),
  (104, 'Palm Spring Plaza', 'office_park', 4.5, 316, 28.4452252, 77.1014154),
  (105, 'DLF Building 9A', 'office_park', 4.6, 316, 28.4964445, 77.092821),
  (106, 'Magnum Global Park', 'office_park', 4.2, 291, 28.4114519, 77.1071738),
  (107, 'Nokia Solutions and Networks India', 'office_park', 4.4, 283, 28.4996958, 77.0718946),
  (108, 'Indiabulls Ventures', 'office_park', 3.7, 278, 28.4965686, 77.0857121),
  (109, 'Nokia Solutions and Networks', 'office_park', 4.4, 277, 28.494114, 77.0929983),
  (110, 'Real Time Data Services', 'office_park', 3.8, 269, 28.5007093, 77.085057),
  (111, 'Gulf Adiba', 'office_park', 4.5, 251, 28.507914, 77.0858398),
  (112, 'Intellion Park Gurgaon', 'office_park', 4.3, 247, 28.4117605, 77.1175881),
  (113, 'RK Four Square', 'office_park', 4.3, 241, 28.4962427, 77.0900278),
  (114, 'Startek', 'office_park', 3.5, 240, 28.4975368, 77.0817161),
  (115, 'Webhelp India', 'office_park', 4.2, 198, 28.502459, 77.0731384),
  (116, 'Unitech Business Park', 'office_park', 4.4, 184, 28.4579478, 77.0706028),
  (117, 'Kochartech', 'office_park', 4.6, 181, 28.4948406, 77.0827136),
  (118, 'Vatika One On One', 'office_park', 4.6, 174, 28.4657027, 77.0502523),
  (119, 'Sauch Tower', 'office_park', 4.0, 174, 28.49458, 77.083854),
  (120, 'Good Earth Business Bay I', 'office_park', 4.6, 163, 28.4116169, 77.1090325),
  (121, 'DLF Cyber Greens Tower D', 'office_park', 4.4, 156, 28.4934563, 77.0923452),
  (122, 'CorporatEdge Cyber Hub', 'office_park', 4.7, 131, 28.4945889, 77.0871607),
  (123, 'Unitech Cyber Park', 'office_park', 4.2, 121, 28.4433425, 77.0550972),
  (124, 'Bestech Cyber Park.', 'office_park', 3.9, 108, 28.4234211, 76.9983083),
  (125, 'AS Business Park', 'office_park', 4.2, 102, 28.422247, 77.0374858),
  (126, 'Bestech Business Tower', 'office_park', 4.5, 62, 28.4043658, 77.0430459),
  (127, 'Tower B1 Spaze I Tech park', 'office_park', 4.4, 29, 28.4132213, 77.0434993),
  (128, 'Unitech Park', 'office_park', 4.7, 10, 28.4201457, 77.0945777),
  (129, 'DLF Galaxy Tower', 'office_park', 5.0, 6, 28.4617161, 77.053061),
  (130, 'Vipul Business Park', 'office_park', NULL, NULL, 28.4229546, 77.0361167),
  (131, 'Sikanderpur Metro Station', 'metro', NULL, NULL, 28.48131, 77.09312),
  (132, 'IFFCO Chowk Metro Station', 'metro', NULL, NULL, 28.47224, 77.0724),
  (133, 'Millennium City Centre Metro Station', 'metro', NULL, NULL, 28.4592, 77.07248),
  (134, 'Sector 55-56 Metro Station (Rapid Metro)', 'metro', NULL, NULL, 28.42341, 77.1052),
  (135, 'MG Road Metro Station', 'metro', NULL, NULL, 28.47957, 77.08006),
  (136, 'Moulsari Avenue Metro Station (Rapid Metro)', 'metro', NULL, NULL, 28.5008186, 77.0945853),
  (137, 'Sector 54 Chowk Metro Station (Rapid Metro)', 'metro', NULL, NULL, 28.432883, 77.1049802),
  (138, 'Phase 3 Metro Station (Rapid Metro)', 'metro', NULL, NULL, 28.49368, 77.09342),
  (139, 'Phase 2 Metro Station (Rapid Metro)', 'metro', NULL, NULL, 28.48761, 77.09287),
  (140, 'Cyber City Metro Station (Rapid Metro)', 'metro', NULL, NULL, 28.49797, 77.08918),
  (141, 'Phase 1 Metro Station (Rapid Metro)', 'metro', NULL, NULL, 28.4713, 77.0939),
  (142, 'Sector 53-54 Metro Station (Rapid Metro)', 'metro', NULL, NULL, 28.445615, 77.100291),
  (143, 'Paras Hospitals', 'hospital', 4.7, 16297, 28.4511221, 77.0876594),
  (144, 'Manipal Hospital, Palam Vihar', 'hospital', 4.7, 15909, 28.5092813, 77.041406),
  (145, 'Fortis Hospital Gurgaon', 'hospital', 4.6, 13556, 28.4572283, 77.07257),
  (146, 'Park Hospital', 'hospital', 4.7, 13329, 28.4199848, 77.0483228),
  (147, 'Medanta', 'hospital', 4.3, 11226, 28.4393335, 77.0408295),
  (148, 'Narayana Hospital', 'hospital', 4.8, 10927, 28.4978455, 77.101681),
  (149, 'Cloudnine Hospital', 'hospital', 4.8, 10107, 28.4274416, 77.0576165),
  (150, 'Park Hospital, Palam Vihar', 'hospital', 4.7, 7796, 28.5184876, 77.0389976);
INSERT INTO poi (poi_id, poi_name, poi_type, rating, review_count, latitude, longitude) VALUES
  (151, 'CK Birla Hospital', 'hospital', 4.6, 6397, 28.423725, 77.0615973),
  (152, 'Artemis Hospitals', 'hospital', 4.2, 6236, 28.4315643, 77.0722305),
  (153, 'Shivam Hospital', 'hospital', 4.9, 5673, 28.4573484, 77.0537083),
  (154, 'The Signature Advanced Super Speciality Hospital', 'hospital', 4.7, 5352, 28.4541997, 76.9732182),
  (155, 'Max Hospital', 'hospital', 4.5, 4914, 28.4613175, 77.0747418),
  (156, 'Centre For Sight Group of Eye Hospitals - New Railway Rd', 'hospital', 4.9, 2433, 28.467828, 77.0260549),
  (157, 'Neelkanth Hospital', 'hospital', 4.6, 2326, 28.483294, 77.1076984),
  (158, 'SilverStreak Multispeciality Hospital', 'hospital', 4.7, 2190, 28.3986102, 76.9309817),
  (159, 'Centre For Sight Group of Eye Hospitals - Sector 29', 'hospital', 4.7, 2175, 28.4636999, 77.0652285),
  (160, 'Miracles Apollo Cradle Hospital', 'hospital', 4.6, 2108, 28.4785763, 77.0473476),
  (161, 'Mayom Hospital', 'hospital', 4.4, 1678, 28.4580894, 77.0635685),
  (162, 'Aryan Hospital', 'hospital', 4.2, 1488, 28.4696561, 77.0195021),
  (163, 'Jyoti Hospital', 'hospital', 4.7, 1063, 28.4575375, 77.0364907),
  (164, 'Yashroop Hospital', 'hospital', 4.6, 922, 28.4639666, 76.9918202),
  (165, 'Civil Hospital sector 10', 'hospital', 3.2, 795, 28.4562792, 76.9974547),
  (166, 'Tirath Ram Hospitals Private Limited', 'hospital', 4.1, 694, 28.4570236, 77.0204882),
  (167, 'Umang Superspeciality Hospital', 'hospital', 4.7, 693, 28.4454865, 76.9909346),
  (168, 'Aarvy Hospital - A unit of Medlix', 'hospital', 4.1, 615, 28.4573968, 77.0300716),
  (169, 'IAS Medicare Hospital', 'hospital', 4.8, 611, 28.4484389, 77.0156741),
  (170, 'Lotus Hospital (Advanced Laparoscopic, Maternity & Surgical Center Of Excellence)', 'hospital', 4.4, 572, 28.4689533, 77.0343583),
  (171, 'Umkal Hospital', 'hospital', 4.4, 466, 28.4715182, 77.0733047),
  (172, 'Madalasa Hospital', 'hospital', 4.6, 454, 28.4335341, 77.0592321),
  (173, 'SCI Hospital', 'hospital', 4.7, 438, 28.4617266, 77.0949261),
  (174, 'GEM HOSPITAL-Trusted Maternity and Advanced laproscopy Surgical care', 'hospital', 4.8, 423, 28.4608371, 77.0182845),
  (175, 'Avise Hospital', 'hospital', 4.3, 396, 28.435742, 77.0475084),
  (176, 'Sparsh Hospital', 'hospital', 4.5, 309, 28.3957065, 77.0466903),
  (177, 'Jai Sai Ram Hospital', 'hospital', 4.9, 300, 28.5154198, 77.0137159),
  (178, 'Shiva Hospital', 'hospital', 4.1, 293, 28.4752601, 77.0304858),
  (179, 'Jain Sant Phool Chand Ji Charitable Hospital', 'hospital', 3.8, 289, 28.4771195, 77.0159224),
  (180, 'Pushpanjali Hospital', 'hospital', 3.2, 276, 28.4506322, 77.0329339),
  (181, 'Shree Krishna Hospital', 'hospital', 4.6, 205, 28.4734293, 77.003384),
  (182, 'Ahmed Hospital and Ortho Care', 'hospital', 3.9, 197, 28.4579094, 77.0412987),
  (183, 'Jeevan Jyoti Hospital', 'hospital', 4.5, 165, 28.4764928, 77.0350115),
  (184, 'Saraswati Hospital', 'hospital', 4.5, 161, 28.4686151, 77.0381293),
  (185, 'Sukhmani Hospital Gurugram', 'hospital', 4.6, 151, 28.4341863, 77.0482366),
  (186, 'Global hospital', 'hospital', 4.6, 146, 28.4801165, 77.0283611),
  (187, 'SGT University', 'college', 4.1, 3434, 28.4837989, 76.9064695),
  (188, 'Dpg Degree College', 'college', 3.9, 1520, 28.4255824, 77.0204439),
  (189, 'Dronacharya Government College', 'college', 4.0, 1140, 28.4686904, 77.0249493),
  (190, 'The NorthCap University', 'college', 4.1, 914, 28.5047791, 77.0487944),
  (191, 'Gurugram University', 'college', 3.9, 883, 28.4228474, 77.066841),
  (192, 'Sushant University', 'college', 4.1, 824, 28.429753, 77.111674),
  (193, 'Government College for Girls', 'college', 4.1, 737, 28.467805, 77.0444213),
  (194, 'Government Polytechnic Manesar', 'college', 4.3, 737, 28.3353207, 76.928524),
  (195, 'Govt. PG College', 'college', 4.0, 707, 28.4578379, 76.9972484),
  (196, 'K-IIT College of Engineering', 'college', 4.0, 431, 28.3623727, 77.0648261),
  (197, 'Sanlok Institute of Management & Information Technology', 'college', 4.7, 340, 28.4554602, 77.0208409),
  (198, 'IILM University', 'college', 4.0, 281, 28.4335512, 77.1035548),
  (199, 'Government Model Industrial Training Institute', 'college', 4.1, 264, 28.4687214, 77.0463017),
  (200, 'Shri Vishwakarma Skill University Haryana', 'college', 4.2, 255, 28.449118, 77.0756005);
INSERT INTO poi (poi_id, poi_name, poi_type, rating, review_count, latitude, longitude) VALUES
  (201, 'Star Aviation Academy, Approved by DGCA, Govt. of India.', 'college', 4.4, 210, 28.5086689, 77.0159221),
  (202, 'Maharshi Dayanand University Centre For Professional And Allied Studies', 'college', 3.9, 210, 28.4500837, 77.0582522),
  (203, 'Indraprasth Institute Of Aeronautics Gurgaon', 'college', 4.0, 200, 28.3851141, 76.9758761),
  (204, 'Royal Institute of Science & Management', 'college', 4.5, 199, 28.4203165, 76.915771),
  (205, 'JudiciaryPRO (Civil Judge Coaching Centre)', 'college', 4.9, 187, 28.4634432, 77.0309372),
  (206, 'BIMT Gurgaon', 'college', 3.9, 181, 28.4021572, 77.0588278),
  (207, 'Gurugram University, Sector 87 Campus, Gurugram (Kankrola Village)', 'college', 4.0, 173, 28.3980566, 76.9281377),
  (208, 'JK Business School Gurugram', 'college', 4.3, 168, 28.3448322, 77.0825445),
  (209, 'Grow Ambition Medical Institute', 'college', 4.8, 164, 28.472147, 77.04628),
  (210, 'Indian School of Hospitality', 'college', 4.3, 138, 28.3919525, 76.9749328),
  (211, 'NIF Global Gurugram', 'college', 4.2, 136, 28.470816, 77.0440939),
  (212, 'PRAGATI B Ed INSTITUTE SECTOR 50 GURGAON', 'college', 5.0, 135, 28.4174484, 77.0596696),
  (213, 'SOIL Institute of Management', 'college', 4.2, 96, 28.450385, 77.0699498),
  (214, 'Suraj PG Degree College, Sector -75 Gurugram', 'college', 4.1, 88, 28.3984078, 77.0110425),
  (215, 'R. R. School And College of Nursing', 'college', 4.0, 84, 28.4188825, 76.9088177),
  (216, 'Kalra Academy', 'college', 4.8, 80, 28.4673973, 77.0267591),
  (217, 'Grace Bible College Haryana', 'college', 4.6, 80, 28.4695767, 76.9369417),
  (218, 'International School Of Business Studies', 'college', 4.5, 76, 28.4395887, 77.0127275),
  (219, 'Government girls college sec 52', 'college', 4.3, 71, 28.4456668, 77.0766527),
  (220, 'Rishikul College Gurugram', 'college', 4.7, 66, 28.4534769, 76.9817138),
  (221, 'Drona College Of Education', 'college', 3.5, 55, 28.4603835, 77.004445),
  (222, 'Rao Mohar Singh College of Education Behrampur', 'college', 3.7, 51, 28.4193773, 77.0166405),
  (223, 'MDI Gurgaon', 'college', 4.6, 44, 28.4706934, 77.0572364);

INSERT INTO direct_competitors (competitor_id, brand, outlet_name, location_name, rating, review_count, latitude, longitude) VALUES
  (1, 'Chai Point', 'Chai Point - DLF Cyber City, Gurgaon', 'DLF Cyber City', 4.4, 908, 28.4935641, 77.0883515),
  (2, 'Chai Point', 'Chai Point - WorldMark', 'WorldMark', 4.8, 870, 28.3975006, 77.0716355),
  (3, 'Chai Point', 'Chai Point - Huda City center, Gurgaon', 'Huda City center', 4.6, 597, 28.4593366, 77.0727555),
  (4, 'Chai Point', 'Chai Point - Ambience Mall, Gurugram', 'Ambience Mall', 4.6, 453, 28.5039906, 77.097265),
  (5, 'Chai Point', 'Chai Point - Narayana Hospital, Gurugram', 'Narayana Hospital', 4.8, 183, 28.4978259, 77.1014679),
  (6, 'Chai Point', 'Chai Point - MD Regent Plaza, Gurgaon', 'MD Regent Plaza', 4.6, 110, 28.4812512, 77.1005224),
  (7, 'Chai Point', 'Chai Point - DLF Cyber Park, Gurgaon', 'DLF Cyber Park', 4.6, 105, 28.5021184, 77.0904776),
  (8, 'Chai Point', 'Chai Point - Unitech, Gurugram', 'Unitech', 5.0, 65, 28.5098027, 77.0716324),
  (9, 'Chai Point', 'Chai Point', NULL, 4.5, 45, 28.4259769, 77.1002313),
  (10, 'Chai Point', 'Chai Point - Udyog Vihar, Gurugram', 'Udyog Vihar', 4.2, 19, 28.512058, 77.084537),
  (11, 'Chai Point', 'Chai Point - sector-59 Gurugram', 'sector-59', 4.1, 19, 28.4019292, 77.1073559),
  (12, 'Chai Point', 'Chai Point - Sector 18 Gurugram', 'Sector 18', 4.5, 18, 28.4909952, 77.0784363),
  (13, 'Chai Sutta Bar', 'Chai Sutta Bar', NULL, 4.4, 92, 28.4729444, 77.0480533),
  (14, 'Chai Sutta Bar', 'Chai Sutta Bar', NULL, 4.1, 29, 28.4185153, 77.0385993),
  (15, 'Chai Sutta Bar', 'Chai Sutta Bar', NULL, NULL, NULL, 28.4937047, 77.092933);

INSERT INTO indirect_cafes (cafe_id, brand, outlet_name, rating, review_count, latitude, longitude) VALUES
  (1, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Sikanderpur', 4.4, 1151, 28.4804701, 77.0925178),
  (2, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Galleria Market', 4.4, 783, 28.4673879, 77.0821819),
  (3, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Elan Miracle', 4.7, 395, 28.4154153, 76.9638966),
  (4, 'Blue Tokai', 'Blue Tokai Coffee Roasters Origins | Ireo Sector 58', 4.8, 238, 28.4164638, 77.1020087),
  (5, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Golf Course Road', 4.4, 236, 28.4453275, 77.1014571),
  (6, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Nirvana Courtyard', 4.2, 235, 28.414425, 77.0656084),
  (7, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Ambience Mall', 4.5, 233, 28.502561, 77.0973084),
  (8, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Indiabulls Commercial One 09', 4.7, 227, 28.505361, 77.010278),
  (9, 'Blue Tokai', 'Blue Tokai Coffee Roasters | AIPL Joy Street', 4.5, 216, 28.3920944, 77.0593958),
  (10, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Global Foyer', 4.8, 157, 28.5115833, 77.0396944),
  (11, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Vatika Atrium', 4.4, 149, 28.4401782, 77.1020334),
  (12, 'Blue Tokai', 'Blue Tokai Coffee Roasters | AIPL Joy Central', 4.7, 141, 28.4050719, 77.0605578),
  (13, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Good Earth Sixty 9', 4.7, 139, 28.391143, 77.0313372),
  (14, 'Blue Tokai', 'Blue Tokai Coffee Roasters | ROF Portico', 4.4, 115, 28.4530051, 77.0822881),
  (15, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Cyber Hub', 4.4, 108, 28.4951464, 77.0886317),
  (16, 'Blue Tokai', 'Blue Tokai Coffee Roasters | AMB Selfie Street', 4.8, 104, 28.407251, 76.922194),
  (17, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Spaze Boulevard', 4.6, 97, 28.4185833, 77.0408056),
  (18, 'Blue Tokai', 'Blue Tokai Coffee Roasters | VLPL Sector 83', 4.6, 81, 28.397171, 76.963501),
  (19, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Metro World Mall, Gurgaon', 4.6, 70, 28.4288478, 77.0996876),
  (20, 'Blue Tokai', 'Blue Tokai Coffee Roasters | M3M Paragon 57', 4.9, 65, 28.4182637, 77.0814912),
  (21, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Felix Plaza', 4.6, 60, 28.3830035, 76.9302693),
  (22, 'Blue Tokai', 'Blue Tokai Coffee Roasters | Summit Plaza', 4.8, 41, 28.446444, 77.106056),
  (23, 'Blue Tokai', 'Blue Tokai Coffee Roasters | DLF Cyber Park', 4.5, 32, 28.502722, 77.090639),
  (24, 'Blue Tokai', 'Blue Tokai Coffee Roasters | DLF Downtown 4', 4.9, 29, 28.5033056, 77.0959722),
  (25, 'Starbucks', 'Starbucks - Dlf Cyber City', 4.4, 2836, 28.4956832, 77.0888688),
  (26, 'Starbucks', 'Starbucks - Sector 54', 4.4, 2507, 28.4351267, 77.1047784),
  (27, 'Starbucks', 'Starbucks - DLF Phase IV', 4.4, 1991, 28.4675632, 77.0822905),
  (28, 'Starbucks', 'Starbucks - Sector 49', 4.4, 1523, 28.406101, 77.045251),
  (29, 'Starbucks', 'Starbucks - Sector 15', 4.5, 949, 28.461614, 77.049805),
  (30, 'Starbucks', 'Starbucks - Sector 43', 4.5, 899, 28.4510446, 77.098231),
  (31, 'Starbucks', 'Starbucks Coffee | Sector 49 | Gurugram', 4.5, 855, 28.4199934, 77.0501327),
  (32, 'Starbucks', 'Starbucks Coffee | Sector 65 | Gurugram', 4.6, 760, 28.3978149, 77.0718711),
  (33, 'Starbucks', 'Starbucks Reserve - Sector 42', 4.6, 572, 28.4604161, 77.0968303),
  (34, 'Starbucks', 'Starbucks Coffee | Sector 85 | Gurugram', 4.7, 461, 28.4031514, 76.9480345),
  (35, 'Starbucks', 'Starbucks - Sector 52', 4.8, 454, 28.4451799, 77.0807295),
  (36, 'Starbucks', 'Starbucks Coffee | MG Road | Gurugram', 4.8, 260, 28.4803875, 77.0926892),
  (37, 'Starbucks', 'Starbucks', 4.7, 203, 28.5031842, 77.0898946),
  (38, 'Starbucks', 'Starbucks', 4.7, 120, 28.4938836, 77.0929155),
  (39, 'Starbucks', 'Starbucks - Sector 21', 4.4, 114, 28.5103738, 77.0717233),
  (40, 'Starbucks', 'Starbucks Coffee | Golf Course Road | Gurugram', 4.6, 61, 28.4159355, 77.1021856),
  (41, 'Starbucks', 'Starbucks - Cyber City', 5.0, 10, 28.4891928, 77.0916331),
  (42, 'Third Wave Coffee', 'Third Wave Coffee - Golf Course Road', 4.6, 1539, 28.4336857, 77.1051533),
  (43, 'Third Wave Coffee', 'Third Wave Coffee - Platina Towers', 4.7, 1114, 28.4805245, 77.0928026),
  (44, 'Third Wave Coffee', 'Third Wave Coffee - Vatika Business Park', 4.6, 716, 28.4062453, 77.045254),
  (45, 'Third Wave Coffee', 'Third Wave Coffee - Sushant Lok', 4.7, 615, 28.4511527, 77.0817631),
  (46, 'Third Wave Coffee', 'Third Wave Coffee - AIPL Business Club', 4.8, 448, 28.4016361, 77.0848661),
  (47, 'Third Wave Coffee', 'Third Wave Coffee - Fortis Hospital', 4.8, 346, 28.4574655, 77.0726615),
  (48, 'Third Wave Coffee', 'Third Wave Coffee - Vensej Mall', 4.5, 129, 28.4154775, 77.079384),
  (49, 'Third Wave Coffee', 'Third Wave Coffee - DLF Star Tower', 4.6, 128, 28.4608188, 77.051825),
  (50, 'Third Wave Coffee', 'Third Wave Coffee - DLF Galleria Market', 4.8, 91, 28.4671064, 77.0817526);
INSERT INTO indirect_cafes (cafe_id, brand, outlet_name, rating, review_count, latitude, longitude) VALUES
  (51, 'Third Wave Coffee', 'Third Wave Coffee - Iris Broadway', 4.8, 76, 28.403975, 76.9480796),
  (52, 'Third Wave Coffee', 'Third Wave Coffee', 4.8, 71, 28.5097648, 77.071539),
  (53, 'Third Wave Coffee', 'Third Wave Coffee - Nirvana Courtyard', 4.3, 71, 28.4139524, 77.065843),
  (54, 'Third Wave Coffee', 'Third Wave Coffee - Capital CyberScape', 4.7, 61, 28.4011739, 77.1015165),
  (55, 'Third Wave Coffee', 'Third Wave Coffee - DLF Saltstayz', 4.2, 47, 28.4661122, 77.0994343),
  (56, 'Third Wave Coffee', 'Third Wave Coffee - Felix Plaza', 3.4, 19, 28.3831228, 76.9654937);

-- Check: row counts should be 34 / 223 / 15 / 56
SELECT 'outlets' AS table_name, COUNT(*) AS total_rows FROM outlets UNION ALL
SELECT 'poi', COUNT(*) FROM poi UNION ALL
SELECT 'direct_competitors', COUNT(*) FROM direct_competitors UNION ALL
SELECT 'indirect_cafes', COUNT(*) FROM indirect_cafes;

-- ################ PART 2: ANALYSIS (sections 1 to 6) ################
USE chaayos_location;

-- =====================================================================
-- SECTION 1: DATA AUDIT
-- =====================================================================
-- 1a. Are all coordinates inside Gurugram?
SELECT 'outlets' AS tbl, MIN(latitude) lat_min, MAX(latitude) lat_max, MIN(longitude) lng_min, MAX(longitude) lng_max FROM outlets UNION ALL
SELECT 'poi', MIN(latitude), MAX(latitude), MIN(longitude), MAX(longitude) FROM poi UNION ALL
SELECT 'direct_competitors', MIN(latitude), MAX(latitude), MIN(longitude), MAX(longitude) FROM direct_competitors UNION ALL
SELECT 'indirect_cafes', MIN(latitude), MAX(latitude), MIN(longitude), MAX(longitude) FROM indirect_cafes;

-- 1b. Missing values and duplicate points
SELECT 'poi: missing review_count' AS check_name, COUNT(*) AS n FROM poi WHERE review_count IS NULL UNION ALL
SELECT 'poi: duplicate coordinates', COUNT(*) - COUNT(DISTINCT latitude, longitude) FROM poi UNION ALL
SELECT 'outlets: duplicate coordinates', COUNT(*) - COUNT(DISTINCT latitude, longitude) FROM outlets;

-- =====================================================================
-- SECTION 2: EXPLORATORY ANALYSIS
-- =====================================================================
-- 2a. Existing Chaayos outlets by type
SELECT outlet_type, COUNT(*) AS outlets, ROUND(AVG(rating),2) AS avg_rating, ROUND(AVG(review_count)) AS avg_reviews
FROM outlets GROUP BY outlet_type ORDER BY outlets DESC;

-- 2b. Demand points by type
SELECT poi_type, COUNT(*) AS pois, ROUND(AVG(review_count)) AS avg_reviews, MAX(review_count) AS max_reviews
FROM poi GROUP BY poi_type ORDER BY pois DESC;

-- 2c. Competition landscape
SELECT 'direct' AS kind, brand, COUNT(*) AS outlets, ROUND(AVG(rating),2) AS avg_rating FROM direct_competitors GROUP BY brand
UNION ALL
SELECT 'indirect', brand, COUNT(*), ROUND(AVG(rating),2) FROM indirect_cafes GROUP BY brand
ORDER BY kind, outlets DESC;

-- 2d. Biggest malls and office parks by reviews (footfall proxy)
SELECT poi_name, poi_type, review_count FROM poi
WHERE poi_type IN ('mall','office_park') ORDER BY review_count DESC LIMIT 10;

-- =====================================================================
-- SECTION 3: SETTINGS + DISTANCE TABLES  (run this whole section together)
-- Change the settings here and re-run Sections 3 and 4 to see how results move.
-- =====================================================================
SET @r_km        = 1.0;    -- catchment radius around a candidate (km)
SET @min_gap_km  = 0.5;    -- candidate must be this far from every existing Chaayos
SET @sep_km      = 1.5;    -- shortlisted picks must be this far from each other
SET @metro_equiv = 5000;   -- metro stations have no reviews: give a fixed review-equivalent
SET @cannib_w    = 1.0;    -- penalty strength: nearby Chaayos outlets
SET @comp_w      = 0.5;    -- penalty strength: nearby direct competitors
SET @bonus_w     = 0.3;    -- bonus strength: nearby premium cafes (Starbucks etc.)

-- How much each type of place matters for demand
DROP TABLE IF EXISTS poi_weights;
CREATE TABLE poi_weights (poi_type VARCHAR(30) PRIMARY KEY, type_weight DECIMAL(3,1));
INSERT INTO poi_weights VALUES ('office_park',1.0),('mall',1.0),('metro',0.8),('hospital',0.5),('college',0.5);

-- Candidate locations = malls and office parks. Company rows (BPOs, MNC offices) count as
-- demand but are not places where a cafe can open, so they are excluded as candidates.
DROP TABLE IF EXISTS candidates;
CREATE TABLE candidates AS
SELECT poi_id AS cand_id, poi_name, poi_type, latitude, longitude
FROM poi
WHERE poi_type IN ('mall','office_park')
  AND poi_name NOT REGEXP 'Startek|Kochartech|Lite Bite|Gulf Adiba|Webhelp|Real Time Data|Indiabulls|Nokia|Genpact|FIS Global|KPMG|Kpmg|Times Internet|EY GDS|MobiKwik|BharatPe|Concentrix|Airtel|Teleperformance|Optum|TCS|Orange|Samsung|Expedia|Bechtel|Siemens|Work Candor';

-- Distance (km) from every candidate to every demand point, outlet, competitor and premium cafe
DROP TABLE IF EXISTS cand_poi;
CREATE TABLE cand_poi AS
SELECT c.cand_id, p.poi_id, ST_Distance_Sphere(POINT(c.longitude, c.latitude), POINT(p.longitude, p.latitude)) / 1000 AS km
FROM candidates c CROSS JOIN poi p;

DROP TABLE IF EXISTS cand_outlet;
CREATE TABLE cand_outlet AS
SELECT c.cand_id, o.outlet_id, ST_Distance_Sphere(POINT(c.longitude, c.latitude), POINT(o.longitude, o.latitude)) / 1000 AS km
FROM candidates c CROSS JOIN outlets o;

DROP TABLE IF EXISTS cand_direct;
CREATE TABLE cand_direct AS
SELECT c.cand_id, k.competitor_id, ST_Distance_Sphere(POINT(c.longitude, c.latitude), POINT(k.longitude, k.latitude)) / 1000 AS km
FROM candidates c CROSS JOIN direct_competitors k;

DROP TABLE IF EXISTS cand_indirect;
CREATE TABLE cand_indirect AS
SELECT c.cand_id, i.cafe_id, ST_Distance_Sphere(POINT(c.longitude, c.latitude), POINT(i.longitude, i.latitude)) / 1000 AS km
FROM candidates c CROSS JOIN indirect_cafes i;

-- =====================================================================
-- SECTION 4: SCORE EVERY CANDIDATE  (run after Section 3)
-- opportunity = demand_index * (1 + bonus * LN(1 + premium cafes))
--               / (1 + cannib_w * cannibalisation) / (1 + comp_w * competition)
-- =====================================================================
-- 4a. Demand: nearby places, weighted by type, ln(reviews) and closeness
DROP TABLE IF EXISTS cand_demand;
CREATE TABLE cand_demand AS
SELECT cp.cand_id,
       SUM( w.type_weight
            * LN(1 + IF(p.poi_type = 'metro', @metro_equiv, COALESCE(p.review_count, 0)))
            * (1 - cp.km / @r_km) ) AS demand_raw,
       COUNT(*) AS pois_nearby
FROM cand_poi cp
JOIN poi p         ON p.poi_id = cp.poi_id
JOIN poi_weights w ON w.poi_type = p.poi_type
WHERE cp.km <= @r_km
GROUP BY cp.cand_id;

-- 4b. Final score table
DROP TABLE IF EXISTS candidate_scores;
CREATE TABLE candidate_scores AS
WITH chaayos AS (
    SELECT cand_id, MIN(km) AS nearest_chaayos_km,
           SUM(km <= @r_km) AS chaayos_in_radius,
           COALESCE(SUM(IF(km <= @r_km, 1 - km / @r_km, 0)), 0) AS cannib_pressure
    FROM cand_outlet GROUP BY cand_id),
direct AS (
    SELECT cand_id, MIN(km) AS nearest_direct_km,
           SUM(km <= @r_km) AS direct_in_radius,
           COALESCE(SUM(IF(km <= @r_km, 1 - km / @r_km, 0)), 0) AS comp_pressure
    FROM cand_direct GROUP BY cand_id),
premium AS (
    SELECT cand_id, SUM(km <= @r_km) AS premium_cafes_in_radius
    FROM cand_indirect GROUP BY cand_id),
scored AS (
    SELECT c.cand_id, c.poi_name, c.poi_type, c.latitude AS lat, c.longitude AS lng,
           d.demand_raw, d.pois_nearby,
           100 * (d.demand_raw - MIN(d.demand_raw) OVER ()) / (MAX(d.demand_raw) OVER () - MIN(d.demand_raw) OVER ()) AS demand_index,
           ch.nearest_chaayos_km, ch.chaayos_in_radius, ch.cannib_pressure,
           dr.nearest_direct_km, dr.direct_in_radius, dr.comp_pressure,
           pr.premium_cafes_in_radius
    FROM candidates c
    JOIN cand_demand d ON d.cand_id = c.cand_id
    JOIN chaayos ch    ON ch.cand_id = c.cand_id
    JOIN direct dr     ON dr.cand_id = c.cand_id
    JOIN premium pr    ON pr.cand_id = c.cand_id)
SELECT s.*,
       ROUND( demand_index * (1 + @bonus_w * LN(1 + premium_cafes_in_radius))
              / (1 + @cannib_w * cannib_pressure)
              / (1 + @comp_w   * comp_pressure), 1) AS opportunity_score
FROM scored s
WHERE s.nearest_chaayos_km >= @min_gap_km;

-- 4c. Top 15 candidates
SELECT poi_name, poi_type, opportunity_score, ROUND(demand_index,1) AS demand_index,
       chaayos_in_radius, ROUND(nearest_chaayos_km,2) AS nearest_chaayos_km, direct_in_radius, premium_cafes_in_radius
FROM candidate_scores ORDER BY opportunity_score DESC LIMIT 15;

-- =====================================================================
-- SECTION 5: SHORTLIST (different parts of the city)
-- Keep a candidate only if no higher-scoring candidate sits within @sep_km of it.
-- =====================================================================
SELECT a.poi_name, a.poi_type, a.opportunity_score, ROUND(a.demand_index,1) AS demand_index, a.pois_nearby,
       a.chaayos_in_radius, ROUND(a.nearest_chaayos_km,2) AS nearest_chaayos_km, a.direct_in_radius, a.premium_cafes_in_radius
FROM candidate_scores a
WHERE NOT EXISTS (
    SELECT 1 FROM candidate_scores b
    WHERE b.opportunity_score > a.opportunity_score
      AND ST_Distance_Sphere(POINT(a.lng, a.lat), POINT(b.lng, b.lat)) / 1000 < @sep_km)
ORDER BY a.opportunity_score DESC
LIMIT 10;

-- 5b. White space: high-demand places with NO Chaayos and NO direct competitor within the radius
SELECT poi_name, poi_type, ROUND(demand_index,1) AS demand_index, premium_cafes_in_radius, ROUND(nearest_chaayos_km,2) AS nearest_chaayos_km
FROM candidate_scores
WHERE chaayos_in_radius = 0 AND direct_in_radius = 0
ORDER BY demand_index DESC LIMIT 10;

-- =====================================================================
-- SECTION 6: VALIDATION
-- Same demand score at the 34 EXISTING outlets, compared with all candidates.
-- A good score should put outlets that already do well in high-demand areas.
-- =====================================================================
DROP TABLE IF EXISTS outlet_demand;
CREATE TABLE outlet_demand AS
SELECT o.outlet_id,
       SUM( w.type_weight
            * LN(1 + IF(p.poi_type = 'metro', @metro_equiv, COALESCE(p.review_count, 0)))
            * (1 - ST_Distance_Sphere(POINT(o.longitude, o.latitude), POINT(p.longitude, p.latitude)) / 1000 / @r_km) ) AS demand_raw
FROM outlets o
JOIN poi p         ON ST_Distance_Sphere(POINT(o.longitude, o.latitude), POINT(p.longitude, p.latitude)) / 1000 <= @r_km
JOIN poi_weights w ON w.poi_type = p.poi_type
GROUP BY o.outlet_id;

-- 6a. Percentile of each outlet's demand against all candidates (100 = best area)
SELECT o.outlet_name, o.outlet_type, o.review_count,
       ROUND(100 * (SELECT AVG(cd.demand_raw < od.demand_raw) FROM cand_demand cd)) AS demand_percentile
FROM outlet_demand od JOIN outlets o ON o.outlet_id = od.outlet_id
ORDER BY demand_percentile DESC LIMIT 10;

-- 6b. Average percentile across all 34 outlets (50 = no better than random)
SELECT ROUND(AVG(100 * (SELECT AVG(cd.demand_raw < od.demand_raw) FROM cand_demand cd))) AS avg_outlet_percentile
FROM outlet_demand od;

-- 6c. Do busier outlets (more reviews) sit in higher-demand areas? Compare the two rankings.
SELECT o.outlet_name, o.review_count,
       RANK() OVER (ORDER BY o.review_count DESC) AS busyness_rank,
       RANK() OVER (ORDER BY od.demand_raw DESC)  AS demand_rank
FROM outlet_demand od JOIN outlets o ON o.outlet_id = od.outlet_id
ORDER BY busyness_rank LIMIT 15;
