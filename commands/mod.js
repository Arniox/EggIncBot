//Import
const Discord = require('discord.js');
const mysql = require('promise-mysql');

exports.run = (bot, guild, message, args) => {
    if (args.length != 0) {
        var command = args.shift().toLowerCase();

        const current_settings_cmd = `
                SELECT 
                ModLevel.Name AS 'ModLevelName', 
                ModControl.Stats_Update_Max_Diff AS 'StatsMaxDiff',
                TrustRole.UUID AS 'TrustRoleId',
                TrustRole.Guild_Id AS 'TrustRoleGuildId',
                ModChat.UUID AS 'ModChatId',
                ModChat.Guild_Id AS 'ModChatGuildId',
                ModRole.UUID AS 'ModRoleId',
                ModRole.Guild_Id AS 'ModRoleGuildId'
                    FROM configure AS Config
                    INNER JOIN ModControl AS ModControl
                        ON Config.Mod_Id = ModControl.Mod_Id
                    INNER JOIN ModerationLevel AS ModLevel
                        ON ModControl.ModLevel_Id = ModLevel.ModLevel_Id
                    LEFT JOIN Roles AS TrustRole
                        ON ModControl.Stats_Trusted_Role = TrustRole.Role_Id
                    LEFT JOIN Channels AS ModChat
                        ON ModControl.Mod_Approval_Chat = ModChat.Channel_Id
                    LEFT JOIN Roles AS ModRole
                        ON ModControl.Moderator_Role = ModRole.Role_Id
                    WHERE Config.Guild_Id = ${message.guild.id}
                `;
        bot.con.query(current_settings_cmd, (error, results, fields) => {
            if (error) return console.error(error); //Throw error and continue

            if (message.member.hasPermission('MANAGE_GUILD') || message.member.roles.cache.some(role => results[0].ModRoleId)) {
                if ((results[0].TrustRoleGuildId == message.guild.id || results[0].TrustRoleId == null) &&
                    (results[0].ModChatGuildId == message.guild.id || results[0].ModChat == null) &&
                    (results[0].ModRoleGuildId == message.guild.id || results[0].ModRole == null)) {
                    //Check the option you want
                    switch (command) {
                        case 'level':
                            break;
                        case 'maxdiff':
                            break;
                        case 'trustrole':
                            break;
                        case 'modchat':
                            break;
                        case 'modrole':


                            break;
                        case 'current':
                            //Return with message
                            var embeddedMessage = new Discord.MessageEmbed()
                                .setColor('#0099ff')
                                .setAuthor(bot.user.username, bot.user.avatarURL())
                                .setDescription(`Current Server Settings:`)
                                .addFields(
                                    { name: 'Moderation Level: ', value: `***${results[0].ModLevelName}***`, inline: true },
                                    {
                                        name: 'Trust Role: ',
                                        value: `***${(results[0].TrustRoleId != null ? `${message.guild.roles.cache.find(i => i.id == results[0].TrustRoleId).toString()}` : 'No Trusted Role Set')}***`,
                                        inline: true
                                    },
                                    {
                                        name: 'Stats Max Difference: ',
                                        value: `***${(results[0].StatsMaxDiff != null ? `${results[0].StatsMaxDiff}` : 'No Stat Max Difference Value Set')}***`,
                                        inline: true
                                    },
                                    {
                                        name: 'Moderation Role: ',
                                        value: `***${(results[0].ModRoleGuildId != null ? `${message.guild.roles.cache.find(i => i.id == results[0].ModRoleGuildId).toString()}` : 'No Moderation Role Set')}***`,
                                        inline: true
                                    },
                                    {
                                        name: 'Moderation Approval Chat: ',
                                        value: `***${(results[0].ModChatGuildId != null ? `${message.guild.channels.cache.find(i => i.id == results[0].ModChatGuildId).toString()}` : 'No Moderation Approval Chat Set')}***`,
                                        inline: true
                                    }
                                )
                                .setTimestamp()
                                .setFooter('Thank you and have a good day!');

                            //Send embedd
                            message.channel.send(embeddedMessage);
                            break;
                        default:
                            HelpMessage(bot, guild, message, args);
                            break;
                    }
                } else {
                    console.error('ERROR - For some reason the database selection returned values that did not share the same Guild.');
                }
            } else {
                message.channel.send(new Discord.MessageEmbed().setDescription('Sorry, you need management permissions, or need to be a moderator to run this command.'));
            }
        });
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
        .setDescription(`The moderation (mod) command is used to set all sorts of moderation functions and variables.\n` +
            `You can use this command by going ***${guild.Prefix}mod [variable/function] [current/set] [value]***`)
        .addFields(
            {
                name: 'Info: ',
                value: 'Setting the moderation level will require different variables for each level and will restrict you from changing the moderation level if you do not correctly set the required variables.\n' +
                    `There are 5 moderation levels:`,
            },
            {
                name: 'Levels: ',
                value: `***None*** - Anyone can update their stats and run commands.\n` +
                    `***Light*** - Auto moderation by the bot. Checks your stat history and sees if there's an unusually high jump in stats.\n` +
                    `***Medium*** - Members with a set trusted role can update their stats, but everyone else needs moderation approval.\n` +
                    `***Heavy*** - Stat screen image is processed and the stat update is then sent for moderation approval for everyone.\n` +
                    `***Restrictive*** - Only manual moderator commanded stat updates may be made.`,
                inline: true
            },
            {
                name: 'Level Requirements: ',
                value: `***None*** - No variable requirements\n` +
                    `***Light*** - Requires a stat max difference percentage, a mod approval chat and a mod approved role to be set.\n` +
                    `***Medium*** - Requires a trusted role, a mod approval chat and a mod approved role to be set.\n` +
                    `***Heavy*** - Requires a mod approval chat and a mod approved role to be set.\n` +
                    `***Restrictive*** - Requires a mod approval chat and a mod approved role to be set.`,
                inline: true
            },
            {
                name: 'Command Format: ',
                value: `${guild.Prefix}mod [variable/function] [current/set] [value]\n` +
                    `${guild.Prefix}mod level [current/set] {optional set: [none/light/medium/heavy/restrictive]}\n` +
                    `${guild.Prefix}mod maxdiff [current/set] {optional set: [number representing percentage, eg: 75]}\n` +
                    `${guild.Prefix}mod trustrole [current/set] {optional set: [@role]}\n` +
                    `${guild.Prefix}mod modchat [current/set] {optional set: [#chat]}\n` +
                    `${guild.Prefix}mod modrole [current/set] {optional set: [@role]}\n` +
                    `${guild.Prefix}mod current - (shows all current settings)`
            }
        )
        .setTimestamp()
        .setFooter('Thanks and have a good day.');

    //Send embedded message
    message.channel.send(embeddedHelpMessage);
}