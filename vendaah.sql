-- SQL schema for Vendaah database

-- Table: users
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    phone_number VARCHAR(20),
    address TEXT,
    date_of_birth DATE,
    role VARCHAR(20) NOT NULL
);

-- Table: vendors
CREATE TABLE vendors (
    vendor_id SERIAL PRIMARY KEY,
    business_name VARCHAR(255) NOT NULL,
    description TEXT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    business_hours JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'ACTIVE'
);

-- Table: products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    vendor_id INT REFERENCES vendors(vendor_id),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    price DECIMAL(10,2),
    currency VARCHAR(10),
    unit VARCHAR(50),
    quantity INT,
    threshold INT,
    images JSONB,
    attributes JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'IN_STOCK'
);

-- Table: inquiries
CREATE TABLE inquiries (
    inquiry_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES users(user_id),
    vendor_id INT REFERENCES vendors(vendor_id),
    product_id INT REFERENCES products(product_id),
    subject VARCHAR(255),
    message TEXT,
    preferred_contact_method VARCHAR(20),
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expected_response_time INTERVAL
);

-- Table: analytics
CREATE TABLE analytics (
    analytics_id SERIAL PRIMARY KEY,
    vendor_id INT REFERENCES vendors(vendor_id),
    period JSONB,
    views INT,
    clicks INT,
    inquiries INT,
    conversion_rate DECIMAL(5,2),
    demographics JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample data for testing purposes
INSERT INTO users (email, password, first_name, last_name, age, gender, phone_number, address, date_of_birth, role)
VALUES ('user@example.com', 'securepassword', 'John', 'Doe', 20, 'Male', '123-456-7890', '123 Street, City, Country', '2000-01-01', 'customer');

INSERT INTO vendors (business_name, description, email, password, phone, address, city, state, postal_code, latitude, longitude, business_hours, status)
VALUES ('Fresh Groceries Ltd', 'Local grocery store specializing in organic produce', 'contact@freshgroceries.com', '********', '+1234567890', '123 Market Street', 'Springfield', 'IL', '62701', 39.78373, -89.65063, '[{"day": "MONDAY", "open": "09:00", "close": "18:00"}]', 'ACTIVE');

INSERT INTO products (vendor_id, name, description, category, price, currency, unit, quantity, threshold, images, attributes, status)
VALUES (1, 'Organic Red Apples', 'Fresh organic apples from local farms', 'PRODUCE', 4.99, 'USD', 'per pound', 100, 20, '[{"url": "https://storage.vendaah.com/products/apple1.jpg", "isPrimary": true}]', '{"organic": true, "origin": "Local Farm", "season": "Fall"}', 'IN_STOCK');

INSERT INTO inquiries (customer_id, vendor_id, product_id, subject, message, preferred_contact_method, status, expected_response_time)
VALUES (1, 1, 1, 'Product Availability', 'Do you have organic pears in stock?', 'EMAIL', 'PENDING', '24h');

INSERT INTO analytics (vendor_id, period, views, clicks, inquiries, conversion_rate, demographics)
VALUES (1, '{"start": "2025-01-01T00:00:00Z", "end": "2025-01-27T23:59:59Z"}', 1250, 380, 45, 3.6, '{"ageGroups": {"18-24": 15, "25-34": 45, "35-44": 25, "45+": 15}, "topLocations": [{"city": "Springfield", "percentage": 75}]}');
