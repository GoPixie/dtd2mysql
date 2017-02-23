
DROP TABLE IF EXISTS `agency`;
CREATE TABLE `agency` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    agency_id VARCHAR(100),
    agency_name VARCHAR(255) NOT NULL,
    agency_url VARCHAR(255) NOT NULL,
    agency_timezone VARCHAR(100) NOT NULL,
    agency_lang VARCHAR(100),
    agency_phone VARCHAR(100),
    agency_fare_url VARCHAR(100)
);

DROP TABLE IF EXISTS `calendar_dates`;
CREATE TABLE `calendar_dates` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    service_id VARCHAR(20) NOT NULL,
    `date` DATE NOT NULL,
    exception_type TINYINT(2) NOT NULL,
    KEY `service_id` (service_id),
    KEY `exception_type` (exception_type)
);

DROP TABLE IF EXISTS `calendar`;
CREATE TABLE `calendar` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    service_id VARCHAR(26) NOT NULL,
    monday TINYINT(1) NOT NULL,
    tuesday TINYINT(1) NOT NULL,
    wednesday TINYINT(1) NOT NULL,
    thursday TINYINT(1) NOT NULL,
    friday TINYINT(1) NOT NULL,
    saturday TINYINT(1) NOT NULL,
    sunday TINYINT(1) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    KEY `service_id` (service_id),
    KEY `start_date` (`start_date`),
    KEY `end_date` (`end_date`),
    KEY `monday` (`monday`),
    KEY `tuesday` (`tuesday`),
    KEY `wednesday` (`wednesday`),
    KEY `thursday` (`thursday`),
    KEY `friday` (`friday`),
    KEY `saturday` (`saturday`),
    KEY `sunday` (`sunday`)
);

DROP TABLE IF EXISTS `fare_attributes`;
CREATE TABLE `fare_attributes` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    fare_id VARCHAR(100),
    price VARCHAR(50) NOT NULL,
    currency_type VARCHAR(50) NOT NULL,
    payment_method TINYINT(1) NOT NULL,
    transfers TINYINT(1) NOT NULL,
    transfer_duration VARCHAR(10),
    exception_type TINYINT(2) NOT NULL,
    agency_id INT(100),
    KEY `fare_id` (fare_id)
);

DROP TABLE IF EXISTS `fare_rules`;
CREATE TABLE `fare_rules` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    fare_id VARCHAR(100),
    route_id VARCHAR(100),
    origin_id VARCHAR(100),
    destination_id VARCHAR(100),
    contains_id VARCHAR(100),
    KEY `fare_id` (fare_id),
    KEY `route_id` (route_id)
);

DROP TABLE IF EXISTS `feed_info`;
CREATE TABLE `feed_info` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    feed_publisher_name VARCHAR(100),
    feed_publisher_url VARCHAR(255) NOT NULL,
    feed_lang VARCHAR(255) NOT NULL,
    feed_start_date DATE NOT NULL,
    feed_end_date DATE,
    feed_version VARCHAR(100)
);

DROP TABLE IF EXISTS `frequencies`;
CREATE TABLE `frequencies` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    trip_id INT(12) unsigned NOT NULL,
    start_time DATE NOT NULL,
    end_time DATE NOT NULL,
    headway_secs VARCHAR(100) NOT NULL,
    exact_times TINYINT(1),
    KEY `trip_id` (trip_id)
);

DROP TABLE IF EXISTS `links`;
CREATE TABLE `links` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    mode VARCHAR(50) NOT NULL,
    from_stop_id VARCHAR(20) NOT NULL,
    to_stop_id VARCHAR(20) NOT NULL,
    link_secs INT(12) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    priority INT(12) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    monday TINYINT(1) NOT NULL,
    tuesday TINYINT(1) NOT NULL,
    wednesday TINYINT(1) NOT NULL,
    thursday TINYINT(1) NOT NULL,
    friday TINYINT(1) NOT NULL,
    saturday TINYINT(1) NOT NULL,
    sunday TINYINT(1) NOT NULL,
    KEY `from_stop_id` (from_stop_id),
    KEY `to_stop_id` (to_stop_id),
    KEY `start_time` (start_time),
    KEY `end_time` (end_time),
    KEY `start_date` (start_date),
    KEY `end_date` (end_date),
    KEY `monday` (`monday`),
    KEY `tuesday` (`tuesday`),
    KEY `wednesday` (`wednesday`),
    KEY `thursday` (`thursday`),
    KEY `friday` (`friday`),
    KEY `saturday` (`saturday`),
    KEY `sunday` (`sunday`)
);

