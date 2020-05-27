//Import classes
const Discord = require('discord.js');

exports.run = (bot, guild, message, args) => {
    const permissionBitField = 335801409;
    //Manage roles, create instant invite, change nickname, view channels,
    //send messages, manage message, embed links, attach files, 
    //read message history, mention everyone, add reactions

    var pingMessage = new Discord.MessageEmbed()
        .setColor('#0099ff')
        .setAuthor(bot.user.username, bot.user.avatarURL())
        .setDescription(`Right back at you! Yes, I am alive.`)
        .addFields(
            { name: 'Current Uptime: ', value: `${UpTime()}`, inline: true },
            { name: 'Server Prefix: ', value: `${guild.prefix}` },
            { name: 'Total Guilds: ', value: `${bot.guilds.cache.size}`, inline: true },
            { name: 'Total Channels: ', value: `${bot.channels.cache.size}`, inline: true },
            { name: 'Total Users: ', value: `${bot.users.cache.size}`, inline: true },
            {
                name: 'Invite Me To Your Own Server: ',
                value: `https://discordapp.com/oauth2/authorize?&client_id=${bot.user.id}&scope=bot&permissions=${permissionBitField}`
            }
        )
        .setTimestamp()
        .setFooter('Thanks, and have a good day');

    message.channel.send(pingMessage);
}

//Functions
//Find uptime
function UpTime() {
    var time = process.uptime();
    var uptime = (time + '').toHHMMSS();
    return uptime;
}