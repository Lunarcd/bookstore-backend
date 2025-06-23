CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS Book(
    bookId uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    title varchar(255) NOT NULL,
    description text,
    isbn varchar(16) UNIQUE NOT NULL,
    author varchar(255) NOT NULL,
    createdAt timestamptz NOT NULL DEFAULT now(),
    updatedAt timestamptz NOT NULL DEFAULT now()
)

CREATE TABLE IF NOT EXISTS Category(
    categoryId uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    name varchar(128) NOT NULL,
    description text,
    createdAt timestamptz NOT NULL DEFAULT now(),
    updatedAt timestamptz NOT NULL DEFAULT now()
)

CREATE TABLE IF NOT EXISTS BookCategory(
    bookCategoryId PRIMARY KEY DEFAULT uuid_generate_v4(),
    bookId uuid NOT NULL REFERENCES Book(bookId) ON DELETE CASCADE,
    categoryId uuid NOT NULL REFERENCES Category(categoryId) ON DELETE CASCADE,
    UNIQUE(bookId, categoryId)
)

CREATE TYPE role AS ENUM (
    'member',
    'staff',
    'admin'
);

CREATE TABLE IF NOT EXISTS User(
    userId uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    email varchar(128) UNIQUE NOT NULL,
    password varchar(64) NOT NULL,
    fname varchar(64) NOT NULL,
    lname varchar(64) NOT NULL,
    dob date,
    role role NOT NULL,
    createdAt timestamptz NOT NULL DEFAULT now(),
    updatedAt timestamptz NOT NULL DEFAULT now()
)

CREATE TABLE IF NOT EXISTS Review(
    reviewId uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    rate INTEGER CHECK (rate >= 1 AND rate <= 5),
    bookId uuid NOT NULL REFERENCES Book(bookId) ON DELETE CASCADE,
    userId uuid NOT NULL REFERENCES User(userId) ON DELETE CASCADE,
    content text,
    createdAt timestamptz NOT NULL DEFAULT now(),
    UNIQUE(bookId, userId)
)