DROP TABLE IF EXISTS `routes`;
CREATE TABLE `routes` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    route_id VARCHAR(100),
    agency_id VARCHAR(50),
    route_short_name VARCHAR(50) NOT NULL,
    route_long_name VARCHAR(255) NOT NULL,
    route_type VARCHAR(2) NOT NULL,
    route_text_color VARCHAR(255),
    route_color VARCHAR(255),
    route_url VARCHAR(255),
    route_desc VARCHAR(255),
    KEY `agency_id` (agency_id),
    KEY `route_type` (route_type)
);

DROP TABLE IF EXISTS `shapes`;
CREATE TABLE `shapes` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    shape_id VARCHAR(100) NOT NULL,
    shape_pt_lat DECIMAL(8,6) NOT NULL,
    shape_pt_lon DECIMAL(8,6) NOT NULL,
    shape_pt_sequence TINYINT(3) NOT NULL,
    shape_dist_traveled VARCHAR(50),
    KEY `shape_id` (shape_id)
);

DROP TABLE IF EXISTS `stop_times`;
CREATE TABLE `stop_times` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    trip_id INT(12) unsigned NOT NULL,
    arrival_time TIME NOT NULL,
    wtt_arrival_time TIME,
    arrival_time_seconds INT(100),
    departure_time TIME NOT NULL,
    wtt_departure_time TIME,
    departure_time_seconds INT(100),
    stop_id VARCHAR(20) NOT NULL,
    stop_sequence TINYINT(1) unsigned NOT NULL,
    stop_headsign VARCHAR(50),
    pickup_type VARCHAR(2),
    drop_off_type VARCHAR(2),
    shape_dist_traveled VARCHAR(50),
    platform VARCHAR(3),
    engineering_allowance TINYINT(3),
    pathing_allowance TINYINT(3),
    performance_allowance TINYINT(3),
    line VARCHAR(3),
    path VARCHAR(3),
    activity VARCHAR(3),
    KEY `trip_id` (trip_id),
    KEY `arrival_time` (arrival_time),
    KEY `departure_time` (departure_time),
    KEY `stop_id` (stop_id),
    KEY `stop_sequence` (stop_sequence)
);

DROP TABLE IF EXISTS `stops`;
CREATE TABLE `stops` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    stop_id VARCHAR(20),
    stop_code VARCHAR(50),
    stop_name VARCHAR(255) NOT NULL,
    stop_desc VARCHAR(255),
    stop_lat DECIMAL(10,6) NOT NULL,
    stop_lon DECIMAL(10,6) NOT NULL,
    zone_id VARCHAR(255),
    stop_url VARCHAR(255),
    location_type VARCHAR(2),
    parent_station VARCHAR(100),
    stop_timezone VARCHAR(50),
    wheelchair_boarding TINYINT(1),
    cate_type VARCHAR(1),
    tiploc VARCHAR(9),
    KEY `stop_id` (stop_id),
    KEY `stop_lat` (stop_lat),
    KEY `stop_lon` (stop_lon),
    KEY `parent_station` (parent_station)
);

DROP TABLE IF EXISTS `transfers`;
CREATE TABLE `transfers` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    from_stop_id VARCHAR(20) NOT NULL,
    to_stop_id VARCHAR(20) NOT NULL,
    transfer_type TINYINT(1) NOT NULL,
    min_transfer_time INT(8) NOT NULL
);

