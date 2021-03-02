const express = require('express');
const knex = require('./database/index');
const app = express();
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('views'));

app.get('/hello', (req, res) => {
	res.send('Hello World!');
});

app.post('/register', (req, res) => {
	const { firstname, lastname, birthdate, address, email, phone } = req.body;
	if (
		!firstname ||
		!lastname ||
		birthdate.length === 0 ||
		!address ||
		!email ||
		!phone
	)
		res.status(403).redirect('/error.html');

	res.status(201).redirect('/success.html');
});

app.listen(port, () => {
	console.log(`listening on http://localhost:${port} 🚀`);
});
