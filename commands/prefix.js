//Import
const Discord = require('discord.js');
const mysql = require('promise-mysql');
//✔️
//❌
//🔵
//⚠️

exports.run = (bot, guild, message, args) => {
    if (args.length != 0) {
        var command = args.shift().toLowerCase();

        //Check which option you want
        switch (command) {
            case 'change':
                if (message.member.hasPermission('MANAGE_GUILD')) {
                    var query = args.shift();

                    //Check if the query exists
                    if (query) {
                        var previousPrefix = guild.Prefix;

                        //Change prefix
                        const update_cmd = `
                        UPDATE configure 
                            SET prefix = "${query}" 
                            WHERE Guild_Id = ${message.guild.id}`;
                        bot.con.query(update_cmd).catch(error => console.error(error));
                        //Change user activity
                        bot.user.setActivity(`the ${query} prefix`, { type: 'WATCHING' });
                        //message
                        message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Changed server Prefix from: ${previousPrefix} to: ${query}`).setColor('#09b50c'));
                    } else {
                        message.channel.send(new Discord.MessageEmbed().setDescription(`❌ Sorry, I cannot change your prefix to nothing!`).setColor('#b50909'));
                    }
                } else {
                    message.channel.send(new Discord.MessageEmbed().setDescription('❌ Sorry, you need to be a server manager/admin to change the server prefix.').setColor('#b50909'));
                }
                break;
            case 'current':
                message.channel.send(new Discord.MessageEmbed().setDescription(`🔵 Current Server Prefix is: ${guild.Prefix}`).setColor('#0099ff'));
                break;
            default:
                HelpMessage(bot, guild, message, args);
                break;
        }
    } else {
        HelpMessage(bot, guild, message, args);
    }
}

//Help message
function HelpMessage(bot, guild, message, args) {
    //Reply with help message
    var embeddedHelpMessage = new Discord.MessageEmbed()
        .setColor('#b50909')
        .setAuthor(bot.user.username, bot.user.avatarURL())
        .setDescription(`❌ You can use prefix by running *${guild.Prefix}prefix current* to list the current prefix, or *${guild.Prefix}prefix change [new prefix]* to change the prefix.`)
        .addFields(
            { name: 'Required Permissions: ', value: 'Manage Server' },
            { name: 'Example: ', value: `${guild.Prefix}prefix current\n\n${guild.Prefix}prefix change $` }
        )
        .setTimestamp()
        .setFooter('Thanks, and have a good day');

    //send embedded message
    message.channel.send(embeddedHelpMessage);
}