DROP TABLE IF EXISTS `trips`;
CREATE TABLE `trips` (
    id INT(12) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transit_system VARCHAR(50) NOT NULL,
    route_id VARCHAR(100) NOT NULL,
    service_id VARCHAR(26) NOT NULL,
    trip_id INT(12) unsigned NOT NULL,
    trip_headsign VARCHAR(255),
    trip_short_name VARCHAR(255),
    direction_id TINYINT(1), #0 for one direction, 1 for another.
    block_id VARCHAR(11),
    shape_id VARCHAR(11),
    wheelchair_accessible TINYINT(1), #0 for no information, 1 for at
    # least one rider accommodated on wheel chair, 2 for no riders
    # accommodated.
    bikes_allowed TINYINT(1), #0 for no information, 1 for at least
    # one bicycle accommodated, 2 for no bicycles accommodated
    train_uid VARCHAR(30),
    train_status VARCHAR(10),
    train_category VARCHAR(10),
    train_identity VARCHAR(10),
    headcode VARCHAR(10),
    train_service_code VARCHAR(10),
    portion_id VARCHAR(10),
    power_type VARCHAR(10),
    timing_load VARCHAR(10),
    speed VARCHAR(10),
    oper_chars VARCHAR(10),
    train_class VARCHAR(10),
    sleepers VARCHAR(10),
    reservations VARCHAR(10),
    catering VARCHAR(10),
    service_branding VARCHAR(10),
    stp_indicator VARCHAR(10),
    uic_code VARCHAR(10),
    atoc_code VARCHAR(10),
    applicable_timetable VARCHAR(10),
    KEY `trip_id` (trip_id),
    KEY `service_id` (service_id),
    KEY `direction_id` (direction_id),
    KEY `block_id` (block_id),
    KEY `shape_id` (shape_id)
);

