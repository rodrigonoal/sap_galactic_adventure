require('dotenv').config();
const nodemailer = require('nodemailer');
const cds = require('@sap/cds');

module.exports = function () {
	this.before('CREATE', 'GalacticSpacefarers', (req) => {
		const { stardustCollection, wormholeNavigationSkill } = req.data;

		const maximumStardust = 255;
		const maximumNavigationSkill = 10;

		const stardustBonus = 15;
		const navigationSkillBonus = 1;

		if (stardustCollection < maximumStardust - stardustBonus) {
			req.data.stardustCollection += stardustBonus;
		} else {
			req.data.stardustCollection = 255;
		}

		if (wormholeNavigationSkill < maximumNavigationSkill)
			req.data.wormholeNavigationSkill += navigationSkillBonus;
	});

	this.after('CREATE', 'GalacticSpacefarers', (galacticSpacefarer) => {
		const { MAILER_HOST, MAILER_PORT, MAILER_EMAIL, MAILER_PASSWORD } =
			process.env;
		const { name, email } = galacticSpacefarer;

		const transporter = nodemailer.createTransport({
			host: MAILER_HOST,
			port: MAILER_PORT,
			auth: {
				user: MAILER_EMAIL,
				pass: MAILER_PASSWORD,
			},
		});

		const mailOptions = {
			from: MAILER_EMAIL,
			to: email,
			subject: `Welcome, Spacefarer ${name}!`,
			html: `Dear ${name}, <p> Congratulations and welcome to the cosmic frontier! It is with great pleasure that we extend our warmest greetings to you as you embark on your adventurous journey among the stars. Your selection to join our esteemed team of spacefarers marks the beginning of an extraordinary chapter in your life, one filled with discovery, excitement, and limitless possibilities. <p> Safe travels, and may the stars guide you on your extraordinary voyage.<p>Warm regards,<p>Lord Vader<p>Director<p>Galactic Empire`,
		};

		transporter.sendMail(mailOptions, (error, info) => {
			if (error) {
				return console.log(`Error: ${error}`);
			}
			console.log(`Message Sent: ${info.response}`);
		});
	});
};

//for e-mail testing purposes: https://ethereal.email/
