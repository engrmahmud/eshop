BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "priority" bigint NOT NULL,
    "imageUrl" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "product" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "price" double precision NOT NULL,
    "discount" double precision NOT NULL,
    "images" json,
    "sizes" json,
    "colors" json,
    "subcategoryId" bigint NOT NULL,
    "categoryId" bigint NOT NULL,
    "quantity" bigint NOT NULL,
    "isAvailable" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subcategory" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "imageUrl" text NOT NULL,
    "categoryId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "email" text NOT NULL,
    "password" text NOT NULL,
    "phone" text NOT NULL,
    "address" text NOT NULL,
    "isAdmin" boolean NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "product"
    ADD CONSTRAINT "product_fk_0"
    FOREIGN KEY("subcategoryId")
    REFERENCES "subcategory"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "product"
    ADD CONSTRAINT "product_fk_1"
    FOREIGN KEY("categoryId")
    REFERENCES "category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subcategory"
    ADD CONSTRAINT "subcategory_fk_0"
    FOREIGN KEY("categoryId")
    REFERENCES "category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR eshop
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('eshop', '20260303071606579', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260303071606579', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260129181124635', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181124635', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
