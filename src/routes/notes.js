const express=require('express');
const router = express.Router();

const mysqlConnection = require('../database');
router.get('/notes',(req, res)=>{
    mysqlConnection.query('select * from notes',(err, rows, fields) =>{
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.get('/notes/:student_code', (req, res)=>{
    const { student_code } = req.params;
    mysqlConnection.query('select * from notes where student_code = ?', [student_code],(err, rows, fields) =>{
        if(!err) {
            res.json(rows[0]);
        } else {
            console.log(err);
        }
    });
});

router.post('/notes',(req, res)=>{
    const {student_code, note, cycle} = req.body;
    const query = `
        CALL notesAdd(?, ?, ?);
    `;
    mysqlConnection.query(query, [student_code, note, cycle],(err, rows, fields) =>{
        if(!err) {
            res.json({Status: 'Notes saved'});
        } else {
            console.log(err);
        } 
    });
});
router.post('/notes/:student_code',(req, res)=>{
    const {note, cycle} = req.body;
    const {student_code} = req.params;
    const query = `
        CALL noteUpdate(?, ?, ?);
    `;
    mysqlConnection.query(query, [student_code, note, cycle],(err, rows, fields) =>{
        if(!err) {
            res.json({Status: 'Notes updated'});
        } else {
            console.log(err);
        }
    });
});

router.delete('/notes/:student_code',(req, res)=>{
    const {student_code} = req.params;
    mysqlConnection.query('DELETE FROM notes WHERE code = ?',[student_code],(err, rows, fields) =>{
        if(!err) {
            res.json({Status: 'Notes Deleted'});
        } else {
            console.log(err);
        }
    });
});
module.exports = router;