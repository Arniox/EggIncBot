//Include
const mysql = require('promise-mysql');

module.exports = (bot, message) => {
    //Ignore all bots
    if (message.author.bot) return;

    const sql_cmd = `SELECT * FROM configure WHERE Guild_Id = ${message.guild.id}`
    bot.con.query(sql_cmd, (error, results, fields) => {
        if (error || !results || !results.length) return console.error(err); //Return error console log and continue

        //If else on messages that start with prefix
        if (message.content.startsWith(results[0].prefix)) {
            //Argument/command name definition.
            var args = message.content.substring(results[0].prefix.length).split(' ');
            var command = args.shift().toLowerCase();

            //Get the command data from client.commands Enmap
            const cmd = bot.commands.get(command);
            //If command doesn't exist, exit and do nothing
            if (!cmd) return;
            //Run the command
            cmd.run(bot, results[0], message, args);
            message.delete({ timeout: 0 }); //Delete message
        }
    });
}