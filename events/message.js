module.exports = (bot, message) => {
    //Ignore all bots
    if (message.author.bot) return;

    //If else on messages that start with prefix
    if (message.content.startsWith(bot.config.prefix)) {
        //Argument/command name definition.
        var args = message.content.substring(bot.config.prefix.length).split(' ');
        var command = args.shift().toLowerCase();

        //Get the command data from client.commands Enmap
        const cmd = bot.commands.get(command);
        //If command doesn't exist, exit and do nothing
        if (!cmd) return;
        //Run the command
        cmd.run(bot, message, args);
        message.delete({ timeout: 0 }); //Delete message
    }
}