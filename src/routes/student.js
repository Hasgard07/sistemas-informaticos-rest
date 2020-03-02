const express=require('express');
const router = express.Router();

const mysqlConnection = require('../database');
router.get('/student',(req, res)=>{
    mysqlConnection.query('select * from student',(err, rows, fields) =>{
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.get('/student/:code', (req, res)=>{
    const { code } = req.params;
    mysqlConnection.query('select * from student where code = ?', [code],(err, rows, fields) =>{
        if(!err) {
            res.json(rows[0]);
        } else {
            console.log(err);
        }
    });
});

router.post('/student',(req, res)=>{
    const {name, surname, code} = req.body;
    const query = `
        CALL studentAddOrUpdate(?, ?, ?);
    `;
    mysqlConnection.query(query, [name, surname, code],(err, rows, fields) =>{
        if(!err) {
            res.json({Status: 'Student saved'});
        } else {
            console.log(err);
        } 
    });
});
router.post('/student/:code',(req, res)=>{
    const {name, surname} = req.body;
    const {code} = req.params;
    const query = `
        CALL studentAddOrUpdate(?, ?, ?);
    `;
    mysqlConnection.query(query, [name, surname, code],(err, rows, fields) =>{
        if(!err) {
            res.json({Status: 'Student updated'});
        } else {
            console.log(err);
        }
    });
});

router.delete('/student/:code',(req, res)=>{
    const {code} = req.params;
    mysqlConnection.query('DELETE FROM student WHERE code = ?',[code],(err, rows, fields) =>{
        if(!err) {
            res.json({Status: 'Student Deleted'});
        } else {
            console.log(err);
        }
    });
});
module.exports = router;