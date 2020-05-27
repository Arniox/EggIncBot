//Include
const mysql = require('promise-mysql');

module.exports = (bot, guild) => {
    console.log("Joined a new guild: " + guild.name);

    //Update database
    const sql_cmd = `INSERT INTO configure (Guild_Id, Guild_Name, prefix) VALUES (${guild.id}, "${guild.name}", "e-")`;
    bot.con.query(sql_cmd, (error, results, fields) => {
        if (error || !results || !results.length) return console.error(err); //return error console log and continue
    });
}