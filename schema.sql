CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS books (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    title varchar(255) NOT NULL,
    description text,
    isbn varchar(16) UNIQUE NOT NULL,
    author varchar(255) NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS categories (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    name varchar(128) NOT NULL,
    description text,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS book_categories (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    book_id uuid NOT NULL REFERENCES books(id) ON DELETE CASCADE,
    category_id uuid NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    UNIQUE(book_id, category_id)
);

CREATE TYPE role AS ENUM (
    'member',
    'staff',
    'admin'
);

CREATE TABLE IF NOT EXISTS users (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    email varchar(128) UNIQUE NOT NULL,
    password varchar(64) NOT NULL,
    fname varchar(64) NOT NULL,
    lname varchar(64) NOT NULL,
    dob date,
    role role NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS reviews (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    rate INTEGER CHECK (rate >= 1 AND rate <= 5),
    book_id uuid NOT NULL REFERENCES books(id) ON DELETE CASCADE,
    user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    content text,
    created_at timestamptz NOT NULL DEFAULT now(),
    UNIQUE(book_id, user_id)
);