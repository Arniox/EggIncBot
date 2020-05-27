module.exports = (bot) => {
    const permissionBitField = 335801409;
    //Manage roles, create instant invite, change nickname, view channels,
    //send messages, manage message, embed links, attach files, 
    //read message history, mention everyone, add reactions

    //Check each guild for data
    bot.guilds.cache.map((value, key) => {
        //Check if guild exists in database
        const sql_cmd = `SELECT * FROM configure WHERE Guild_Id = ${key}`;
        bot.con.query(sql_cmd, (error, results, fields) => {
            if (error) return console.error(err); //Return error console log and continue
            else if (!results || !results.length) {
                //Create new
                const update_cmd = `INSERT INTO configure (Guild_Id, Guild_Name, prefix) VALUES (${key}, "${value.name}", "e-")`;
                bot.con.query(update_cmd);
            }
        });
    });

    //log
    console.log('Connected!');
    console.log(`Logged in as ${bot.user.username} - (${bot.user.id})`);
    console.log(`Ready to serve in ${bot.channels.cache.size} channels on ${bot.guilds.cache.size} servers, for a total of ${bot.users.cache.size} users.`);
    console.log(`Invite bot to your server:\nhttps://discordapp.com/oauth2/authorize?&client_id=${bot.user.id}&scope=bot&permissions=${permissionBitField}`);
};