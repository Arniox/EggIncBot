//Include
const mysql = require('promise-mysql');

module.exports = (bot, guild) => {
    console.log("Left a guild: " + guild.name);

    //Remove from database
    const sql_cmd = `DELETE FROM configure WHERE Guild_Id = ${guild.id}`;
    bot.con.query(sql_cmd, (error, results, fields) => {
        if (error || !results || !results.length) return console.error(err); //return error console log and continue
    });
}