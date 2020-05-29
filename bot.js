//Constst
const Enmap = require("enmap");
const Discord = require('discord.js');
const fs = require('fs');
const dotenv = require('dotenv');
const mysql = require('promise-mysql');
//Load env variables
dotenv.config({ path: './.env' });

//Create and initialise database
const pool = mysql.createPool({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: 'eggincbot'
});

//Initialise Discord bot
var bot = new Discord.Client();
//✔️
//❌
//🔵
//⚠️

pool.then((p) => {
    return p.getConnection();
}).then((connection) => {
    console.log(`Connection to ${process.env.MYSQL_HOST} was successful!`);
    bot.con = connection; //Attach connection to bot

    //Attaches all events files to event
    fs.readdir('./events/', (err, files) => {
        if (err) return console.error(err); //Throw if file breaks
        files.forEach(file => {
            //If file is not js file, ignore
            if (!file.endsWith('.js')) return;
            //Load event file
            const event = require(`./events/${file}`);
            //Get the event name from file name
            var eventName = file.split('.')[0];
            console.log(`Attempting to load event ${eventName}`);
            //Bind all found events to client
            bot.on(eventName, event.bind(null, bot));
            delete require.cache[require.resolve(`./events/${file}`)]; //Remove from memory
        });
    });

    //Set up command sand attach to the client
    bot.commands = new Enmap();
    fs.readdir('./commands/', (err, files) => {
        if (err) return console.err(err); //Throw if folder breaks
        files.forEach(file => {
            //If file is not js file. Ignore
            if (!file.endsWith('.js')) return;
            //Load the command file itself
            var props = require(`./commands/${file}`);
            //Get just the command name from the file name
            var commandName = file.split('.')[0];
            console.log(`Attempting to load command ${commandName}`);
            //Store the command in the command Enmap.
            bot.commands.set(commandName, props);
        });
    });
    //Handle promise rejections
    process.on('unhandledRejection', error => console.error('Uncaught Promise Rejection', error));
}).catch(err => {
    console.error(err, `Connection to ${process.env.MYSQL_HOST} failed!`);
});
//Bot loggin
bot.login(process.env.BOT_TOKEN);

//---------------PROTOTYPES-----------------------
String.prototype.toHHMMSS = function () {
    var sec_num = parseInt(this, 10); //don't forget the second param
    var hours = Math.floor(sec_num / 3600);
    var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
    var seconds = sec_num - (hours * 3600) - (minutes * 60);

    if (hours < 10)
        hours = '0' + hours;
    if (minutes < 10)
        minutes = '0' + minutes;
    if (seconds < 10)
        seconds = '0' + seconds;

    var time = hours + ':' + minutes + ':' + seconds;
    return time;
}