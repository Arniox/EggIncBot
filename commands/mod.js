//Import
const Discord = require('discord.js');
const mysql = require('promise-mysql');

exports.run = (bot, guild, message, args) => {
    if (args.length != 0) {
        var command = args.shift().toLowerCase();

        const current_settings_cmd = `
                SELECT 
                ModLevel.ModLevel_Id AS 'ModLevel_ID',
                ModLevel.Name AS 'ModLevelName', 
                ModControl.Mod_Id AS 'ModControl_Id',
                ModControl.Stats_Update_Max_Diff AS 'StatsMaxDiff',
                TrustRole.Role_Id AS 'TrustRole_RoleId',
                TrustRole.UUID AS 'TrustRoleId',
                TrustRole.Guild_Id AS 'TrustRoleGuildId',
                ModChat.Channel_Id AS 'ModChat_ChannelId',
                ModChat.UUID AS 'ModChatId',
                ModChat.Guild_Id AS 'ModChatGuildId',
                ModRole.Role_Id AS 'ModRole_RoleId',
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
                    (results[0].ModChatGuildId == message.guild.id || results[0].ModChatId == null) &&
                    (results[0].ModRoleGuildId == message.guild.id || results[0].ModRoleId == null)) {

                    console.log(results);

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
                            if (args.length != 0) {
                                var dictation = args.shift();

                                switch (dictation) {
                                    case 'set':
                                        var roles = message.mentions.roles;
                                        if (roles.size != 0) {
                                            if (roles.size == 1) {
                                                //Save roles id
                                                roles.map((value, key) => {
                                                    //Check that the role isn't already the moderator role
                                                    if (results[0].ModRoleId != key) {
                                                        //If modrole id is null, then create a new modrole
                                                        var update_modrole_cmd = '';
                                                        if (results[0].ModRole_RoleId == null) {
                                                            update_modrole_cmd = `INSERT INTO roles (Guild_Id, UUID, Role_Color) VALUES ("${message.guild.id}", "${key}", "${value.color.toString(16)}")`;
                                                        } else {
                                                            //Update database
                                                            update_modrole_cmd = `UPDATE roles SET uuid = "${key}" WHERE Role_Id = ${results[0].ModRole_RoleId}`;
                                                        }
                                                        //Run command
                                                        bot.con.query(update_modrole_cmd, (error, roleresults, fields) => {
                                                            if (error) return console.error(error); //Throw error and continue

                                                            //If ModRole_RoleId is null, then insert into ModControl
                                                            if (results[0].ModRole_RoleId == null) {
                                                                const set_modcontrol_cmd = `UPDATE modcontrol SET moderator_role = ${roleresults.insertId} WHERE Mod_Id = ${results[0].ModControl_Id}`;
                                                                bot.con.query(set_modcontrol_cmd).catch(error => console.error(error)); //Update the mod controller with new id
                                                            }
                                                            //Message
                                                            message.channel.send(new Discord.MessageEmbed().setDescription(`Set ${message.guild.roles.cache.get(key).toString()}` +
                                                                ` as the egg inc moderator.`).setColor('#09b50c'));
                                                        });

                                                    } else {
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`${message.guild.roles.cache.get(results[0].ModRoleId).toString()}` +
                                                            ` is already set as the moderator role for ${message.guild.toString()}`).setColor('#b50909'));
                                                    }
                                                });
                                            } else {
                                                message.channel.send(new Discord.MessageEmbed().setDescription('There can only be one specified moderator role. ' +
                                                    'Remember, the server manager permission automatically gives you moderation abilities.').setColor('#b50909'));
                                            }
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('You didn\'t supply any roles to set.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'clear':
                                        //If modrole id is null, then don't do anything
                                        if (results[0].ModRole_RoleId != null) {
                                            //Set modcontrol moderator_role id tp null
                                            const remove_id_cmd = `UPDATE modcontrol SET moderator_role = null WHERE Mod_Id = ${results[0].ModControl_Id}`;
                                            bot.con.query(remove_id_cmd).catch(error => console.error(error));

                                            //Delete moderator role
                                            const delete_modrole_cmd = `DELETE FROM roles WHERE Role_Id = ${results[0].ModRole_RoleId}`;
                                            bot.con.query(delete_modrole_cmd).catch(error => console.error(error));

                                            //Message
                                            message.channel.send(new Discord.MessageEmbed().setDescription(`Removed ${message.guild.roles.cache.get(results[0].ModRoleId).toString()}` +
                                                ` from moderation.`).setColor('#09b50c'));
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('There was no moderation role to clear.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'current':
                                        message.channel.send(new Discord.MessageEmbed().setDescription(`The current listed moderator role is ` +
                                            `${(results[0].ModRoleId != null ? `${message.guild.roles.cache.get(results[0].ModRoleId).toString()}` : '***No Moderation Role Set***')}`).setColor('#09b50c'));
                                        break;
                                    default:
                                        HelpMessage(bot, guild, message, args);
                                        break;
                                }
                            } else {
                                message.channel.send(new Discord.MessageEmbed().setDescription('Did you want to set a new modrole, or view the current modrole?').setColor('#b50909'));
                            }
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
                                        value: `${(results[0].TrustRoleId != null ? `${message.guild.roles.cache.get(results[0].TrustRoleId).toString()}` : '***No Trusted Role Set***')}`,
                                        inline: true
                                    },
                                    {
                                        name: 'Stats Max Difference: ',
                                        value: `${(results[0].StatsMaxDiff != null ? `${results[0].StatsMaxDiff}` : '***No Stat Max Difference Value Set***')}`,
                                        inline: true
                                    },
                                    {
                                        name: 'Moderation Role: ',
                                        value: `${(results[0].ModRoleId != null ? `${message.guild.roles.cache.get(results[0].ModRoleId).toString()}` : '***No Moderation Role Set***')}`,
                                        inline: true
                                    },
                                    {
                                        name: 'Moderation Approval Chat: ',
                                        value: `${(results[0].ModChatId != null ? `${message.guild.channels.cache.get(results[0].ModChatId).toString()}` : '***No Moderation Approval Chat Set***')}`,
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
                message.channel.send(new Discord.MessageEmbed().setDescription('Sorry, you need management permissions, or need to be a moderator to run this command.').setColor('#b50909'));
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
                value: `${guild.Prefix}mod [variable/function] [current/set/clear] [value]\n` +
                    `${guild.Prefix}mod level [current/set/clear] {optional set: [none/light/medium/heavy/restrictive]}\n` +
                    `${guild.Prefix}mod maxdiff [current/setclear] {optional set: [number representing percentage, eg: 75]}\n` +
                    `${guild.Prefix}mod trustrole [current/setclear] {optional set: [@role]}\n` +
                    `${guild.Prefix}mod modchat [current/setclear] {optional set: [#chat]}\n` +
                    `${guild.Prefix}mod modrole [current/setclear] {optional set: [@role]}\n` +
                    `${guild.Prefix}mod current - (shows all current settings)`
            }
        )
        .setTimestamp()
        .setFooter('Thanks and have a good day.');

    //Send embedded message
    message.channel.send(embeddedHelpMessage);
}