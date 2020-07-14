//Import
const Discord = require('discord.js');
const mysql = require('promise-mysql');
//✅ .setColor('#09b50c')
//❌ .setColor('#b50909')
//🔵 .setColor('#0099ff')
//⚠️ .setColor('#ffcc00')

exports.run = (bot, guild, message, args) => {
    if (args.length != 0) {
        var command = args.shift().toLowerCase();

        const current_settings_cmd = `
            SELECT
            ModRole.Role_Id AS 'ModRole_RoleId',
            ModRole.UUID AS 'ModRoleId',
            ModRole.Guild_ID AS 'ModRoleGuildId'
                FROM Configure AS Config
                INNER JOIN ModControl as ModControl
                    ON Config.Mod_Id = ModControl.Mod_Id
                LEFT JOIN Roles AS ModRole
                    ON ModControl.Moderator_Role = ModRole.Role_Id
                WHERE Config.Guild_Id = ${message.guild.id}`;

        bot.con.query(current_settings_cmd, (error, results, fields) => {
            if (error) return console.error(error); //Throw error and continue

            if ((results[0].ModRoleGuildId == message.guild.id || results[0].ModRoleId == null)) {
                if (message.member.hasPermission('MANAGE_GUILD') || message.member.roles.cache.some(role => results[0].ModRoleId)) {

                    //Check the option you want
                    switch (command) {
                        case 'contract':
                            if (args.length != 0) {
                                var func = args.shift().toLowerCase();

                                //Check the function you want
                                switch (func) {
                                    case 'prefarm':
                                        //Grab message member mention and role pings
                                        var memberMentions = message.mentions.members;
                                        var rolePings = message.mentions.roles;
                                        //Get contract code if it exists
                                        var isContract = (args.length != 0 ? args.shift() : 'null');

                                        //Set up default insert values
                                        var contractCode = (/^(<[#@]?[&!]?\d+>)$/.test(isContract) ? 'null' : isContract);
                                        var memberid = 'null';
                                        var roleid = 'null';

                                        if (memberMentions.size != 0 || rolePings.size != 0)
                                            //If member mentions exists, it must be size 1, and same for role pings.
                                            if ((memberMentions.size != 0 ? memberMentions.size == 1 : true) && (rolePings.size != 0 ? rolePings.size == 1 : true)) {
                                                //Add member if member exists
                                                if (memberMentions.size == 1) {
                                                    //Save member id
                                                    memberMentions.map((value, key) => {
                                                        const add_new_member = `
                                                        INSERT INTO members (Guild_Id, UUID, Name, Nick_Name)
                                                        VALUES ("${message.guild.id}", "${key}", "${value.user.username}", "${value.nickname}")`;

                                                        console.log(add_new_member);

                                                        //Run command
                                                        bot.con.query(add_new_member, (error, memberreuslts, fields) => {
                                                            if (error) return console.error(error); //Throw error and continue
                                                            //Set member id as such
                                                            memberid = memberreuslts.insertId;
                                                        });
                                                    });
                                                }

                                                //Add role if role exists
                                                if (rolePings.size == 1) {
                                                    //Save role id
                                                    rolePings.map((value, key) => {
                                                        const add_new_role = `
                                                        INSERT INTO roles (Guild_Id, UUID, Role_Color, Role_Name)
                                                        VALUES ("${message.guild.id}", "${key}", "${value.color.toString(16)}", "${value.name}")`;

                                                        console.log(add_new_role);

                                                        //Run command
                                                        bot.con.query(add_new_role, (error, roleresults, fields) => {
                                                            if (error) return console.error(error); //Throw error and continue
                                                            //Set role id as such
                                                            roleid = roleresults.insertId;
                                                        });
                                                    });
                                                }
                                            } else {
                                                return message.channel.send(new Discord.MessageEmbed().setDescription(`❌ Sorry, a contract can only be started by one member and you can only ping one person.`).setColor('#b50909'));
                                            }

                                        console.log(contractCode, memberid, roleid);

                                        message.channel
                                            .send(new Discord.MessageEmbed().setDescription(`⚠️ Generating automatic contract prefarm counter...`).setColor('#ffcc00'))
                                            .then((sent) => {



                                                var add_contract_counter_cmd = `
                                                INSERT INTO ContractCounters (Guild_Id, Channel_Id, Message_Id, Status, Contract_Code, Ping_Role, Starter_Member)`;
                                            });
                                        break;
                                    case 'add':
                                        break;
                                    case 'remove':
                                        break;
                                    default:
                                        HelpMessage(bot, guild, message, args);
                                        break;
                                }
                            } else {
                                HelpMessage(bot, guild, message, args);
                            }
                            break;
                        default:
                            HelpMessage(bot, guild, message, args);
                            break;
                    }
                } else {
                    message.channel.send(new Discord.MessageEmbed().setDescription('❌ Sorry, you need management permissions, or need to be a moderator to run this command.').setColor('#b50909'));
                }
            } else {
                console.error(`ERROR: For some reason, the database selection returned values that did not shrae the same Guild.`);
            }
        });
    } else {
        HelpMessage(bot, guild, message, args);
    }
}

function HelpMessage(bot, guild, message, args) {
    //Reply with help message
    var embeddedHelpMessge = new Discord.MessageEmbed()
        .setColor('#b50909')
        .setAuthor(bot.user.username, bot.user.avatarURL())
        .setDescription(`❌ The start command is used to start different functions that automatically run on your server.\n` +
            `You can use this command by going ***${guild.Prefix}start [function] [settings/options]***`)
        .setTimestamp()
        .setFooter('Thanks and have a good day.');

    //Send embedded message
    message.channel.send(embeddedHelpMessge);
}