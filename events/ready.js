module.exports = (bot) => {
    const permissionBitField = 335801409;
    //Manage roles, create instant invite, change nickname, view channels,
    //send messages, manage message, embed links, attach files, 
    //read message history, mention everyone, add reactions

    //Check if guild exists in database
    const sql_cmd = `SELECT Guild_Id FROM configure`;
    bot.con.query(sql_cmd, (error, results, fields) => {
        if (error) return console.error(error); //Return error console log and and continue

        //Check all guilds
        bot.guilds.cache.map((value, key) => {
            //If this guild isn't in database, then add
            if (!results.map(v => v.Guild_Id).includes(key)) {
                //Create default mod controller
                const mod_control_cmd = `
                INSERT INTO ModControl (ModLevel_Id)
                    VALUES ((
                        SELECT ModLevel_Id
                        FROM ModerationLevel
                        WHERE Name = 'None'
                        LIMIT 1
                    ))
                `;
                bot.con.query(mod_control_cmd, (error, results, fields) => {
                    if (error) return console.error(error); //Throw error and continue
                    //Create new configure
                    const configure_cmd = `
                    INSERT INTO configure (Guild_Id, Guild_Name, Prefix, Mod_Id)
                        VALUES ("${key}", "${value.name}", "e-", ${results.insertId})
                    `;
                    bot.con.query(configure_cmd).catch(error => console.error(error));
                });
            }
        });
    });

    //log
    console.log('Connected!');
    console.log(`Logged in as ${bot.user.username} - (${bot.user.id})`);
    console.log(`Ready to serve in ${bot.channels.cache.size} channels on ${bot.guilds.cache.size} servers, for a total of ${bot.users.cache.size} users.`);
    console.log(`Invite bot to your server:\nhttps://discordapp.com/oauth2/authorize?&client_id=${bot.user.id}&scope=bot&permissions=${permissionBitField}`);
};