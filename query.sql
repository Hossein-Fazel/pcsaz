/*
WE USE TA'S TABLES
 */
create database pcsaz;

USE pcsaz;

create table
    product (
        id VARCHAR(20) primary key,
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
        current_price INTEGER not null default 0,
        stock_count INTEGER not null default 0,
        brand VARCHAR(40) not null,
        model VARCHAR(40) not null
    );

create table
    hdd (
        id VARCHAR(20) primary key,
        rotational_speed INTEGER not null,
        wattage INTEGER not null,
        capacity smallint not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table
    cp_case (
        id VARCHAR(20) primary key,
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

create table
    power_supply (
        id VARCHAR(20) primary key,
        supported_wattage INTEGER not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table
    gpu (
        id VARCHAR(20) primary key,
        clock_speed smallint not null,
        ram_size smallint not null,
        number_of_fans smallint not null,
        wattage INTEGER not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table
    ssd (
        id VARCHAR(20) primary key,
        wattage INTEGER not null,
        capacity smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table
    ram_stick (
        id VARCHAR(20) primary key,
        frequency INTEGER not null,
        generation smallint not null,
        wattage INTEGER not null,
        capacity smallint not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

--speed range is int or another thing like range????
create table
    motherboard (
        id VARCHAR(20) primary key,
        chipset VARCHAR(40) not null,
        num_of_memory_slots smallint not null,
        memory_speed_range smallint not null,
        wattage INTEGER not null,
        depth smallint not null,
        height smallint not null,
        width smallint not null,
        foreign key (id) references product (id) on delete cascade on update cascade
    );

create table
    cpu (
        id VARCHAR(20) primary key,
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

create table
    cooler (
        id VARCHAR(20) primary key,
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

create table
    cc_socket_compatible_with (
        cooler_id VARCHAR(20),
        cpu_id VARCHAR(20),
        primary key (cooler_id, cpu_id),
        foreign key (cooler_id) references cooler (id) on delete cascade on update cascade,
        foreign key (cpu_id) references cpu (id) on delete cascade on update cascade
    );

create table
    mc_socket_compatible_with (
        motherboard_id VARCHAR(20),
        cpu_id VARCHAR(20),
        primary key (motherboard_id, cpu_id),
        foreign key (motherboard_id) references motherboard (id) on delete cascade on update cascade,
        foreign key (cpu_id) references cpu (id) on delete cascade on update cascade
    );

create table
    rm_slot_compatible_with (
        motherboard_id VARCHAR(20),
        ram_id VARCHAR(20),
        primary key (motherboard_id, ram_id),
        foreign key (motherboard_id) references motherboard (id) on delete cascade on update cascade,
        foreign key (ram_id) references ram_stick (id) on delete cascade on update cascade
    );

create table
    gm_slot_compatible_with (
        motherboard_id VARCHAR(20),
        gpu_id VARCHAR(20),
        primary key (motherboard_id, gpu_id),
        foreign key (motherboard_id) references motherboard (id) on delete cascade on update cascade,
        foreign key (gpu_id) references gpu (id) on delete cascade on update cascade
    );

create table
    sm_slot_compatible_with (
        motherboard_id VARCHAR(20),
        ssd_id VARCHAR(20),
        primary key (motherboard_id, ssd_id),
        foreign key (motherboard_id) references motherboard (id) on delete cascade on update cascade,
        foreign key (ssd_id) references ssd (id) on delete cascade on update cascade
    );

create table
    connector_compatible_with (
        gpu_id VARCHAR(20),
        power_id VARCHAR(20),
        primary key (gpu_id, power_id),
        foreign key (gpu_id) references gpu (id) on delete cascade on update cascade,
        foreign key (power_id) references power_supply (id) on delete cascade on update cascade
    );

create table
    client (
        id INTEGER AUTO_INCREMENT primary key,
        phone_number VARCHAR(11) unique,
        first_name VARCHAR(50) not null,
        last_name VARCHAR(50) not null,
        wallet_balance integer default 0,
        referral_code VARCHAR(20) not null unique,
        client_timestamp TIMESTAMP not null default CURRENT_TIMESTAMP
    );
create table
    vip_client (
        id INTEGER primary key,
        subscription_expiration_time TIMESTAMP,
        foreign key (id) references client (id) on delete cascade on update cascade
    );

create table
    refer (
        referee INTEGER primary key,
        referrer INTEGER not null,
        foreign key (referee) references client (id) on delete cascade on update cascade,
        foreign key (referrer) references client (id) on delete cascade on update cascade
    );

create table
    address (
        id INTEGER,
        province VARCHAR(50),
        remainder VARCHAR(300),
        primary key (id, province, remainder),
        foreign key (id) references client (id) on delete cascade on update cascade
    );

create table
    discount_code (
        code INTEGER primary key AUTO_INCREMENT,
        amount VARCHAR(7) not null,
        discount_limit INTEGER not null,
        usage_count INTEGER not null,
        expiration_date TIMESTAMP not null
    );

create table
    private_code (
        code INTEGER,
        id INTEGER,
        private_code_timestamp TIMESTAMP not null default CURRENT_TIMESTAMP,
        primary key (code),
        foreign key (code) references discount_code (code) on delete cascade on update cascade,
        foreign key (id) references client (id) on delete cascade on update cascade
    );

create table
    public_code (
        code INTEGER,
        primary key (code),
        foreign key (code) references discount_code (code) on delete cascade on update cascade
    );

create table
    shopping_cart (
        id INTEGER,
        cart_number INTEGER,
        cart_status ENUM ('active', 'blocked', 'locked') not null default 'active',
        primary key (id, cart_number),
        foreign key (id) references client (id) on delete cascade on update cascade
    );

create table
    locked_shopping_cart (
        id INTEGER,
        cart_number INTEGER,
        locked_number INTEGER,
        locked_timestamp TIMESTAMP not null default CURRENT_TIMESTAMP,
        primary key (id, cart_number, locked_number),
        foreign key (id, cart_number) references shopping_cart (id, cart_number) on delete cascade on update cascade
    );

create table
    added_to (
        id INTEGER,
        cart_number INTEGER,
        locked_number INTEGER,
        product_id VARCHAR(20),
        quantity INTEGER not null default 1,
        cart_price INTEGER not null,
        primary key (id, cart_number, locked_number, product_id),
        foreign key (id, cart_number, locked_number) references locked_shopping_cart (id, cart_number, locked_number) on delete cascade on update cascade,
        foreign key (product_id) references product (id) on delete cascade on update cascade
    );

create table
    applied_to (
        id INTEGER,
        cart_number INTEGER,
        locked_number INTEGER,
        code INTEGER,
        applied_timestamp TIMESTAMP not null default CURRENT_TIMESTAMP,
        primary key (id, cart_number, locked_number, code),
        foreign key (id, cart_number, locked_number) references locked_shopping_cart (id, cart_number, locked_number) on delete cascade on update cascade,
        foreign key (code) references discount_code (code) on delete cascade on update cascade
    );

create table
    transaction (
        tracking_code VARCHAR(15) primary key,
        transaction_status enum ('Successful', 'Unsuccessful', 'Semi successful') not null default 'Unsuccessful',
        transaction_timestamp TIMESTAMP not null default CURRENT_TIMESTAMP
    );

create table
    bank_transaction (
        tracking_code VARCHAR(15),
        card_number VARCHAR(16) not null,
        primary key (tracking_code),
        foreign key (tracking_code) references transaction (tracking_code) on delete cascade on update cascade
    );

create table
    wallet_transaction (
        tracking_code VARCHAR(15),
        primary key (tracking_code),
        foreign key (tracking_code) references transaction (tracking_code) on delete cascade on update cascade
    );

create table
    subscribe (
        tracking_code VARCHAR(15),
        id INTEGER,
        primary key (tracking_code),
        foreign key (tracking_code) references transaction (tracking_code) on delete cascade on update cascade,
        foreign key (id) references client (id) on delete cascade on update cascade
    );

create table
    issued_for (
        tracking_code VARCHAR(15),
        id INTEGER,
        cart_number INTEGER,
        locked_number INTEGER,
        primary key (tracking_code),
        foreign key (tracking_code) references transaction (tracking_code) on delete cascade on update cascade,
        foreign key (id, cart_number, locked_number) references locked_shopping_cart (id, cart_number, locked_number) on delete cascade on update cascade
    );

create table
    deposits_into_wallet (
        tracking_code VARCHAR(15),
        id INTEGER,
        amount INTEGER not null,
        primary key (tracking_code),
        foreign key (tracking_code) references bank_transaction (tracking_code) on delete cascade on update cascade,
        foreign key (id) references client (id) on delete cascade on update cascade
    );


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

        IF (shopping_cart_status = 'blocked') THEN signal sqlstate '45000'
        SET
            MESSAGE_TEXT = 'The cart is blocked';
END IF;
END // DELIMITER ;


DELIMITER //
    CREATE PROCEDURE issue_private_discount_code(ref_id INTEGER,ref_level INTEGER)
    BEGIN
        DECLARE last_code INTEGER;
        DECLARE dis_amount VARCHAR(7);
        IF ROUND (50 / (ref_level * 2),3) < 1 THEN
        Set dis_amount = '50000';
        ELSE
        SET dis_amount = CONCAT(CAST(ROUND(50 / (ref_level * 2),3) AS CHAR),'%');
        END IF;
        INSERT INTO discount_code(amount,discount_limit,usage_count,expiration_date) VALUES (dis_amount,1000000,1,DATE_ADD(CURRENT_TIMESTAMP,INTERVAL 7 DAY));
        SET last_code = LAST_INSERT_ID();
        INSERT INTO private_code(code,id) VALUES (last_code,ref_id);
        
    END//
DELIMITER ;

DELIMITER //
    CREATE PROCEDURE loop_through_refer_list()
    BEGIN
        DECLARE done BOOLEAN DEFAULT FALSE;
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
CREATE TRIGGER check_cart_count
BEFORE INSERT ON shopping_cart
FOR EACH ROW
BEGIN
    DECLARE is_vip BOOLEAN;
    DECLARE used_cart INTEGER;

    SELECT COUNT(id) INTO is_vip
    FROM vip_client vc
    WHERE NEW.id = vc.id;

    SELECT COUNT(*) INTO used_cart
    FROM shopping_cart sc
    WHERE sc.id = NEW.id;

    IF is_vip = TRUE THEN
        IF (used_cart + 1) > 5 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'The vip users can not have more than 5 shopping cart';
        END IF;
    ELSE
        IF (used_cart + 1) > 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Users can not have more than 1 shopping cart';
        END IF;
    END IF;
END //
DELIMITER ;