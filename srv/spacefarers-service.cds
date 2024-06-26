using btp.spacefarers as bs from '../db/data-models';

@cds.query.limit.default: 10
service SpacefarerService @(requires: 'authenticated-user') {
    @restrict: [{
        grant: '*',
        where: 'originPlanet = $user.originPlanet'
    }]
    entity GalacticSpacefarers as select from bs.GalacticSpacefarers;
    annotate GalacticSpacefarers with @odata.draft.enabled;
    @readonly entity Positions           as select from bs.Positions;
    @readonly entity Departments         as select from bs.Departments;

}
