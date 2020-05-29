//Import
const Discord = require('discord.js');
const mysql = require('promise-mysql');
//✅
//❌
//🔵
//⚠️

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
                            if (args.length != 0) {
                                var dictation = args.shift().toLowerCase();

                                switch (dictation) {
                                    case 'set':
                                        if (args.length != 0) {
                                            var level = args.shift().toLowerCase();
                                            //Create sql statement
                                            const update_mod_level_cmd = `
                                            UPDATE ModControl SET ModLevel_Id = (
                                                SELECT ModLevel_Id
                                                FROM ModerationLevel
                                                WHERE Name LIKE '${level}'
                                                LIMIT 1
                                            )
                                            WHERE Mod_id = ${results[0].ModControl_Id}`;

                                            switch (level) {
                                                case 'none':
                                                    bot.con.query(update_mod_level_cmd).catch(error => console.error(error)); //Update the moderation level.
                                                    //Message
                                                    message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Set moderation level to ${level}`).setColor('#09b50c'));
                                                    break;
                                                case 'light':
                                                    //Check that, for light moderation level, the stats max diff, mod approval chat and moderator roles are set
                                                    if (results[0].StatsMaxDiff != null && results[0].ModChat_ChannelId != null && results[0].ModRole_RoleId != null) {
                                                        bot.con.query(update_mod_level_cmd).catch(error => console.error(error)); //Update the moderation level.
                                                        //Message
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Set moderation level to ${level}`).setColor('#09b50c'));
                                                    } else
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${level} moderation level *requires* that the maximum stats difference, ` +
                                                            `moderation approval chat, and moderator roles are set. Please set these before changing the moderation level to ${level}`).setColor('#b50909'));
                                                    break;
                                                case 'medium':
                                                    //Check that, for medium moderation level, the trusted role, mod approval chat and moderator roles are set
                                                    if (results[0].TrustRole_RoleId != null && results[0].ModChat_ChannelId != null && results[0].ModRole_RoleId != null) {
                                                        bot.con.query(update_mod_level_cmd).catch(error => console.error(error)); //Update the moderation level.
                                                        //Message
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Set moderation level to ${level}`).setColor('#09b50c'));
                                                    } else
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${level} moderation level *requires* that a trusted role, ` +
                                                            `the moderation approval chat, and moderator roles are set. Please set these before changing the moderation level to ${level}`).setColor('#b50909'));
                                                    break;
                                                case 'heavy':
                                                    //Check that, for heavy moderation level, the mod approval chat and moderator roles are set
                                                    if (results[0].ModChat_ChannelId != null && results[0].ModRole_RoleId != null) {
                                                        bot.con.query(update_mod_level_cmd).catch(error => console.error(error)); //Update the moderation level.
                                                        //Message
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Set moderation level to ${level}`).setColor('#09b50c'));
                                                    } else
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${level} moderation level *requires* that a moderation approval chat, ` +
                                                            `and a moderator role are set. Please set these before changing the moderation level to ${level}`).setColor('#b50909'));
                                                    break;
                                                case 'restrictive':
                                                    //Check that, for restrictive moderation level, the mod approval chat and moderator roles are set
                                                    if (results[0].ModChat_ChannelId != null && results[0].ModRole_RoleId != null) {
                                                        bot.con.query(update_mod_level_cmd).catch(error => console.error(error)); //Update the moderation level.
                                                        //Message
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Set moderation level to ${level}`).setColor('#09b50c'));
                                                    } else
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${level} moderation level *requires* that a moderation approval chat, ` +
                                                            `and a moderator role are set. Please set these before changing the moderation level to ${level}`).setColor('#b50909'));
                                                    break;
                                                default:
                                                    message.channel.send(new Discord.MessageEmbed().setDescription(`❌ There is no moderation level named ${level}. ` +
                                                        `There is only *None*, *Light*, *Heavy*, and *Restrictive*. Please select one. (case insensitive)`).setColor('#b50909'));
                                                    break;
                                            }
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('❌ You didn\'t supply any level name.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'current':
                                        message.channel.send(new Discord.MessageEmbed().setDescription(`🔵 The current listed moderation level is ***${results[0].ModLevelName}***`).setColor('#0099ff'));
                                        break;
                                    default:
                                        HelpMessage(bot, guild, message, args);
                                        break;
                                }
                            } else {
                                HelpMessage(bot, guild, message, args);
                            }
                            break;
                        case 'maxdiff':
                            if (args.length != 0) {
                                var dictation = args.shift().toLowerCase();

                                switch (dictation) {
                                    case 'set':
                                        if (args.length != 0) {
                                            var value = args.shift();
                                            //Check that it's a number
                                            if (/^\d+(.\d+)?$/.test(value)) {
                                                if (parseFloat(value) != 0) {
                                                    const update_maxdiff_cmd = `UPDATE modcontrol SET stats_update_max_diff = ${parseFloat(value)} WHERE Mod_Id = ${results[0].ModControl_Id}`;
                                                    bot.con.query(update_maxdiff_cmd).catch(error => console.error(error)); //Update the mod controller directly.

                                                    //Message
                                                    message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Set ${parseFloat(value)}% ` +
                                                        `as the egg inc maximum stats difference.`).setColor('#09b50c'));
                                                } else {
                                                    message.channel.send(new Discord.MessageEmbed().setDescription('❌ You cannot set the maximum stat difference to 0.').setColor('#b50909'));
                                                }
                                            } else {
                                                message.channel.send(new Discord.MessageEmbed().setDescription(`❌ Sorry, *${value}* is not a floating point, or integer value.`).setColor('#b50909'));
                                            }
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('❌ You didn\'t supply any maximum stat difference percentage value.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'clear':
                                        //If stats max diff is null, then don't do anything
                                        if (results[0].StatsMaxDiff != null) {
                                            //Check moderation level is not light. Any other moderation level allows for max difference to be null.
                                            if (results[0].ModLevelName != 'Light') {
                                                //Set stat max difference to null
                                                const delete_statdiff_cmd = `UPDATE modcontrol SET stats_update_max_diff = null WHERE Mod_Id = ${results[0].ModControl_Id}`;
                                                bot.con.query(delete_statdiff_cmd).catch(error => console.error(error));

                                                //Message
                                                message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Cleared maximum stat difference from ${results[0].StatsMaxDiff}%`).setColor('#09b50c'));
                                            } else {
                                                message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${results[0].ModLevelName} moderation level *requires* a maximum stat difference value to be set.` +
                                                    ` To clear the maximum stat difference, please set the moderation level to none, medium, heavy, or restrictive.`).setColor('#b50909'));
                                            }
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('❌ The Maximum stat difference was already nothing.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'current':
                                        message.channel.send(new Discord.MessageEmbed().setDescription(`🔵 The current listed maximum stat difference percentage is ` +
                                            `***${(results[0].StatsMaxDiff != null ? `${results[0].StatsMaxDiff}%` : 'No Maximum Stat Difference Set')}***`).setColor('#0099ff'));
                                        break;
                                    default:
                                        HelpMessage(bot, guild, message, args);
                                        break;
                                }
                            } else {
                                HelpMessage(bot, guild, message, args);
                            }
                            break;
                        case 'trustrole':
                            if (args.length != 0) {
                                var dictation = args.shift().toLowerCase();

                                switch (dictation) {
                                    case 'set':
                                        var roles = message.mentions.roles;
                                        if (roles.size != 0) {
                                            if (roles.size == 1) {
                                                //Save roles id
                                                roles.map((value, key) => {
                                                    //Check that the role isn't already the trusted role
                                                    if (results[0].TrustRoleId != key) {
                                                        //if trusted role id is null, then create a new trusted role
                                                        var update_trustrole_cmd = '';
                                                        if (results[0].TrustRole_RoleId == null) {
                                                            update_trustrole_cmd = `
                                                            INSERT INTO roles (Guild_Id, UUID, Role_Color, Role_Name) 
                                                            VALUES ("${message.guild.id}", "${key}", "${value.color.toString(16)}", "${value.name}")`;
                                                        } else {
                                                            //Update database
                                                            update_trustrole_cmd = `
                                                            UPDATE roles SET 
                                                            uuid = "${key}", 
                                                            role_color = "${value.color.toString(16)}",
                                                            role_name = "${value.name}"
                                                            WHERE Role_Id = ${results[0].TrustRole_RoleId}`;
                                                        }
                                                        //Run command
                                                        bot.con.query(update_trustrole_cmd, (error, roleresults, fields) => {
                                                            if (error) return console.error(error); //Throw error and continue

                                                            //If TrustRole_RoleId is null, then insert into ModControl
                                                            if (results[0].TrustRole_RoleId == null) {
                                                                const set_trustrole_cmd = `UPDATE modcontrol SET stats_trusted_role = ${roleresults.insertId} WHERE Mod_Id = ${results[0].ModControl_Id}`;
                                                                bot.con.query(set_trustrole_cmd).catch(error => console.error(error)); //Update and mod controller with new id
                                                            }
                                                            //Message
                                                            message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Set ${message.guild.roles.cache.get(key).toString()}` +
                                                                ` as the egg inc trusted role.`).setColor('#09b50c'));
                                                        });
                                                    } else {
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${message.guild.roles.cache.get(results[0].TrustRoleId).toString()}` +
                                                            ` is already set as the trusted role for ${message.guild.toString()}`).setColor('#b50909'));
                                                    }
                                                });
                                            } else {
                                                message.channel.send(new Discord.MessageEmbed().setDescription('❌ There can only be one specified trusted role.').setColor('#b50909'));
                                            }
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('❌ You didn\'t supply any role to set.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'clear':
                                        //if trusted role id is null, then don't do anything
                                        if (results[0].TrustRole_RoleId != null) {
                                            //Check that the moderation level is not Medium. Any other levels are allowed to have no trusted role set.
                                            if (results[0].ModLevelName != 'Medium') {
                                                //Set Stats_Trusted_Role to null
                                                const remove_id_cmd = `UPDATE modcontrol SET stats_trusted_role = null WHERE Mod_Id = ${results[0].ModControl_Id}`;
                                                bot.con.query(remove_id_cmd).catch(error => console.error(error));

                                                //Delete trusted role
                                                const delete_trustedrole_cmd = `DELETE FROM roles WHERE Role_id = ${results[0].TrustRole_RoleId}`;
                                                bot.con.query(delete_trustedrole_cmd).catch(error => console.error(error));

                                                //Message
                                                message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Removed ${message.guild.roles.cache.get(results[0].TrustRoleId).toString()}` +
                                                    ` from trusted roles.`).setColor('#09b50c'));
                                            } else {
                                                message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${results[0].ModLevelName} moderation level *requires* a trusted role to be set.` +
                                                    ` To clear the trusted role, please set the moderation level to none, light, heavy or restrictive.`).setColor('#b50909'));
                                            }
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('❌ There was no trusted role to clear.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'current':
                                        message.channel.send(new Discord.MessageEmbed().setDescription(`🔵 The current listed trusted role is ` +
                                            `${(results[0].TrustRoleId != null ? `${message.guild.roles.cache.get(results[0].TrustRoleId).toString()}` : '***No Trusted Role Set***')}`).setColor('#0099ff'));
                                        break;
                                    default:
                                        HelpMessage(bot, guild, message, args);
                                        break;
                                }
                            } else {
                                HelpMessage(bot, guild, message, args);
                            }
                            break;
                        case 'modchat':
                            if (args.length != 0) {
                                var dictation = args.shift().toLowerCase();

                                switch (dictation) {
                                    case 'set':
                                        var channels = message.mentions.channels;
                                        if (channels.size != 0) {
                                            if (channels.size == 1) {
                                                //Save channel id
                                                channels.map((value, key) => {
                                                    //Check that the channel isn't already the moderation approval chat
                                                    if (results[0].ModChatId != key) {
                                                        //If modchat id is null, then create a new modchat
                                                        var update_modchat_cmd = '';
                                                        if (results[0].ModChat_ChannelId == null) {
                                                            update_modchat_cmd = `INSERT INTO channels (Guild_Id, UUID, Channel_Name) VALUES ("${message.guild.id}", "${key}", "${value.name}")`;
                                                        } else {
                                                            //Update database
                                                            update_modchat_cmd = `UPDATE channels SET uuid = "${key}", channel_name = "${value.name}" WHERE channel_id = ${results[0].ModChat_ChannelId}`;
                                                        }
                                                        //Run command
                                                        bot.con.query(update_modchat_cmd, (error, channelresults, fields) => {
                                                            if (error) return console.error(error); //Throw error and continue

                                                            //If ModChat_ChannelId is null, then insert into ModControl
                                                            if (results[0].ModChat_ChannelId == null) {
                                                                const set_modchat_cmd = `UPDATE modcontrol SET mod_approval_chat = ${channelresults.insertId} WHERE Mod_Id = ${results[0].ModControl_Id}`;
                                                                bot.con.query(set_modchat_cmd).catch(error => console.error(error)); //Update the mod controller with new id
                                                            }
                                                            //Message
                                                            message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Set ${message.guild.channels.cache.get(key).toString()}` +
                                                                ` as the egg inc moderation approval chat.`).setColor('#09b50c'));
                                                        });
                                                    } else {
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${message.guild.channels.cache.get(results[0].ModChatId).toString()}` +
                                                            ` is already set as the moderation approval chat for ${message.guild.toString()}`).setColor('#b50909'));
                                                    }
                                                });
                                            } else {
                                                message.channel.send(new Discord.MessageEmbed().setDescription('❌ There can only be one specified moderation approval chat.').setColor('#b50909'));
                                            }
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('❌ You didn\'t supply any channel to set.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'clear':
                                        //If modchat id is null, then don't do anything
                                        if (results[0].ModChat_ChannelId != null) {
                                            //Check that the moderation level is none. Any other level requires a moderator chat to be set
                                            if (results[0].ModLevelName == 'None') {
                                                //Set modcontrol mod_approval_chat id to null
                                                const remove_id_cmd = `UPDATE modcontrol SET mod_approval_chat = null WHERE Mod_Id = ${results[0].ModControl_Id}`;
                                                bot.con.query(remove_id_cmd).catch(error => console.error(error));

                                                //Delete mod approval chat
                                                const delete_modchat_cmd = `DELETE FROM channels WHERE channel_id = ${results[0].ModChat_ChannelId}`;
                                                bot.con.query(delete_modchat_cmd).catch(error => console.error(error));

                                                //Message
                                                message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Removed ${message.guild.roles.cache.get(results[0].ModChatId)}` +
                                                    ` as a moderation approval chat.`).setColor('#09b50c'));
                                            } else {
                                                message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${results[0].ModLevelName} moderation *requires* a moderation approval chat to be set.` +
                                                    ` To clear the moderation approval, please set the moderation level to none.`).setColor('#b50909'));
                                            }
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('❌ There was no moderation approval chat to clear.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'current':
                                        message.channel.send(new Discord.MessageEmbed().setDescription(`🔵 The current listed moderation approval chat is ` +
                                            `${(results[0].ModChatId != null ? `${message.guild.channels.cache.get(results[0].ModChatId).toString()}` : '***No Moderation Approval Chat Set***')}`).setColor('#0099ff'));
                                        break;
                                    default:
                                        HelpMessage(bot, guild, message, args);
                                        break;
                                }
                            } else {
                                HelpMessage(bot, guild, message, args);
                            }
                            break;
                        case 'modrole':
                            if (args.length != 0) {
                                var dictation = args.shift().toLowerCase();

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
                                                            update_modrole_cmd = `
                                                            INSERT INTO roles (Guild_Id, UUID, Role_Color, Role_Name) 
                                                            VALUES ("${message.guild.id}", "${key}", "${value.color.toString(16)}", "${value.name}")`;
                                                        } else {
                                                            //Update database
                                                            update_modrole_cmd = `
                                                            UPDATE roles SET 
                                                            uuid = "${key}", 
                                                            role_color = "${value.color.toString(16)}",
                                                            role_name = "${value.name}" 
                                                            WHERE Role_Id = ${results[0].ModRole_RoleId}`;
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
                                                            message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Set ${message.guild.roles.cache.get(key).toString()}` +
                                                                ` as the egg inc moderator.`).setColor('#09b50c'));
                                                        });

                                                    } else {
                                                        message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${message.guild.roles.cache.get(results[0].ModRoleId).toString()}` +
                                                            ` is already set as the moderator role for ${message.guild.toString()}`).setColor('#b50909'));
                                                    }
                                                });
                                            } else {
                                                message.channel.send(new Discord.MessageEmbed().setDescription('❌ There can only be one specified moderator role. ' +
                                                    'Remember, the server manager permission automatically gives you moderation abilities.').setColor('#b50909'));
                                            }
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('❌ You didn\'t supply any role to set.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'clear':
                                        //If modrole id is null, then don't do anything
                                        if (results[0].ModRole_RoleId != null) {
                                            //Check that the moderation level is none. Any other level requires a moderator role to be set
                                            if (results[0].ModLevelName == 'None') {
                                                //Set modcontrol moderator_role id to null
                                                const remove_id_cmd = `UPDATE modcontrol SET moderator_role = null WHERE Mod_Id = ${results[0].ModControl_Id}`;
                                                bot.con.query(remove_id_cmd).catch(error => console.error(error));

                                                //Delete moderator role
                                                const delete_modrole_cmd = `DELETE FROM roles WHERE Role_Id = ${results[0].ModRole_RoleId}`;
                                                bot.con.query(delete_modrole_cmd).catch(error => console.error(error));

                                                //Message
                                                message.channel.send(new Discord.MessageEmbed().setDescription(`✅ Removed ${message.guild.roles.cache.get(results[0].ModRoleId).toString()}` +
                                                    ` from moderation.`).setColor('#09b50c'));
                                            } else {
                                                message.channel.send(new Discord.MessageEmbed().setDescription(`❌ ${results[0].ModLevelName} moderation *requires* a moderation role to be set.` +
                                                    ` To clear the moderation role, please set the moderation level to none.`).setColor('#b50909'));
                                            }
                                        } else {
                                            message.channel.send(new Discord.MessageEmbed().setDescription('❌ There was no moderation role to clear.').setColor('#b50909'));
                                        }
                                        break;
                                    case 'current':
                                        message.channel.send(new Discord.MessageEmbed().setDescription(`🔵 The current listed moderator role is ` +
                                            `${(results[0].ModRoleId != null ? `${message.guild.roles.cache.get(results[0].ModRoleId).toString()}` : '***No Moderation Role Set***')}`).setColor('#0099ff'));
                                        break;
                                    default:
                                        HelpMessage(bot, guild, message, args);
                                        break;
                                }
                            } else {
                                HelpMessage(bot, guild, message, args);
                            }
                            break;
                        case 'current':
                            //Return with message
                            var embeddedMessage = new Discord.MessageEmbed()
                                .setColor('#0099ff')
                                .setAuthor(bot.user.username, bot.user.avatarURL())
                                .setDescription(`🔵 Current Server Settings:`)
                                .addFields(
                                    { name: 'Moderation Level: ', value: `***${results[0].ModLevelName}***`, inline: true },
                                    {
                                        name: 'Trust Role: ',
                                        value: `${(results[0].TrustRoleId != null ? `${message.guild.roles.cache.get(results[0].TrustRoleId).toString()}` : '***No Trusted Role Set***')}`,
                                        inline: true
                                    },
                                    {
                                        name: 'Stats Max Difference: ',
                                        value: `${(results[0].StatsMaxDiff != null ? `${results[0].StatsMaxDiff}%` : '***No Stat Max Difference Value Set***')}`,
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
                message.channel.send(new Discord.MessageEmbed().setDescription('❌ Sorry, you need management permissions, or need to be a moderator to run this command.').setColor('#b50909'));
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
        .setDescription(`❌ The moderation (mod) command is used to set all sorts of moderation functions and variables.\n` +
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