DROP TABLE IF EXISTS `group_station`;
CREATE TABLE `group_station` (
    `group_nlc` char(4) NOT NULL,
    `member_crs` char(3) NOT NULL,
    PRIMARY KEY (`group_nlc`, `member_crs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `group_station` VALUES
    ("0032","LBG"),
    ("0032","LST"),
    ("0032","KGX"),
    ("0032","CHX"),
    ("0032","WAT"),
    ("0032","FST"),
    ("0032","MYB"),
    ("0032","VXH"),
    ("0032","EUS"),
    ("0032","PAD"),
    ("0032","CST"),
    ("0032","VIC"),
    ("0032","MOG"),
    ("0032","STP"),
    ("0032","BFR"),
    ("0032","CTK"),
    ("0032","WAE"),
    ("0033","STP"),
    ("0033","BFR"),
    ("0033","CTK"),
    ("0033","WAE"),
    ("0033","LBG"),
    ("0033","LST"),
    ("0033","KGX"),
    ("0033","EAL"),
    ("0033","CHX"),
    ("0033","WAT"),
    ("0033","FST"),
    ("0033","MYB"),
    ("0033","VXH"),
    ("0033","EUS"),
    ("0033","PAD"),
    ("0033","CST"),
    ("0033","VIC"),
    ("0033","MOG"),
    ("0034","STP"),
    ("0034","BFR"),
    ("0034","CTK"),
    ("0034","WAE"),
    ("0034","LBG"),
    ("0034","LST"),
    ("0034","KGX"),
    ("0034","EAL"),
    ("0034","CHX"),
    ("0034","WAT"),
    ("0034","FST"),
    ("0034","MYB"),
    ("0034","VXH"),
    ("0034","EUS"),
    ("0034","PAD"),
    ("0034","CST"),
    ("0034","VIC"),
    ("0034","MOG"),
    ("0035","EUS"),
    ("0035","PAD"),
    ("0035","CST"),
    ("0035","VIC"),
    ("0035","MOG"),
    ("0035","STP"),
    ("0035","BFR"),
    ("0035","CTK"),
    ("0035","WAE"),
    ("0035","LBG"),
    ("0035","LST"),
    ("0035","KGX"),
    ("0035","CHX"),
    ("0035","WAT"),
    ("0035","FST"),
    ("0035","MYB"),
    ("0035","VXH"),
    ("0038","BKG"),
    ("0038","KPA"),
    ("0038","WHD"),
    ("0038","NXG"),
    ("0038","WIM"),
    ("0038","SRA"),
    ("0038","NWX"),
    ("0051","VXH"),
    ("0051","EUS"),
    ("0051","PAD"),
    ("0051","CST"),
    ("0051","VIC"),
    ("0051","MOG"),
    ("0051","STP"),
    ("0051","BFR"),
    ("0051","CTK"),
    ("0051","WAE"),
    ("0051","LBG"),
    ("0051","LST"),
    ("0051","KGX"),
    ("0051","CHX"),
    ("0051","WAT"),
    ("0051","FST"),
    ("0051","MYB"),
    ("0052","NWX"),
    ("0052","HOH"),
    ("0052","TOM"),
    ("0052","BKG"),
    ("0052","WHD"),
    ("0052","SRU"),
    ("0052","NXG"),
    ("0052","WIM"),
    ("0052","FPK"),
    ("0052","SRA"),
    ("0053","SRA"),
    ("0053","HOH"),
    ("0053","EAL"),
    ("0053","RMD"),
    ("0054","BKG"),
    ("0054","HOH"),
    ("0054","GFD"),
    ("0055","HOH"),
    ("0055","SRU"),
    ("0057","GFD"),
    ("0057","BKG"),
    ("0057","HOH"),
    ("0059","UPM"),
    ("0059","RIC"),
    ("0060","MYB"),
    ("0060","VXH"),
    ("0060","EUS"),
    ("0060","PAD"),
    ("0060","CST"),
    ("0060","VIC"),
    ("0060","MOG"),
    ("0060","STP"),
    ("0060","BFR"),
    ("0060","CTK"),
    ("0060","WAE"),
    ("0060","LBG"),
    ("0060","LST"),
    ("0060","EAL"),
    ("0060","KGX"),
    ("0060","CHX"),
    ("0060","WAT"),
    ("0060","FST"),
    ("0061","HOH"),
    ("0061","SRU"),
    ("0062","GFD"),
    ("0062","BKG"),
    ("0062","HOH"),
    ("0063","HOH"),
    ("0063","SRU"),
    ("0063","NWX"),
    ("0063","SRA"),
    ("0063","TOM"),
    ("0063","BKG"),
    ("0063","WHD"),
    ("0063","NXG"),
    ("0063","WIM"),
    ("0063","FPK"),
    ("0064","CHX"),
    ("0064","WAT"),
    ("0064","FST"),
    ("0064","MYB"),
    ("0064","VXH"),
    ("0064","EUS"),
    ("0064","PAD"),
    ("0064","CST"),
    ("0064","VIC"),
    ("0064","MOG"),
    ("0064","STP"),
    ("0064","BFR"),
    ("0064","CTK"),
    ("0064","WAE"),
    ("0064","LBG"),
    ("0064","LST"),
    ("0064","EAL"),
    ("0064","KGX"),
    ("0065","EAL"),
    ("0065","KGX"),
    ("0065","CHX"),
    ("0065","WAT"),
    ("0065","FST"),
    ("0065","MYB"),
    ("0065","VXH"),
    ("0065","EUS"),
    ("0065","PAD"),
    ("0065","CST"),
    ("0065","VIC"),
    ("0065","MOG"),
    ("0065","STP"),
    ("0065","BFR"),
    ("0065","CTK"),
    ("0065","WAE"),
    ("0065","LBG"),
    ("0065","LST"),
    ("0066","HOH"),
    ("0066","SRU"),
    ("0066","NWX"),
    ("0066","SRA"),
    ("0066","TOM"),
    ("0066","BKG"),
    ("0066","WHD"),
    ("0066","NXG"),
    ("0066","WIM"),
    ("0066","FPK"),
    ("0067","RMD"),
    ("0067","EAL"),
    ("0067","HOH"),
    ("0067","SRU"),
    ("0067","SRA"),
    ("0068","GFD"),
    ("0068","HOH"),
    ("0068","SRU"),
    ("0068","BKG"),
    ("0069","HOH"),
    ("0069","SRU"),
    ("0070","RIC"),
    ("0070","UPM"),
    ("0254","CET"),
    ("0254","COL"),
    ("0258","CFB"),
    ("0258","CTF"),
    ("0259","EBR"),
    ("0259","EBT"),
    ("0260","FNN"),
    ("0260","FNB"),
    ("0262","PNE"),
    ("0262","PNW"),
    ("0263","ENC"),
    ("0263","ENF"),
    ("0265","WHD"),
    ("0265","WHP"),
    ("0268","PFM"),
    ("0268","PFR"),
    ("0271","TNN"),
    ("0271","TNS"),
    ("0403","RDG"),
    ("0403","RDW"),
    ("0404","HLC"),
    ("0404","HLU"),
    ("0410","BSJ"),
    ("0410","BDM"),
    ("0411","SOV"),
    ("0411","SOC"),
    ("0413","HFN"),
    ("0413","HFE"),
    ("0414","DVP"),
    ("0415","GNB"),
    ("0415","GBL"),
    ("0416","DKT"),
    ("0416","DPD"),
    ("0416","DKG"),
    ("0418","BSW"),
    ("0418","BHM"),
    ("0418","BMO"),
    ("0424","BDI"),
    ("0424","BDQ"),
    ("0428","CBE"),
    ("0428","CBW"),
    ("0429","DCH"),
    ("0429","DCW"),
    ("0431","FKK"),
    ("0431","FKG"),
    ("0432","FKC"),
    ("0432","FKW"),
    ("0433","GLQ"),
    ("0433","GLC"),
    ("0435","LVC"),
    ("0435","LVJ"),
    ("0435","LIV"),
    ("0435","MRF"),
    ("0437","MDW"),
    ("0437","MDE"),
    ("0437","MDB"),
    ("0438","DGT"),
    ("0438","MCO"),
    ("0438","MAN"),
    ("0438","MCV"),
    ("0440","PMS"),
    ("0440","PMH"),
    ("0441","NCT"),
    ("0441","NNG"),
    ("0443","TYL"),
    ("0443","UTY"),
    ("0444","WKK"),
    ("0444","WKF"),
    ("0445","WBQ"),
    ("0445","WAC"),
    ("0446","WGN"),
    ("0446","WGW"),
    ("0447","WOS"),
    ("0447","WOF"),
    ("0449","WCY"),
    ("0449","ECR"),
    ("0785","LBG"),
    ("0785","LST"),
    ("0785","KGX"),
    ("0785","CHX"),
    ("0785","WAT"),
    ("0785","FST"),
    ("0785","MYB"),
    ("0785","VXH"),
    ("0785","OLD"),
    ("0785","EUS"),
    ("0785","PAD"),
    ("0785","CST"),
    ("0785","VIC"),
    ("0785","MOG"),
    ("0785","STP"),
    ("0785","BFR"),
    ("0785","CTK"),
    ("0785","WAE"),
    ("0786","STP"),
    ("0786","BFR"),
    ("0786","CTK"),
    ("0786","WAE"),
    ("0786","LBG"),
    ("0786","LST"),
    ("0786","EAL"),
    ("0786","KGX"),
    ("0786","CHX"),
    ("0786","WAT"),
    ("0786","FST"),
    ("0786","MYB"),
    ("0786","VXH"),
    ("0786","EUS"),
    ("0786","PAD"),
    ("0786","CST"),
    ("0786","VIC"),
    ("0786","MOG"),
    ("0790","STP"),
    ("0790","BFR"),
    ("0790","CTK"),
    ("0790","WAE"),
    ("0790","LBG"),
    ("0790","LST"),
    ("0790","KGX"),
    ("0790","CHX"),
    ("0790","WAT"),
    ("0790","FST"),
    ("0790","MYB"),
    ("0790","VXH"),
    ("0790","EUS"),
    ("0790","PAD"),
    ("0790","CST"),
    ("0790","VIC"),
    ("0790","MOG"),
    ("0791","EUS"),
    ("0791","PAD"),
    ("0791","CST"),
    ("0791","VIC"),
    ("0791","MOG"),
    ("0791","STP"),
    ("0791","BFR"),
    ("0791","CTK"),
    ("0791","WAE"),
    ("0791","EAL"),
    ("0791","LBG"),
    ("0791","LST"),
    ("0791","KGX"),
    ("0791","CHX"),
    ("0791","WAT"),
    ("0791","FST"),
    ("0791","MYB"),
    ("0791","VXH"),
    ("0792","VXH"),
    ("0792","EUS"),
    ("0792","PAD"),
    ("0792","CST"),
    ("0792","VIC"),
    ("0792","MOG"),
    ("0792","STP"),
    ("0792","BFR"),
    ("0792","CTK"),
    ("0792","WAE"),
    ("0792","EAL"),
    ("0792","LBG"),
    ("0792","LST"),
    ("0792","KGX"),
    ("0792","CHX"),
    ("0792","WAT"),
    ("0792","FST"),
    ("0792","MYB"),
    ("0793","NXG"),
    ("0793","FPK"),
    ("0793","WHD"),
    ("0793","VXH"),
    ("0793","HHY"),
    ("0793","QPW"),
    ("0793","NWX"),
    ("0793","KTN"),
    ("0793","KPA"),
    ("0793","BRX"),
    ("0793","EPH"),
    ("0797","EPH"),
    ("0797","BAL"),
    ("0797","WIM"),
    ("0797","NXG"),
    ("0797","WHD"),
    ("0797","NWX"),
    ("0797","TOM"),
    ("0797","SRA"),
    ("0797","KTN"),
    ("0797","EAL"),
    ("0797","BRX"),
    ("0825","BKG"),
    ("0825","EPH"),
    ("0825","RMD"),
    ("0825","WIM"),
    ("0825","NXG"),
    ("0825","WHD"),
    ("0825","NWX"),
    ("0825","TOM"),
    ("0825","SRA"),
    ("0825","KTN"),
    ("0825","BRX"),
    ("0829","BKG"),
    ("0829","WIM"),
    ("0829","NXG"),
    ("0829","WHD"),
    ("0829","KPA"),
    ("0829","NWX"),
    ("0829","SRA"),
    ("0830","SVS"),
    ("0830","BAL"),
    ("0830","WIM"),
    ("0830","EAL"),
    ("0830","TOM"),
    ("0830","SRA"),
    ("0835","SRA"),
    ("0835","BAL"),
    ("0835","RMD"),
    ("0835","BKG"),
    ("0835","EAL"),
    ("0839","EAL"),
    ("0839","SRA"),
    ("0839","RMD"),
    ("0841","GFD"),
    ("0841","BKG"),
    ("0844","UPM"),
    ("0844","GFD"),
    ("0844","BKG"),
    ("0844","HOH"),
    ("0847","UPM"),
    ("0847","HOH"),
    ("1072","MYB"),
    ("1072","EUS"),
    ("1072","PAD"),
    ("1072","VIC"),
    ("1072","STP"),
    ("1072","BFR"),
    ("1072","LBG"),
    ("1072","LST"),
    ("1072","KGX"),
    ("1072","CHX"),
    ("1072","WAT"),
    ("1072","FST"),
    ("1780","BOT"),
    ("1780","BNW"),
    ("1998","SOA"),
    ("4452","ZFD"),
    ("4452","EPH"),
    ("4452","CTK"),
    ("4452","STP"),
    ("4452","BFR"),
    ("4452","LBG"),
    ("5564","HWE"),
    ("5564","HWO"),
    ("5564","HWX"),
    ("5564","HWF"),
    ("5564","HTR"),
    ("5564","HWA"),
    ("7468","TBR"),
    ("7468","TIL"),
    ("7934","BCS"),
    ("7934","BIT");