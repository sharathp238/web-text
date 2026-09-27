const express = require('express');
const app = express();
const PORT = process.env.PORT || 80;

const text = process.env.WEBTEXT || "Hello World!";

app.get('/', (req, res) => {
  res.send(text);
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
