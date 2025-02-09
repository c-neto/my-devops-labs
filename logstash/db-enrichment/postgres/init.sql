CREATE DATABASE db;

\c db;

CREATE TABLE table_users (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_group VARCHAR(50) NOT NULL
);

INSERT INTO table_users (user_name, user_email, user_group) VALUES
('Alice Silva', 'alice@example.com', 'admin'),
('Bruno Costa', 'bruno@example.com', 'user'),
('Carlos Mendes', 'carlos@example.com', 'user'),
('Diana Lopes', 'diana@example.com', 'moderator');
