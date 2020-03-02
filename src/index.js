const express = require('express');
const cors = require('cors');
const app = express();

//Settings
app.set('port',process.env.PORT || 3000);

//Middlewares
app.use(cors());
app.use(express.json());

//Routes
app.use(require('./routes/student'));
app.use(require('./routes/notes'));
app.use(require('./routes/questions'));
//Starting server
app.listen(app.get('port'), ()=>{
    console.log('server on port ', app.get('port'));
});
