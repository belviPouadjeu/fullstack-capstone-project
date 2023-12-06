require('dotenv').config();
const MongoClient = require('mongodb').MongoClient;
const fs = require('fs');

const username = encodeURIComponent(process.env.MONGO_USER);
const password = encodeURIComponent(process.env.MONGO_PASS);
const authSource = 'admin';

// MongoDB connection URL
const url = process.env.MONGO_URL;
console.log(url)

const dbName = 'productdb';
const collectionName = 'products';

// notice you have to load the array of products into the data object
const data = JSON.parse(fs.readFileSync('sample.json', 'utf8')).docs;

// connect to database and insert data into the collection
async function loadData() {
    const client = new MongoClient(url, {
        auth: {
            username: username,
            password: password
        },
        authSource: authSource,
        useUnifiedTopology: true
    });

    try {
        // Connect to the MongoDB client
        await client.connect();
        console.log("Connected successfully to server");

        // database will be created if it does not exist
        const db = client.db(dbName);

        // collect will be created if it does not exist
        const collection = db.collection(collectionName);

        // Insert data into the collection
        const insertResult = await collection.insertMany(data);
        console.log('Inserted documents:', insertResult.insertedCount);
    } catch (err) {
        console.error(err);
    } finally {
        // Close the connection
        await client.close();
    }
}

// call the function to load the data
loadData();