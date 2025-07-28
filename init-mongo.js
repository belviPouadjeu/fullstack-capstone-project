// MongoDB initialization script
db = db.getSiblingDB('giftsdb');

// Create collections
db.createCollection('users');
db.createCollection('gifts');

// Create indexes for better performance
db.users.createIndex({ "email": 1 }, { unique: true });
db.gifts.createIndex({ "name": 1 });
db.gifts.createIndex({ "date_added": -1 });

print('Database initialized successfully');