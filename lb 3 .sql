CREATE TABLE IF NOT EXISTS "branch" (
	"branch_id" int NOT NULL,
	"branch_name" varchar(40) NOT NULL,
	"city" varchar(30) NOT NULL,
	"street" varchar(40) NOT NULL,
	"building_no" int,
	PRIMARY KEY ("branch_id")
);
CREATE TABLE IF NOT EXISTS "librarian" (
	"librarian_id" int NOT NULL,
	"first_name" varchar(30) NOT NULL,
	"last_name" varchar(30) NOT NULL,
	"position" varchar(30) NOT NULL,
	"hire_date" date NOT NULL,
	"branch_id" int NOT NULL,
	"manager_id" int,
	"salary" float NOT NULL,
	PRIMARY KEY ("librarian_id")
);
CREATE TABLE IF NOT EXISTS "reader" (
	"reader_id" int NOT NULL,
	"first_name" varchar(30) NOT NULL,
	"last_name" varchar(30) NOT NULL,
	"gender" varchar(1) NOT NULL,
	"birth_date" date NOT NULL,
	"phone_number" int NOT NULL,
	"email" varchar(50) NOT NULL,
	"address" varchar(100),
	PRIMARY KEY ("reader_id")
);
CREATE TABLE IF NOT EXISTS "book" (
	"book_id" int NOT NULL,
	"title" varchar(100) NOT NULL,
	"genre" varchar(30) NOT NULL,
	"publisher" varchar(50) NOT NULL,
	"publication_year" int NOT NULL,
	"isbn" varchar(13) NOT NULL,
	"copies_count" int NOT NULL,
	PRIMARY KEY ("book_id")
);
CREATE TABLE IF NOT EXISTS "author" (
	"author_id" int NOT NULL,
	"first_name" varchar(30) NOT NULL,
	"last_name" varchar(30) NOT NULL,
	"country" varchar(30) NOT NULL,
	PRIMARY KEY ("author_id")
);
CREATE TABLE IF NOT EXISTS "book_author" (
	"book_id" int NOT NULL,
	"author_id" int NOT NULL,
	PRIMARY KEY ("book_id", "author_id")
);
CREATE TABLE IF NOT EXISTS "loan" (
	"loan_id" int NOT NULL,
	"librarian_id" int NOT NULL,
	"reader_id" int NOT NULL,
	"book_id" int NOT NULL,
	"issue_date" date NOT NULL,
	"due_date" date NOT NULL,
	"return_date" date,
	PRIMARY KEY ("loan_id")
);
ALTER TABLE "librarian" ADD CONSTRAINT "librarian_fk5" FOREIGN KEY ("branch_id") REFERENCES "branch"("branch_id");
ALTER TABLE "librarian" ADD CONSTRAINT "librarian_fk6" FOREIGN KEY ("manager_id") REFERENCES "librarian"("librarian_id");
ALTER TABLE "book_author" ADD CONSTRAINT "book_author_fk0" FOREIGN KEY ("book_id") REFERENCES "book"("book_id");
ALTER TABLE "book_author" ADD CONSTRAINT "book_author_fk1" FOREIGN KEY ("author_id") REFERENCES "author"("author_id");
ALTER TABLE "loan" ADD CONSTRAINT "loan_fk1" FOREIGN KEY ("librarian_id") REFERENCES "librarian"("librarian_id");
ALTER TABLE "loan" ADD CONSTRAINT "loan_fk2" FOREIGN KEY ("reader_id") REFERENCES "reader"("reader_id");
ALTER TABLE "loan" ADD CONSTRAINT "loan_fk3" FOREIGN KEY ("book_id") REFERENCES "book"("book_id");