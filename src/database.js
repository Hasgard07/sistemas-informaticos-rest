const mysql = require('mysql');
const mysqlconnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'password',
    database: 'introduccion_s_i'
});

mysqlconnection.connect((e)=>  {
        if(e!=null){
            console.log('resultado conexion: ',e);
        } else {
            console.log('conexion Exitosa...');
        }
        return;
});

module.exports = mysqlconnection;