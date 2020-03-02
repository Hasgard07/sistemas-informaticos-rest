const express=require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/questions/:cycle', (req, res)=>{
    const { cycle } = req.params;
    mysqlConnection.query('select * from questions where cycle = ?', [cycle],(err, rows, fields) =>{
        if(!err) {
            res.json(rows[0]);
        } else {
            console.log(err);
        }
    });
});

module.exports = router;