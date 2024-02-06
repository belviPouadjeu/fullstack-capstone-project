router.get('/', async (req, res) => {
    try {
        // Task 1: Connect to MongoDB
        // {{insert code here}}

        // Task 2: Access MongoDB collection
        // {{insert code here}}

        // Task 3: Fetch all gifts
        // {{insert code here}}

        res.json(/* Task 4: Return gifts */);
    } catch (e) {
        console.error('Error fetching gifts:', e);
        res.status(500).send('Error fetching gifts');
    }
});
