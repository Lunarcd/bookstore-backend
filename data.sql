-- Insert books
INSERT INTO books (title, description, isbn, author)
VALUES 
    ('The Great Gatsby', 'A novel by F. Scott Fitzgerald.', '9780743273565', 'F. Scott Fitzgerald'),
    ('1984', 'A dystopian novel by George Orwell.', '9780451524935', 'George Orwell'),
    ('To Kill a Mockingbird', 'A novel by Harper Lee.', '9780061120084', 'Harper Lee'),
    ('Brave New World', 'A science fiction novel by Aldous Huxley.', '9780060850524', 'Aldous Huxley'),
    ('Moby-Dick', 'A novel about the voyage of the whaling ship Pequod.', '9781503280786', 'Herman Melville'),
    ('The Catcher in the Rye', 'A story about adolescent Holden Caulfield.', '9780316769488', 'J.D. Salinger')
ON CONFLICT DO NOTHING;

-- Insert categories
INSERT INTO categories (name, description)
VALUES
    ('Classic Literature', 'Timeless works of fiction'),
    ('Dystopian', 'Explores futuristic and oppressive societies'),
    ('Science Fiction', 'Futuristic technology and science-based themes'),
    ('American Literature', 'Written by American authors'),
    ('Coming-of-Age', 'Focus on growing up and personal development')
ON CONFLICT DO NOTHING;

-- Insert users
INSERT INTO users (email, password, fname, lname, dob, role)
VALUES
    ('alice@example.com', 'hashed1', 'Alice', 'Smith', '1990-05-14', 'member'),
    ('bob@example.com', 'hashed2', 'Bob', 'Johnson', '1985-08-22', 'staff'),
    ('carol@example.com', 'hashed3', 'Carol', 'White', '1992-12-03', 'admin'),
    ('dave@example.com', 'hashed4', 'Dave', 'Brown', '1999-04-11', 'member'),
    ('emma@example.com', 'hashed5', 'Emma', 'Davis', '2001-09-27', 'member'),
    ('frank@example.com', 'hashed6', 'Frank', 'Garcia', '1988-07-19', 'staff')
ON CONFLICT DO NOTHING;

-- Insert book-category relationships
INSERT INTO book_categories (book_id, category_id)
VALUES
    ((SELECT id FROM books WHERE title = '1984'), (SELECT id FROM categories WHERE name = 'Dystopian')),
    ((SELECT id FROM books WHERE title = '1984'), (SELECT id FROM categories WHERE name = 'Science Fiction')),
    ((SELECT id FROM books WHERE title = 'Brave New World'), (SELECT id FROM categories WHERE name = 'Science Fiction')),
    ((SELECT id FROM books WHERE title = 'Brave New World'), (SELECT id FROM categories WHERE name = 'Dystopian')),
    ((SELECT id FROM books WHERE title = 'The Great Gatsby'), (SELECT id FROM categories WHERE name = 'Classic Literature')),
    ((SELECT id FROM books WHERE title = 'To Kill a Mockingbird'), (SELECT id FROM categories WHERE name = 'American Literature')),
    ((SELECT id FROM books WHERE title = 'Moby-Dick'), (SELECT id FROM categories WHERE name = 'Classic Literature')),
    ((SELECT id FROM books WHERE title = 'The Catcher in the Rye'), (SELECT id FROM categories WHERE name = 'Coming-of-Age')),
    ((SELECT id FROM books WHERE title = 'The Catcher in the Rye'), (SELECT id FROM categories WHERE name = 'American Literature'))
ON CONFLICT DO NOTHING;

-- Insert reviews
INSERT INTO reviews (rate, book_id, user_id, content)
VALUES
    (5, (SELECT id FROM books WHERE title = '1984'), (SELECT id FROM users WHERE email = 'alice@example.com'), 'A chilling and powerful read.'),
    (4, (SELECT id FROM books WHERE title = 'The Great Gatsby'), (SELECT id FROM users WHERE email = 'bob@example.com'), 'Beautifully written but a bit slow-paced.'),
    (5, (SELECT id FROM books WHERE title = 'To Kill a Mockingbird'), (SELECT id FROM users WHERE email = 'carol@example.com'), 'A masterpiece on justice and morality.'),
    (3, (SELECT id FROM books WHERE title = 'Brave New World'), (SELECT id FROM users WHERE email = 'dave@example.com'), 'Interesting concepts but hard to follow.'),
    (4, (SELECT id FROM books WHERE title = 'Moby-Dick'), (SELECT id FROM users WHERE email = 'emma@example.com'), 'A deep and adventurous read.'),
    (5, (SELECT id FROM books WHERE title = 'The Catcher in the Rye'), (SELECT id FROM users WHERE email = 'frank@example.com'), 'Really resonated with me.')
ON CONFLICT DO NOTHING;