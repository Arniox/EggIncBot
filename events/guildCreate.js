//Include
const mysql = require('promise-mysql');

module.exports = (bot, guild) => {
    console.log("Joined a new guild: " + guild.name);

    //Check if guild exists in database already
    const sql_cmd = `SELECT * FROM configure WHERE Guild_Id = ${guild.id}`;
    bot.con.query(sql_cmd, (error, results, fields) => {
        if (error) return console.error(error); //Return error console log and continue
        else if (!results || !results.length) {
            //Create new
            const update_cmd = `INSERT INTO configure (Guild_Id, Guild_Name, prefix) VALUES (${guild.id}, "${guild.name}", "e-")`;
            bot.con.query(update_cmd).catch(error => console.error(error));
        }
    });
}