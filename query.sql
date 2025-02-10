/*
WE USE TA'S TABLES
 */
create database pcsaz;

USE pcsaz;

create table product (
        id INTEGER primary key AUTO_INCREMENT,
        category enum (
            'Motherboard',
            'CPU',
            'RAM Stick',
            'Cooler',
            'GPU',
            'Power Supply',
            'Case',
            'SSD',
            'HDD'
        ) not null,
        image LONGBLOB,
        current_price BIGINT not null,
        stock_count INTEGER not null default 0,
        brand VARCHAR(40) not null,
        model VARCHAR(40) not null
    );

create table hdd (
        id INTEGER primary key,
        rotational_speed INTEGER not null,
        wattage INTEGER not null,
        capacity smallint not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table cp_case (
        id INTEGER primary key,
        number_of_fans smallint not null,
        fan_size smallint not null,
        wattage INTEGER not null,
        ctype enum (
            'Desktop',
            'Full Tower',
            'Mid Tower',
            'Mini Tower',
            'SFF'
            ) not null,
        material enum (
            'Steel',
            'Aluminum',
            'Tempered Glass',
            'Plastic',
            'Acrylic',
            'Mesh'
            ) not null,
        color enum (
            'Black',
            'White',
            'Gray',
            'Blue',
            'Red',
            'Green',
            'Yellow',
            'Brown',
            'Orange'
            ) not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table power_supply (
        id INTEGER primary key,
        supported_wattage INTEGER not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table gpu (
        id INTEGER primary key,
        clock_speed smallint not null,
        ram_size smallint not null,
        number_of_fans smallint not null,
        wattage INTEGER not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table ssd (
        id INTEGER primary key,
        wattage INTEGER not null,
        capacity smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table ram_stick (
        id INTEGER primary key,
        frequency INTEGER not null,
        generation smallint not null,
        wattage INTEGER not null,
        capacity smallint not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table motherboard (
        id INTEGER primary key,
        chipset VARCHAR(40) not null,
        num_of_memory_slots smallint not null,
        memory_speed_range smallint not null,
        wattage INTEGER not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table cpu (
        id INTEGER primary key,
        maximum_addressable_memory_limit smallint not null,
        boost_frequency smallint not null,
        base_frequency smallint not null,
        number_of_cores smallint not null,
        number_of_threads smallint not null,
        microarchitecture enum (
            'AMD Zen',
            'Intel Apple',
            'Intel Amber',
            'Intel Broadwell',
            'Intel Kaby Lake'
        ) not null,
        wattage INTEGER not null,
        generation smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table cooler (
        id INTEGER primary key,
        maximum_rotational_speed INTEGER not null,
        wattage INTEGER not null,
        fan_size smallint not null,
        cooling_method enum (
            'Air',
            'Passive',
            'Liquid immersion',
            'Heat sinks',
            'Peltier',
            'Liquid'
        ) not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table cc_socket_compatible_with (
        cooler_id INTEGER,
        cpu_id INTEGER,
        primary key (cooler_id, cpu_id),
        foreign key (cooler_id) references cooler (id) on delete cascade on update cascade,
        foreign key (cpu_id) references cpu (id) on delete cascade on update cascade
    );

create table mc_socket_compatible_with (
        motherboard_id INTEGER,
        cpu_id INTEGER,
        primary key (motherboard_id, cpu_id),
        foreign key (motherboard_id) references motherboard (id) on delete cascade on update cascade,
        foreign key (cpu_id) references cpu (id) on delete cascade on update cascade
    );

create table rm_slot_compatible_with (
        motherboard_id INTEGER,
        ram_id INTEGER,
        primary key (motherboard_id, ram_id),
        foreign key (motherboard_id) references motherboard (id) on delete cascade on update cascade,
        foreign key (ram_id) references ram_stick (id) on delete cascade on update cascade
    );

create table gm_slot_compatible_with (
        motherboard_id INTEGER,
        gpu_id INTEGER,
        primary key (motherboard_id, gpu_id),
        foreign key (motherboard_id) references motherboard (id) on delete cascade on update cascade,
        foreign key (gpu_id) references gpu (id) on delete cascade on update cascade
    );

create table sm_slot_compatible_with (
        motherboard_id INTEGER,
        ssd_id INTEGER,
        primary key (motherboard_id, ssd_id),
        foreign key (motherboard_id) references motherboard (id) on delete cascade on update cascade,
        foreign key (ssd_id) references ssd (id) on delete cascade on update cascade
    );

create table connector_compatible_with (
        gpu_id INTEGER,
        power_id INTEGER,
        primary key (gpu_id, power_id),
        foreign key (gpu_id) references gpu (id) on delete cascade on update cascade,
        foreign key (power_id) references power_supply (id) on delete cascade on update cascade
    );

create table client (
        id INTEGER AUTO_INCREMENT primary key,
        phone_number CHAR(11) unique,
        first_name VARCHAR(50) not null,
        last_name VARCHAR(50) not null,
        wallet_balance integer default 0,
        referral_code VARCHAR(20) not null unique,
        client_timestamp TIMESTAMP not null default CURRENT_TIMESTAMP
    );
create table vip_client (
        id INTEGER primary key,
        subscription_expiration_time TIMESTAMP,
        foreign key (id) references client (id) on delete cascade on update cascade
    );

create table refer (
        referee INTEGER primary key,
        referrer INTEGER not null,
        foreign key (referee) references client (id) on delete cascade on update cascade,
        foreign key (referrer) references client (id) on delete cascade on update cascade
    );

create table address (
        id INTEGER,
        province VARCHAR(50),
        remainder VARCHAR(300),
        primary key (id, province, remainder),
        foreign key (id) references client (id) on delete cascade on update cascade
    );

create table discount_code (
        code INTEGER primary key AUTO_INCREMENT,
        amount DECIMAL not null,
        discount_limit INTEGER not null,
        usage_count INTEGER not null,
        expiration_date TIMESTAMP not null
    );

create table private_code (
        code INTEGER,
        id INTEGER,
        private_code_timestamp TIMESTAMP not null default CURRENT_TIMESTAMP,
        primary key (code),
        foreign key (code) references discount_code (code) on delete cascade on update cascade,
        foreign key (id) references client (id) on delete cascade on update cascade
    );

create table public_code (
        code INTEGER,
        primary key (code),
        foreign key (code) references discount_code (code) on delete cascade on update cascade
    );

create table shopping_cart (
        id INTEGER,
        cart_number INTEGER,
        cart_status ENUM ('active', 'blocked', 'locked') not null default 'active',
        primary key (id, cart_number),
        foreign key (id) references client (id) on delete cascade on update cascade
    );

create table locked_shopping_cart (
        id INTEGER,
        cart_number INTEGER,
        locked_number INTEGER,
        locked_timestamp TIMESTAMP not null default CURRENT_TIMESTAMP,
        primary key (id, cart_number, locked_number),
        foreign key (id, cart_number) references shopping_cart (id, cart_number) on delete cascade on update cascade
    );

create table added_to (
        id INTEGER,
        cart_number INTEGER,
        locked_number INTEGER,
        product_id INTEGER,
        quantity INTEGER not null default 1,
        cart_price INTEGER not null,
        primary key (id, cart_number, locked_number, product_id),
        foreign key (id, cart_number, locked_number) references locked_shopping_cart (id, cart_number, locked_number) on delete cascade on update cascade,
        foreign key (product_id) references product (id) on delete cascade on update cascade
    );

create table applied_to (
        id INTEGER,
        cart_number INTEGER,
        locked_number INTEGER,
        code INTEGER,
        applied_timestamp TIMESTAMP not null default CURRENT_TIMESTAMP,
        primary key (id, cart_number, locked_number, code),
        foreign key (id, cart_number, locked_number) references locked_shopping_cart (id, cart_number, locked_number) on delete cascade on update cascade,
        foreign key (code) references discount_code (code) on delete cascade on update cascade
    );

create table transaction (
        tracking_code VARCHAR(15) primary key,
        transaction_status enum ('Successful', 'Unsuccessful', 'Semi successful') not null default 'Unsuccessful',
        transaction_timestamp TIMESTAMP not null default CURRENT_TIMESTAMP
    );

create table bank_transaction (
        tracking_code VARCHAR(15),
        card_number VARCHAR(16) not null,
        primary key (tracking_code),
        foreign key (tracking_code) references transaction (tracking_code) on delete cascade on update cascade
    );

create table wallet_transaction (
        tracking_code VARCHAR(15),
        primary key (tracking_code),
        foreign key (tracking_code) references transaction (tracking_code) on delete cascade on update cascade
    );

create table subscribe (
        tracking_code VARCHAR(15),
        id INTEGER,
        primary key (tracking_code),
        foreign key (tracking_code) references transaction (tracking_code) on delete cascade on update cascade,
        foreign key (id) references client (id) on delete cascade on update cascade
    );

create table issued_for (
        tracking_code VARCHAR(15),
        id INTEGER,
        cart_number INTEGER,
        locked_number INTEGER,
        primary key (tracking_code),
        foreign key (tracking_code) references transaction (tracking_code) on delete cascade on update cascade,
        foreign key (id, cart_number, locked_number) references locked_shopping_cart (id, cart_number, locked_number) on delete cascade on update cascade
    );

create table deposits_into_wallet (
        tracking_code VARCHAR(15),
        id INTEGER,
        amount INTEGER not null,
        primary key (tracking_code),
        foreign key (tracking_code) references bank_transaction (tracking_code) on delete cascade on update cascade,
        foreign key (id) references client (id) on delete cascade on update cascade
    );

-- ##############################  PROCEDURES ##############################

DELIMITER //
    CREATE PROCEDURE issue_private_discount_code(ref_id INTEGER,ref_level INTEGER)
    BEGIN
        DECLARE last_code INTEGER;
        DECLARE dis_amount DECIMAL;
        IF ROUND (50 / (ref_level * 2),3) < 1 THEN
        Set dis_amount = 50000;
        ELSE
        SET dis_amount = ROUND(50 / (ref_level * 2),3);
        END IF;
        INSERT INTO discount_code(amount,discount_limit,usage_count,expiration_date) VALUES (dis_amount,1000000,1,DATE_ADD(CURRENT_TIMESTAMP,INTERVAL 7 DAY));
        SET last_code = LAST_INSERT_ID();
        INSERT INTO private_code(code,id) VALUES (last_code,ref_id);
        
    END//
DELIMITER ;

DELIMITER //
    CREATE PROCEDURE loop_through_refer_list()
    BEGIN
        DECLARE done TINYINT DEFAULT FALSE;
        DECLARE ref_id INTEGER;
        DECLARE ref_level INTEGER;
        DECLARE referrer_list CURSOR FOR  
        SELECT referrer,ROW_NUMBER() OVER (ORDER BY client_timestamp DESC) AS level FROM referral_hierarchy_temp,client WHERE referrer = id;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
        OPEN referrer_list;
            loop_through:
            LOOP
                FETCH NEXT FROM referrer_list INTO ref_id,ref_level;
                IF done THEN LEAVE loop_through;
                ELSE
                CALL issue_private_discount_code(ref_id,ref_level);
                END IF;
            END LOOP;
        CLOSE referrer_list;
    END//
DELIMITER ;

DELIMITER //
    CREATE PROCEDURE restore_products_from_blocked_cart(user_id INTEGER,shopping_cart_number INTEGER,locked_cart_number INTEGER)
    BEGIN
        DECLARE product_quantity INTEGER;
        DECLARE pr_id INTEGER;

        DECLARE done TINYINT DEFAULT FALSE;
        DECLARE product_list CURSOR FOR  
        SELECT adt.product_id,adt.quantity FROM added_to AS adt
        WHERE adt.id = user_id AND adt.cart_number = shopping_cart_number AND adt.locked_number = locked_cart_number;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
        OPEN product_list;
            loop_through:
            LOOP
                FETCH NEXT FROM product_list INTO pr_id,product_quantity;
                IF done THEN LEAVE loop_through;
                ELSE
                    UPDATE product SET stock_count = stock_count + product_quantity WHERE id = pr_id;
                END IF;
            END LOOP;
        CLOSE product_list;  
    END//
DELIMITER ;

DELIMITER //
    CREATE PROCEDURE block_cart(user_id INTEGER,shopping_cart_number INTEGER)
    BEGIN
        UPDATE shopping_cart SET cart_status = 'blocked' WHERE id = user_id AND cart_number = shopping_cart_number;
    END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE activate_cart(user_id INTEGER,shopping_cart_number INTEGER)
BEGIN
    UPDATE shopping_cart SET cart_status = 'active' WHERE id = user_id AND cart_number = shopping_cart_number;
END// DELIMITER ;

DELIMITER //
CREATE PROCEDURE calculate_cart_price (user_id INTEGER,shopping_cart_number INTEGER,locked_cart_number INTEGER,OUT result BIGINT)
BEGIN
    DECLARE shopping_cart_price BIGINT;
    DECLARE cart_price_after_applying_code BIGINT;
    DECLARE discount_code_amount DECIMAL;
    DECLARE discount_code_limit INTEGER;
    DECLARE dis_code INTEGER;
    DECLARE done TINYINT DEFAULT FALSE;

    DECLARE code_list CURSOR FOR  
    SELECT code FROM applied_to AS apt 
    WHERE user_id = apt.id AND shopping_cart_number = apt.cart_number AND locked_cart_number = apt.locked_number
    ORDER BY apt.applied_timestamp;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    SELECT SUM(cart_price * quantity) INTO shopping_cart_price FROM added_to WHERE user_id = id AND shopping_cart_number = cart_number AND locked_cart_number = locked_number;
    SET cart_price_after_applying_code = shopping_cart_price;
    
    OPEN code_list;
        loop_through:
        LOOP
            FETCH NEXT FROM code_list INTO dis_code;
            IF done THEN LEAVE loop_through;
            ELSE
                SELECT dc.amount,dc.discount_limit INTO discount_code_amount,discount_code_limit FROM discount_code AS dc WHERE dis_code = dc.code;
                IF (discount_code_amount <= 100) THEN
                    IF (ROUND((cart_price_after_applying_code * discount_code_amount) / 100 ,0) > discount_code_limit ) THEN
                        SET cart_price_after_applying_code = cart_price_after_applying_code - discount_code_limit;
                    ELSE
                        SET cart_price_after_applying_code = cart_price_after_applying_code - (ROUND((cart_price_after_applying_code * discount_code_amount) / 100 ,0));
                    END IF;
                ELSE 
                    SET cart_price_after_applying_code = cart_price_after_applying_code - discount_code_amount;
                END IF;
            END IF;
        END LOOP;
    CLOSE code_list;  

    IF cart_price_after_applying_code < 0 THEN
        SET result = 0;
    ELSE
        SET result = cart_price_after_applying_code;
    END IF;
END// DELIMITER ;

-- ##############################  TRIGGERS ##############################

DELIMITER // 
CREATE TRIGGER blocked_cart BEFORE INSERT ON locked_shopping_cart FOR EACH ROW BEGIN DECLARE 
            
        shopping_cart_status ENUM ('active', 'blocked', 'locked');
        SELECT
            cart_status INTO shopping_cart_status
        FROM
            shopping_cart
        WHERE
            id = NEW.id
            AND cart_number = NEW.cart_number;

        IF (shopping_cart_status = 'blocked') THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The cart is blocked';
END IF;
END // DELIMITER ;

DELIMITER // 
CREATE TRIGGER check_discount_code_limit_for_non_percentage_code BEFORE INSERT ON discount_code FOR EACH ROW
BEGIN
    IF (NEW.amount > 100) THEN
        IF (NEW.amount != NEW.discount_limit ) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount amount must be equal to discount limit for non percentage codes';
        END IF;
    END IF;
END // DELIMITER ;

DELIMITER //
CREATE TRIGGER issue_discount_code_from_referral AFTER INSERT ON refer FOR EACH ROW 
BEGIN
        DROP TEMPORARY TABLE IF EXISTS referral_hierarchy_temp;
        CREATE TEMPORARY TABLE referral_hierarchy_temp AS
        (WITH RECURSIVE referral_hierarchy(referrer,referee) AS 
        (
            SELECT referrer,referee FROM refer
            WHERE NEW.referee = referee
            UNION
            SELECT r.referrer,r.referee
            FROM refer AS r,referral_hierarchy AS rh
            WHERE rh.referrer = r.referee
        )
        SELECT * FROM referral_hierarchy);
        CALL loop_through_refer_list();
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_cart_number_range_and_count BEFORE INSERT ON shopping_cart FOR EACH ROW
BEGIN
    DECLARE is_vip TINYINT;

    IF NEW.id IN (SELECT id FROM vip_client WHERE TIMESTAMPDIFF(SECOND,CURRENT_TIMESTAMP(),subscription_expiration_time) >= 0) THEN
        SET is_vip = TRUE;
    ELSE
        SET is_vip = FALSE;
    END IF;

    IF is_vip = TRUE THEN
        IF (NEW.cart_number < 2 OR NEW.cart_number > 5) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'The vip users can not have more than 5 shopping cart';
        END IF;
    ELSE
        IF (EXISTS (SELECT * FROM shopping_cart WHERE NEW.id = id)) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Normal users can not have more than 1 shopping cart';
        ELSE
            IF (NEW.cart_number != 1) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'The cart number can be 1 for normal clients';
            END IF;
        END IF;
    END IF;

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER actions_after_adding_client AFTER INSERT ON client FOR EACH ROW
BEGIN
    INSERT INTO shopping_cart VALUES (NEW.id,1,'active');
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER actions_after_adding_vip_client AFTER INSERT ON vip_client FOR EACH ROW
BEGIN
    IF (NOT EXISTS (SELECT * FROM shopping_cart WHERE NEW.id = id AND cart_number >= 2)) THEN
        INSERT INTO shopping_cart VALUES (NEW.id,2,'active'),(NEW.id,3,'active'),(NEW.id,4,'active'),(NEW.id,5,'active');
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_existence_of_product BEFORE INSERT ON added_to FOR EACH ROW
BEGIN
    DECLARE total INTEGER;
    SELECT stock_count INTO total
    FROM product p
    WHERE p.id = NEW.product_id;
    IF NEW.quantity < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity can not be negative.';
    END IF;
    IF total = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The product is non existent.';
    ELSE
        IF total < NEW.quantity THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Your selected quantity of this product is more than the stock.';
        END IF;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_existence_of_product_on_update BEFORE UPDATE ON added_to FOR EACH ROW
BEGIN
    DECLARE total INTEGER;
    DECLARE diff_product_quantity INTEGER;
    SELECT stock_count INTO total
    FROM product p
    WHERE p.id = NEW.product_id;
    IF NEW.quantity < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity can not be negative.';
    END IF;
    SET diff_product_quantity = NEW.quantity - OLD.quantity;
    IF (diff_product_quantity > 0) THEN    
        IF (total = 0) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'The product is non existent.';
        ELSE
            IF total < diff_product_quantity THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Your selected quantity of this product is more than the stock.';
            END IF;
        END IF;
    END IF;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER add_diff_product_to_stock_on_update AFTER UPDATE ON added_to FOR EACH ROW
BEGIN
    DECLARE total INTEGER;
    DECLARE diff_product_quantity INTEGER;
    SELECT stock_count INTO total
    FROM product p
    WHERE p.id = NEW.product_id;
    SET diff_product_quantity = NEW.quantity - OLD.quantity;
    IF (diff_product_quantity > 0) THEN
        UPDATE product SET stock_count = stock_count - diff_product_quantity WHERE id = NEW.product_id;
    ELSE
        IF (diff_product_quantity < 0) THEN
            UPDATE product SET stock_count = stock_count + ABS(diff_product_quantity) WHERE id = NEW.product_id;
        END IF;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER reduce_stock_number AFTER INSERT ON added_to FOR EACH ROW
BEGIN
    UPDATE product p
    SET stock_count = stock_count - NEW.quantity
    WHERE p.id = NEW.product_id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_phone_number_structure BEFORE INSERT ON client FOR EACH ROW
BEGIN
    IF NOT (NEW.phone_number REGEXP '^[0-9]+$') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A phone number should only contains digits';
    END IF;
    IF LENGTH(NEW.phone_number) != 11 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A phone number should contains 11 digits';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_discount_usage_count BEFORE INSERT ON applied_to FOR EACH ROW
BEGIN
    DECLARE number_of_usage INTEGER;
    DECLARE usage_limit INTEGER;
    
    SELECT COUNT(*) INTO number_of_usage
    FROM applied_to apt
    WHERE apt.id = NEW.id AND apt.code = NEW.code;

    SELECT usage_count INTO usage_limit
    FROM discount_code as dc , public_code as pc , private_code
    WHERE (NEW.code = pc.code OR (NEW.code = private_code.code AND NEW.id = private_code.id));

    IF (number_of_usage + 1) > usage_limit THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Usage limit has been exceeded'
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_using_expired_discount_code BEFORE INSERT ON applied_to FOR EACH ROW
BEGIN
    DECLARE exp_date TIMESTAMP;

    SELECT expiration_date INTO exp_date
    FROM discount_code dc
    WHERE dc.code = NEW.code;

    IF exp_date < NOW() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This code is expired';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_user_for_using_private_code BEFORE INSERT ON applied_to FOR EACH ROW
BEGIN
    DECLARE is_private TINYINT;

    IF EXISTS(SELECT * FROM private_code pc WHERE pc.code = NEW.code and  pc.id != NEW.id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This code does not belong to you'
    END IF;
END //
DELIMITER ;

-- check transaction for insert into issued for

DELIMITER //
CREATE TRIGGER free_shopping_cart AFTER INSERT ON issued_for FOR EACH ROW
BEGIN
    DECLARE  trans_status enum ('Successful', 'Unsuccessful', 'Semi successful');

    SELECT t.transaction_status INTO trans_status
    FROM transaction t
    WHERE NEW.tracking_code = t.tracking_code;

    IF trans_status = 'Successful' THEN
        IF ((NEW.id NOT IN (SELECT id FROM vip_client WHERE TIMESTAMPDIFF(SECOND,CURRENT_TIMESTAMP(),subscription_expiration_time) >= 0)) AND NEW.cart_number >= 2) THEN
            UPDATE shopping_cart SET cart_status ='blocked' WHERE NEW.id = shopping_cart.id AND shopping_cart.cart_number = NEW.cart_number;
        ELSE
            UPDATE shopping_cart SET cart_status = 'active' WHERE shopping_cart.id= NEW.id AND shopping_cart.cart_number = NEW.cart_number ; 
        END IF;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER charge_wallet AFTER INSERT ON deposits_into_wallet FOR EACH ROW
BEGIN
    DECLARE  trans_status enum ('Successful', 'Unsuccessful', 'Semi successful');

    SELECT t.transaction_status INTO trans_status
    FROM transaction t
    WHERE NEW.tracking_code = t.tracking_code;

    IF trans_status = 'Successful' THEN
        UPDATE client SET wallet_balance = wallet_balance + NEW.amount WHERE NEW.id = client.id;
    END IF;
END //
DELIMITER ;

CREATE FUNCTION subscription_amount () RETURNS INTEGER DETERMINISTIC RETURN 20000;


DELIMITER //
CREATE TRIGGER transaction_for_subscription AFTER INSERT ON subscribe FOR EACH ROW
BEGIN
    DECLARE  trans_status enum ('Successful', 'Unsuccessful', 'Semi successful');
    DECLARE  trans_timestamp TIMESTAMP;
    SELECT t.transaction_status,t.transaction_timestamp INTO trans_status,trans_timestamp
    FROM transaction AS t WHERE NEW.tracking_code = t.tracking_code;

    IF (trans_status = 'Successful' AND NEW.tracking_code IN (SELECT tracking_code FROM wallet_transaction)) THEN
        UPDATE client SET wallet_balance = wallet_balance - subscription_amount() WHERE NEW.id = client.id;
        IF (NOT EXISTS(SELECT id FROM vip_client WHERE NEW.id = id))THEN
            INSERT INTO vip_client VALUES (NEW.id,trans_timestamp + INTERVAL 30 DAY);
        ELSE
            UPDATE vip_client SET subscription_expiration_time = trans_timestamp + INTERVAL 30 DAY WHERE id = NEW.id;
            UPDATE shopping_cart SET cart_status ='active' WHERE NEW.id = shopping_cart.id AND (shopping_cart.cart_number >=2 AND shopping_cart.cart_number<=5) AND shopping_cart.cart_status != 'locked';
        END IF;
    ELSE
        IF (trans_status = 'Successful' AND NEW.tracking_code IN (SELECT tracking_code FROM bank_transaction)) THEN
            IF (NOT EXISTS(SELECT id FROM vip_client WHERE NEW.id = id))THEN
                INSERT INTO vip_client VALUES (NEW.id,trans_timestamp + INTERVAL 30 DAY);
            ELSE
                UPDATE vip_client SET subscription_expiration_time = trans_timestamp + INTERVAL 30 DAY WHERE id = NEW.id;
                UPDATE shopping_cart SET cart_status ='active' WHERE NEW.id = shopping_cart.id AND (shopping_cart.cart_number >=2 AND shopping_cart.cart_number<=5) AND shopping_cart.cart_status != 'locked';
            END IF;
        END IF;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER transaction_for_shopping AFTER INSERT ON issued_for FOR EACH ROW
BEGIN
    DECLARE  trans_status enum ('Successful', 'Unsuccessful', 'Semi successful');
    DECLARE shopping_cart_price BIGINT;

    SELECT t.transaction_status INTO trans_status FROM transaction t WHERE NEW.tracking_code = t.tracking_code;
    CALL calculate_cart_price(NEW.id,NEW.cart_number,NEW.locked_number,shopping_cart_price); 
    IF (trans_status = 'Successful' AND NEW.tracking_code IN (SELECT tracking_code FROM wallet_transaction)) THEN
        UPDATE client SET wallet_balance = wallet_balance - shopping_cart_price WHERE NEW.id = client.id;
    END IF;
END //
DELIMITER ;
-- ##############################  EVENTS ##############################
SET GLOBAL event_scheduler = ON;

-- locked number have to be auto increment
DELIMITER //
CREATE EVENT check_cart_payment
ON SCHEDULE EVERY 1 HOUR 
STARTS CURRENT_TIMESTAMP + INTERVAL 3 DAY
ON COMPLETION PRESERVE
DO 
    BEGIN
        DECLARE done TINYINT DEFAULT FALSE;
        DECLARE user_id INTEGER;
        DECLARE shopping_cart_number INTEGER;
        DECLARE locked_cart_number INTEGER;
        DECLARE lock_timestamp TIMESTAMP;
        DECLARE newest_cart_timestamp TIMESTAMP;
        DECLARE locked_cart_list CURSOR FOR  
        SELECT lsc.id,lsc.cart_number,lsc.locked_number,lsc.locked_timestamp FROM locked_shopping_cart AS lsc,issued_for AS issue , transaction AS ta
        WHERE (lsc.id = issue.id AND lsc.cart_number = issue.cart_number AND lsc.locked_number = issue.locked_number AND ta.tracking_code = issue.tracking_code AND ta.transaction_status != 'Successful') UNION  (SELECT lsc.id,lsc.cart_number,lsc.locked_number,lsc.locked_timestamp FROM locked_shopping_cart AS lsc WHERE ((lsc.id,lsc.cart_number,lsc.locked_number) NOT IN (SELECT i.id,i.cart_number,i.locked_number FROM issued_for AS i)));
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
        OPEN locked_cart_list;
            loop_through:
            LOOP
                FETCH NEXT FROM locked_cart_list INTO user_id,shopping_cart_number,locked_cart_number,lock_timestamp;
                IF done THEN LEAVE loop_through;
                ELSE
                    SELECT MAX(locked_timestamp) INTO newest_cart_timestamp FROM locked_shopping_cart WHERE id= user_id AND cart_number = shopping_cart_number GROUP BY id,cart_number;
                    IF ((lock_timestamp = newest_cart_timestamp) AND TIMESTAMPDIFF(DAY,lock_timestamp,CURRENT_TIMESTAMP()) > 3) THEN
                        CALL restore_products_from_blocked_cart(user_id,shopping_cart_number,locked_cart_number);
                        CALL block_cart(user_id,shopping_cart_number);
                    END IF;
                END IF;
            END LOOP;
        CLOSE locked_cart_list;
    END //
DELIMITER ;

DELIMITER //
CREATE EVENT check_blocked_cart_for_activating
ON SCHEDULE EVERY 1 HOUR 
STARTS CURRENT_TIMESTAMP + INTERVAL 7 DAY
ON COMPLETION PRESERVE
DO 
    BEGIN
        DECLARE done TINYINT DEFAULT FALSE;
        DECLARE user_id INTEGER;
        DECLARE shopping_cart_number INTEGER;
        DECLARE locked_cart_number INTEGER;
        DECLARE lock_timestamp TIMESTAMP;
        DECLARE newest_cart_timestamp TIMESTAMP;

        DECLARE blocked_cart_list CURSOR FOR  
        SELECT sc.id,sc.cart_number,lsc.locked_timestamp FROM shopping_cart AS sc , locked_shopping_cart AS lsc
        WHERE sc.cart_status = 'blocked' AND sc.id = lsc.id AND sc.cart_number = lsc.cart_number;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
        OPEN blocked_cart_list;
            loop_through:
            LOOP
                FETCH NEXT FROM blocked_cart_list INTO user_id,shopping_cart_number,lock_timestamp;
                IF done THEN LEAVE loop_through;
                ELSE
                    SELECT MAX(locked_timestamp) INTO newest_cart_timestamp FROM locked_shopping_cart WHERE id= user_id AND cart_number = shopping_cart_number GROUP BY id,cart_number;
                    IF ((lock_timestamp = newest_cart_timestamp) AND TIMESTAMPDIFF(DAY,lock_timestamp,CURRENT_TIMESTAMP()) >= 7) THEN
                        
                        IF user_id IN (SELECT id FROM vip_client WHERE TIMESTAMPDIFF(SECOND,CURRENT_TIMESTAMP(),subscription_expiration_time) >= 0) THEN
                            CALL activate_cart(user_id,shopping_cart_number);
                        ELSE
                            IF(shopping_cart_number = 1) THEN
                                CALL activate_cart(user_id,shopping_cart_number);
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END LOOP;
        CLOSE blocked_cart_list;
    END //

DELIMITER //
CREATE EVENT check_expiration_vip_subscription
ON SCHEDULE EVERY 1 MINUTE 
STARTS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
DO
BEGIN
    
    DECLARE done TINYINT DEFAULT FALSE;
    DECLARE user_id INTEGER;

    DECLARE expired_vip_list CURSOR FOR  
    SELECT vc.id FROM vip_client AS vc WHERE TIMESTAMPDIFF(SECOND,CURRENT_TIMESTAMP(),subscription_expiration_time) < 0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN expired_vip_list;
        loop_through:
        LOOP
            FETCH NEXT FROM expired_vip_list INTO user_id;
            IF done THEN LEAVE loop_through;
            ELSE
                UPDATE shopping_cart SET cart_status ='blocked' WHERE user_id = shopping_cart.id AND (shopping_cart.cart_number >=2 AND shopping_cart.cart_number<=5) AND shopping_cart.cart_status != 'locked';
            END IF;
        END LOOP;
    CLOSE expired_vip_list;
END //
DELIMITER ;

DELIMITER //
CREATE EVENT monthly_add_to_vip_wallet
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    DECLARE user_id INTEGER;
    DECLARE total_purchase DECIMAL(10,2) DEFAULT 0;
    DECLARE spent_for_cart DECIMAL(10,2) DEFAULT 0;
    DECLARE cnumber     INT;
    DECLARE clnumber   INT;
    DECLARE vip_done INT DEFAULT 0;
    DECLARE numbers_done INT DEFAULT 0;
    
    DECLARE vip_cur CURSOR FOR 
        SELECT id
        FROM vip_client 
        WHERE Subscription_expiration_time >= CURRENT_TIMESTAMP;

    DECLARE numbers_cur CURSOR FOR
        SELECT cart_number, locked_number
        FROM applied_to apt JOIN issued_for isu ON apt.id = isj.id AND apt.cart_number = isu.cart_number AND apt.locked_number = isu.locked_number
        WHERE apt.id = user_id AND tracking_code IN (
            SELECT tracking_code 
            FROM transaction
            WHERE transaction_status = 'Successful'
            AND transaction_timestamp >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 MONTH)
          );
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET vip_done = 1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET numbers_done = 1;
    OPEN vip_cur;


    vip_loop: LOOP
        FETCH vip_cur INTO user_id;
        IF done THEN
            LEAVE vip_loop;
        END IF;
        OPEN numbers_cur;

        numbers_loop: LOOP
            FETCH numbers_cur INTO cnumber, clnumber;
            IF done2 THEN
                LEAVE numbers_loop;
            END IF;
            SET spent_for_cart = 0;

            CALL calculate_cart_price(vid, cnumber, clnumber, spent_for_cart);
            SET total_purchase = total_purchase + spent_for_cart;
        END LOOP;
        
        CLOSE numbers_cur;
        SET numbers_done = FALSE;

        UPDATE client
        SET wallet_balance = wallet_balance + total_purchase
        WHERE id = user_id;

        SET total_purchase = 0;
    END LOOP;
    CLOSE vip_cur;
END//
DELIMITER ;