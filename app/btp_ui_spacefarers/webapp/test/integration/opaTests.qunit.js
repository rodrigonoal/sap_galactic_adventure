sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'btpuispacefarers/test/integration/FirstJourney',
		'btpuispacefarers/test/integration/pages/GalacticSpacefarersList',
		'btpuispacefarers/test/integration/pages/GalacticSpacefarersObjectPage'
    ],
    function(JourneyRunner, opaJourney, GalacticSpacefarersList, GalacticSpacefarersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('btpuispacefarers') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheGalacticSpacefarersList: GalacticSpacefarersList,
					onTheGalacticSpacefarersObjectPage: GalacticSpacefarersObjectPage
                }
            },
            opaJourney.run
        );
    }
);