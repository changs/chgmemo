CREATE TABLE "users" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "username" VARCHAR(15), "fullname" VARCHAR(25), "email" VARCHAR(50) NOT NULL, "hashed_password" VARCHAR(50), "created_at" TIMESTAMP NOT NULL, "auth_token" VARCHAR(50), "locale" INTEGER, "admin" BOOLEAN);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX "unique_users_username" ON "users" ("username");
CREATE UNIQUE INDEX "unique_users_email" ON "users" ("email");
CREATE TABLE "items" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "question" VARCHAR(50) NOT NULL, "answer" VARCHAR(50) NOT NULL, "ef" FLOAT, "interval" FLOAT, "created_at" TIMESTAMP, "updated_at" TIMESTAMP, "review_at" TIMESTAMP, "user_id" INTEGER NOT NULL);
CREATE INDEX "index_items_user" ON "items" ("user_id");
CREATE TABLE "news" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" TIMESTAMP, "title" VARCHAR(50), "content" TEXT, "locale" INTEGER);
CREATE TABLE "locales" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "code" VARCHAR(2));
