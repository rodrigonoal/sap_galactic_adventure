using btp.spacefarers as bs from '../db/data-models';

service SpacefarerService @(requires: 'authenticated-user') {
    @restrict: [{ grant: '*', where: 'originPlanet = $user.originPlanet' }]
    entity GalacticSpacefarers as select from bs.GalacticSpacefarers;
    annotate GalacticSpacefarers with @odata.draft.enabled;
    entity Departments         as select from bs.Departments;
    annotate Departments with @odata.draft.enabled;
    entity Positions           as select from bs.Positions;
    annotate Positions with @odata.draft.enabled;

}
