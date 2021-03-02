const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('views'));

app.get('/', (req, res) => {
	res.send('Hello World!');
});

app.post('/register', (req, res) => {
	const { firstname, lastname, birthdate, address, mail, phone } = req.body;
	if (!firstname || !lastname || !birthdate || !address || !mail || !phone)
		res.status(403).json('missing body parameters');

	res.status(201).json('It works');
});

app.listen(port, () => {
	console.log(`listening on http://localhost:${port}`);
});
