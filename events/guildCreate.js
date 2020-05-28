//Include
const mysql = require('promise-mysql');

module.exports = (bot, guild) => {
    console.log("Joined a new guild: " + guild.name);

    //Check if guild exists in database already
    const sql_cmd = `SELECT * FROM configure WHERE Guild_Id = ${guild.id}`;
    bot.con.query(sql_cmd, (error, results, fields) => {
        if (error) return console.error(error); //Return error console log and continue
        else if (!results || !results.length) {
            //Create default mod controller
            const mod_control_cmd = `
            INSERT INTO ModControl (ModLevel_Id)
                VALUES ((
                    SELECT ModLevel_Id
                    FROM ModerationLevel
                    WHERE Name = 'None'
                    LIMIT 1
                ))`;
            bot.con.query(mod_control_cmd, (error, results, fields) => {
                if (error) return console.error(error); //Throw error and continue
                //Create new configure
                const configure_cmd = `
                INSERT INTO configure (Guild_Id, Guild_Name, Prefix, Mod_Id)
                    VALUES ("${guild.id}", "${guild.name}", "e-", ${results.insertId})`;
                bot.con.query(configure_cmd).catch(error => console.error(error));
            });
        }
    });
}