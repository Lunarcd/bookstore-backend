--: User (id, email, password, fname, lname, dob?, role, created_at, updated_at)

--! get : User
SELECT * 
FROM users
WHERE id = :id;

--! get_by_email : User
SELECT * 
FROM users
WHERE email = :email;